import React from "react";
import ReactDOM from "react-dom";
import { BrowserRouter } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";
import App from "./App";

/**
 * @description Ce composant permet de créer un composant racine.
 * Il est appelé par le composant {@link index}.
 * @return {JSX.Element} Le composant racine.
 */
ReactDOM.render(
  <React.StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </React.StrictMode>,
  document.getElementById("root")
);