import React, {useRef, useState} from 'react';
import {Form, Button, Card, Container, Alert, Modal} from 'react-bootstrap'
import {Link, useHistory} from 'react-router-dom';
import {useAuth} from "../../contexts/AuthContext";


function Login(){

  const emailRef = useRef()
  const passwordRef = useRef()
  const resetEmailRef = useRef()
  const {login, resetPassword} = useAuth()
  const [error, setError] = useState('')
  const [error1, setError1] = useState('')
  const [message, setMessage] = useState('')
  const [loading, setLoading] = useState(false)
  const history = useHistory()
  const [show, setShow] = useState(false)
  const handleShow = () => setShow(true)
  const handleClose = () => setShow(false)

  async function handleSubmit(event){
    event.preventDefault()
      setError("")
      setLoading(true)
      await login(emailRef.current.value, passwordRef.current.value)
      .then(() => {
          history.push("/")
        })
    .catch( error => {
      setError(error.message);
    })
    setLoading(false)
  }

  async function handleResetSubmit(event){
    event.preventDefault()

    try{
      setMessage("")
      setError1("")
      setLoading(true)
      await resetPassword(resetEmailRef.current.value)
      setMessage('Further Instruction to reset your account has been sent to inbox.')
    }
   catch{
      setError1('Failed to reset password!')
   }
    setLoading(false)
  }


    return (
    <Container className="d -flex align-items-center justify-our-content mt-5">
    <div className="w-responsive mx-auto p-3 mt-2">
    <Card>
      <Card.Body>
          <h2 className="text-center wb-4">Log In</h2>
          {error && <Alert variant="danger">{error}</Alert>}
        <Form onSubmit={handleSubmit}>
            <Form.Group controlId="formBasicEmail">
              <Form.Label>Email address</Form.Label>
              <Form.Control type="email" required placeholder="Enter your email" ref={emailRef} />
              <Form.Text className="text-muted">
                We'll never share your email with anyone.
                </Form.Text>
            </Form.Group>

            <Form.Group controlId="formBasicPassword">
              <Form.Label>Password</Form.Label>
              <Form.Control type="password" required placeholder="Password" ref={passwordRef} />
            </Form.Group>

            <Button disabled={loading} className="w-100" variant="primary" type="submit">
              Log In
            </Button>
          </Form>

          <Card.Text className="text-center mt-2"><Link onClick={handleShow}>Forgot your password?</Link></Card.Text>
        </Card.Body>
      </Card>
      </div>
      <div className="w-100 text-center mt-2">
      <h3>Don't Have an Account?</h3>
      <Link to='/signup'>Register Now</Link>
      </div>
      <Modal aria-labelledby="contained-modal-title-vcenter" show={show} onHide={handleClose} centered>
        <Modal.Header closeButton>
          <Modal.Title>Reset Your Password</Modal.Title>
        </Modal.Header>
        <Modal.Body>
        {error1 && <Alert variant="danger">{error1}</Alert>}
        {message && <Alert variant="success">{message}</Alert>}
        <Form onSubmit={handleResetSubmit}>
            <Form.Group controlId="formBasicEmail">
              <Form.Label>Email address</Form.Label>
              <Form.Control type="email" required placeholder="Enter your email" ref={resetEmailRef} />
            </Form.Group>
            <Button disabled={loading} className="w-100 mt-3" variant="primary" type="submit">
              Submit
            </Button>
          </Form>
        </Modal.Body>
        </Modal>
    </Container>

   );
}
export default Login;
