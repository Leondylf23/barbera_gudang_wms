import axios from "axios";
import { errHandler } from "./config";

const endpointUrl = "/api/";

export const getLoginInformation = async () => {
    return axios.post(`${endpointUrl}get-login-status`, {});
}
export const getGudangData = async (search: string) => {
    try {
        return await axios.post(`${endpointUrl}get-gudang-data`, {search});
    } catch (error) {
        errHandler(error);
    }
}
export const getPicData = async (idBarang: string) => {
    try {
        return await axios.post(`${endpointUrl}search-photo`, {filename_search: idBarang});
    } catch (error) {
        errHandler(error);
    }
}
export const loginUser = async (username: string, password: string) => {
    return await axios.post(`${endpointUrl}login`, {username, password});
}
export const logoutUser = async () => {
    return await axios.post(`${endpointUrl}logout`, {});
}