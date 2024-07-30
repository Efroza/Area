import React from "react";
import { Link } from "react-router-dom";
import { useUserAuth } from "./UserAuthContexte";

/**
 * @description Ce composant permet de créer une route protégée.
 * Il est appelé par le composant {@link App}.
 * @return {JSX.Element} Le composant de la route protégée.
 */
const ProtectedRoute = ({ children }) => {
  const { user } = useUserAuth();

  console.log("Check user in Private: ", user);
  if (!user) {
    return <Link to="/" />;
  }
  return children;
};

export default ProtectedRoute;