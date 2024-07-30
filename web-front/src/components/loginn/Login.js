import React, { useContext, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { Form, Alert } from "react-bootstrap";
import { Button } from "react-bootstrap";
import GoogleButton from "react-google-button";
import UserAuthContext from "./UserAuthContexte";
import axios from "axios";
import '../pages/Register.css';


const API_LOGIN_SIGNIN = process.env.REACT_APP_API_HOST + 'signin'

/**
 * @name LogIn
 * @description Cette page permet à l'utilisateur de se connecter.
 * @returns {JSX.Element} - Page de connexion
 */
const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const { user, logIn, googleSignIn } = useContext(UserAuthContext);
  const navigate = useNavigate();

  /**
   * @name LogInUser
   * @description Envoie l'email et le mot de passe de l'utilisateur au serveur.
   * Si le serveur renvoie une erreur, on affiche l'erreur.
   * Sinon, on affiche la page d'accueil.
   * @type {Connexion_serveur}
   * @param {object} e - L'événement.
   */
  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    try {
      await axios.post(
        API_LOGIN_SIGNIN,
        JSON.stringify({
          email: email,
          password: password,
        })
      )
      .then((res) => {
        console.log(res);
        if (res.status !== 200) {
          setError("Invalid email or password");
        } else {
          console.log("success");
          sessionStorage.setItem("user_email", email); // On stocke l'email de l'utilisateur dans le sessionStorage
          sessionStorage.setItem("user_name", res.data['username']); // On stocke le nom de l'utilisateur dans le sessionStorage
          sessionStorage.setItem("Token", res.data['Token']); // On stocke le Token de l'utilisateur dans le sessionStorage
          localStorage.setItem("Token", res?.data['Token']); // On stocke le Token de l'utilisateur dans le localStorage
          sessionStorage.setItem("user_image", "https://www.kindpng.com/picc/m/78-785904_block-chamber-of-commerce-avatar-white-avatar-icon.png"); // On stocke l'image de l'utilisateur dans le sessionStorage
          navigate('/');
          window.location.reload(false);
        }
      })
      .catch((err) => {
        setError("Invalid email or password");
        console.log(err);
      });
    } catch (err) {
      setError(err.message);
    }
  };

  /**
   * @name GoogleSignIn
   * @description Envoie l'email et le mot de passe de l'utilisateur au serveur pour se connecter avec Google.
   * Si le serveur renvoie une erreur, on affiche l'erreur.
   * Sinon, on affiche la page d'accueil.
   * @type {Connexion_serveur}
   * @param {object} e - L'événement.
   */
  const handleGoogleSignIn = async (e) => {
    e.preventDefault();
    try {
      await googleSignIn();
      console.log(user);
      sessionStorage.setItem("user_email", user.email); // On stocke l'email de l'utilisateur dans le sessionStorage
      sessionStorage.setItem("user_name", user.displayName); // On stocke le nom de l'utilisateur dans le sessionStorage
      sessionStorage.setItem("user_image", user.photoURL); // On stocke l'image de l'utilisateur dans le sessionStorage
      sessionStorage.setItem("Token", user.accessToken); // On stocke le Token de l'utilisateur dans le sessionStorage
      navigate("/");
      window.location.reload(false);
    } catch (error) {
      console.log(error.message);
    }
  };

  return (
    <>
      <div className="app">
        {error && <Alert variant="danger">{error}</Alert>}
        <Form onSubmit={handleSubmit}>
        <h1>Authentification</h1>
          <Form.Group className=".form_input" controlId="formBasicEmail">
            <Form.Control className=".form_input"
              type="email"
              placeholder="Email address"
              onChange={(e) => setEmail(e.target.value)}
            />
          </Form.Group>

          <Form.Group controlId="formBasicPassword">
            <Form.Control
              type="password"
              placeholder="Password"
              onChange={(e) => setPassword(e.target.value)}
            />
          </Form.Group>

          <div className="button">
            <Button variant="primary" type="Submit">
              Sign In
            </Button>
          </div>
          <div className="text_account">
            <Link to="/forgetpassword">Forgot Password ?</Link>
          </div>
          <div>
          <GoogleButton
            // className="g-btn"
            label="Sign in with Google"
            type="dark"
            onClick={handleGoogleSignIn}
          />
          </div>
        <div className="text_account">
          Don't have an account? <Link to="/signup">Sign up</Link>
        </div>
        </Form>
        <hr />
        {/* <div>
          <GoogleButton
            className="g-btn"
            type="dark"
            onClick={handleGoogleSignIn}
          />
        </div> */}
      </div>
    </>
  );
};

export default Login;