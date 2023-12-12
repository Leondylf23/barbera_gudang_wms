const messages = require("../../Constants/messages");
const codes = require("../../Constants/codes");
const fs = require("fs");
const path = require("path");
const url = require("url");

module.exports = {
  pathName: "search-photo",

  run: async (db, req, res) => {
    try {
      const urlQuery = url.parse(req.url, true).query;
      const { id } = urlQuery;

      if (id === undefined) {
        res.status(400);
        res.json({
          code: codes.badReq,
          message: messages.body400,
        });
        return;
      }
      // const mysql = db.mysql;
      // const con = await mysql.createConnection(db.pool);

      // const [rows, _] = await con.execute("SELECT * FROM barang LIMIT 100");

      function searchFile(filename, startDir) {
        const files = fs.readdirSync(startDir);
        let filePathFound = null;

        for (const file of files) {
          const filePath = path.join(startDir, file);
          const stats = fs.statSync(filePath);

          const filenameOnly = file.toLowerCase().split(".")[0];

          if (stats.isDirectory()) {
            // Recursively search in subdirectories
            filePathFound = searchFile(filename, filePath);
          } else if (filenameOnly == filename.toLowerCase()) {
            // Found the file
            console.log("File found:", filePath);
            filePathFound = filePath;
          }
          if (filePathFound) break;
        }
        return filePathFound;
      }

      const filePathFound = searchFile(id, "D:/New folder/");
      if (!filePathFound) {
        res.status(404);
        res.json({
          code: codes.notFound,
          message: messages.notfound404,
        });
        return;
      }

      res.sendFile(filePathFound);

      //   await con.destroy();
    } catch (error) {
      try {
        res.status(500);
        res.json({
          code: codes.errorBE,
          message: messages.error500,
        });
      } catch (err) {
        console.error(err.message);
      }
      console.error(error.message);
    }
  },
};
