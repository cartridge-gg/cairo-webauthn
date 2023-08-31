import os
from typing import List
from abc import ABC, abstractmethod


class CodeBlock(ABC):
    @abstractmethod
    def to_text(self) -> str:
        pass


class Test(CodeBlock):
    name: str
    body: str
    gas: int

    def __init__(self, name: str, body: str, gas: int = 200000000000) -> None:
        super().__init__()
        self.name = name
        self.body = body
        self.gas = gas

    def to_text(self) -> str:
        text = "\n".join(
            ["#[test]", f"#[available_gas({self.gas})]", f"fn test_{self.name}() {{"]
        )

        lines = self.body.split("\n")
        text += "\n\t" + "\n\t".join(lines)
        text += "\n" + "}" + "\n"

        return text


class SimpleBlock(CodeBlock):
    body: str

    def __init__(self, body) -> None:
        super().__init__()
        self.body = body

    def to_text(self) -> str:
        return self.body


class TestFile:
    name: str
    path: str
    imports: List[str]
    tests: List[CodeBlock]
    python_suite_folder: str

    def __init__(self, name: str, python_suite_folder: str) -> None:
        self.imports = []
        self.tests = []
        self.name = name
        self.python_suite_folder = python_suite_folder + name + "_test.py"

    def add_block(self, block: CodeBlock):
        self.tests.append(block)

    def add_blocks(self, blocks: List[CodeBlock]):
        self.tests += blocks

    def add_imports(self, imports: List[str]):
        self.imports += imports

    def file_name(self):
        return self.name + "_gen_test.cairo"

    def write_to_file(self, path: str):
        with open(path + "/" + self.file_name(), "w") as file:
            contents = "// This file is script-generated.\n"
            contents += "// Don't modify it manually!\n"
            contents += f"// See /{os.path.basename(os.path.dirname(self.python_suite_folder))}/auth/{self.name}_test.py for details\n"
            for i in self.imports:
                contents += "use " + i + ";\n"

            contents += "\n"

            for t in self.tests:
                contents += t.to_text() + "\n"
            file.write(contents)


class TestFileCreatorInterface(ABC):
    @abstractmethod
    def test_file(self, python_source_folder) -> TestFile:
        pass


class TestSuite:
    path: str
    mod_file_path: str
    test_files: List[TestFile]
    python_source_folder: str

    splitter = "// ^^^ Auto generated tests ^^^ Place your code below this line!!!"

    def __init__(self, path: str, mod_file_path: str, python_source_folder: str) -> None:
        self.path = path
        self.mod_file_path = mod_file_path
        self.test_files = []
        self.python_source_folder = python_source_folder

    def add_test_file(self, file: TestFileCreatorInterface):
        self.test_files.append(file.test_file(self.python_source_folder))

    def generate(self, delete_old_tests=False):
        if delete_old_tests:
            self.delete_old()

        self.manipulate_mod_file()

        for tf in self.test_files:
            tf.write_to_file(self.path)

    def manipulate_mod_file(self):
        with open(self.mod_file_path, "r") as file:
            content = file.read()

        custom = content.split(TestSuite.splitter)[-1]
        generated = "\n".join([f"mod {t.name}_gen_test;" for t in self.test_files])

        new_content = (
            "\n".join(
                [
                    "// Place your code below auto generated tests' modules!!!",
                    generated,
                    TestSuite.splitter,
                    custom.strip(),
                ]
            )
            + "\n"
        )

        with open(self.mod_file_path, "w") as file:
            file.write(new_content)

    def has_file(self, file_name: str):
        return file_name in [f"{tf.name}_gen_test.cairo" for tf in self.test_files]

    def delete_old(self):
        for file_name in os.listdir(self.path):
            if file_name.endswith("_gen_test.cairo") and not self.has_file(file_name):
                file_path = os.path.join(self.path, file_name)
                try:
                    # Remove the file
                    os.remove(file_path)
                    print(f"Deleted: {file_path}")
                except Exception as e:
                    print(f"Error deleting file {file_path}. Reason: {e}")


from abc import ABC, abstractmethod

