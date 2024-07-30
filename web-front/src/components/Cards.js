import { useState, useEffect } from 'react';
import CardItem from './CardItem';
import './Cards.css';
import axios from "axios";
// import { Link } from 'react-router-dom';
// import { FaPhoneAlt } from 'react-icons/fa';
// import { GiArrowCursor } from 'react-icons/gi';
// import { FaBars, FaTimes } from 'react-icons';

/**
 * @typedef {Object} Connexion_serveur
 * @property {string} URL - L'URL du serveur.
 * @property {string} Request - La requête à effectuer.
 * @property {string} Response_server - La réponse du serveur.
 */
//  const URL_HOST_API  =   'http://127.0.0.1:8000/' // URL du serveur 

const URL_HOST_API  =   process.env.REACT_APP_API_HOST // URL du serveur 
const URL_ALL_SERVICE =  URL_HOST_API + 'service/' // URL de l'API pour récupérer les services

const ColoredLine = ({ color }) => (
    <hr
        style={{
            color: color,
            backgroundColor: color,
            height: 5
        }}
    />
);

/**
 * @description Ce composant permet d'afficher les cartes de présentation des services.
 * Il est appelé par le composant {@link Cards}.
 * @param {Object} services - Les services récupérés depuis le serveur.
 * @return {JSX.Element} Une map des cartes de présentation des services.
 */
function DisplayCards({services})
{
    return services
    .map(service => <CardItem key={service.id} src={URL_HOST_API + service.image}
    text={service.name} label={service.description} path={'/service/' + service.name}/>)
}

/**
 * @description Ce composant permet d'afficher les différents services de l'application en faisant une connexion depuis le backend.
 * Il est appelé par le composant {@link Home}.
 * @return {JSX.Element} Les cartes de présentation des services.
 */
function Cards() {

    const [services, setServices] = useState([])

    /**
     * @name useEffect
     * @description Cette fonction envoie une requête au serveur à l'url :  'http://127.0.0.1:8000/service' pour récupérer les différents services.
     * Le serveur envoie alors une réponse qui est stockée dans la variable services.
     * @type {Connexion_serveur}
     */
    useEffect(() => {
        axios.get(URL_ALL_SERVICE)
        .then(res => setServices(res['data']))
        .catch(err => console.error(err))
    }, [])

    return (
        <div className='cards'>
            <h1>Discover our services</h1>
            <div className="cards__container">
                <div className="cards__wrapper">
                    <ul className="cards_grid">
                        <DisplayCards services={services} />
                    </ul>
                    <div className="separator">
                    <div className="line"></div>
                    <h2>
                    </h2>
                    <div className="line"></div>
                    </div>
                    <br/>
                    <h2></h2>
                </div>
            </div>
        </div>
    )
}

export default Cards