import './AppletFormat.css'
import axios from 'axios'
import { useEffect, useState } from 'react';

const API_HOST_URL = process.env.REACT_APP_API_HOST

const GET_APPLET = API_HOST_URL +  'applet/applet/'
const ACTIVATE_APPLET = API_HOST_URL +  'applet/activate'

/**
 * @description Fonction qui affiche les applets.
 * @param {number} id - Id de l'applet
 * @param {string} description - Description de l'applet
 * @param {function} onClick - Fonction qui permet d'activer ou de désactiver l'applet
 * @param {string} activate - Permet de savoir si l'applet est activé ou non
 * @returns {Component} - Composant qui affiche les applets
 */
function Display({ id, activate, description, onClick })
{
    return (
        <div className='AppletTest'>
            <h2 className="title">{id}</h2>
            <div className="applet-description">
                <h2 className='left'>Statue:</h2>
                <h2>{activate}</h2>
            </div>
            <div className="applet-description">
                <a className='left'>description: </a>
                <p className="description-applet">{description}</p>
            </div>
            <button className='ActvButtn'onClick={onClick}>Activation</button>
        </div>
    )
}

/**
 * @description Fonction qui affiche tout les applets.
 * @param {Object} token - Token de l'utilisateur
 * @param {Object[]} all_applet - Liste de tout les applets
 * @returns {Component} - Composant qui affiche tout les applets
 */
function ALL({all_applet, token})
{
    function activate_applet(id_applet)
    {
        const json_body = { applet_id: id_applet }

        axios.post(ACTIVATE_APPLET, json_body,{
        headers: {
            'Authorization': `Token ${token}`
            }
        })
        .then(response => console.log(response))
        .catch(err => console.error(err))
    }

    return all_applet.map(applet => {
        return (<Display id={applet.id} activate={applet.activate === false ? "False" : "True"} description={applet.description}
            onClick={() => activate_applet(applet.id)} />)
    })
}

export default function Applet({reload, token})
{
    const [applet, setApplet] = useState([])

    useEffect(() => {
        axios.get(GET_APPLET,{
        headers: {
                    'Authorization': `Token ${token}`
                }
        })
        .then(res => setApplet(res["data"]))
        .catch(err => console.error(err))
        console.log('reload')
    }, [reload]);

    return (
        <div>
            <h1>Applet:</h1>
            <div className='grid_applet'>
                <ALL all_applet={applet} token={token} />
            </div>
        </div>
    )
}