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

let progressJson;   // 0: No iniciado; 1: En progreso; 2: Finalizado (correctamente); -2: No hay; -1: Finalizado (con error)
let nmapJson;
//let selectionJson;  // 0: No seleccionado; 1: seleccionado || "": No seleccionado; "string": seleccionado
let selectionJson = { "dns": { "basic": "on", "xss_url": "", "xss_domain": "" }, "ssh": { "basic": "on" }, "ftp": { "basic": "on" }, "samba": { "basic": "on" }, "sql": { "basic": "on" } }
let currentIP = "Get out of China";
let currentDomain = "";

let ssh = false;
let ftp = false;
let samba = false;
let sql = false;

app.get("/", (req, res) => {

    progressJson = ""; nmapJson = ""; selectionJson = "";
    currentIP = ""; currentDomain = "";
    ssh = false; ftp = false; samba = false; sql = false;

    res.render("index.ejs")
})

app.get("/pingProgress", (req, res) => {
    res.send(progressJson)
});

app.post("/ping", (req, res) => {
    currentIP = req.body.ip;
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

app.post("/nmap", (req, res) => {
    nmapJson = { "status": 0 }
    progressJson = { "ports": 0, "dns": 0, "ssh": 0, "ftp": 0, "samba": 0, "sql": 0 }
    selectionJson = { "dns": { "basic": "on", "xss_url": "", "xss_domain": "" }, "ssh": { "basic": "on" }, "ftp": { "basic": "on" }, "samba": { "basic": "on" }, "sql": { "basic": "on" } }
    res.render("nmaping.ejs", {ip: currentIP})
    
    console.log("nmap execution started")
    const scriptProcess = spawn('bash', [appPath+"/general/nmap-start.sh", currentIP]);
    scriptProcess.on('close', (code) => {
        console.log("CODE: ", code)
        console.log("Nmap execution ended");
        if (code == 0) nmapJson.status = 1; else nmapJson.status = 2;   // 1 = OK; 2 = ERROR
    });

    scriptProcess.stdout.on('data', (data) => {
        const output = data.toString().toLowerCase();
        
        if (output.includes("ssh")) { ssh = true; } else { progressJson.ssh = 3; }
        if (output.includes("ftp")) {  ftp = true;  } else { progressJson.ftp = 3;}
        if (output.includes("samba")) { samba = true; } else { progressJson.samba = 3; }
        if (output.includes("sql")) { sql = true; } else { progressJson.sql = 3; }
    });

});

app.get("/generateJSON", (req, res) => {
    console.log("JSON generation started")
    let currentDomain = "";
    
    if (selectionJson.dns.xss_domain != "") {
        currentDomain = selectionJson.dns.xss_domain;
    } else {
        currentDomain = selectionJson.dns.xss_url;
    }
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
    res.render("analyzing.ejs", {ip: currentIP, discovered: progressJson})
});

app.get("/analyze", (req, res) => {
    res.render("analyzing.ejs", {ip: currentIP, discovered: progressJson})
});

function dispatcher (protocolID) {
    console.log("Llamada a dispatcher")

    switch (protocolID) {
        case 0:
            if (progressJson.ftp != 3 && selectionJson.ftp.basic == "on") {
                selectionJson.ftp.basic == "off";
                dispatcher(3);
            } else if (progressJson.ssh != 3 && selectionJson.ssh.basic == "on") {
                selectionJson.ssh.basic == "off";
                dispatcher(2);
            } else if (progressJson.samba != 3 && selectionJson.samba.basic == "on") {
                selectionJson.samba.basic == "off";
                dispatcher(4);
            } else if (progressJson.ftp != 3 && selectionJson.sql.basic == "on") {
                selectionJson.sql.basic == "off";
                dispatcher(5);
            } else if (selectionJson.dns.basic == "on") {
                selectionJson.dns.basic == "off"
                dispatcher(1);
            } else if (selectionJson.dns.xss_url != "" || selectionJson.dns.xss_domain != "") {
                dispatcher(6);
            }
            break;
        case 1:
            console.log("Llamada a dispatcher 1")

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

            break;
        case 2:
            console.log("Llamada a dispatcher 2")

            progressJson.ssh = 1;
            const sshProcess = spawn('bash', ['./Analysis-app/SSH/mainSSH.sh', currentIP]);
            sshProcess.on('close', (sshCode) => {
                console.log("CODE ssh: ", sshCode)
                console.log("SSH execution ended");
                if (sshCode == 0) progressJson.ssh = 2; else progressJson.ssh = -1;
                dispatcher(0);
            });

            break;
        case 3:
            console.log("Llamada a dispatcher 3")
            
            progressJson.ftp = 1;
            const ftpProcess = spawn('bash', ['./Analysis-app/FTP/mainFTP.sh', currentIP]);
            ftpProcess.on('close', (ftpCode) => {
                console.log("CODE ftp: ", ftpCode)
                console.log("FTP execution ended");
                if (ftpCode == 0) progressJson.ftp = 2; else progressJson.ftp = -1;
                dispatcher(0);
            });
            
            break;
        case 4:
            console.log("Llamada a dispatcher 4")
            
            progressJson.samba = 1;
            const sambaProcess = spawn('bash', ['./Analysis-app/SAMBA/mainSAMBA.sh', currentIP]);
            sambaProcess.on('close', (sambaCode) => {
                console.log("CODE samba: ", sambaCode)
                console.log("SAMBA execution ended");
                if (sambaCode == 0) progressJson.samba = 2; else progressJson.samba = -1;
                dispatcher(0);
            });
            
            break;
        case 5:
            console.log("Llamada a dispatcher 5")
            
            progressJson.sql = 1;
            const sqlProcess = spawn('bash', ['./Analysis-app/SQL/mainSQL.sh', currentIP]);
            sqlProcess.on('close', (sqlCode) => {
                console.log("CODE sql: ", sqlCode)
                console.log("SQL execution ended");
                if (sqlCode == 0) progressJson.sql = 2; else progressJson.sql = -1;
                dispatcher(0);
            });

            break;
        case 6:
            console.log("Llamada a dispatcher 6")

            if (selectionJson.dns.option_xss == "url") {
            
            } else if (selectionJson.dns.option_xss == "domain") {

            }

            const xssProcess = spawn('bash', ['./Analysis-app/DNS/analyzer/launcher.sh', currentDomain]);

            break;
        default:
            console.log("Llamada a dispatcher default")
            break;
    }
}

app.get("/downloadJSON", (req, res) => {

    const file = `${__dirname}/Analysis-app/general/global.json`
    console.log("FILE: " + file);
    res.download(file);
});

app.post("/options", (req, res) => {
    let prot = req.body.prot;
    res.render("options.ejs", {protocol: prot, selection: selectionJson})
});

app.post("/sendOptions", (req, res) => {
    console.log("BASIC:" + JSON.stringify(req.body))
    switch (req.body.protocol) {
        case "DOMAIN":
            if (req.body.basic == "on") {
                selectionJson.dns.basic = req.body.basic;
            } else {
                selectionJson.dns.basic = "off";
            }
            
            if (req.body.option_xss == "domain") {
                selectionJson.dns.xss_domain = req.body.xss_domain_text;
            } else if (req.body.option_xss == "url") {
                selectionJson.dns.xss_url = req.body.xss_url_text;
            } else {
                selectionJson.dns.xss_domain = "";
                selectionJson.dns.xss_url = "";
            }
            break;
        case "SSH":
            if (req.body.basic == "on") {
                selectionJson.ssh.basic = req.body.basic;
            } else {
                selectionJson.ssh.basic = "off";
            }
            break;
        case "FTP":
            if (req.body.basic == "on") {
                selectionJson.ftp.basic = req.body.basic;
            } else {
                selectionJson.ftp.basic = "off";
            }
            break;
        case "SAMBA":
            if (req.body.basic == "on") {
                selectionJson.samba.basic = req.body.basic;
            } else {
                selectionJson.samba.basic = "off";
            }
            break;
        case "SQL":
            if (req.body.basic == "on") {
                selectionJson.sql.basic = req.body.basic;
            } else {
                selectionJson.sql.basic = "off";
            }
            break;
        default:
            console.log("ERROR: Protocolo no reconocido:" + req.body.protocol)
            break;
    }
    console.log("Selection: " + JSON.stringify(selectionJson));

    res.render("analyzing.ejs", { ip: currentIP, discovered: progressJson })
});

app.get("/startAnalysis", (req, res) => {
    dispatcher();
    res.send("");
});


let currentURL = "https://brutelogic.com.br/gym.php";
let currentURL_JSON = "";
let domain = "ikasten.io";
let domainJSON = { "urls": -1 };
let contURL = 0;
let lineas;
app.get("/debug", (req, res) => {
    //progressJson = { "ports": 0, "dns": 0, "ssh": 0, "ftp": 0, "samba": 0, "sql": 0 }

    //progressJson = { "ports": 0, "dns": 0, "ssh": 0, "ftp": 0, "samba": 0, "sql": 0 }
    //selectionJson = { "dns": { "basic": true, "xss_url": "asdf", "xss_domain": "ffff" }, "ssh": { "basic": true }, "ftp": { "basic": true }, "samba": { "basic": true }, "sql": { "basic": true } }

    //res.render("analyzing.ejs", {ip: currentIP, discovered: progressJson})
    
    //const xssProcess = spawn('bash', ['./Analysis-app/DNS/analyzer/launcher.sh', currentURL]);


    fs.unlink("./Analysis-app/DNS/analyzer/temp-vulns.json", (err) => {});
    const scriptProcess = spawn('bash', ["./Analysis-app/DNS/analyzer/clean-temp.sh"]);
    currentURL_JSON = "";
    res.render("domainXSS.ejs", { domain: domain });
});

app.get("/startIndividualURL", (req, res) => {
    analyzeOneURL(currentURL);
    res.send("");
});

app.get("/getIndividualURL", (req, res) => {
    //console.log(currentURL_JSON)
    res.send( currentURL_JSON );
});

function analyzeOneURL(url) {
    const scriptProcess = spawn('bash', ["./Analysis-app/DNS/analyzer/eachAnalyzer.sh", url]);
    
    scriptProcess.stdout.on('data', (data) => {
        var txt = data.toString();
        
        currentURL_JSON = txt;
    });
    
    scriptProcess.on('close', (code) => {
        console.log("EXIT INDIVIDUAL: ", code)
        currentURL_JSON = { "END": 1 };

        fs.access("./Analysis-app/DNS/analyzer/temp-vulns.json", fs.constants.F_OK, (err) => {
            if (err) {
              fs.writeFile("./Analysis-app/DNS/analyzer/temp-vulns.json", '{}', (err) => {
                if (err) {
                  console.error('Error al crear el archivo:', err);
                } else {
                  console.log('Archivo creado exitosamente.');
                }
              });
            } else {
              console.log('El archivo ya existe.');
            }
          });
    });
}

app.get("/startFullDomain", (req, res) => {
    const scriptProcess = spawn('bash', ["./Analysis-app/DNS/analyzer/test.sh", domain]);

    scriptProcess.stdout.on('data', (data) => {
        var txt = data.toString();
        //console.log("URLs: " + txt);
        domainJSON.urls = txt;
    });
    
    res.send("");
});

app.get("/getDomain", (req, res) => {
    res.send(domainJSON);
});

app.get("/startURLvuln", (req, res) => {
    domainJSON = { "urls": -1 };
    analyzeDomain();
    res.send("");
});

function analyzeDomain() {
    contURL = 0;

    fs.readFile("./Analysis-app/DNS/analyzer/out-sorted-https.txt", 'utf8', (err, data) => {
        if (err) {
          console.error('Error al leer el archivo:', err);
          return;
        }

        lineas = data.split('\n').filter(linea => linea.trim() !== '');
        analyzeAllDomain();
    });
}

function analyzeAllDomain() {
    if (contURL == lineas.length) {
        currentURL_JSON = { "END": 1 };
        
        const scriptProcess = spawn('bash', ["./Analysis-app/DNS/analyzer/clean-temp.sh"]);

        fs.access("./Analysis-app/DNS/analyzer/temp-vulns.json", fs.constants.F_OK, (err) => {
            if (err) {
              fs.writeFile("./Analysis-app/DNS/analyzer/temp-vulns.json", '{}', (err) => {
                if (err) {
                  console.error('Error al crear el archivo:', err);
                } else {
                  console.log('Archivo creado exitosamente.');
                }
              });
            } else {
              console.log('El archivo ya existe.');
            }
          });

    } else {
        var linea = lineas[contURL];
        analyzeIndividualURL(linea);
        contURL++;
    }
}

function analyzeIndividualURL(url) {
    
    const scriptProcess = spawn('bash', ["./Analysis-app/DNS/analyzer/eachAnalyzer.sh", url]);
    
    scriptProcess.stdout.on('data', (data) => {
        var txt = data.toString();
        
        currentURL_JSON = txt;
    });
    
    scriptProcess.on('close', (code) => {
        analyzeAllDomain();
        //console.log("EXIT INDIVIDUAL: ", url)
    });
}

app.listen(3000, function() {console.log("Servidor lanzando en el puerto 3000")});