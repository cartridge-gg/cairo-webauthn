use starknet::core::types::FieldElement;

pub struct CallSequence {
    calls: Vec<[FieldElement; 4]>,
}

impl Default for CallSequence {
    fn default() -> Self {
        Self {
            calls: vec![[FieldElement::default(); 4]],
        }
    }
}

impl Into<Vec<FieldElement>> for CallSequence {
    fn into(self) -> Vec<FieldElement> {
        let mut result = Vec::new();
        result.push(self.calls.len().into());
        result.extend(self.calls.into_iter().flatten());
        result
    }
}
