use std::sync::Mutex;
use std::process::Child;

pub struct AppState {
    pub node_process: Mutex<Option<Child>>,
}

impl AppState {
    pub fn new() -> Self {
        AppState {
            node_process: Mutex::new(None),
        }
    }
}
