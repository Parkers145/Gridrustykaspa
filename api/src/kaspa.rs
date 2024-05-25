use std::process::{Command, Child, Stdio};
use std::fs::File;

pub fn start_node() -> std::io::Result<Child> {
    let log_file = File::create("/var/log/kaspad.log")?;
    let process = Command::new("/usr/local/bin/kaspad")
        .stdout(Stdio::from(log_file.try_clone()?))
        .stderr(Stdio::from(log_file))
        .spawn()?;
    Ok(process)
}

pub fn stop_node(process: &mut Child) -> std::io::Result<()> {
    process.kill()?;
    process.wait()?;
    Ok(())
}
