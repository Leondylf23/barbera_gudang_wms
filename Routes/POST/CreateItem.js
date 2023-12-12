const messages = require("../../Constants/messages");
const codes = require("../../Constants/codes");

module.exports = {

    pathName: "create-item",

    run: async (db, req, res) => {
        try {

            const { nama, serial, jenis_id, harga, location, lot, ukuran } = req.body;

            if(nama === undefined || serial === undefined || jenis_id === undefined || harga === undefined || location === undefined || lot === undefined || ukuran === undefined) {
                res.status(400);
                res.json({
                    code: codes.badReq,
                    message: messages.body400,
                });
                return;
            }

            const userData = req.session.userdata;

            const mysql = db.mysql;
            const con = await mysql.createConnection(db.pool);

            const [row, _] = await con.execute(`SELECT serial FROM item WHERE serial = ?`, [serial]);
            if(row.length != 0) {
                res.json({
                    message: "Item sudah ada."
                });
                return;
            }

            try {
                await con.beginTransaction();
                const [result] = await con.execute(`INSERT INTO item (jenis_id, serial, nama_item, harga_jual, location, lot, ukuran, created_by) VALUES (?,?,?,?,?,?,?,?)`, [jenis_id, serial, nama, harga, location, lot, ukuran, userData.user_id]);
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