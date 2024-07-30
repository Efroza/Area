// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyDVOioPxkMXEj1bdyP6FA6Q-kdlr_1mW2U",
  authDomain: "area--auth.firebaseapp.com",
  projectId: "area--auth",
  storageBucket: "area--auth.appspot.com",
  messagingSenderId: "1053270725949",
  appId: "1:1053270725949:web:675e976b3bbbf93581a154"
};

// Initialize Firebase

/**
 * @name Firebase
 * @description Export de firebase
 * @export {firebase}
 */
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export default app;
