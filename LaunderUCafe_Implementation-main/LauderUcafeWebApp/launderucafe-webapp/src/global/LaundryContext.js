import React, {createContext,useEffect, useReducer, useState} from 'react';
import {LaundryReducer, initializer} from './LaundryReducer';
import {firestore} from "../firebase";
import {useAuth} from "../contexts/AuthContext";


export const LaundryContext = createContext();

export const LaundryContextProvider = (props) => {

    const{currentUser} = useAuth();

    const [cart, dispatchLaundry] = useReducer(LaundryReducer, {laundryCart: [], totalLaundryPrice: 0, totalLaundryQty: 0 }, initializer)

        useEffect(() => {
          if (currentUser) {
              if(cart.laundryCart.length > 0){
                  firestore
                        .collection("LaundryCart")
                        .doc(currentUser.uid)
                        .set({
                          CartItems: cart.laundryCart,
                          TotalCartQty: cart.totalLaundryQty,
                          TotalCartPrice: cart.totalLaundryPrice
                        },{merge:true})
                      localStorage.setItem("LaundryCart", JSON.stringify(cart));
                    }
                }
              },[cart])


    return (
      <LaundryContext.Provider value={{...cart, dispatchLaundry}}>
            {props.children}
      </LaundryContext.Provider>
    )

}
