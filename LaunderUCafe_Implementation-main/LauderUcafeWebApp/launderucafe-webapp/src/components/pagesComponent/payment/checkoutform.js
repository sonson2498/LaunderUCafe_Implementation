import React, { useState, useEffect, useContext} from "react";
import {
  CardElement,
  useStripe,
  useElements
} from "@stripe/react-stripe-js";
import {Form, Col, Button, CardGroup, Card, Container, Alert} from 'react-bootstrap'
import axios from "axios";
import {CartContext} from '../../../global/CartContext';
import {firestore} from "../../../firebase";
import {useAuth} from "../../../contexts/AuthContext";

export default function CheckOutForm() {
  const [succeeded, setSucceeded] = useState(false);
  const [error, setError] = useState(null);
  const [processing, setProcessing] = useState('');
  const [disabled, setDisabled] = useState(true);
  const stripe = useStripe();
  const elements = useElements();
  const {currentUser} = useAuth();
  const [message, setMessage] = useState("");


  const cardStyle = {
  style: {
    base: {
      color: "#32325d",
      fontFamily: 'Arial, sans-serif',
      fontSmoothing: "antialiased",
      fontSize: "16px",
      "::placeholder": {
        color: "#32325d"
      }
    },
    invalid: {
      color: "#fa755a",
      iconColor: "#fa755a"
    }
  }
};

  const handleChange = async (event) => {
    // Listen for changes in the CardElement
    // and display any errors as the customer types their card details
    setDisabled(event.empty);
    setError(event.error ? event.error.message : "");
  };

  const handleSubmit = async ev => {
    ev.preventDefault();
    setProcessing(true);

    // Create PaymentIntent as soon as the page loads
    const { data: clientSecret } = await axios.post("/payment_intents");

    const payload = await stripe.confirmCardPayment(clientSecret, {
      payment_method: {
        card: elements.getElement(CardElement)
      }
    });

    if (payload.error) {
      setError(`Payment failed ${payload.error.message}`);
      setProcessing(false);
    } else {
      setError(null);
      setProcessing(false);
      setSucceeded(true);
    }
  };

  const { shoppingCart, dispatch, totalPrice, totalQty} = useContext(CartContext);

  function placeOrder(){

    firestore
    .collection("orderDetails")
    .doc(currentUser.uid)
    .set({
      shoppingCart,
      totalPrice,
      totalQty
    })
    setMessage("Order Placed Sucessfully.")
  }



  return (
    <Container className="d -flex justify-our-content mt-5">
    {message && <Alert variant="success">{message}</Alert>}
    <CardGroup>
      <Card>
        <Card.Header as="h5">Order Details</Card.Header>
        <Card.Body>
        <Card.Text as="h6" className="mt-2">
          Sub Total: ${totalPrice}
        </Card.Text>
        <Card.Text as="h6" className="mt-2">
          Sales Tax(6.5%): ${totalPrice*0.065}
        </Card.Text>
        <Card.Text as="h6" className="mt-2">
          TotalDue: ${totalPrice+(totalPrice*0.065)}
        </Card.Text>
      </Card.Body>
      </Card>


    <Card>
    <Card.Header as="h5">Card Details</Card.Header>
      <Card.Body>
    <Form id="payment-form" onSubmit={handleSubmit}>
     <Form.Row className="align-items-center">
      <CardElement id="card-element" options={cardStyle} onChange={handleChange}/>
    </Form.Row>
      <Button className="mt-2"
        disabled={processing || disabled || succeeded}
        id="submit"
      >
        <span id="button-text">
          {processing ? (
            <div className="spinner" id="spinner"></div>
          ) : (
            "Pay now"
          )}
        </span>
      </Button>
      {/* Show any error that happens when processing the payment */}
      {error && (
        <div className="card-error" role="alert">
          {error}
        </div>
      )}
      {/* Show a success message upon completion */}
      <p className={succeeded ? "result-message" : "result-message hidden"}>
        Payment succeeded, see the result in your
        <a
          href={`https://dashboard.stripe.com/test/payments`}
        >
          {" "}
          Stripe dashboard.
        </a> Refresh the page to pay again.
      </p>
        <Button className="mt-2 mx-2" onClick={placeOrder}
          id="submit">
          <span id="button-text">
            Place Test Order
          </span>
        </Button>

    </Form>
    </Card.Body>
    </Card>

    </CardGroup>
    </Container>
  );
}
