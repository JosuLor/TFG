const express = require("express");
const app = express();
const path = require("path")
const fs = require("fs")
const { spawn } = require('child_process');
const bodyParser = require("body-parser");
const appPath="./Analysis-app/"

app.set('view engine', 'ejs');
app.set('views', './views');
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true }));

// 0: No iniciado; 1: En progreso; 2: Finalizado (correctamente); 3: No hay; -1: Finalizado (con error)
let progressJson;
let currentIP;
let currentDomain;

app.get("/", (req, res) => {
    /*
    scriptProcess = spawn('bash', [appPath+"DNS/mainDNS.sh", "ikasten.io"]);
    scriptProcess.on('close', (code) => {
        console.log("CODE: ", code)
        console.log("Ping execution ended");
    });
    */
    res.render("index.ejs")
})

app.get("/pingProgress", (req, res) => {
    res.send(progressJson)
});

app.post("/ping", (req, res) => {
    currentIP = req.body.ip;
    currentDomain = req.body.domain;
    res.render("pinging.ejs", {ip: req.body.ip})
    progressJson = { "ping": 0 }
    console.log("ping execution started")
    const scriptProcess = spawn('bash', [appPath+"/general/ping-start.sh", currentIP]);
    scriptProcess.on('close', (code) => {
        console.log("CODE: ", code)
        console.log("Ping execution ended");
        if (code == 0) progressJson.ping = 2; else progressJson.ping = -1;
    });

    scriptProcess.stdout.on('data', (data) => {
        console.log(data.toString());
    });
});

app.get("/generateJSON", (req, res) => {
    console.log("JSON generation started")
    
    const jsonProcess = spawn('bash', ['./Analysis-app/general/merge-json.sh', currentIP, currentDomain]);
    jsonProcess.on('close', (jsonCode) => {
        console.log("CODE json: ", jsonCode)
        console.log("JSON execution ended");
        res.send("")
    })
});

app.get("/progress", (req, res) => {
    res.send(progressJson)
});

app.post("/analyze", (req, res) => {

    progressJson = { "ports": 0, "dns": 0, "ssh": 0, "ftp": 0, "samba": 0, "sql": 0 }

    res.render("analyzing.ejs", {ip: currentIP, domain: currentDomain})

    let ssh = false;
    let ftp = false;
    let samba = false;
    let sql = false;

    console.log("nmap execution started")
    progressJson.ports = 1;
    const scriptProcess = spawn('bash', [appPath+"/general/nmap-start.sh", currentIP]);
    scriptProcess.on('close', (code) => {
        console.log("CODE: ", code)
        console.log("Nmap execution ended");
        if (code == 0) progressJson.ports = 2; else progressJson.ports = -1;
    
        if (currentDomain != "" && currentDomain != null) {
            progressJson.dns = 1;
            const dnsProcess = spawn('bash', ['./Analysis-app/DNS/mainDNS.sh', currentDomain]);
            dnsProcess.on('close', (dnsCode) => {
                console.log("CODE dns: ", dnsCode)
                console.log("DNS execution ended");
                if (dnsCode == 0) progressJson.dns = 2; else progressJson.dns = -1;
            });

            dnsProcess.stdout.on('data', (data) => {
                const output = data.toString().toLowerCase();
                console.log(data.toString());
            });
        } else {
            progressJson.dns = 3;
        }

        if (ssh) {
            progressJson.ssh = 1;
            const sshProcess = spawn('bash', ['./Analysis-app/SSH/mainSSH.sh', currentIP]);
            sshProcess.on('close', (sshCode) => {
                console.log("CODE ssh: ", sshCode)
                console.log("SSH execution ended");
                if (sshCode == 0) progressJson.ssh = 2; else progressJson.ssh = -1;
            });
        }

        if (ftp) {
            progressJson.ftp = 1;
            const ftpProcess = spawn('bash', ['./Analysis-app/FTP/mainFTP.sh', currentIP]);
            ftpProcess.on('close', (ftpCode) => {
                console.log("CODE ftp: ", ftpCode)
                console.log("FTP execution ended");
                if (ftpCode == 0) progressJson.ftp = 2; else progressJson.ftp = -1;
            });
        }

        if (samba) {
            progressJson.samba = 1;
            const sambaProcess = spawn('bash', ['./Analysis-app/SAMBA/mainSAMBA.sh', currentIP]);
            sambaProcess.on('close', (sambaCode) => {
                console.log("CODE samba: ", sambaCode)
                console.log("SAMBA execution ended");
                if (sambaCode == 0) progressJson.samba = 2; else progressJson.samba = -1;
            });
        }

        if (sql) {
            progressJson.sql = 1;
            const sqlProcess = spawn('bash', ['./Analysis-app/SQL/mainSQL.sh', currentIP]);
            sqlProcess.on('close', (sqlCode) => {
                console.log("CODE sql: ", sqlCode)
                console.log("SQL execution ended");
                if (sqlCode == 0) progressJson.sql = 2; else progressJson.sql = -1;
            });
        }
    });

    scriptProcess.stdout.on('data', (data) => {
        const output = data.toString().toLowerCase();
        
        if (output.includes("ssh")) { ssh = true; } else { progressJson.ssh = 3; }
        if (output.includes("ftp")) {  ftp = true;  } else { progressJson.ftp = 3;}
        if (output.includes("samba")) { samba = true; } else { progressJson.samba = 3; }
        if (output.includes("sql")) { sql = true; } else { progressJson.sql = 3; }
    });
  });

app.get("/downloadJSON", (req, res) => {

    const file = `${__dirname}/Analysis-app/general/global.json`
    console.log("FILE: " + file);
    res.download(file);
});

app.listen(3000, function() {console.log("Servidor lanzando en el puerto 3000")});