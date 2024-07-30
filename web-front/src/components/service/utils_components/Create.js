import './AppletFormat.css';
import axios from 'axios'
import { useEffect, useState } from 'react';
import Componeent from './Component'

const URL_HOST_API = process.env.REACT_APP_API_HOST

const URL_GET_MANDATORY_ACTION = URL_HOST_API + "applet/action/mandatory"

const URL_GET_MANDATORY_REACTION = URL_HOST_API + "applet/reaction/mandatory"

const URL_POST_APPLET = URL_HOST_API + 'applet/applet/'

const URL_SERVICE_API = URL_HOST_API + 'service/'

/**
 * @description Description à faire.
 */
function Build_Mandatory({ mandatory, stop, json_funct }) {
  const [values, setValue] = useState([])

  useEffect(() => {
    const stock = []
    let result;

    if (stop === false)
        return
    for (let i = 0; i < mandatory.length; ++i)
      stock.push({ [mandatory[i].name]: values[i] })
    for (const obj of stock)
      result = { ...result, ...obj }
    json_funct(result)
    setValue([])
  }, [stop, json_funct, mandatory]) // moid je dis beleck

  function handleChange(event, index) {
    const copy = values;
    copy[index] = event.target.value
    setValue(copy)
  }

  return mandatory.map((res, index) => {
    return (<input type="text"
        key={index}
        name={res.name}
        placeholder={res.name}
        value={values[index]}
        onChange={(event) => handleChange(event, index)}
    />)
  }
  )
}

function Create_Componeent({ component, url , stop, result_funct})
{
  const [mandatory, setMandatory] = useState([])
  const [image, setImage] = useState('')

  /**
  * @name useEffect
  * @description Je ne sais pas.
  * @type {Connexion_serveur}
  */
  useEffect(() => {
    axios.get(url)
    .then(res => setMandatory(res.data))
      .catch(err => console.error(err))
    axios.get(URL_SERVICE_API + component.id_service)
      .then(res => setImage(res?.data[0]?.image))
      .catch(err => console.error(err))
  }, [])

  function json_component(manedatory_json)
  {
    result_funct({ id: component.id , ...manedatory_json})
  }

  return (
    <div className='line'>
      <Componeent name={component.name} description={component.description} image={URL_HOST_API + image} />
      <Build_Mandatory mandatory={mandatory} stop={stop} json_funct={json_component} />
    </div>
  )
}

function Create_Reaction({ reactions, stop, add_reaction })
{
  return reactions.map((reaction, index) =>
    <Create_Componeent key={index} component={reaction}
      url={URL_GET_MANDATORY_REACTION + '/' + reaction.id.toString()}
      stop={stop} result_funct={add_reaction} />
  )
}

export default function Create({ action, reactions, empty, token })
{
  const [create, setCreate] = useState({})
  const [reactionCreate, setReactionCreate] = useState([])
  const [stop, setStop] = useState(false)
    useEffect(() => {
    if (create.action !== undefined
      && create.reaction !== undefined
      && create.reaction.length === reactions.length)
    {
      axios.post(URL_POST_APPLET, create,{
        headers: {
            'Authorization': `Token ${token}`
            }
        })
        .then(response => console.log('response post', response))
        .catch(err => console.error(err))
      setCreate({})
      setReactionCreate([])
      setStop(false)
      empty()
    }
    }, [create, reactionCreate])

  useEffect(() => {
    console.log('REACTION CREATE', reactionCreate)
    if (reactions.length === reactionCreate.length)
      add_create({reaction : reactionCreate})
  }, [reactionCreate])

  function add_create(component_json) {
    setCreate({ ...create, ...component_json })
  }

  function add_action_json(json_component) {
    add_create({action: json_component})
  }

  function add_reaction_json(json_element)
  {
    setReactionCreate(current => [...current, json_element])
  }

  if (action == null)
    return <h1>Create:</h1>
  return (
    <div>
      <div>
        <h1>Create: </h1>
      </div>
      <div className='line'>
        <Create_Componeent className='Create' component={action} url={URL_GET_MANDATORY_ACTION + '/' + action.id.toString()} stop={stop}
          result_funct={add_action_json} />
      </div>
      <Create_Reaction reactions={reactions} stop={stop} add_reaction={add_reaction_json} />
      <div className='ContainerButton'>
        <button className='DoneButton' onClick={() => setStop(true)}>DONE</button>
        <br></br>
        <br></br>
        <br></br>

      </div>
    </div>
  )
}