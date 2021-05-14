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
    
    debugLog({days, mins, debug});
    
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

const $routes = [];

// Define all route maps here
$routes.push({route: "/shopify_orders.asp", days: -355, mins: 20});
$routes.push({route: "/shopify_orders2.asp", days: -720, mins: 17});
$routes.push({route: "/shopify_orders3.asp", days: -1085, mins: 17});
$routes.push({route: "/shopify_orders4.asp", days: -1453, mins: 17});
$routes.push({route: "/shopify_ordersDO.asp", days: -365, mins: 20});
$routes.push({route: "/shopify_ordersDO2.asp", days: -730, mins: 17});
$routes.push({route: "/shopify_ordersDO3.asp", days: -1095, mins: 17});
$routes.push({route: "/shopify_ordersDO4.asp", days: -1463, mins: 17});

// Configure all end-points dynamically based on the route map
$routes.forEach($route => {
    debugLog($route);
    
    app.get($route.route, async (req, res) => {
        const $response = await getApiResponse($route.days || -355, $route.mins || 17, req.query.debug==="1");
        res.send($response);
    });
});

app.listen($PORT, $HOST, () => {
    debugLog("Shopify Proxy starting up...");
    console.log(apiURL);
    console.log(`Shopify Proxy listening on ${$HOST}:${$PORT}!`);
  }
);