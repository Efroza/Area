import { createContext, useContext, useEffect, useState } from "react";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  onAuthStateChanged,
  signOut,
  GoogleAuthProvider,
  signInWithPopup,
} from "firebase/auth";
import { auth } from "./firebase";

const UserAuthContext = createContext();

/**
 * @name GoogleAuthentication
 * @description Export de plusieurs fonctions liés à google :
 * - logIn: permet de se connecter avec google
 * - signUp: permet de s'enregistrer avec google
 * - logOut: permet de se déconnecter
 * 
 * @returns {function[]} - Tableau de fonctions
 */
export const UserAuthContextProvider = ({ children }) => {
  const [user, setUser] = useState({});

  function logIn(email, password) {
    return signInWithEmailAndPassword(auth, email, password);
  }
  function signUp(email, password) {
    return createUserWithEmailAndPassword(auth, email, password);
  }
  function logOut() {
    return signOut(auth);
  }
  function googleSignIn() {
    const googleAuthProvider = new GoogleAuthProvider();
    console.log("log :", user);

    return signInWithPopup(auth, googleAuthProvider);
  }

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (currentuser) => {
      console.log("Auth", currentuser);
      setUser(currentuser);
    });

    return () => {
      unsubscribe();
    };
  }, []);

  return (
    <UserAuthContext.Provider
      value={{ user, logIn, signUp, logOut, googleSignIn }}
    >
      {children}
    </UserAuthContext.Provider>
  );
}

// export function useUserAuth() {
//   return useContext(userAuthContext);
// }

// const test = UserAuthContextProvider;

export default UserAuthContext;