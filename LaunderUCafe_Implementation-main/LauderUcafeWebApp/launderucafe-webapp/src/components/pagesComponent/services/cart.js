import React, {useContext, useEffect} from 'react';
import {CartContext} from '../../../global/CartContext';
import { Icon } from 'react-icons-kit'
import { ic_add } from 'react-icons-kit/md/ic_add'
import { ic_remove } from 'react-icons-kit/md/ic_remove'
import { iosTrashOutline } from 'react-icons-kit/ionicons/iosTrashOutline'
import { Link } from 'react-router-dom'
import {Container, Button} from "react-bootstrap";
import {useAuth} from "../../../contexts/AuthContext";
import { useHistory } from 'react-router-dom'
import {firestore} from "../../../firebase";

export default function Cart() {

    const {currentUser} = useAuth()

    const { shoppingCart, dispatch, totalPrice, totalQty} = useContext(CartContext);

    const history = useHistory();

    useEffect(() => {
            if (!currentUser) {
                history.push('/login');
            }

          },[])

  return (
    <Container className="d -flex align-items-center justify-our-content mt-5">
    <h1>Cart</h1>
    <div className='cart-container'>
      {
        shoppingCart.length === 0 && <>
              <div>No items in your cart!</div>
              <div><Link to="/">Return to Home page</Link></div>
            </>
            }
            {shoppingCart && shoppingCart.map(cart => (
                <div className='cart-card' key={cart.id}>

                    <div className='cart-img'>
                        <img src={cart.image} alt="not found" />
                    </div>

                    <div className='cart-name'>{cart.name}</div>

                    <div className='cart-price-orignal'>$ {cart.cost}</div>

                    <div className='inc' onClick={() => dispatch({ type: 'INC', id: cart.id, cart })}>
                      <Button variant="success">  <Icon icon={ic_add} size={24} /></Button>
                    </div>

                    <div className='quantity'>{cart.qty}</div>

                    <div className='dec' onClick={() => dispatch({ type: 'DEC', id: cart.id, cart })}>
                      <Button variant="success">  <Icon icon={ic_remove} size={24} /></Button>
                    </div>

                    <div className='cart-price'>
                        $ {cart.totalProductPrice}
                    </div>

                    <div className='delete-btn' onClick={() => dispatch({ type: 'DELETE', id: cart.id, cart })}>
                      <Button variant="danger"><Icon icon={iosTrashOutline} size={24} />  </Button>
                    </div>
                </div>
            ))
            }
            {shoppingCart.length > 0 && <div className='cart-summary'>
                <div className='cart-summary-heading'>
                    Cart-Summary
                </div>
                <div className='cart-summary-price'>
                    <span>Total Price</span>
                    <span>{totalPrice}</span>
                </div>
                <div className='cart-summary-price'>
                    <span>Total Qty</span>
                    <span>{totalQty}</span>
                </div>
                <Link to='/checkout' className='cashout-link'>
                    <Button className='w-100 mt-3' variant="success">
                        Proceed To CheckOut
                </Button>
                </Link>
            </div>}
            </div>
    </Container>
  )
}
