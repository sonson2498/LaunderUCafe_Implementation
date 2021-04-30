import React from "react"
import { Route, Redirect } from "react-router-dom"
import { useAuth } from "../contexts/AuthContext"

export default function EmployeeRoute({ component: Component, ...rest }) {
  const { employee } = useAuth()

  return (
    <Route
      {...rest}
      render={props => {
        return employee ? <Component {...props} /> : <Redirect to="/login" />
      }}
    ></Route>
  )
}
