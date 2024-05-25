use actix_web::{web, HttpResponse, Error};
use jsonwebtoken::{encode, decode, Header, Validation, EncodingKey, DecodingKey};
use serde::{Deserialize, Serialize};
use actix_service::Service;
use futures_util::future::{ok, Either};
use actix_web::dev::{ServiceRequest, ServiceResponse};
use actix_web::error::ErrorUnauthorized;

#[derive(Debug, Serialize, Deserialize)]
struct Claims {
    sub: String,
    exp: usize,
}

const SECRET_KEY: &[u8] = b"your_secret_key";

pub fn create_jwt(user_id: &str) -> Result<String, jsonwebtoken::errors::Error> {
    let expiration = chrono::Utc::now()
        .checked_add_signed(chrono::Duration::seconds(60))
        .expect("valid timestamp")
        .timestamp() as usize;

    let claims = Claims { sub: user_id.to_owned(), exp: expiration };
    encode(&Header::default(), &claims, &EncodingKey::from_secret(SECRET_KEY))
}

pub fn validate_jwt(token: &str) -> Result<Claims, jsonwebtoken::errors::Error> {
    decode::<Claims>(token, &DecodingKey::from_secret(SECRET_KEY), &Validation::default())
        .map(|data| data.claims)
}

pub async fn login(user: web::Json<User>) -> Result<HttpResponse, Error> {
    if user.username == "admin" && user.password == "password" {
        let token = create_jwt(&user.username)?;
        Ok(HttpResponse::Ok().json(token))
    } else {
        Ok(HttpResponse::Unauthorized().finish())
    }
}

#[derive(Debug, Deserialize)]
pub struct User {
    username: String,
    password: String,
}

pub async fn middleware<S, B>(req: ServiceRequest, srv: &S) -> Result<ServiceResponse<B>, Error>
where
    S: Service<Request = ServiceRequest, Response = ServiceResponse<B>, Error = Error> + 'static,
    B: 'static,
{
    let headers = req.headers();
    if let Some(auth_header) = headers.get("Authorization") {
        if let Ok(auth_str) = auth_header.to_str() {
            if auth_str.starts_with("Bearer ") {
                let token = &auth_str[7..];
                if validate_jwt(token).is_ok() {
                    let res = srv.call(req).await?;
                    return Ok(res);
                }
            }
        }
    }
    Err(ErrorUnauthorized("Unauthorized"))
}
