const messages = require("../../Constants/messages");
const codes = require("../../Constants/codes");

module.exports = {

    pathName: "get-gudang-data",

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
                    item.item_id AS id,
                    item.serial,
                    jenis.name AS jenis,
                    item.nama_item,
                    item.harga_jual,
                    item.location,
                    item.lot,
                    item.ukuran,
                    item.created_date,
                    created.name AS created_by,
                    item.modified_date,
                    modified.name AS modified_by 
                FROM
                    item
                    LEFT JOIN jenis ON item.jenis_id = jenis.jenis_id
                    LEFT JOIN users AS created ON item.created_by = created.user_id
	                LEFT JOIN users AS modified ON item.modified_by = modified.user_id
                ${search != "" ? `
                WHERE
                    serial LIKE '%${search}%'
                ` : ""} 
                ORDER BY
                    REGEXP_REPLACE ( serial, '[^0-9H]', '' ) ASC,
                    serial ASC
                LIMIT ${offset}, 5001
            `);

            let isMore = false;
            if(rows.length > 5000) {
                isMore = true;
                rows.pop();
            }

            await con.destroy();

            res.json({
                data: rows,
                is_more: isMore
            });

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