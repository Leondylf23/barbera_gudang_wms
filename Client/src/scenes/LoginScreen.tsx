import { useState } from "react";
import { beCodes } from "../constants";
import { loginUser } from "../controller/post";
import { AxiosResponse } from "axios";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCircleNotch } from "@fortawesome/free-solid-svg-icons";


export default function LoginScreen(props: { setUserData: (userData: {name: string; role: string;}) => void }) {
    const { setUserData } = props;
    const [username, setUsername] = useState<string>("");
    const [password, setPassword] = useState<string>("");
    const [isLoading, setIsLoading] = useState<boolean>(false);
    const [errorMsg, setErrorMsg] = useState<string>("");

    function appendErrorMsg(msg: string) {
        setErrorMsg(msg);
        setTimeout(() => {
            setErrorMsg("");
        }, 3000);
    }

    async function sendLogin(e: any) {
        e.preventDefault();
        try {
            const res: AxiosResponse<{ name: string; role: string }> = await loginUser(username, password);
            setUserData(res.data);
        } catch (err: any) {
            console.error(err);
        }
        setIsLoading(true);
        try {
            const res: AxiosResponse<{name: string, role: string}> = await loginUser(username, password);
            setUserData(res.data);
        } catch (err: any) {
            setIsLoading(false);
            if (err.response) {
                const response: {
                  status: number;
                  data: { code: number; message: string; };
                } = err.response;
                if (response.status == 401 && response.data.code == beCodes.loginErr) {
                  appendErrorMsg(response.data.message);
                  return;
                }
              }
              appendErrorMsg(err.message);
        }
    }

    return(
        <div className="w-full h-screen flex items-center justify-center bg-gray-800">
            <div className="w-[400px] p-4 rounded-lg bg-white flex flex-col justify-center">
                <div className="w-full flex justify-center mb-4">
                    <a className="font-semibold text-2xl">Login</a>
                </div>
                <form className="w-full" onSubmit={sendLogin}>
                    <a className="mb-1">Username</a>
                    <input type="text" className="w-full border rounded-md p-1 mb-2" onChange={(e) => setUsername(e.target.value)} />
                    <a className="mb-1">Password</a>
                    <input type="password" className="w-full border rounded-md p-1 mb-2" onChange={(e) => setPassword(e.target.value)} />
                    <button type="submit" className={`w-full ${isLoading ? "bg-blue-600" : "bg-blue-500 hover:bg-blue-400"} text-white rounded-md p-1 mb-2`} disabled={isLoading}>{isLoading ? <FontAwesomeIcon icon={faCircleNotch} spin /> : <a>Login</a>}</button>
                    {errorMsg && <p className="text-red-500">{errorMsg}</p>}
                </form>
            </div>
        </div>
    );
}