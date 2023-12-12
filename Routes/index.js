const fs = require("fs").promises;
require('dotenv').config();

const endpoint = process.env.ENDPOINT || "/api";

function loadRoutes(db, app) {
  //GET routes
  fs.readdir("./Routes/GET").then((files) => {
    files
      .filter((fileName) => fileName.endsWith(".js"))
      .forEach((file) => {
        const loaded = require("./GET/" + file);

        if (!loaded.pathName || !loaded.run) {
          return console.log(
            `Some POST parameters are missing in ${file}! Please check your parameters.`
          );
        }
        app.get(`${endpoint}/${loaded.pathName}`, (req, res) => {
          loaded.run(db, req, res);
        });

        // console.log(`Method POST ${file}: ${loaded.pathName} is loaded!`);
      });
  });
  //POST routes
  fs.readdir("./Routes/POST").then((files) => {
    files
      .filter((fileName) => fileName.endsWith(".js"))
      .forEach((file) => {
        const loaded = require("./POST/" + file);

        if (!loaded.pathName || !loaded.run) {
          return console.log(
            `Some POST parameters are missing in ${file}! Please check your parameters.`
          );
        }
        app.post(`${endpoint}/${loaded.pathName}`, (req, res) => {
          loaded.run(db, req, res);
        });

        // console.log(`Method POST ${file}: ${loaded.pathName} is loaded!`);
      });
  });
  //PUT routes
  fs.readdir("./Routes/PUT").then((files) => {
    files
      .filter((fileName) => fileName.endsWith(".js"))
      .forEach((file) => {
        const loaded = require("./PUT/" + file);

        if (!loaded.run) {
          return console.log(
            `Some PUT parameters are missing in ${file}! Please check your parameters.`
          );
        }
        loaded.run(app, db, endpoint);     

        // console.log(`Method PUT ${file} is loaded!`);
      });
  });
}

module.exports = loadRoutes;
