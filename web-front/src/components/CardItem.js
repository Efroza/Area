import React from 'react';
import { Link } from 'react-router-dom';

/**
 * @description Ce composant permet d'afficher chaque card de la page d'accueil.
 * Il est appelé par le composant {@link Cards}.
 * @param {Object} props Les propriétés du composant (title, path, label, src, text)
 * @return {JSX.Element} Le composant.
 */
function CardItem(props) {
    return (
        <>
            <li className='cards__item'>
                <Link
                className='cards__item__link'to={props.path}>
                    <figure className='cards__item__pic-wrap' data-category={props.label}>
                        <img src={props.src} alt='VSM Image'
                        className='cards__item__img'/>
                    </figure>
                    <div className='cards__item__info'>
                        <h5 className='cards__item__text'>{props.text}</h5>
                    </div>
                </Link>
            </li>
        </>
    );
}

export default CardItem
