use actix_web::{web, HttpResponse, Responder};
use std::fs::File;
use std::io::{BufReader, Read};
use crate::state::AppState;
use crate::kaspa;

pub fn config(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::resource("/start")
            .route(web::post().to(start_node))
    )
    .service(
        web::resource("/stop")
            .route(web::post().to(stop_node))
    )
    .service(
        web::resource("/status")
            .route(web::get().to(status))
    )
    .service(
        web::resource("/logs")
            .route(web::get().to(get_logs))
    );
}

async fn start_node(data: web::Data<AppState>) -> impl Responder {
    let mut node_process = data.node_process.lock().unwrap();
    if node_process.is_none() {
        match kaspa::start_node() {
            Ok(process) => {
                *node_process = Some(process);
                HttpResponse::Ok().body("Kaspa node started")
            }
            Err(e) => HttpResponse::InternalServerError().body(format!("Failed to start Kaspa node: {}", e)),
        }
    } else {
        HttpResponse::Ok().body("Kaspa node is already running")
    }
}

async fn stop_node(data: web::Data<AppState>) -> impl Responder {
    let mut node_process = data.node_process.lock().unwrap();
    if let Some(mut process) = node_process.take() {
        match kaspa::stop_node(&mut process) {
            Ok(_) => HttpResponse::Ok().body("Kaspa node stopped"),
            Err(e) => HttpResponse::InternalServerError().body(format!("Failed to stop Kaspa node: {}", e)),
        }
    } else {
        HttpResponse::Ok().body("Kaspa node is not running")
    }
}

async fn status(data: web::Data<AppState>) -> impl Responder {
    let node_process = data.node_process.lock().unwrap();
    if node_process.is_some() {
        HttpResponse::Ok().body("Kaspa node is running")
    } else {
        HttpResponse::Ok().body("Kaspa node is not running")
    }
}

async fn get_logs() -> Result<HttpResponse, actix_web::Error> {
    let file = File::open("/var/log/kaspad.log").map_err(|e| {
        HttpResponse::InternalServerError().body(format!("Failed to open log file: {}", e))
    })?;

    let mut reader = BufReader::new(file);
    let mut contents = String::new();
    reader.read_to_string(&mut contents).map_err(|e| {
        HttpResponse::InternalServerError().body(format!("Failed to read log file: {}", e))
    })?;

    Ok(HttpResponse::Ok().body(contents))
}
