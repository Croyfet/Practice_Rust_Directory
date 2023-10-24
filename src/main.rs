use std::{fs, path::PathBuf};

const DIRETORY: &str = "./resource";

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("Hello, world!");

    let entries = fs::read_dir(DIRETORY);

    let entries: fs::ReadDir = match entries {
        Ok(o) => o,
        Err(e) => {
            println!("Failed to find directory.");
            return Err(e.into());
        }
    };

    let mut files = Vec::<String>::new();

    for entry in entries {
        let _ = match entry {
            Ok(o) => {
                let path = o.path();
                if path.is_file() && is_html(&path) {
                    let file_path = match path.file_name() {
                        Some(o) => o,
                        None => {
                            return Err("Failed to get path".into());
                        }
                    };

                    let file_path = match file_path.to_str() {
                        Some(o) => o,
                        None => {
                            return Err("Failed to get path".into());
                        }
                    };

                    files.push(file_path.to_owned());
                }
            }
            Err(e) => {
                return Err(e.into());
            }
        };
    }

    println!("{:?}", files);

    println!("----------------");

    Ok(())
}

fn is_html(p: &PathBuf) -> bool {
    if let Some(o) = p.extension() {
        //println!("{:?}", o);
        if let Some(a) = o.to_str() {
            if a == "html" {
                println!("match {}", a);
                return true;
            }
        }
    }

    false
}
