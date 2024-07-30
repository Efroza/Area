/**
 * @typedef {Object} DropDownItemsProps
 * @property {number} id - Identifiant du service.
 * @property {string} title - Titre du service.
 * @property {string} path - Chemin de la page du service.
 * @property {string} className - Classe CSS du service. 
 */

/** 
 * @description Ce composant permet de faire une liste déroulante des différentes pages présentes dans le menu déroulant de la navbar.
 * Il est appelé par le composant {@link DropDown}.
 * @type {DropDownItemsProps[]}
 */
export const serviceDropdown = [
  {
    id: 1,
    title: "Settings",
    path: "./",
    className: "dropdown-item",
  },
  {
    id: 2,
    title: "Favorite",
    path: "./applets",
    className: "dropdown-item",
  },
  {
    id: 3,
    title: "Infos",
    path: "./",
    className: "dropdown-item",
  },
  {
    id: 4,
    title: "Development",
    path: "./",
    className: "dropdown-item",
  },
];