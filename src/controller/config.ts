import { beCodes } from "../constants";

export function errHandler(err: any) {
    if(err.response?.status == 401 && err.response?.data?.code == beCodes.loginRequired) {
        alert("Silahkan masuk kembali!");
        window.location.reload();
    } else {
        throw new Error(err);
    }
}