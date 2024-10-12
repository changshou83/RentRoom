import axios, { AxiosError, AxiosInstance, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

export default class Http {
  request: AxiosInstance;

  constructor({ baseURL }) {
    this.request = axios.create({
      baseURL,
      timeout: 20000,
    })

    this.request.interceptors.request.use(
      (config: InternalAxiosRequestConfig) => {
        // 未来需要添加 token
        // config.headers.token = token;
        return config;
      }
    )

    this.request.interceptors.response.use(
      (response: AxiosResponse) => {
        if (response.data.code === 200) {
          return response.data.data;
        } else {
          return Promise.reject(response.data.message);
        }
      },
      (error: AxiosError) => {
        return Promise.reject(error.message);
      }
    )
  }
  get<T>(url: string, params?: object) {
    return this.request.get<null, T>(url, {
      params
    })
  }

  post<T>(url: string, data?: object) {
    return this.request.post<null, T>(url, data)
  }

  put<T>(url: string, data?: object) {
    return this.request.put<null, T>(url, data)
  }

  delete<T>(url: string, params?: object) {
    return this.request.delete<null, T>(url, {
      params
    })
  }
};

export const http = new Http({ baseURL: 'http://192.168.1.105:6060' });
