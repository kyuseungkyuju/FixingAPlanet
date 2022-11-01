// server message format
// const message = {
//     'err' : {
//         'message' : ''
//     } ,
//     'result' : {
//         'temp' : []
//     }
// }

// client message format
// const data = {
//     'error' = false
//     'data' : {
//         'tempList' : []
//     }
// }


export default class Controller {
    constructor(rootURI = '', serverURL = '') {
        this.rootURI = rootURI
        this.serverURL = serverURL

        this.init()
    }

    init() {

    }

    async get (url) {
        const result = {
            error: false,
            data: {}
        }
        
        const response = await fetch(url, {
            method: 'GET'
        })

        const json = await (response).json()

        console.log(JSON.stringify(json))

        if (json.err) {
            result.error = true
            result.data = json.err.message
        } else {
            result.data = json.result
        }

        return result;
    }

    async post (url, data, contentType = 'application/json;charset=utf-8') {
        let headers = {}

        if (contentType && contentType.length != 0) {
            headers = { 'Content-type': contentType }
        }

        if (contentType == 'file') {
            headers = {}
        }

        let json = null

        if (contentType === 'application/json;charset=utf-8') {
            json = await (
                await fetch(url, {
                    method: 'POST',
                    headers,
                    body: JSON.stringify(data),
                })
            ).json()
        } else {
            json = await (
                await fetch(url, {
                    method: 'POST',
                    headers,
                    body: data,
                })
            ).json()
        }

        const result = {
            error: false,
            data: {}
        }

        if (json.err) {
            result.error = true
            result.data = json.err.message
        } else {
            result.data = json.result
        }

        return output
    }
}