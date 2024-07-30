import React from 'react';
import '../App.css';
import { Button } from './Button';
import './HeroSection.css';

/**
 * @description Composant de la section d'accueil, il permet de définir le contenu du bloc sous la navbar quand l'utilisateur est connecté.
 * Ce composant est appelé par le composant {@link Home}
 */
function HeroSection() {
  return (
    <div className='hero-container'>
      {/* <video src='/videos/video-1.mp4' autoPlay loop muted /> */}
    {/* <img src={image} height={1000} width={500} /> */}
      <h2></h2>
        {/* <p></p>
      <ul>
          <li>Test</li>
          <li>Test</li>
          <li>Test</li>
       </ul>
      <p>Test ?</p> */}
      </div>
  );
}


export default HeroSection;