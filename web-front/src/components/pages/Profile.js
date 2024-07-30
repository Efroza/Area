import React from 'react'
import "./Profile.css"
import cardImage from "../../images/bg-pattern-card.svg";

/**
 * @description Ce composant permet de créer une page profile pour l'utilisateur avec ses différentes informations
 * Il est appelé par le composant {@link App}.
 * @return {JSX.Element} Le composant de la page profile.
 */
const Profile = () => {
  const user_name = sessionStorage.getItem("user_name");
  const user_email = sessionStorage.getItem("user_email");

  if (user_name === null) {
    console.log("user_name is null");
  }
  return (
    <div className='profileCard'>
      <img className='banner' src={cardImage} alt='SVG as an image' />
      <img className='avatar' src={"https://www.kindpng.com/picc/m/78-785904_block-chamber-of-commerce-avatar-white-avatar-icon.png"} alt='' />
      <div className="basic-info">
        <h3 className="name"> {user_name} </h3>

      </div>
      <p className="location">{user_email}</p>
      <div className="divider"></div>
      <div className="social-info">
        <div className="followers">
          <h3>0</h3>
          <p>Followers</p>
        </div>
        <div className="likes">
          <h3>0</h3>
          <p>Likes</p>
        </div>
        <div className="photos">
          <h3>0</h3>
          <p>Photos</p>
        </div>
      </div>
    </div>
  )
}

export default Profile