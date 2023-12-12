const messages = require("../../Constants/messages");
const codes = require("../../Constants/codes");

module.exports = {

    pathName: "create-jenis-item",

    run: async (db, req, res) => {
        try {

            const { nama_jenis, initial_jenis } = req.body;

            if(nama_jenis === undefined || initial_jenis === undefined) {
                res.status(400);
                res.json({
                    code: codes.badReq,
                    message: messages.body400,
                });
                return;
            }

            const mysql = db.mysql;
            const con = await mysql.createConnection(db.pool);

            const [row, _] = await con.execute(`SELECT jenis_id FROM jenis WHERE initial_jenis = ?`, [initial_jenis]);
            if(row.length != 0) {
                res.json({
                    message: "Initial sudah ada."
                });
                return;
            }

            try {
                await con.beginTransaction();
                const [result] = await con.execute(`INSERT INTO jenis (name, initial_jenis) VALUES (?,?)`, [nama_jenis, initial_jenis]);
                if(result.insertId === null) throw new Error("Jenis not inserted!");

                await con.commit();
            } catch (error) {
                await con.rollback();
            }

            await con.destroy();

            res.json({message: "OK"});

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