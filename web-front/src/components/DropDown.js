import React, { useState } from 'react';
import { serviceDropdown } from "./DropDownItems";
import { Link } from "react-router-dom";
import "./DropDown.css"

/**
 * @description Ce composant permet de faire une liste déroulante sur le profil de l'utilisateur.
 * Il est appelé par le composant {@link Navbar} et il fait appel au composant {@link DropDownItems}.
 */
function DropDown() {
  const [dropdown, setDropdown] = useState(false);

  return (
    <ul className={!dropdown ? "dropdown" : "dropdown clicked"} onClick={() => setDropdown(!dropdown)}>
      {serviceDropdown.map(item => {
        return (
          <li key={item.id}>
            <Link to={item.path} className={item.className} onClick={() => setDropdown(false)}>{item.title}</Link>
          </li>
        )
      })}
    </ul>
  )
}

export default DropDown