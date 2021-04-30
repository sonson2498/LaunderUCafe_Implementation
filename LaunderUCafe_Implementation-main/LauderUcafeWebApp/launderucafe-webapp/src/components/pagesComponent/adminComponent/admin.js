import React, {useContext, useState, useEffect} from 'react';
import {Form, Card, Button, ListGroup, Container, Modal, Alert,Row, Col, InputGroup} from "react-bootstrap";
import {firestore, functions} from "../../../firebase";

export default function Admin() {
  const [adminEmail, setAdminEmail] = useState("")
  const [employeeEmail, setEmployeeEmail] = useState("")
  const [message, setMessage] = useState("")

  const handleAdminSubmit = e => {
    e.preventDefault();
    const addAdminRole = functions.httpsCallable('addAdminRole');
    addAdminRole({'email' : adminEmail}).then(result => {
        setMessage(result);
    });
  }

  const handleEmployeeSubmit = e => {
    e.preventDefault();
    const addEmployeeRole = functions.httpsCallable('addEmployeeRole');
    addEmployeeRole({'email' : employeeEmail}).then(result => {
        setMessage(result);
    });
  }

  return (
  <Container className="d -flex align-items-center justify-our-content mt-3">
  {message && <Alert variant="success">{message}</Alert>}
  <Form className="w-50" onSubmit={handleAdminSubmit}>
  <Form.Group controlId="AdminEmail">
    <Form.Label>Email</Form.Label>
    <Form.Control name="email"
    onChange = {e => setAdminEmail(e.currentTarget.value)}
    required
    />
    </Form.Group>
    <div><Button variant="primary mb-3" type="submit">Make User an Admin</Button></div>
  </Form>

  <Form className="w-50 mt-5" onSubmit={handleEmployeeSubmit}>
  <Form.Group controlId="EmployeeEmail">
    <Form.Label>Email</Form.Label>
    <Form.Control name="email"
    onChange = {e => setEmployeeEmail(e.currentTarget.value)}
    required
    />
    </Form.Group>
    <div><Button variant="primary mb-3" type="submit">Make User an Employee</Button></div>
  </Form>

  <div><Button variant="secondary mb-3">Manage User Account</Button></div>
  <div><Button variant="secondary mb-3">Manage Laundry Products</Button></div>
  <div><Button variant="secondary mb-3">Manage Cafe Product</Button></div>
  <div><Button variant="secondary mb-3">Manage Orders</Button></div>




  </Container>
  )
}
