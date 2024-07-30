import { useState } from "react";
import "./SignUp.css";
import FormInput from "./FormInput";
import { Alert } from "react-bootstrap";
import axios from "axios";
import { useNavigate } from "react-router-dom";

/**
 * @typedef {FormCreationCompte}
 * @property {id} id - id de l'input.
 * @property {string} type - type de l'input.
 * @property {string} name - nom de l'input.
 * @property {string} placeholder - placeholder de l'input.
 * @property {string} errorMessage - message d'erreur de l'input.
 * @property {boolean} [required] - booléen qui indique si l'input est requis.
 * @property {string} [label] - label de l'input.
 * @property {string} [pattern] - pattern de l'input.
 */
/**
 * @description Sign up page.
 * @returns {JSX.Element} - Sign up page.
 */
const SignUp = () => {
  let navigate = useNavigate();
  const [error, setError] = useState("");

  const [values, setValues] = useState({
    first_name: "",
    last_name : "",
    email: "",
    birthday: "",
    password: "",
    confirmPassword: "",
  });

  /** 
   * @description Prends les différents inputs dans les forms afin de pouvoir créer un nouvel utilisateur.
   * @return {FormCreationCompte[]} Les différents inputs.
   */
  const inputs = [
    {
      id: 1,
      name: "first name",
      type: "text",
      placeholder: "First name",
      errorMessage:
        "Name should be 3-16 characters and shouldn't include any special character!",
      label: "First name",
      pattern: "^[A-Za-z0-9]{3,16}$",
      required: true,
    },
    {
      id: 2,
      name: "last name",
      type: "text",
      placeholder: "Last name",
      errorMessage:
        "Name should be 3-16 characters and shouldn't include any special character!",
      label: "Last name",
      pattern: "^[A-Za-z0-9]{3,16}$",
      required: true,
    },
    {
      id: 3,
      name: "email",
      type: "email",
      placeholder: "Email",
      errorMessage: "It should be a valid email address!",
      label: "Email",
      required: true,
    },
    {
      id: 4,
      name: "birthday",
      type: "date",
      placeholder: "Birthday",
      label: "Birthday",
    },
    {
      id: 5,
      name: "password",
      type: "password",
      placeholder: "Password",
      errorMessage:
        "Password should be 8-20 characters and include at least 1 letter, 1 number and 1 special character!",
      label: "Password",
      pattern: `^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$`,
      required: true,
    },
    {
      id: 6,
      name: "confirmPassword",
      type: "password",
      placeholder: "Confirm Password",
      errorMessage: "Passwords don't match!",
      label: "Confirm Password",
      pattern: values.password,
      required: true,
    },
  ];

  /**
   * @description Prends les valeurs des inputs si ils sont corrects et les envoie au serveur pour valider l'inscription de l'utilisateur.
   * Si l'inscription est validée, l'utilisateur est redirigé vers la page de connexion.
   * Sinon un message d'erreur est affiché.
   * @param {Object} e - Événement.
   * @type {Connexion_serveur}
   */
  const handleSubmit = async (e) => {
    e.preventDefault();
      await axios.post(
        process.env.REACT_APP_API_HOST + "signup",
        JSON.stringify({
         first_name : values['first name'], last_name : values['last name'], email : values['email'], password : values['password']})
      )
      .then((res) => {
        console.log(res);
        if (res.data === "Email already exists") {
          setError("Email already exists");
        } else {
          navigate('/');
        }
      })
      .catch((err) => {
        console.log(err);
      });
  };

  const onChange = (e) => {
    setValues({ ...values, [e.target.name]: e.target.value });
  };

  return (
    <div className="app">
      <form onSubmit={handleSubmit}>
        <h1>Register</h1>
        {error && <Alert variant="danger">{error}</Alert>}
        {inputs.map((input) => (
          <FormInput
            key={input.id}
            {...input}
            value={values[input.name]}
            onChange={onChange}
          />
        ))}
        <button>Submit</button>
      </form>
    </div>
  );
};

export default SignUp;