import express from "express";
import dotenv from "dotenv";
import fetch from 'node-fetch';
import bodyParser from "body-parser";

const app = express();
dotenv.config();

const userName = process.env.API_User;
const password = process.env.API_Password;
const apiURL = `https://${userName}:${password}@novel-concept-designs.myshopify.com/admin/orders.json?created_at_min=[dFrm]&created_at_max=[dTo]&fields=id,email,customer`;

app.use(function(req, res, next) {
    res.setHeader("Content-Type", "application/json");
    next();
});

const $PORT = process.env.PORT || 8088;
const $HOST = process.env.HOST || "localhost";

app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

const debugLog = msg => console.log(msg);

const padString = (input, len, pad = "0") => {
    input = input + "";

    while (input.length < len) {
        input = pad + input;
    }

    return input;
};

Date.prototype.addDays = function(days) {
    let date = new Date(this.valueOf());
    date.setDate(date.getDate() + days);
    return date;
};

const getApiResponse = async (days, mins, debug=false) => {
    const now = new Date();
    const dteFrm = now.addDays(days+1);

    const minF = padString(now.getMinutes() - mins, 2);
    const minT = padString(now.getMinutes(), 2);
    
    const dFrm = `${dteFrm.getFullYear()}-${padString(dteFrm.getMonth()+1, 2)}-${padString(dteFrm.getDate(), 2)} ${padString(now.getHours(), 2)}:${minF}:00`;
    const dTo = `${dteFrm.getFullYear()}-${padString(dteFrm.getMonth()+1, 2)}-${padString(dteFrm.getDate(), 2)} ${padString(now.getHours(), 2)}:${minT}:00`;
    
    const $url = apiURL.replace("[dFrm]", dFrm).replace("[dTo]", dTo);

    return new Promise((resolve, reject) => {
        
        if (debug) {
            console.log($url);
        }

        fetch($url).then(d => d.json()).then(d => {
            if(debug) {
                d.url = $url;
            }
            resolve(d);
        });
    });
};

app.get("/shopify_orders.asp", async (req, res) => {
    const $response = await getApiResponse(-355, 20, req.query.debug==="1");
    res.send($response);
});

app.get("/shopify_orders2.asp", async (req, res) => {
    const $response = await getApiResponse(-720, 17, req.query.debug==="1");
    res.send($response);
});

app.get("/shopify_orders3.asp", async (req, res) => {
    const $response = await getApiResponse(-1085, 17, req.query.debug==="1");
    res.send($response);
});


app.get("/shopify_ordersDO.asp", async (req, res) => {
    const $response = await getApiResponse(-365, 20, req.query.debug==="1");
    res.send($response);
});

app.get("/shopify_ordersDO2.asp", async (req, res) => {
    const $response = await getApiResponse(-730, 17, req.query.debug==="1");
    res.send($response);
});

app.get("/shopify_ordersDO3.asp", async (req, res) => {
    const $response = await getApiResponse(-1095, 17, req.query.debug==="1");
    res.send($response);
});

app.listen($PORT, $HOST, () =>
  {
    debugLog("Shopify Proxy starting up...");
    console.log(apiURL);
    console.log(`Shopify Proxy listening on ${$HOST}:${$PORT}!`);
  }
);