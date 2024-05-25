use actix_web::{get, post, web, HttpResponse, Responder};
use reqwest::Client;
use serde_json::json;
use std::error::Error;

const RPC_URL: &str = "http://localhost:16110";
const RPC_USER: &str = "user";
const RPC_PASS: &str = "pass";

async fn rpc_call(method: &str, params: serde_json::Value) -> Result<serde_json::Value, Box<dyn Error>> {
    let client = Client::new();
    let response = client.post(RPC_URL)
        .basic_auth(RPC_USER, Some(RPC_PASS))
        .json(&json!({
            "jsonrpc": "1.0",
            "id": "curltest",
            "method": method,
            "params": params
        }))
        .send()
        .await?;
    
    let json: serde_json::Value = response.json().await?;
    Ok(json)
}

#[post("/wallet/create")]
async fn create() -> impl Responder {
    match rpc_call("createwallet", json!(["mynewwallet"])).await {
        Ok(response) => HttpResponse::Ok().json(response),
        Err(e) => HttpResponse::InternalServerError().body(e.to_string())
    }
}

#[get("/wallet/{wallet_id}/balance")]
async fn balance(wallet_id: web::Path<String>) -> impl Responder {
    match rpc_call("getbalance", json!([wallet_id.into_inner()])).await {
        Ok(response) => HttpResponse::Ok().json(response),
        Err(e) => HttpResponse::InternalServerError().body(e.to_string())
    }
}

#[post("/wallet/{wallet_id}/send")]
async fn send(wallet_id: web::Path<String>, json: web::Json<SendRequest>) -> impl Responder {
    let params = json!([wallet_id.into_inner(), json.to_address, json.amount]);
    match rpc_call("sendtoaddress", params).await {
        Ok(response) => HttpResponse::Ok().json(response),
        Err(e) => HttpResponse::InternalServerError().body(e.to_string())
    }
}

#[post("/wallet/{wallet_id}/import")]
async fn import(wallet_id: web::Path<String>, json: web::Json<ImportRequest>) -> impl Responder {
    let params = json!([wallet_id.into_inner(), json.seed_phrase]);
    match rpc_call("importwallet", params).await {
        Ok(response) => HttpResponse::Ok().json(response),
        Err(e) => HttpResponse::InternalServerError().body(e.to_string())
    }
}

#[derive(Deserialize)]
pub struct SendRequest {
    to_address: String,
    amount: f64,
}

#[derive(Deserialize)]
pub struct ImportRequest {
    seed_phrase: String,
}

pub fn init(cfg: &mut web::ServiceConfig) {
    cfg.service(create);
    cfg.service(balance);
    cfg.service(send);
    cfg.service(import);
}
