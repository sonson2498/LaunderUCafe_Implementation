import {toast} from 'react-toastify';

toast.configure();

const initialState = [];

export const initializer = (initialValue = initialState) =>
  JSON.parse(localStorage.getItem("localCart")) || initialValue;

export const CartReducer = (state, action) => {

    const {shoppingCart, totalPrice, totalQty} = state;

    let product;
    let index;
    let updatedPrice;
    let updatedQty;

    switch (action.type){

        case 'ADD_TO_CART':

          const check = shoppingCart.find(product => product.id === action.id );

          if (check){
              toast.error('This product is already in your cart', {
                  position: "top-right",
                  autoClose: 2000,
                  hideProgressbar: false,
                  closeOnClick: true,
                  pauseOnHover: false,
                  draggable: false,
                  progress: undefined,
                  toastId: 0,
              });

              return state;
          }
          else{
              product= action.product;
              product['qty']=1;
              product['totalProductPrice']= product.cost * product.qty;
              updatedQty = totalQty + 1;
              updatedPrice = totalPrice + product.cost;
              toast.dark('Item added to your cart', {
                  position: "top-right",
                  autoClose: 2000,
                  hideProgressbar: false,
                  closeOnClick: true,
                  pauseOnHover: false,
                  draggable: false,
                  progress: undefined,
                  toastId:1,
              });
              return{
                  shoppingCart: [product, ...shoppingCart], totalPrice: updatedPrice, totalQty: updatedQty
              }
          }
          break;

        case 'INC':
            product = action.cart;
            ++product.qty;
            product.totalProductPrice = product.qty * product.cost;
            updatedQty = totalQty + 1;
            updatedPrice = totalPrice + product.cost;
            index = shoppingCart.findIndex(cart => cart.id === action.id);
            shoppingCart[index] = product;
            return {
                shoppingCart: [...shoppingCart], totalPrice: updatedPrice, totalQty: updatedQty
            }
            break;

            case 'DEC':
                product = action.cart;
                if (product.qty > 1) {
                    --product.qty;
                    product.totalProductPrice = product.qty * product.cost;
                    updatedPrice = totalPrice - product.cost;
                    updatedQty = totalQty - 1;
                    index = shoppingCart.findIndex(cart => cart.id === action.id);
                    shoppingCart[index] = product;
                    return {
                      shoppingCart: [...shoppingCart], totalPrice: updatedPrice, totalQty: updatedQty
                    }
                }
                else {
                    return state;
                }
                break;

            case 'DELETE':
                const filtered = shoppingCart.filter(product => product.id !== action.id);
                product = action.cart;
                updatedQty = totalQty - product.qty;
                updatedPrice = totalPrice - product.qty * product.cost;
                return {
                    shoppingCart: [...filtered], totalPrice: updatedPrice, totalQty: updatedQty
                }
                break;

            case 'EMPTY':
                return {
                    shoppingCart: [], totalPrice: 0, totalQty: 0
                }

            default:
                return state;

    }
}
