import React, {useContext, useState, useEffect} from "react";
import {auth, firestore} from "../firebase";

const AuthContext = React.createContext()

export function useAuth(){
  return useContext(AuthContext)
}

export function AuthProvider({children}) {
  const [currentUser, setCurrentUser] = useState()
  const [loading, setLoading] = useState(true)
  const [userDetails, setUserDetails] = useState([])
  const [admin, setAdmin] = useState(false)
  const [employee, setEmployee] = useState(false)



function signup(email, password){
  return auth.createUserWithEmailAndPassword(email, password)
}

function login(email, password){
  return auth.signInWithEmailAndPassword(email, password)
}

function logout(){
   return auth.signOut()
}

function resetPassword(email){
  return auth.sendPasswordResetEmail(email)
}

function updatePassword(password){
  return currentUser.updatePassword(password)
}



useEffect(() =>{
  const unsubscribe = auth.onAuthStateChanged(user => {

    if(user){
      setCurrentUser(user)
      user.getIdTokenResult().then(idTokenResult => {
        setEmployee(idTokenResult.claims.employee);
        setAdmin(idTokenResult.claims.admin)
        console.log(admin);
        console.log(employee);
      })
    }
    else{
      setCurrentUser(null);
    }
    setLoading(false)
  })
  return unsubscribe
}, [admin, employee])


  const value = {
    currentUser,
    login,
    signup,
    logout,
    resetPassword,
    updatePassword,
    admin,
    employee
  }

  return (
    <AuthContext.Provider value={value}>
      {!loading && children}
    </AuthContext.Provider>
  )
}
