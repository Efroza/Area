import React, {useState} from 'react';
import { Link, useNavigate } from 'react-router-dom';
import './Navbar.css';
import { Button } from './Button';
import Avatar from './Avatar';
import DropDown from './DropDown';
// import { unstable_concurrentAct } from 'react-dom/test-utils';

/**
 * @description La barre de navigation de l'application permet de naviguer entre les différentes pages de l'application situé en haut de la page:
 * - Si l'utilisateur n'est pas connecté :
 *      - La page d'accueil {@link Home}
 *      - La page de connexion {@link Login}
 *      - La page d'inscription {@link Register}
 * - Si l'utilisateur est connecté :
 *      - La page d'accueil {@link Home}
 *      - La page de profil {@link Profile}
 *      - La page de déconnexion
 * 
 * @returns {JSX.Element} La barre de navigation
 */

function Navbar() {
    const [click, setClick] = useState(false);  // Permet de détecter si on clique sur le bouton du menu
    const [button, setButton] = useState(true);

    const [dropdown, setDropdown] = useState(false); // Permet de détecter si on passe la souris sur le bouton du menu

    const handleClick = () => setClick(!click); // Permet de changer l'état du click
    const closeMobileMenu = () => setClick(false); // Permet de fermer le menu mobile

    const user_name = sessionStorage.getItem("user_name"); // Récupère le nom de l'utilisateur connecté
    const user_image = sessionStorage.getItem("user_image"); // Récupère l'image de l'utilisateur connecté
    const navigate = useNavigate(); // Permet de naviguer entre les pages

    
    const showButton = () => {
        if(window.innerWidth <= 960) {
            setButton(false);
        } else {
            setButton(true);
        }
    }; /** 
    * Permet de détecter la taille de l'écran et de changer l'état du bouton selon.
    * Si la taille de l'écran est inférieur à 960px, le bouton est caché.
    * Sinon, le bouton est affiché.
    */

    const logOut = () => {
        sessionStorage.clear();
        navigate('/');
        window.location.reload(false);
    } /** Permet à l'utilisateur de se déconnecter */

    const ShowButtonUser = () => {
        if (user_name === null) { // Si l'utilisateur n'est pas connecté
            return (
                <ul className={click ? 'nav-menu active' : 'nav-menu'}>
                <li className='nav-item'>
                    <Link
                    to='/login'
                    className='nav-links'
                    onClick={closeMobileMenu}
                    >
                    Login
                    </Link>
                </li>
                <li className='nav-item'>
                    <Link to='/register' className='nav-links'onClick={closeMobileMenu}>Sign Up</Link>
                </li>
                </ul>
            )
        } else { // Si l'utilisateur est connecté
            return (
                <ul className={click ? 'nav-menu active' : 'nav-menu'}>
                    <li className='nav-item'>
                        <Link to='/' className='nav-links' onClick={closeMobileMenu}>
                            Home
                        </Link>
                    </li>
                    {/* <li className='nav-item'> */}
                            {/* <Link
                            to='/'
                            className='nav-links'
                            onClick={closeMobileMenu}
                            >
                                Test
                            </Link> */}
                        {/* </li> */}
                        <li className='nav-item' onMouseEnter={() => setDropdown(true)}
                            onMouseLeave={() => setDropdown(false)}>
                            <Link to='profile' className='nav-links'onClick={closeMobileMenu}>
                                <Avatar src = {user_image} alt={user_name}/>
                            </Link>
                            {dropdown && <DropDown />}
                        </li>
                        <li className='nav-item'>
                            <Link className='nav-links' onClick={logOut}>
                                <Avatar src = {"https://www.citypng.com/public/uploads/preview/png-login-logout-white-icon-11641484341czkekai5wp.png"} alt="logout"/>
                            </Link>
                        </li>
                </ul>
            )
        }
    }; /**
    * Permet de détecter si l'utilisateur est connecté ou non.
    * Si l'utilisateur est connecté, le bouton de connexion et d'inscription sont cachés.
    * Sinon, le bouton de déconnexion est caché.
    * @returns {JSX.Element} Le bouton de connexion ou de déconnexion
    * @returns {JSX.Element} Le bouton d'inscription
    * @returns {JSX.Element} Le bouton de profil avec @returns {JSX.Element} menu dropdown
    * @returns {JSX.Element} Le bouton de test
    * @returns {JSX.Element} Le bouton de déconnexion
    * }
    */

    window.addEventListener('resize', showButton); // Permet de détecter la taille de l'écran

    return (
        <>
            <nav className='navbar'>
                <div className='navbar-container'>
                    <Link to="/" className='navbar-logo'>
                        AREA <i className='fab.fa-typo3'/>
                    </Link>
                    <div className='menu-icon' onClick={handleClick}>
                        <i className={click ? 'fas fa-times' : 'fas fa-bars'} />
                    </div>
                    <ShowButtonUser />
                </div>
            </nav>
        </>
    );
    /**
     * @returns {JSX.Element} La barre de navigation
     */
}

export default Navbar;