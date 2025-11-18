<p align="center">
  <img src="https://raw.githubusercontent.com/dennysubke/ashigaru-terminal/main/public/icon.png" alt="Ashigaru Logo" width="96" />
</p>



# Ashigaru Terminal (Docker Version)
A Docker-based, browser-accessible Bitcoin wallet terminal application for use in conjunction with **Ashigaru Whirlpool**.

This repository provides a ready‑to‑use `docker-compose.yml` that allows you to run the Ashigaru Terminal locally using Docker.

---

## 🚀 Features
- Browser-accessible terminal UI (via **gotty**)
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

  ___
