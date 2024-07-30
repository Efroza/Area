import axios from "axios"
import { useState, useEffect } from "react"
import { useParams, useNavigate } from "react-router-dom"

const URL_SEND_TOKEN = process.env.REACT_APP_API_HOST +  'service/account/oauth2/' //<str:service_name>'

function ResendToken()
{
    const { all_token, service_name } = useParams()
    const [message, setMessage] = useState('')
    const navigate = useNavigate()

    useEffect(() => {
        let token = sessionStorage.getItem('Token')
        if (token === null) {
            token = localStorage.getItem('Token')
            if (token == null)
                navigate('/login')
            sessionStorage.setItem('Token', token)
        }
        const data = { token: all_token }
        axios.post(URL_SEND_TOKEN + service_name, data, {
            headers: {
                'Authorization': `${token}`
            }
        })
        .then(res => {
            if (res?.data?.success === false)
                setMessage(res?.data?.message ? res?.data?.message : '')
            else
                navigate('/')
        }).catch(err => console.error(err))
    }, [])
    return <h1> Error: {message} </h1>
}

export default ResendToken