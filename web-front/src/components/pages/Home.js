import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom'
import '../../App.css';
import HeroSection from '../HeroSection';
import Cards from '../Cards';
import Footer from '../Footer';

/**
 * @description Composant de la page d'accueil
 * Ce composant est appelé par le composant principal de l'application {@link App},
 * Il redirige vers la page de connexion si l'utilisateur n'est pas déjà connecté en regardant le token dans le localStorage :
 * 
 * Sinon il affiche la page d'accueil permettant de voir les différentes fonctionnalités de l'application :
 * - {@link HeroSection} : la section d'accueil
 * - {@link Cards} : les cartes de présentation des fonctionnalités
 * 
 * @returns {JSX.Element} La page d'accueil
 */
function Home() {
    const token = sessionStorage.getItem('Token')
    const navigate = useNavigate()

    useEffect(() => {
        if (token == null)
            navigate('/login')
    }, [token])

    return (
        <>
            <HeroSection />
            <Cards />
            <Footer />
        </>
    );
}

export default Home;

