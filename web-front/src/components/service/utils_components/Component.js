import './AppletFormat.css';
/**
 * @function Applet
 * @description Ce composant permet de créer un applet selon des paramètres.
 * Il est appelé par le composant {@link App}.
 * @param {number} id - Identifiant de l'applet.
 * @param {string} name - Titre de l'applet.
 * @param {string} description - Description de l'applet.
 * @param {function} onClick - La fonction à exécuter au clic.
 * @return {JSX.Element} Le composant de l'applet.
 */
export default function Component({name, description, onClick, image })
{
  return (
    <button className='Applet' onClick={onClick}>
      <img className='image_applet' src={image} />
      <h2>{name}</h2>
      <p>{description}</p>
  </button>)
}
