import {useState, useEffect} from "react"
import { useParams, useNavigate } from "react-router-dom"
import CardItem from '../CardItem';
// import '../Cards.css';
import './Action_service.css';
import axios from "axios"

const URL_HOST_API = process.env.REACT_APP_API_HOST


const BASE_URL_SERVICE_ACTION = URL_HOST_API +  'applet/action/service/'


const URL_SERVICE = URL_HOST_API + 'service/'


const URL_IS_SUBSCRIBE = URL_SERVICE + 'account/issubscribe/'

/**
 * @description Description à faire.
 */

function GetAction({name})
{
    const [actions, setActions] = useState([])

    const [image, setImage] = useState([])

    const token = sessionStorage.getItem('Token')
    const navigate = useNavigate()

    useEffect(() => {
        if (token == null)
            navigate('/login')
        axios.get(URL_IS_SUBSCRIBE + name, {
            headers: {
                'Authorization': `Token ${token}`
            }
        }).then(res => {
            if (res?.data?.subscribe === false) {
                navigate('/service/subscribe/' + name)
            }
        }).catch(err => console.log(err.response.data))

        axios.get(BASE_URL_SERVICE_ACTION + name)
        .then(res => setActions(res['data']))
        .catch(err => console.error(err))
    }, [])

    useEffect(() => {
        actions.map( action => {
            axios.get(URL_SERVICE + action.id_service)
            .then(res => res['data'])
            .then(res => setImage(current => [...current, res[0].image]))
            .catch(err => console.error(err))
        })
    }, [actions])

    return actions.map((action, index) => {
        return <CardItem
            key={action.id}
            src={URL_HOST_API + image[index]}
            text={action.name}
            label={action.description}
            path={'/service/'+ name + '/activate/' + action.name}
        />
    })
}

function Action_service()
{
    const {name} = useParams()

    return (
    <div className="cards__container">
        <div className="cards__wrapper">
            <ul className="cards__items">
                <GetAction name={name}/>
            </ul>
        </div>
    </div>)
}

export default Action_service