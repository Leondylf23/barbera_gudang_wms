import { useEffect, useState } from "react";
import { getGudangData } from "../controller/post";
import { removeFrontAlphabet } from "../utils";
import { AxiosResponse } from "axios";

export default function Barang() {
  const [data, setData] = useState<Array<DataGudang> | []>([]);
  const [searchInpt, setSearchInpt] = useState<string>("");
//   const [offset, setOffset] = useState<number>(0);

  type DataGudang = {
    id_barang: string;
    id_jenis: string;
    nama_brg: string;
    harga_jual: string;
    harga_beli: string;
    loc: string;
    lat: string;
    notes: string;
    pic: string;
  };

  async function appendData() {
    try {
        const resData: AxiosResponse<Array<DataGudang>> | undefined = await getGudangData(
          searchInpt
        );
        let getData = resData?.data;
        if(!getData) throw new Error("Data empty");

        for (let index = 0; index < getData.length; index++) {
          let e = getData[index];
          if (e.pic === undefined || e.pic === null) {
            let dataPic = "";
            try {
            //   const regex = /^[A-Za-z]+|([A-Za-z]+)$/g;
              const strSearch = removeFrontAlphabet(e.id_barang);
    
              dataPic = `http://localhost:3000/api/search-photo?id=${strSearch}`;
            } catch (e) {}
    
            e.pic = dataPic;
          }
        }
        setData(getData);
    } catch (error) {
        
    }
  }

  useEffect(() => {
    appendData();
  }, [searchInpt]);

  return (
    <div className="mt-20 mx-10">
      <input
        type="text"
        className="mb-10 border border-black w-1/2 rounded-md p-1"
        onChange={(e) => setSearchInpt(e.target.value)}
      />
      <table className="">
        <thead>
          <th>id barang</th>
          <th>jenis</th>
          <th>nama barang</th>
          <th>harga jual</th>
          <th>harga beli</th>
          <th>loc / lot</th>
          <th>notes</th>
          <th>gambar</th>
        </thead>
        <tbody>
          {data.length > 0 &&
            data.map((e) => (
              <tr>
                <td>{e.id_barang}</td>
                <td>{e.id_jenis}</td>
                <td>{e.nama_brg}</td>
                <td>{e.harga_jual}</td>
                <td>{e.harga_beli}</td>
                <td>{`${e.loc} / ${e.lat}`}</td>
                <td>{e.notes}</td>
                <td>
                  <img src={e.pic} className="h-[400px]" alt="none" />
                </td>
              </tr>
            ))}
        </tbody>
      </table>
      <button className="border p-1"></button>
    </div>
  );
}
