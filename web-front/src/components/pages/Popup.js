import React from 'react';
import './Popup.css';
import { useNavigate } from "react-router-dom";

/**
 * @description Ce composant permet de créer une popup.
 * Il est appelé par le composant {@link App}.
 * @return {JSX.Element} Le composant de la popup.
 * @param {Object} props - Le contenu de la popup.
 */
function Popup(props) {
  let navigate = useNavigate();

  return (props.trigger) ? (
    <div className="popup">
        <div className="popup-inner">
            <button className="close-btn" onClick={() => navigate('/')}>Close</button>
            {props.children}
        </div>
    </div>
  ) : "";
}

export default Popup