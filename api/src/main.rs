use actix_files as fs;
use actix_web::{web, App, HttpServer};
mod handlers;
mod auth;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .service(fs::Files::new("/", "/usr/local/share/web-wallet").index_file("index.html"))
            .service(web::scope("/api")
                .configure(handlers::wallet::init)
                .configure(handlers::node::init)
                .configure(auth::init))
            .wrap_fn(auth::middleware)
    })
    .bind("0.0.0.0:80")?
    .run()
    .await
}
