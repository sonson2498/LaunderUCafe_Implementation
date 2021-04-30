import React, {useContext, useState, useEffect} from 'react';
import {Form, Card, Button, ListGroup, Container, Modal, Alert,Row, Col, InputGroup} from "react-bootstrap";
import {firestore} from "../../../firebase";
import {useAuth} from "../../../contexts/AuthContext";

export default function Employee() {

  const{currentUser} = useAuth()
  const orderDetails = [];

  async function viewOrder(){
    await firestore.collection('orderDetails').get()
    .then(querySnapshot => {
      querySnapshot.docs.forEach(doc => {
      orderDetails.push({id: currentUser.uid, ...doc.data()});
    });
  });
  }

  useEffect(()=>{
    viewOrder()
    console.log(orderDetails);
  },[])

  return (
    <Container className="d -flex align-items-center justify-our-content mt-3">
    <Card>
    <Card.Header as="h3">Orders</Card.Header>
    {orderDetails.map((product) =>
      <Card.Body key={product.id}>
      <ListGroup className="list-group-flush">
            <div id="ItemHeader">{JSON.stringify(product.shoppingCart)}</div>
      </ListGroup>
      </Card.Body>)}
      </Card>


    </Container>
  )
}
