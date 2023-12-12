const messages = require("../../Constants/messages");
const codes = require("../../Constants/codes");

module.exports = {

    pathName: "get-jenis-item",

    run: async (db, req, res) => {
        try {

            const { search, offset } = req.body;

            if(search === undefined || offset === undefined) {
                res.status(400);
                res.json({
                    code: codes.badReq,
                    message: messages.body400,
                });
                return;
            }

            const mysql = db.mysql;
            const con = await mysql.createConnection(db.pool);

            const [rows, _] = await con.execute(`
                SELECT
                    jenis.name, 
                    jenis.initial_jenis
                FROM
                    jenis
                LIMIT ?, 5000
            `, [offset]);

            await con.destroy();

            res.json(rows);

        } catch (error) {
            try{
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
    }
}