import React, {useState, useContext} from 'react';
import {Link, useHistory} from 'react-router-dom';
import {Button} from 'react-bootstrap';
import {useAuth} from "../../contexts/AuthContext";
import { CartContext } from '../../global/CartContext';
import { LaundryContext } from '../../global/LaundryContext';


function Header(){

    const [error, setError] = useState("")
    const {currentUser, logout} = useAuth()
    const history = useHistory()
    const { totalQty } = useContext(CartContext);
    const {totalLaundryQty} = useContext(LaundryContext);



    async function handleLogOut(){
      setError('')

      try{
        await logout()
        history.push('/login')
      }catch{
        setError("Failed to log out!")  

      }

    }

    return (
      <nav className="navbar navbar-expand-xl navbar-light bg-dark">
      <div className="container-fluid">
        <Link className="navbar-brand text-white" to="/">
        <img src="logo.png" alt="logo" width="70" height="60"/>
        LaunderUCafe
        </Link>
    <button
      className="navbar-toggler bg-white"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent"
      aria-expanded="false"
      aria-label="Toggle navigation"
      >

      <span className="navbar-toggler-icon"></span>
    </button>
    <div className="collapse navbar-collapse" id="navbarSupportedContent">
      <ul className="navbar-nav m-auto">
        <li className="nav-item">
          <Link className="nav-link text-white mx-3" aria-current="page" to='/'>Home</Link>
        </li>
        <li className="nav-item dropdown">
          <ul className="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <li><a className="dropdown-item" href="#">Laundry Services</a></li>
            <li><a className="dropdown-item" href="#">Cafe Menu</a></li>
          </ul>
        </li>
        <li className="nav-item dropdown">
          <Link className="nav-link dropdown-toggle text-white mx-3" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Services
          </Link>
          <ul className="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><Link className="dropdown-item" to="/laundry">Laundry</Link></li>
            <li><Link className="dropdown-item" to="/cafe">Cafe</Link></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white mx-3" href="#" tabindex="-1" aria-disabled="true">About Us</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white mx-3" href="#" tabindex="-1" aria-disabled="true">Contact Us</a>
        </li>
        </ul>
        <ul className="navbar-nav m-auto">
        <li class="nav-item">
        {
            currentUser ?
            (<Link class="nav-link text-white mx-3" to='/userpage' tabindex="-1" aria-disabled="true"><span class="fas fa-user"></span> Profile</Link>) :
            (<Link class="nav-link text-white mx-3" to='/signup' tabindex="-1" aria-disabled="true"><span class="fas fa-user"></span> Sign Up</Link>)

        }
        </li>
        <li class="nav-item">
        {
          currentUser ?
          (<Button variant="link color-white" onClick={handleLogOut}><span class="fas fa-sign-out-alt"></span>Log Out</Button>) :
          (<Link class="nav-link text-white mx-3" to='/login' tabindex="-1" aria-disabled="true"><span class="fas fa-sign-in-alt"></span>Log In</Link>)

        }
          </li>
        </ul>
        <ul className="navbar-nav m-auto">
        <li className="nav-item dropdown">
          <Link className="nav-link dropdown-toggle text-white mx-3" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            View Cart <span className="fas fa-shopping-cart fa-lg"></span><span className='no-of-products'>{totalQty+totalLaundryQty}</span>
          </Link>
          <ul className="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><Link className="dropdown-item" to="/cart">Cafe Cart</Link></li>
            <li><Link className="dropdown-item" to="/laundryCart">Laundry Cart</Link></li>
          </ul>
        </li>
        </ul>
      </div>
    </div>
  </nav>
  );
}

export default Header;
