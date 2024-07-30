import React from 'react'
import "./Avatar.css"

/**
 * @description Ce composant permet de créer un avatar customiser avec une image.
 * Il est appelé par le composant {@link Navbar}.
 * @param {Object} src - L'image de l'avatar.
 * @param {Object} alt - Le texte alternatif de l'avatar (Nom de l'utilisateur).
 * @return {JSX.Element} Le composant de l'avatar.
 */
const Avatar = ({src, alt}) => {
    return (
        <div >
            {src ? (
                <img className={`defaultClass`} src={src} alt={alt} />
            ) : (
                <img 
                className={`defaultClass`}
                src={
                    src}
                    alt={alt} />
            )}
        </div>
    )
}

export default Avatar