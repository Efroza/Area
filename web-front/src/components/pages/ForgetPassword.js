import React from 'react'
import './ForgetPassword.css'
import { Form, Button, Alert } from "react-bootstrap";
import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from 'axios';
import Popup from './Popup';
import './Register.css'

const API_FORGET_URL = process.env.REACT_APP_API_HOST + 'forgetPassword'

/**
 * @description Cette page permet de réinitialiser le mot de passe d'un utilisateur.
 * Elle est appelée par le composant {@link App}.
 * @returns {JSX.Element} - ForgetPassword page.
 */
const ForgetPassword = () => {
  const [email, setEmail] = useState("");
	const [password, setPassword] = useState("");
	const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState("");
  const [buttonPopup, setButtonPopup] = useState(false);
  const navigate = useNavigate();

	/**
	 * @name ResetPassword
	 * @description Envoie l'email et le nouveau de mot de passe de l'utilisateur au serveur.
	 * Si le serveur renvoie une erreur, on affiche l'erreur.
	 * Sinon, on affiche une popup qui nous renvoie vers la page de login.
	 * @type {Connexion_serveur}
	 * @param {object} e - L'événement.
	 */
	const handleSubmit = async (e) =>  {
		e.preventDefault();
		setError("");
		if (password !== confirmPassword || password.length < 4 || email.length < 4) {
			setError("Passwords do not match");
		} else {
			try {
				await axios.post(
					API_FORGET_URL,
					JSON.stringify({
						email: email,
						password: password,
					})
				)
				.then((res) => {
					console.log(res);
					if (res.data === 'Email does not exist we cannot change your password') {
						setError("Email does not exist we cannot change your password");
					} else {
						setButtonPopup(true);
					}
				})
				.catch((err) => {
					setError("Invalid email");
					console.log(err);
      	});
    	} catch (err) {
      	setError(err.message);
    	}
	}
	};

  return (
    <div className="app">
		{error && <Alert variant="danger">{error}</Alert>}
        <Form onSubmit={handleSubmit}>
		<h1>Forget Password</h1>
          <Form.Group controlId="formBasicEmail">
            <Form.Control
              type="email"
              placeholder="Email address"
              onChange={(e) => setEmail(e.target.value)}
            />
          </Form.Group>

          <Form.Group controlId="formBasicNewPassword">
            <Form.Control
              type="password"
              placeholder="Password"
              onChange={(e) => setPassword(e.target.value)}
            />
          </Form.Group>
			<Form.Group controlId="formBasicConfirmNewPassword">
				<Form.Control
					type="password"
					placeholder="Confirm Password"
					onChange={(e) => setConfirmPassword(e.target.value)}
				/>
				</Form.Group>
			<div className="d-grid gap-2">
            <Button variant="primary" type="Submit">
              Reset Password
            </Button>
          </div>
			<Popup trigger={buttonPopup} setTrigger={setButtonPopup}>
        		<h3>Success</h3>
        		<p>An email has been sent to {email} to confirm your new password.</p>
      		</Popup>
			<div className="text_account">
        		Don't have an account? <Link to="/signup">Sign up</Link>
      		</div>
			</Form>
    </div>
  )
}

export default ForgetPassword