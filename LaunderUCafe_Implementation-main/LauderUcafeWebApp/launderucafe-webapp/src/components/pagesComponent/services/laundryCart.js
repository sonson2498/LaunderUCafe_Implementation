import React, {useContext, useEffect, useState} from 'react';
import {LaundryContext} from '../../../global/LaundryContext';
import { Icon } from 'react-icons-kit'
import { ic_add } from 'react-icons-kit/md/ic_add'
import { ic_remove } from 'react-icons-kit/md/ic_remove'
import { iosTrashOutline } from 'react-icons-kit/ionicons/iosTrashOutline'
import { Link } from 'react-router-dom'
import {Container, Card, Button} from "react-bootstrap";
import {useAuth} from "../../../contexts/AuthContext";
import { useHistory } from 'react-router-dom'
import {firestore} from "../../../firebase";

export default function LaundryCart() {

        const {currentUser} = useAuth()

      const history = useHistory();

      const [details, setDetails] = useState({});

      useEffect(() => {
              if (!currentUser) {
                  history.push('/login');
              }
              else{
                firestore
                  .collection("LaundryCart")
                  .doc(currentUser.uid)
                  .get()
                  .then(snapshot => setDetails(snapshot.data()))
                }
            },[])


    const {laundryCart, dispatchLaundry, totalLaundryPrice, totalLaundryQty} = useContext(LaundryContext);

    const [loading, setLoading] = useState(true)




  return (

    <Container className="d -flex align-items-center justify-our-content mt-5">
    <h1> Laundry Cart</h1>
    <div className='cart-container'>

            <Card className='mb-5'>
            <Card.Header><Card.Title>Customer Details</Card.Title></Card.Header>
            <Card.Body>
            {details ?
              (<div><span>Please make sure you have entered your address in your profile page before placing order.</span></div>) :
              (<div>
                  {details.DeliveryInformation}
              </div>)
            }
            </Card.Body>
            </Card>
            {
              laundryCart.length === 0 && <>
                    <div>No items in your cart!</div>
                    <div><Link to="/">Return to Home page</Link></div>
                  </>
                  }
            {laundryCart && laundryCart.map(cart => (
                <div className='cart-card' key={cart.id}>

                    <div className='cart-img'>
                        <img src={cart.image} alt="not found" />
                    </div>

                    <div className='cart-name'>{cart.name}</div>

                    <div className='cart-price-orignal'>$ {cart.cost}</div>

                    <div className='inc' onClick={() => dispatchLaundry({ type: 'INC', id: cart.id, cart })}>
                      <Button variant="success">  <Icon icon={ic_add} size={24} /></Button>
                    </div>

                    <div className='quantity'>{cart.qty}</div>

                    <div className='dec' onClick={() => dispatchLaundry({ type: 'DEC', id: cart.id, cart })}>
                      <Button variant="success">  <Icon icon={ic_remove} size={24} /></Button>
                    </div>

                    <div className='cart-price'>
                        $ {cart.totalProductPrice}
                    </div>

                    <div className='delete-btn' onClick={() => dispatchLaundry({ type: 'DELETE', id: cart.id, cart })}>
                      <Button variant="danger"><Icon icon={iosTrashOutline} size={24} />  </Button>
                    </div>
                </div>
            ))
            }
            {laundryCart.length > 0 && <div className='cart-summary'>
                <div className='cart-summary-heading'>
                    Cart-Summary
                </div>
                <div className='cart-summary-price'>
                    <span>Total Price</span>
                    <span>{totalLaundryPrice}</span>
                </div>
                <div className='cart-summary-price'>
                    <span>Total Qty</span>
                    <span>{totalLaundryQty}</span>
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
