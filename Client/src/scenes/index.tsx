import NavBar from './NavBar';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Barang from './Barang';
import Stok from './Stok';
import { useEffect, useState } from 'react';
import LoginScreen from './LoginScreen';
import { getLoginInformation } from '../controller/post';
import { AxiosResponse } from 'axios';

export default function Scenes() {
	const [ userData, setUserData ] = useState<{
		name: string;
		role: string;
	} | null>(null);

	async function getData() {
		try {
			const res: AxiosResponse<{ name: string; role: string }> = await getLoginInformation();
			setUserData(res.data);
		} catch (err) {
			console.error(err);
		}
	}

	useEffect(() => {
		getData();
	}, []);

	return (
		<div className="w-full min-h-screen">
			{userData ? (
				<div className='pt-20'>
					<Router>
						<NavBar setUserData={setUserData} />
						<Routes>
							<Route path="" element={<Barang />} />
							<Route path="stok" element={<Stok />} />
						</Routes>
					</Router>
				</div>
			) : (
				<LoginScreen setUserData={setUserData} />
			)}
		</div>
	);
}
