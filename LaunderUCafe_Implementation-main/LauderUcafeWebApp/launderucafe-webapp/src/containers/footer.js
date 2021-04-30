import React from 'react'
import Footer from '../components/footerComponent'

export function FooterContainer() {
    return (
        <Footer>
            <Footer.Wrapper>
            <Footer.Row>
                <Footer.Column>
                <Footer.Title>About Us</Footer.Title>
                    <Footer.Link href="#">Story</Footer.Link>
                    <Footer.Link href="#">Clients</Footer.Link>
                    <Footer.Link href="#">Testimonials</Footer.Link>
                </Footer.Column>
                <Footer.Column>
                <Footer.Title>Services</Footer.Title>
                    <Footer.Link href="#">Cafe</Footer.Link>
                    <Footer.Link href="#">Schedule Laundry Delivery</Footer.Link>
                    <Footer.Link href="#">Schedule Laundry Pick Up</Footer.Link>
                </Footer.Column>
                <Footer.Column>
                <Footer.Title>Contact Us</Footer.Title>
                    <Footer.Link href="#">Contact Page</Footer.Link>
                    <Footer.Link href="#">Support</Footer.Link>
                </Footer.Column>
                <Footer.Column>
                <Footer.Title>Social</Footer.Title>
                    <Footer.Link href="#"><span className="fab fa-facebook-f"> Facebook</span></Footer.Link>
                    <Footer.Link href="#"><span className="fab fa-instagram"> Instagram</span></Footer.Link>
                    <Footer.Link href="#"><span className="fab fa-youtube"> Youtube</span></Footer.Link>
                    <Footer.Link href="#"><span className="fab fa-twitter"> Twitter</span></Footer.Link>
                </Footer.Column>
            </Footer.Row>
            </Footer.Wrapper>
        </Footer>
    )
}
