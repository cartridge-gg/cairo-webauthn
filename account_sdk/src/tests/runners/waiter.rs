use std::{process::ChildStdout, sync::mpsc::{self, Sender}, io::{Read, BufReader, BufRead}, time::Duration, fs::{File, self}, path::Path};
use std::io::Write;
struct OutputWaiter {
    log_file_path: String,
    child_stdout: ChildStdout
}

impl OutputWaiter {
    pub fn new(log_file_path: String, child_stdout: ChildStdout) -> Self {
        Self {
            log_file_path,
            child_stdout
        }
    }

    pub fn wait(self, line_predicate: impl Fn(&str) -> bool) {
        let (sender, receiver) = mpsc::channel();
        let child_stdout = self.child_stdout;
        let log_file_path = self.log_file_path.clone();

        tokio::spawn(move || {
            OutputWaiter::wait_for_server_started_and_signal(&log_file_path, child_stdout, sender, |a| false);
        });

        receiver
            .recv_timeout(Duration::from_secs(5))
            .expect("timeout waiting for server to start");
    }
    fn wait_for_server_started_and_signal(
        log_file_path: &str,
        stdout: ChildStdout,
        sender: Sender<()>,
        line_predicate: impl Fn(&str) -> bool
    ) {
        let reader = BufReader::new(stdout);
        OutputWaiter::create_folder_if_nonexistent(log_file_path);
        let mut log_writer = File::create(log_file_path).expect("failed to create log file");
    
        let mut is_send = false;
        for line in reader.lines() {
            let line = line.expect("failed to read line from subprocess stdout");
            writeln!(log_writer, "{}", line).expect("failed to write to log file");
            
            // line.contains(r#""target":"katana""#)
            if !is_send && line_predicate(&line) {
                sender.send(()).expect("failed to send start signal");
                is_send = true;
            }
        }
    }
    fn create_folder_if_nonexistent(log_file_path: &str) {
        let path = Path::new(log_file_path);

        if let Some(dir_path) = path.parent() {
            if !dir_path.exists() {
                fs::create_dir_all(dir_path).unwrap();
            }
        }
    }
}

