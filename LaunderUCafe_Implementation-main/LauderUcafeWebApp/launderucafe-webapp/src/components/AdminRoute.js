import React from "react"
import { Route, Redirect } from "react-router-dom"
import { useAuth } from "../contexts/AuthContext"

export default function AdminRoute({ component: Component, ...rest }) {

  const { admin } = useAuth()

  return (
    <Route
      {...rest}
      render={props => {
        return admin ? <Component {...props} /> : <Redirect to="/login" />
      }}
    ></Route>
  )
}
