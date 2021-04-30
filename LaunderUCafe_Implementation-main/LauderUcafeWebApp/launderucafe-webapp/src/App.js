//includes
import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch
} from 'react-router-dom';
import './Assets/css/default.min.css';

//components
import Header from './components/headerComponent/header';
import Homepage from './components/pagesComponent/homepage';
import Login from './components/pagesComponent/login';
import Signup from './components/pagesComponent/signup';
import UserPage from './components/pagesComponent/userpage';
import {AuthProvider} from "./contexts/AuthContext";
import {CartContextProvider} from "./global/CartContext";
import {LaundryContextProvider} from "./global/LaundryContext";
import PrivateRoute from './components/PrivateRoute';
import AdminRoute from './components/AdminRoute';
import EmployeeRoute from './components/EmployeeRoute';
import Cafe from './components/pagesComponent/services/cafe';
import Laundry from './components/pagesComponent/services/laundry';
import Cart from './components/pagesComponent/services/cart';
import LaundryCart from './components/pagesComponent/services/laundryCart';
import CheckOutForm from './components/pagesComponent/payment/checkoutform';
import Admin from './components/pagesComponent/adminComponent/admin';
import Employee from './components/pagesComponent/employeeComponent/employee';
import Toolbar from './components/toolbarComponent/Toolbar'
import { FooterContainer } from './containers/footer'
import { loadStripe } from "@stripe/stripe-js";
import { Elements } from "@stripe/react-stripe-js";

const promise = loadStripe(process.env.REACT_APP_STRIPE_PUBLIC_KEY);


function App (){
  return (

    <Router>
      <AuthProvider>
      <CartContextProvider>
      <LaundryContextProvider>
      <Toolbar/>
      <Switch>
        <div className="App">
          <Header/>
          <Route exact path='/' component={Homepage}/>
          <Route exact path='/login' component={Login}/>
          <Route exact path='/signup' component={Signup}/>
          <PrivateRoute exact path='/userpage' component={UserPage}/>
          <Route exact path='/cafe' component={Cafe}/>
          <Route exact path='/laundry' component={Laundry}/>
          <PrivateRoute exact path='/cart' component={Cart}/>
          <PrivateRoute exact path='/laundryCart' component={LaundryCart}/>
          <Elements stripe={promise}>
          <PrivateRoute exact path='/checkout' component={CheckOutForm}/>
          <AdminRoute exact path='/admin' component={Admin}/>
          <EmployeeRoute exact path='/employee' component={Employee}/>
          </Elements>
          <FooterContainer />

        </div>
      </Switch>
      </LaundryContextProvider>
      </CartContextProvider>
      </AuthProvider>
    </Router>
  );
 }

export default App;
