# Converting Docker Image to .flist for Deployment on the Grid

## Overview

This document provides a comprehensive guide on converting the built Docker image of the GridRustyKaspa project to a .flist file for deployment on the ThreeFold Grid. The .flist format is used to efficiently deploy and manage applications on the grid.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Building the Docker Image](#building-the-docker-image)
3. [Using Zero-OS SDK](#using-zero-os-sdk)
   - [Installing Zero-OS SDK](#installing-zero-os-sdk)
   - [Converting Docker Image to .flist using SDK](#converting-docker-image-to-flist-using-sdk)
4. [Using the ThreeFold Hub](#using-the-threefold-hub)
   - [Converting Docker Image to .flist using the Hub](#converting-docker-image-to-flist-using-the-hub)
   - [Uploading .flist to the ThreeFold Hub](#uploading-flist-to-the-threefold-hub)
5. [Deploying on the ThreeFold Grid](#deploying-on-the-threefold-grid)
6. [Troubleshooting](#troubleshooting)

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- Docker installed on your machine.
- Access to the ThreeFold Hub.
- Zero-OS SDK installed on your machine (if using SDK method).

## Building the Docker Image

If you haven't already built the Docker image for GridRustyKaspa, follow these steps:

1. Navigate to the root directory of the GridRustyKaspa repository.

2. Build the Docker image using the following command:

   ```sh
   docker build -t gridrustykaspa .
   ```

This command will create a Docker image named `gridrustykaspa`.

## Using Zero-OS SDK

### Installing Zero-OS SDK

To convert the Docker image to a .flist file using the SDK, you need to install the Zero-OS SDK. Follow these steps:

1. Clone the Zero-OS SDK repository:

   ```sh
   git clone https://github.com/threefoldtech/0-OS_sdk.git
   ```

2. Navigate to the Zero-OS SDK directory:

   ```sh
   cd 0-OS_sdk
   ```

3. Install the SDK dependencies:

   ```sh
   pip install -r requirements.txt
   ```

### Converting Docker Image to .flist using SDK

To convert the Docker image to a .flist file using the SDK, follow these steps:

1. Export the Docker image to a tar file:

   ```sh
   docker save gridrustykaspa -o gridrustykaspa.tar
   ```

2. Use the Zero-OS SDK to convert the tar file to a .flist file:

   ```sh
   ./zos_tools flist create --docker --name gridrustykaspa --file gridrustykaspa.tar
   ```

This command will generate a .flist file named `gridrustykaspa.flist`.

## Using the ThreeFold Hub

### Converting Docker Image to .flist using the Hub

The ThreeFold Hub provides a web interface to convert Docker images to .flist files. Follow these steps:

1. Navigate to the ThreeFold Hub website: [https://hub.grid.tf](https://hub.grid.tf).

2. Log in with threefold connect.

3. Go to the "docker" section.

4. Upload the Docker image tar file (`gridrustykaspa.tar`).

5. Follow the on-screen instructions to convert the Docker image to a .flist file.




## Troubleshooting

Here are some common issues and solutions:

- **Conversion errors**: Ensure the Zero-OS SDK is correctly installed and all dependencies are met.
- **Upload issues**: Verify your internet connection and ensure the .flist file is not corrupted.
- **Deployment problems**: Check the container configuration and ensure the .flist URL is correct.
