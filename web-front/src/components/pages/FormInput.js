import "./FormInput.css"

import { useState } from "react";

/**
 * @description Ce composant permet de créer un input dans un formulaire.
 * Il est appelé par le composant {@link Form}.
 * @param {Object} props - Les paramètres de l'input.
 * @return {JSX.Element} Le composant de l'input.
 */
const FormInput = (props) => {
  const [focused, setFocused] = useState(false);
  const { label, errorMessage, onChange, id, ...inputProps } = props;

  const handleFocus = (e) => {
    setFocused(true);
  };

  return (
    <div className="formInput">
      <label>{label}</label>
      <input
        {...inputProps}
        onChange={onChange}
        onBlur={handleFocus}
        onFocus={() =>
          inputProps.name === "confirmPassword" && setFocused(true)
        }
        focused={focused.toString()}
      />
      <span>{errorMessage}</span>
    </div>
  );
};

export default FormInput;