<p align="center">
  <img src="https://raw.githubusercontent.com/dennysubke/ashigaru-terminal/main/public/icon.png" alt="Ashigaru Logo" width="96" />
</p>



# Ashigaru Terminal (Docker Version)
A Docker-based, browser-accessible Bitcoin wallet terminal application for use in conjunction with **Ashigaru Whirlpool**.

This repository provides a ready‑to‑use `docker-compose.yml` that allows you to run the Ashigaru Terminal locally using Docker.

___

> ⚠️ **ARM64 support in progress**
>
> A native ARM64 build of Ashigaru Terminal is available and installs correctly, but the application currently refuses to start in headless environments. Even with a fully emulated display stack (Xvfb + x11vnc + noVNC), the ARM64 binary exits immediately with:
>
> `No display detected. This application has not been built to run on a headless (no display) system.`
>
> All required native libraries (`libX11`, `libGL`, JavaFX ARM binaries, etc.) are present and loaded, but the internal headless check inside the JavaFX application prevents execution.
>
> Because of this, ARM64 support cannot be completed without upstream changes.
>
> Work continues, and updates will follow as soon as a viable solution exists.

___

## 🎴 Overview

Ashigaru Terminal is a **self-custodial Bitcoin wallet** that operates entirely through a **Terminal User Interface (TUI)**. It can be used on desktop systems or deployed on a **headless server**. The application is intentionally minimalistic, offering a simple and accessible way to interact with your Bitcoin funds.

Ashigaru Terminal serves as a **companion application for Ashigaru Whirlpool**, enabling you to perform and manage CoinJoin transactions within your existing wallet setup.

With Ashigaru Terminal, you can:

- **Initiate a Transaction Zero (Tx0)** to create UTXOs for a specific Whirlpool pool in the *Premix* account  
- **Mix coins** from the *Deposit*, *Postmix*, and *Badbank* accounts  
- **Continuously remix** funds from the *Postmix* account  

In short, Ashigaru Terminal provides a lightweight, terminal-based interface that enhances your Bitcoin privacy workflow through Whirlpool.

---

## 📸 Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/dennysubke/ashigaru-terminal/refs/heads/main/public/screen1.jpg" width="32%" />
  <img src="https://raw.githubusercontent.com/dennysubke/ashigaru-terminal/refs/heads/main/public/screen2.jpg" width="32%" />
  <img src="https://raw.githubusercontent.com/dennysubke/ashigaru-terminal/refs/heads/main/public/screen3.jpg" width="32%" />
</p>

---

## 🚀 Features
- Browser-accessible terminal UI
- Built‑in **Tor SOCKS proxy**
- Persistent Tor datadir
- Auto-starting tmux session running Ashigaru Terminal
- Fully containerized & simple to deploy

---

## 📦 Requirements
Before you begin, ensure that you have:

- **Docker** installed  
  https://docs.docker.com/get-docker/

- **Docker Compose** installed  
  Included in Docker Desktop or install separately.

---

## 🛠️ Installation & Running (Docker Compose)

### 1. Clone this repository

```bash
git clone https://github.com/dennysubke/ashigaru-terminal.git
cd ashigaru-terminal
```


### 2. Start the container

```bash
docker compose up -d
```

### 3. Access the Terminal

Open your browser and visit:

```
http://localhost:7682
```

---

## 🪛 Rebuilding the Image Locally

If you want to build the image from the Dockerfile in this repo:

```bash
docker build -t ashigaru-terminal .
```

Then run it:

```bash
docker run -p 7682:7682 ashigaru-terminal
```
___

## 📝 Usage Tips & Important Notes

### 🔧 Terminal usage

- **Paste text** into the web terminal using:
  - **Windows/Linux:** `Ctrl + Shift + V`
  - **macOS:** `Cmd + Shift + V`
- Browsers with fingerprinting resistance (e.g., **LibreWolf**, **Tor Browser**) may block the terminal from receiving keystrokes.  
  If this happens, disable `resistFingerprinting` temporarily or use a Chromium-based browser like **Brave**.

### 🧅 Using Tor inside Ashigaru Terminal

To connect to an Electrum server through Tor:

1. Enter the server’s **.onion** hostname  
2. Use the correct Electrum port  
3. Enable proxy access:
   - **Proxy address:** `127.0.0.1`
   - **Proxy port:** `9050`

### 🔐 Wallet Safety

- Updates might not preserve existing wallets.  
- **Always back up your seed phrase** before upgrading, migrating, or modifying anything.
- The Ashigaru Mobile App and this terminal are designed to work together.

### ⚠️ Security & Authenticity

- The **only official website** is:  
  **https://ashigaru.rs**
- Ashigaru has **no social media accounts**.  
- Anyone claiming to represent Ashigaru outside the website is fraudulent.
- Always act responsibly, verify information, and make informed decisions.  
  The developers assume no liability for improper use.

### 📚 Helpful Resources

- Ashigaru Code Repository (Tor only)   
  http://ashicodepbnpvslzsl2bz7l2pwrjvajgumgac423pp3y2deprbnzz7id.onion/Ashigaru/Ashigaru-Terminal

- Ashigaru Terminal Overview  
  https://ashigaru.rs/docs/ashigaru-terminal-overview

- Whirlpool Guide  
  https://k3tan.com/ashigaru-whirlpool

  ##
