import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import App from './App';
import { UserAuthContextProvider } from './components/loginn/UserAuthContexte';

/**
 * @name Index
 * @description Root est le point d'entrée de l'application
 * Il permet de déclarer le contexte d'authentification {@link UserAuthContextProvider} et le routeur {@link 'react-router-dom' BrowserRouter} :
 * 
 * Il permet ensuite de rediriger vers le composant principal de l'application {@link App}
 */

const root = ReactDOM.createRoot(document.getElementById('root')); 
/**
 * @description rendu de l'application
 * @param {JSX.Element} <BrowserRouter> Le routeur de l'application
 * @param {JSX.Element} <UserAuthContextProvider> Le contexte d'authentification de l'application
 */
root.render(
  <React.StrictMode>
    <BrowserRouter>
    <UserAuthContextProvider>
        <App />
    </UserAuthContextProvider>
    </BrowserRouter>
  </React.StrictMode>
);
