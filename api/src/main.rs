mod handlers;
mod state;
mod kaspa;

use actix_web::{web, App, HttpServer};
use state::AppState;
use env_logger;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    env_logger::init();
    let app_state = web::Data::new(AppState::new());

    HttpServer::new(move || {
        App::new()
            .app_data(app_state.clone())
            .configure(handlers::config)
    })
    .bind("0.0.0.0:8080")?
    .run()
    .await
}
