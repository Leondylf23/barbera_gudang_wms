const messages = require("../../Constants/messages");
const codes = require("../../Constants/codes");

module.exports = {
  pathName: "login",

  run: async (db, req, res) => {
    try {
      const { username, password } = req.body;

      if (username === undefined && password === undefined) {
        res.status(400);
        res.json({
          code: codes.badReq,
          message: messages.body400,
        });
        return;
      }

      const mysql = db.mysql;
      const con = await mysql.createConnection(db.pool);

      const [rows, _] = await con.execute(`SELECT user_id, name, role_name, permission FROM users INNER JOIN roles ON users.role = roles.role_id WHERE username = ? AND password = ? LIMIT 1`, [username, password]);
      if(rows.length == 0) {
        res.status(401);
        res.json({
          code: codes.loginErr,
          message: "Username atau password salah!",
        });
        return;
      }

      req.session.userdata = rows[0];

      await con.destroy();
      res.json({
        name: rows[0].name,
        role: rows[0].role_name,
      });
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
