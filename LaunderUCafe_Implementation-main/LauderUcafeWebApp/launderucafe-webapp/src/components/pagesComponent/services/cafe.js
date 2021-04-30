import React, {useContext, useState, useEffect} from 'react';
import {Card, ListGroup, Button, Container} from "react-bootstrap";
import {firestore} from "../../../firebase";
import {CartContext} from '../../../global/CartContext';

function useFoodDetails(){

     const [foodItems, setFoodItems] = useState([])
     useEffect(()=>{
       firestore
         .collection('foodMenu')
         .onSnapshot((snapshot) =>{
           const newFoodDetails = snapshot.docs.map((doc) => ({
             id:doc.id,
             ...doc.data()
           }))
            setFoodItems(newFoodDetails)
        })
     },[])

     return foodItems
    }

    export default function Cafe() {

      const foodItems = useFoodDetails()
      const {dispatch} = useContext(CartContext);

      return (
        <Container className="d -flex align-items-center justify-our-content mt-5">

          <Card>
          <Card.Header as="h3"><span class="fas fa-utensils"></span> Cafe Menu</Card.Header>
          {foodItems.map((product) =>
            <Card.Body key={product.id}>
            <ListGroup className="list-group-flush">
                  <div id="ItemHeader">{product.name}</div>
                <div id="ItemHolder">
                    <div id="ItemImage"><img src={product.image}/></div>
                    <div id="ItemDetails">{product.details}</div>
                </div>
                <div id="ItemShop">
                    <div id="ItemCost">Price: ${product.cost}</div>
                    <div id="CartButton"><Button variant="secondary" className="customAddItem"
                        onClick={() => dispatch({type:'ADD_TO_CART', id: product.id, product})}>
                        Add
                        <span className="fas fa-shopping-cart"></span></Button></div>
                    </div>
            </ListGroup>
            </Card.Body>)}
            </Card>
        </Container>
      )
}
