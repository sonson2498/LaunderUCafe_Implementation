import React from 'react';
import {Link} from 'react-router-dom';
import {useAuth} from "../../contexts/AuthContext";

export default function Toolbar() {

  const {currentUser, admin, employee} = useAuth();


  return (
    <div>
    {currentUser &&

    <div className="tool_bar">
    {admin &&
      <ul>
        <li>
            <Link to="/admin">Admin Panel</Link>
        </li>
      </ul>
    }

      {employee &&
        <ul>
          <li>
            <Link to="/employee">Employee Panel</Link>
          </li>
        </ul>}
      </div>}
    </div>
  )
}
