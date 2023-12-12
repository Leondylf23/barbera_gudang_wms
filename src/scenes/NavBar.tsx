import { useNavigate } from "react-router-dom";
import { logoutUser } from "../controller/post";

export default function NavBar(props: {setUserData: (userData: null) => void}) {
    const { setUserData } = props;
    const navigate = useNavigate();

    async function sendLogout() {
        try {
            await logoutUser();
            setUserData(null);
        } catch (error) {
            console.error(error);
        }
    }
    return(
        <nav className="fixed top-0 left-0 w-full h-[60px] bg-gray-800 text-white flex items-center px-20">
            <b className="text-xl" onClick={() => navigate("")}>BARBERA</b>
            <div className="ml-4 flex items-center gap-4">
                <div className="h-full hover:bg-gray-700" onClick={() => navigate("stok")}>Stok</div>
                <div className="h-full hover:bg-gray-700" onClick={sendLogout}>Logout</div>
            </div>
        </nav>
    );
}