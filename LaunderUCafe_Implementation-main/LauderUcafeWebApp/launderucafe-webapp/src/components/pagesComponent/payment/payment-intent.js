import Stripe from "stripe";

// real secret API key.
const stripe = new Stripe (process.env.REACT_APP_STRIPE_PRIVATE_KEY);

const calculateOrderAmount = items => {
  // Replace this constant with a calculation of the order's amount
  // Calculate the order total on the server to prevent
  // people from directly manipulating the amount on the client
  return 1400;
};

export default async (req, res) => {
    if (req.method === "POST") {
      try{
        const { items } = req.body;
        // Create a PaymentIntent with the order amount and currency
        const paymentIntent = await stripe.paymentIntents.create({
          amount: calculateOrderAmount(items),
          currency: "usd"
        });

        res.status(200).send({
          clientSecret: paymentIntent.client_secret
        });
      } catch (err) {
          res.status(500).json({ statusCode: 500, message: err.message });
        }
      } else {
        res.setHeader("Allow", "POST");
        res.status(405).end("Method Not Allowed");
      }
    };
