import {toast} from 'react-toastify';

toast.configure();

const initialState = [];

export const initializer = (initialValue = initialState) =>
  JSON.parse(localStorage.getItem("LaundryCart")) || initialValue;

export const LaundryReducer = (state, action) => {

    const {laundryCart, totalLaundryPrice, totalLaundryQty} = state;

    let info;
    let product;
    let index;
    let updatedPrice;
    let updatedQty;

    switch (action.type){
        case 'ADD_TO_CART':

          const check = laundryCart.find(product => product.id === action.id );

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
              updatedQty = totalLaundryQty + 1;
              updatedPrice = totalLaundryPrice + product.cost;
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
                  laundryCart: [product, ...laundryCart], totalLaundryPrice: updatedPrice, totalLaundryQty: updatedQty
              }
          }
          break;

        case 'INC':
            product = action.cart;
            ++product.qty;
            product.totalProductPrice = product.qty * product.cost;
            updatedQty = totalLaundryQty + 1;
            updatedPrice = totalLaundryPrice + product.cost;
            index = laundryCart.findIndex(cart => cart.id === action.id);
            laundryCart[index] = product;
            return {
                laundryCart: [...laundryCart], totalLaundryPrice: updatedPrice, totalLaundryQty: updatedQty
            }
            break;

            case 'DEC':
                product = action.cart;
                if (product.qty > 1) {
                    --product.qty;
                    product.totalProductPrice = product.qty * product.cost;
                    updatedPrice = totalLaundryPrice - product.cost;
                    updatedQty = totalLaundryQty - 1;
                    index = laundryCart.findIndex(cart => cart.id === action.id);
                    laundryCart[index] = product;
                    return {
                      laundryCart: [...laundryCart], totalLaundryPrice: updatedPrice, totalLaundryQty: updatedQty
                    }
                }
                else {
                    return state;
                }
                break;

            case 'DELETE':
                const filtered = laundryCart.filter(product => product.id !== action.id);
                product = action.cart;
                updatedQty = totalLaundryQty - product.qty;
                updatedPrice = totalLaundryPrice - product.qty * product.cost;
                return {
                    laundryCart: [...filtered], totalLaundryPrice: updatedPrice, totalLaundryQty: updatedQty
                }
                break;

            case 'EMPTY':
                return {
                    laundryCart: [], totalLaundryPrice: 0, totalLaundryQty: 0
                }

            default:
                return state;

    }
}
