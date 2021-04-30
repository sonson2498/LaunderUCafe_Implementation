import React, {createContext,useEffect, useReducer, useState} from 'react';
import {CartReducer, initializer} from './CartReducer';
import {firestore} from "../firebase";
import {useAuth} from "../contexts/AuthContext";
import { useHistory } from 'react-router-dom'


export const CartContext = createContext();

export const CartContextProvider = (props) => {

    const{currentUser} = useAuth();

    const history = useHistory();

    const [cart, dispatch] = useReducer(CartReducer, {shoppingCart: [], totalPrice: 0, totalQty: 0 }, initializer)

    useEffect(() => {
      if (currentUser) {
        if(cart.shoppingCart.length > 0){
          async function SetCartItems(){
            await firestore
                  .collection("cart")
                  .doc(currentUser.uid)
                  .set({
                    CartItems: cart.shoppingCart,
                    TotalCartQty: cart.totalQty,
                    TotalCartPrice: cart.totalPrice
                  })
                }
                SetCartItems();
                localStorage.setItem("localCart", JSON.stringify(cart));
        }
      }


          },[cart])

    return (
      <CartContext.Provider value={{...cart, dispatch}}>
            {props.children}
      </CartContext.Provider>
    )

}
