const express = require('express');
const session = require('express-session');
const loadRoutes = require('./Routes');
const db = require('./Database/mysql');
const path = require("path");
const cookieParser = require('cookie-parser');
const messages = require('./Constants/messages');
const codes = require('./Constants/codes');
require('dotenv').config();

const app = express();

app.use(express.json());
app.use(cookieParser());
app.use(session({
  secret: process.env.TOKEN_SECRET, 
  resave: false,
  saveUninitialized: false,
  cookie: {
    maxAge: parseInt(process.env.SESSION_AGE),
    httpOnly: true,
  }
}));

const publicPost = [
  "/api/login",
  "/api/get-login-status"
];

app.use((req, res, next) => {
  if (!req.session?.userdata && (req.method === 'POST' || req.method === "PUT") && !publicPost.includes(req.path)) {
    res.status(401);
    res.json({ message: messages.login401, code: codes.loginRequired });
  } else {
    next();
  }
  // console.log(req.url);
  // res.status(401);
});

app.use(express.static(path.join(__dirname, '/Client/dist')));
app.get('*', (req, res, next) => {
  const page = req.originalUrl.split('/');
  const endpoint = process.env.ENDPOINT;
  if(page[1] == endpoint.slice(1, endpoint.length)) {
    next();
  } else {
    res.sendFile(path.join(__dirname, '/Client/dist/index.html'));
  }
});

loadRoutes(db, app);

const port = process.env.PORT || 3000;

app.listen(port, () => {
  console.log("Listening on port " + port);
});