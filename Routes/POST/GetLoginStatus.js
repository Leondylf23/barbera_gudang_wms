const messages = require("../../Constants/messages");
const codes = require("../../Constants/codes");

module.exports = {
  pathName: "get-login-status",

  run: async (db, req, res) => {
    try {
      const {} = req.body;

      const userData = req.session?.userdata;

      if (!userData) throw new Error("User data is empty!");

      res.json({
        name: userData.name,
        role: userData.role_name,
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
