import React from 'react';
import { Button } from './Button';
import './Footer.css';
import { Link } from 'react-router-dom';

/**
 * @description Pour l'instant ce composant n'est pas utile, il s'agit d'une page test.
 */
function Footer() {
    return (
        <div className='footer-container'>
            <section className="footer-subscription">
                <p className="footer-subscription-heading">
                    test bbabb
                    bababbabbabbabab lknlnlnlknlknlnln
                </p>
                <p className="footer-subscription-text">
                    testttttttttttttttttttttttt
                </p>
                <div className="input-areas">
                    {/* <form>
                        <input type="email"
                        name="email"
                        placeholder="Your Email"
                        className="footer-input"
                        />
                        <Button buttonStyle='btn--outline'>Suscribe</Button>
                    </form> */}
                </div>
            </section>
            <div className="footer-links">
                <div className="footer-link-wrapper">
                <div className="footer-link-items">
                    <h2>Test</h2>
                    <Link to='/sign-up'></Link>
                    <Link to='/'>Testimonials</Link>
                    <Link to='/'>Careers</Link>
                    <Link to='/'>Terms</Link>
                </div>
                <div className="footer-link-items">
                    <h2>About us</h2>
                    <Link to='/sign-up'></Link>
                    <Link to='/'>Support</Link>
                    <Link to='/'>1</Link>
                    <Link to='/'>Terms of service</Link>
                </div>
            </div>
            <div className="footer-link-wrapper">
                <div className="footer-link-items">
                    <h2>Contact Us</h2>
                    <Link to='/sign-up'></Link>
                    <Link to='/'>m</Link>
                    <Link to='/'>Test</Link>
                    <Link to='/'>Test</Link>
                </div>
                {/* <div className="footer-link-items">
                    <h2>Media</h2>
                    <Link to='/sign-up'></Link>
                    <Link to='/'>Testimonials</Link>
                    <Link to='/'>Test</Link>
                    <Link to='/'>Test</Link>
                </div> */}
            </div>
        </div>
        <section className='social-media'>
            <div className='social-media-wrap'>
                <div className='footer-logo'>
                    {/* <Link to='/'className='social-logo'>
                        VSM <i className='fab fa-typo3'></i>
                    </Link> */}
                </div>
                <small className='website-rights'>IFTT ©️ 2023</small>
                <div className='social-icons'>
                    <Link className='social-icon-link facebook'
                    to='///fr-fr.facebook.com/monvehiculesurmesure/'
                    target='_blank'
                    aria-label='Facebook'
                    >
                        <i className='fab fa-facebook-f' />
                    </Link>
                    <Link className='social-icon-link instagram'
                    to={'//www.instagram.com/vehicule_sur_mesure/'}
                    target='_blank'
                    aria-label='Instagram'
                    >
                        <i className='fab fa-instagram' />
                    </Link>
                    <Link className='social-icon-link whatsapp'
                    to='/'
                    target='_blank'
                    aria-label='Whatsapp'
                    >
                        <i className='fab fa-whatsapp' />
                    </Link>
                    {/* <Link className='social-icon-link twitter'
                    to='/'
                    target='_blank'
                    aria-label='Twitter'
                    >
                        <i className='fab fa-twitter' />
                    </Link> */}
                </div>
            </div>
        </section>
    </div>
    )
}

export default Footer;