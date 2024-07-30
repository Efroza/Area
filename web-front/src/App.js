import React from 'react';
import Navbar from './components/Navbar';
import './App.css';
import Home from './components/pages/Home';
import { Routes, Route } from 'react-router-dom';
import Register from './components/pages/Register';
import Login from './components/loginn/Login';
import Signup from './components/loginn/Signup';
import Profile from './components/pages/Profile';
import Action_service from './components/service/Action_service';
import SubscribeService from './components/service/SubscribeService';
import ActivateApplet from './components/service/ActivateApplet';
import ForgetPassword from './components/pages/ForgetPassword';
import AppletPage from './components/pages/AppletPage';
import ResendToken from './components/service/ResendToken';
import DownloadApp from './DownloadApp';

// import AppAuth from './components/loginn/AppAuth';

/**
 * @description Il s'agit du composant principal de l'application
 * Il permet de déclarer la barre de navigation {@link Navbar} et les routes de l'application :
 * - /Home : page d'accueil {@link Home}
 * - /Register : page d'inscription {@link Register}
 * - /Login : page de connexion {@link Login}
 * - /Profile : page de profil {@link Profile}
 * - /Action_service : page d'action sur un service {@link Action_service}
 * - /SubscribeService : page d'abonnement à un service {@link SubscribeService}
 * - /ActivateApplet : page d'activation d'un applet {@link ActivateApplet}
 * - /ForgetPassword : page de réinitialisation du mot de passe {@link ForgetPassword}
 * 
 * @returns {JSX.Element} Le composant principal de l'application
 */
function App() {
  return (
    <>
      <Navbar />
      <Routes>
        {/* <Switch> */}
        <Route path='/' element={<Home />} /> 
        <Route path='/service/:name' element={< Action_service />} /> {/* La route pour l'action sur un service */}
        <Route path='/service/subscribe/:name' element={ <SubscribeService/> } /> {/* La route pour l'abonnement à un service */}
        <Route path='/service/:service_name/activate/:action_name' element={<ActivateApplet/>}/> {/* La route pour l'activation d'un applet */}
        <Route path="/login" element={<Login />} /> {/* La route pour la connexion */}
        <Route path="/signup" element={<Signup />} /> {/* La route pour l'inscription */}
        <Route path='/register' element={<Register />} /> {/* La route pour l'inscription */}
        <Route path='/profile' element={<Profile />} /> {/* La route pour le profil */}
        <Route path='/forgetpassword' element={<ForgetPassword />} /> {/* La route pour la réinitialisation du mot de passe */}
        <Route path='/applets' element={<AppletPage />} /> {/* La route pour la page applet que l'utilisateur verra sur sa page favorite */}
        <Route path='/service/:service_name/resendtoken/:all_token' element={<ResendToken/>} /> {/* La route qui va permettre d'envoyer l'access token au backend*/}
        <Route path='/client.apk' element={<DownloadApp/>}/>
        {/* </Switch> */}
      </Routes>
    </>
  );
}

export default App;