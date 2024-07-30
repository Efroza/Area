import './AppletFormat.css';
import axios from 'axios'
import { useEffect, useState } from 'react';
import Create from './Create';
import Component from './Component'
import Applet from './Applet';

const URL_HOST_API = process.env.REACT_APP_API_HOST

const URL_GET_ACTION = URL_HOST_API + "applet/action"

const URL_GET_REACTION = URL_HOST_API + "applet/reaction"

const URL_GET_SERVICE = URL_HOST_API + 'service/'

/**
 * @description Cette fonction retourne un composant qui affiche chaques réactions présente dans chaque actions
 * @param {Object[]} reactions - Liste des réactions
 * @param {function} add_create - Fonction qui ajoute une réaction à la liste des réactions à créer
 * @returns {Component} - Composant qui affiche chaques réactions présente dans chaque actions
 */

function ParseReaction({ reaction, add_create })
{
  const [image, setImage] = useState('')

  useEffect(() => {
    axios.get(URL_GET_SERVICE + reaction?.id_service)
      .then(res => {
        res?.data.forEach(element => {
          setImage(URL_HOST_API + element?.image)
        });
      })
      .catch(err => console.error(err))
  }, [])

  return <Component image={image} name={reaction.name}
    description={reaction.description} onClick={() => add_create(reaction.id)} />
}

function Reaction({reactions, add_create})
{

  return reactions.map(reaction => <ParseReaction key={reaction.id} reaction={reaction} add_create={add_create} />)
}

/**
 * @description Cette fonction retourne la value de l'action qui a l'id passé en paramètre
 * @param {Object[]} actions - Liste des actions
 * @param {number} id - Id de l'action
 * @returns {Object} - Value de l'action
 */
function getAction(id, actions)
{
  for (const value of actions) {
    if (value.id === id)
      return value
  }
  return null
}

/**
 * @description Cette fonction retourne un tableau de réactions qui ont l'id passé en paramètre
 * @param {number[]} ids - Liste des ids des réactions
 * @param {Object[]} reactions - Liste des réactions
 * @returns {Object[]} - Tableau de réactions
 */
function getReaction(ids, reactions)
{
  const result = []
  for (const id of ids)
    for (const value of reactions)
      if (value.id === id)
        result.push(value)
  return result
}

/**
 * @description Cette fonction retourne un composant qui affiche chaques actions présente dans chaque réactions
 * @param {Function} createActions - Fonction qui ajoute une action à la liste des actions à créer
 * @param {Object} token - Token de l'utilisateur
 * @returns {Component} - Composant qui affiche chaques actions présente dans chaque réactions
 */
function AppletFormat({createActions, token}) {
  const [actions, setActions] = useState([])
  const [reactions, setReactions] = useState([])
  const [createReactions, setCreateReactions] = useState([])
  const [reload, setReload] = useState(0)

  /**
   *
   */
  useEffect(() => {
    axios.get(URL_GET_ACTION, {
      headers: {
                'Authorization': `Token ${token}`
            }
    })
    .then(res => {
      setActions(res['data'])
        console.log(res['data'])
      }).catch(err => {
        console.error(err)
      })

    axios.get(URL_GET_REACTION, {
      headers: {
                'Authorization': `Token ${token}`
            }
    })
    .then(res => {
      setReactions(res['data'])
        console.log(res['data'])

      }).catch(err => {
        console.error(err)
      })
  }, [token])

  useEffect(() => {
    console.log('Action: %d', createActions)
    console.log('Reactions:', createReactions)
  }, [createActions, createReactions])

  const add_reaction = (id) => setCreateReactions(current => {
    for (const value of current)
      if (value === id)
        return current
    return [...current, id]
  })

  function empty()
  {
    setCreateReactions([])
    setReload(current => current + 1)
  }

  return (
    <div className="AppletFormat">
        <Create action={getAction(createActions, actions)} reactions={getReaction(createReactions, reactions)}
          empty={empty} token={token} />
        <h1>Reaction:</h1>
        <div className='reactions_container'>
          <Reaction className="reactions_container_child" reactions={reactions} add_create={add_reaction} />
        </div>
      {/* <Applet reload={reload} token={token} /> */}
    </div>
  );
}

export default AppletFormat;
