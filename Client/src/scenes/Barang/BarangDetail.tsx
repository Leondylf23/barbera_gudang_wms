import { faCircleXmark } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { useEffect, useRef, useState } from 'react';

export default function BarangDetail(props: { id: number | null; closeHandler: () => void }) {
	const { id, closeHandler } = props;
	const [ data, setData ] = useState<DataGudang | null>(null);
	const [ imgData, setImgData ] = useState<string>('');

	function clickOutside() {
		const refDetail = useRef<HTMLDivElement>(null);

		const handleClickOutside = (event: any) => {
			if (refDetail.current && !refDetail.current.contains(event.target)) {
				closeHandler();
			}
		};

		useEffect(() => {
			document.addEventListener('click', handleClickOutside, true);
			return () => {
				document.removeEventListener('click', handleClickOutside, true);
			};
		});
		return { refDetail };
	}
	const { refDetail } = clickOutside();

	return (
		<div className="fixed w-full h-screen bg-black/[.6] top-0 left-0 flex items-center justify-center">
			<div className="w-[1000px] p-6 bg-white rounded-xl" ref={refDetail}>
				<div className="flex items-start">
					<a className="w-full text-xl font-semibold">{id === null ? 'Buat Baru' : 'Detil'}</a>
					<button className="" onClick={closeHandler}>
						<FontAwesomeIcon icon={faCircleXmark} className="text-2xl text-red-700 hover:text-red-500" />
					</button>
				</div>
				<div className="flex gap-2">
					<div className="mt-4 flex flex-col w-1/2">
						<div className="flex w-full gap-4">
							<div className="flex flex-col w-full">
								<label htmlFor="item_id" className="mb-1">
									Serial :
								</label>
								<input type="text" id="item_id" className="border p-1 rounded-md mb-2 w-full" />
							</div>
							<div className="flex flex-col w-full">
								<label htmlFor="jenis" className="mb-1">
									Jenis :
								</label>
								<select className="border p-1 rounded-md mb-2 w-full" id="jenis">
									<option value="">-</option>
								</select>
							</div>
						</div>
						<label htmlFor="item_id" className="mb-1">
							Nama Barang :
						</label>
						<input type="text" id="item_id" className="border p-1 rounded-md mb-2" />
						<label htmlFor="item_id" className="mb-1">
							Harga Jual (Rp.) :
						</label>
						<input type="number" id="item_id" className="border p-1 rounded-md mb-2" />
						<label htmlFor="item_id" className="mb-1">
							Ukuran :
						</label>
						<input type="text" id="item_id" className="border p-1 rounded-md mb-2" />
						<div className="flex w-full gap-4">
							<div className="flex flex-col w-full">
								<label htmlFor="item_id" className="mb-1">
									Location :
								</label>
								<input type="text" id="item_id" className="border p-1 rounded-md mb-2" />
							</div>
							<div className="flex flex-col w-full">
								<label htmlFor="item_id" className="mb-1">
									Lot :
								</label>
								<input type="text" id="item_id" className="border p-1 rounded-md mb-2" />
							</div>
						</div>
					</div>
					<div className="w-1/2 flex justify-center items-center">
						{imgData != '' ? <img src={imgData} className="w-full" /> : <div className='w-full h-full bg-gray-800 flex items-center justify-center text-white'><a>No Image</a></div>}
					</div>
				</div>
			</div>
		</div>
	);
}
