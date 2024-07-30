import { useState } from "react";
import "./Register.css";
import FormInput from "./FormInput";
import { Alert } from "react-bootstrap";
import axios from "axios";
import { Link, useNavigate } from "react-router-dom";
import Popup from './Popup';

/**
 * @description Register page pour inscrire des nouveaux utilisateurs.
 * @returns {JSX.Element} - Register page.
 */
const Register = () => {
  let navigate = useNavigate();
  const [error, setError] = useState("");
  const [buttonPopup, setButtonPopup] = useState(false);

  const [values, setValues] = useState({
    username: "",
    email: "",
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
      id: 5,
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
   * @description Prends les valeurs des inputs et les envoie au backend pour créer un nouvel utilisateur.
   * Si l'utilisateur est créé, une popup est affiché pour confirmer la création. {@link Popup}
   * Sinon un message d'erreur est affiché.
   * @param {Event} e - L'événement de la soumission du formulaire.
   * @returns {void}
   * @async
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
          console.log("hello");
          setButtonPopup(true);
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
        <h1>Sign Up</h1>
        {error && <Alert variant="danger">{error}</Alert>}
        {inputs.map((input) => (
          <FormInput
            key={input.id}
            {...input}
            value={values[input.name]}
            onChange={onChange}
          />
        ))}
        <button>Create account</button>
        <p className="text_account">Already have an account ?
          <Link to="/login"> Sign In Here !</Link>
        </p>
      </form>
      <Popup trigger={buttonPopup} setTrigger={setButtonPopup}>
        <h3>Registration Successful</h3>
        <p>An email of verification has been sent to {values['email']}.</p>
      </Popup>
    </div>
  );
};

export default Register;