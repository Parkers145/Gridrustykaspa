# API Documentation

This document provides detailed information about the API endpoints provided by the Gridrustykaspa project.

## Table of Contents

- [Overview](#overview)
- [Authentication](#authentication)
- [Endpoints](#endpoints)
  - [Wallet Endpoints](#wallet-endpoints)
  - [Node Endpoints](#node-endpoints)
- [Error Handling](#error-handling)

## Overview

The API is built using Actix Web and provides endpoints for managing wallets and the Kaspa node.

## Authentication

The API uses JWT-based authentication. You need to include a valid JWT token in the `Authorization` header for all requests.

## Endpoints

### Wallet Endpoints

#### Create Wallet

```
POST /api/wallet/create
```

Creates a new wallet.

#### Get Wallet Balance

```
GET /api/wallet/{wallet_id}/balance
```

Returns the balance of the specified wallet.

#### Send Transaction

```
POST /api/wallet/{wallet_id}/send
```

Sends a transaction from the specified wallet.

#### Import Wallet

```
POST /api/wallet/{wallet_id}/import
```

Imports a wallet using a seed phrase.

### Node Endpoints

#### Get Node Status

```
GET /api/node/status
```

Returns the status of the Kaspa node.

#### Start Node

```
POST /api/node/start
```

Starts the Kaspa node.

#### Stop Node

```
POST /api/node/stop
```

Stops the Kaspa node.

## Error Handling

All endpoints return appropriate HTTP status codes and error messages.
