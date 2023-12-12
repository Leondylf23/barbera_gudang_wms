const messages = require("../../Constants/messages");
const codes = require("../../Constants/codes");

module.exports = {
  pathName: "logout",

  run: async (db, req, res) => {
    try {
      const { } = req.body;

      req.session.destroy((err) => {
            if(err) {
                console.error("Error destroying session: ", err);
            }
        });

      res.json({
        message: "Ok"
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
