import { useState, useEffect } from "react"
import { useParams, useNavigate } from "react-router-dom"
import { useForm } from "react-hook-form"
import './SubscribeService.css';
import axios from "axios";
// import axios from "axios"

// const URL_HOST_API = 'http://127.0.0.1:8000/'

const URL_HOST_API = process.env.REACT_APP_API_HOST

const URL_SERVICE_API = URL_HOST_API + 'service/'

const URL_SERVICE_USE_INFO = URL_SERVICE_API + 'useInfo/'

const URL_SERVICE_POST = URL_SERVICE_API + 'account/'

const URL_SERVICE_OAUTH_ELIGIBLE = URL_SERVICE_API + 'oauth2/eligible/'

const URL_SERVICE_SET_REDIRECT = URL_SERVICE_API + 'set/redirect'

/**
 * @description Description à faire.
 */

function SubscribeAuth2({service_name, token})
{
    const [eligible, setEligible] = useState(false)
    const [url, setUrl] = useState('')

    useEffect(() => {
        axios.get(URL_SERVICE_OAUTH_ELIGIBLE + service_name)
            .then(res => {
                console.log(URL_SERVICE_OAUTH_ELIGIBLE + service_name)
                if (res?.data?.success === true && res?.data?.oauth2 === true)
                    setEligible(true)
                setUrl(res?.data?.url ? res?.data?.url : '')
            })
    }, [service_name])

    useEffect(() => {
        if (eligible === false)
            return
        const url_redirect = 'http://localhost:' + window.location.port + '/service/' + service_name + '/resendtoken/'
        const data = { url: url_redirect }
        axios.post(URL_SERVICE_SET_REDIRECT, data, {
            headers: {
                'Authorization': `${token}`
            }
        })
            .then(res => console.log(res?.data?.message))
            .catch(err => console.error(err))
    }, [eligible])

    function redirect_url(url)
    {
        if (url === undefined || url?.lenght === 0) {
            console.log(url)
            return
        }
        window.location.assign(url)
    }

    if (eligible === false)
        return <div>Noting</div>
    return <button className="submit_form" onClick={() => redirect_url(url)}>CONNECT</button>
}


function SubscribeService()
{
    const { name } = useParams()
    const [info, setInfo] = useState({})
    const { register, handleSubmit } = useForm()
    const navigate = useNavigate()
    const token = sessionStorage.getItem('Token')

    useEffect(() => {
        axios.get(URL_SERVICE_USE_INFO + name)
            .then(res => setInfo(res['data']))
            .catch(err => navigate('/'))
    }, [navigate, name])

    const onSubmit = data => {
        if (data?.email == '' && data?.password == '' && data?.token == '' && data?.extra == '')
            return
        axios.post(URL_SERVICE_POST + name, data,
        {
            headers: {
                'Authorization': `Token ${token}`
            }
        })
        .then(res => {
            if (res?.data?.success === true) {
                navigate('/service/' + name);
                return
            }
            alert(res?.data?.message)
            window.location.reload(false);
        })
        .catch(err => {
            console.log(err)
        })
    }

    return (
        <form className='subsribe_container' onSubmit={handleSubmit(onSubmit)}>
            <h1 className="pink"> Subscribe {name}</h1>
            <div className={'subscribe_item' + (info?.email === true ? '' : ' hide')}>
                <label>Email</label>
                <input type="text" name="email" {...register('email')} />
            </div>
            <div className={'subscribe_item' + (info?.password === true ? '' : ' hide')}>
                <label>Password</label>
                <input type="password" name="password" {...register('password')}/>
            </div>
            <div className={'subscribe_item' + (info?.token === true ? '' : ' hide')}>
                <label>Token</label>
                <input type="text" name="token" {...register('token')}/>
            </div>
            <div className={'subscribe_item' + (info?.extra?.required === true ? '' : ' hide')}>
                <label> {info?.extra?.description} </label>
                <input type="text" name="extra" {...register('extra')}/>
            </div>
            <button className='submit_form'>Submit</button>
            <SubscribeAuth2 service_name={name} token={token} />
        </form>
    )
}

export default SubscribeService