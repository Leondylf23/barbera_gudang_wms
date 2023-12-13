import { useEffect, useState } from 'react';
import { getGudangData } from '../../controller/post';
import { dateFormating, numberWithPeriods } from '../../utils';
import { AxiosResponse } from 'axios';
import { faAngleLeft, faAngleRight } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import BarangDetail from './BarangDetail';

export default function Barang() {
	const [ data, setData ] = useState<Array<DataGudang> | []>([]);
	const [ searchInpt, setSearchInpt ] = useState<string>('');
	const [ erroMsg, setErrMsg ] = useState<string>('');
	const [ offset, setOffset ] = useState<number>(0);
	const [ isMore, setIsMore ] = useState<boolean>(false);	
	const [ detailPage, setDetailPage ] = useState<any | null>(null);

	function appendErrorMsg(msg: string) {
		setErrMsg(msg);
		setTimeout(() => {
			setErrMsg('');
		}, 3000);
	}

	function openDetailPage(selectedId: number) {
		setDetailPage(<BarangDetail id={selectedId} closeHandler={() => setDetailPage(null)} />);
	}

	async function appendData() {
		setIsMore(false);
		try {
			const resData:
				| AxiosResponse<{ data: Array<DataGudang>; is_more: boolean }>
				| undefined = await getGudangData(searchInpt, offset);
			let getData = resData?.data;
			if (!getData) throw new Error('Data fetch failed!');

			setData(getData.data);
			setIsMore(getData.is_more);
		} catch (error: any) {
			appendErrorMsg(error.message);
		}
	}

	useEffect(
		() => {
			appendData();
		},
		[ searchInpt, offset ]
	);

	return (
		<div className="px-10 w-full">
			{erroMsg != "" && <div className='bg-red-500 text-white w-full py-2 rounded-lg'>{erroMsg}</div>}
			<div className="flex items-center mb-4">
				<a className="font-semibold mr-2">Cari Id Barang: </a>
				<input
					type="text"
					className="border border-black w-1/2 rounded-md p-1"
					onChange={(e) => setSearchInpt(e.target.value)}
				/>
			</div>
			<div>
				<table className="border-2 w-full">
					<thead className="border-2">
						<th className="font-semibold border w-[6%]">Id Barang</th>
						<th className="font-semibold border w-[6%]">Jenis</th>
						<th className="font-semibold border w-[18%]">Nama Barang</th>
						<th className="font-semibold border w-[12%]">Harga Jual</th>
						<th className="font-semibold border w-[10%]">Location / Lot</th>
						<th className="font-semibold border w-[5%]">Ukuran</th>
						<th className="font-semibold border w-[10%]">Dibuat Oleh</th>
						<th className="font-semibold border w-[11%]">Tgl Dibuat</th>
						<th className="font-semibold border w-[10%]">Diupdate Oleh</th>
						<th className="font-semibold border">Tgl Diupdate</th>
					</thead>
					<tbody>
						{data.length > 0 &&
							data.map((e) => (
								<tr className="hover:bg-gray-100 cursor-pointer" onClick={() => openDetailPage(e.id)}>
									<td className="border p-1">{e.serial}</td>
									<td className="border p-1">{e.jenis ? e.jenis : '-'}</td>
									<td className="border p-1">{e.nama_item}</td>
									<td className="border p-1">Rp. {numberWithPeriods(e.harga_jual)}</td>
									<td className="border p-1">
										{e.location} / {e.lot}
									</td>
									<td className="border p-1">{e.ukuran}</td>
									<td className="border p-1">{e.created_by}</td>
									<td className="border p-1">{dateFormating(e.created_date, false)}</td>
									<td className="border p-1">{e.modified_by ? e.modified_by : '-'}</td>
									<td className="border p-1">{dateFormating(e.modified_date, false)}</td>
								</tr>
							))}
					</tbody>
				</table>
			</div>
			<div className="w-full mt-6 flex gap-10 justify-center">
				<button
					className={`border rounded-lg p-2 ${offset != 0 ? 'hover:bg-gray-200' : 'bg-gray-300'}`}
					disabled={offset == 0}
					onClick={() => setOffset((prevVal) => prevVal - 5000)}
				>
					<FontAwesomeIcon icon={faAngleLeft} className="mr-2" />Sebelumnya
				</button>
				<button
					className={`border rounded-lg p-2 ${isMore ? 'hover:bg-gray-200' : 'bg-gray-300'}`}
					disabled={!isMore}
					onClick={() => setOffset((prevVal) => prevVal + 5000)}
				>
					Selanjutnya<FontAwesomeIcon icon={faAngleRight} className="ml-2" />
				</button>
			</div>
			{detailPage}
		</div>
	);
}
