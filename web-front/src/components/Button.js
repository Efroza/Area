
import React from 'react';
import './Button.css';
import { Link } from 'react-router-dom';

const STYLES = ['btn--primary', 'btn--outline', 'btn--test'];

const SIZES = ['btn--medium', 'btn--large'];

/**
 * @function Button
 * @description Ce composant permet de créer un bouton customiser.
 * Il est appelé par le composant {@link Footer}.
 * @param {Object} children - Le contenu du bouton.
 * @param {Object} type - Le type du bouton.
 * @param {Object} onClick - La fonction à exécuter au clic.
 * @param {Object} buttonStyle - Le style du bouton.
 * @param {Object} buttonSize - La taille du bouton.
 * @return {JSX.Element} Le composant du button.
 */
export const Button = ({
  children,
  type,
  onClick,
  buttonStyle,
  buttonSize
}) => {
  const checkButtonStyle = STYLES.includes(buttonStyle)
    ? buttonStyle
    : STYLES[0];

  const checkButtonSize = SIZES.includes(buttonSize) ? buttonSize : SIZES[0];

  return (
    <Link to='/sign-up' className='btn-mobile'>
      <button
        className={`btn ${checkButtonStyle} ${checkButtonSize}`}
        onClick={onClick}
        type={type}
      >
        {children}
      </button>
    </Link>
  );
};