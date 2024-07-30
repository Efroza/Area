import axios from "axios"
import { useState, useEffect } from "react"
import { useParams, useNavigate  } from "react-router-dom"
import AppletFormat from "./utils_components/AppletFormat"

// const URL_HOST_API  =   'http://127.0.0.1:8000/'

const URL_HOST_API = process.env.REACT_APP_API_HOST

const URL_APPLET_ACTION = URL_HOST_API + 'applet/action/'

/**
 * @description Description à faire.
 */
function ActivateApplet()
{
    const { action_name, service_name } = useParams()
    const [actionId, setActionId] = useState(0)
    const token = sessionStorage.getItem('Token')
    const navigate = useNavigate()

    useEffect(() => {
        if (token == null) {
            navigate('/login')
            return
        }

        axios.get(URL_APPLET_ACTION + action_name)
            .then(res => {
                if (res?.data?.length > 0)
                    setActionId(res.data[0].id)
            console.log('URL_APPLET_ACTION', res?.data)
        }).catch(err => console.log(err))

    }, [action_name, navigate, token])

    useEffect(() => {
        console.log('actionId', actionId)
    }, [actionId])

    return (
        <div>
            <h1>Service { service_name }</h1>
            <AppletFormat createActions={actionId} token={ token } />
        </div>
    )
}

export default ActivateApplet