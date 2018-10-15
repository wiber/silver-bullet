import React from 'react'
import ReactDOM from 'react-dom'

class HomePage extends React.Component {
  render () {
    return (
      <nav>
        <div className="nav-wrapper cyan">
          <a href="" className="brand-logo">Linkstates for </a>
          <ul id="nav-mobile" className="right hide-on-med-and-down">
            <LoginHeader />
          </ul>
        </div>
      </nav>
    );
  }
}

class LoginHeader extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      user : Meteor.user(),
      userId : Meteor.userId()
    }
    this.onLogout = this.onLogout.bind(this);
    this.onLogin = this.onLogin.bind(this);

  }
  onLogout(){
    const self = this;
    Meteor.logout(function(){
      self.setState({
        user : null,
        userId : null
      });
    });
  };

  onLogin(){
    const self = this;
    Meteor.loginWithFacebook(function(){
      self.setState({
        user : Meteor.user(),
        userId : Meteor.userId()
      });
    });
  };

  render() {
      if(this.state.user){
        return (
          <li onClick={this.onLogout}><a href="">{this.state.user.profile.name} Logout</a></li>
        );
      }else{
        return (<li onClick={this.onLogin}><a href="">Login with Facebook</a></li>)
      }
  }
}
module.exports = { HomePage }