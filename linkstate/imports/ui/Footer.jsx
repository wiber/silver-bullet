React = require("react")
ReactDOM = require("react-dom")

class Footer extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      user: Meteor.user() || {profile: {name: ""}}
    };
    this.onLogout = this.onLogout.bind(this);
  }

  componentDidMount() {
    const self = this;
    setTimeout(function(){
      self.setState({user: Meteor.user()});
    },5000);
  }
  onLogout(){
    Meteor.logout(function(){
      location.reload();
    });
  };

  render () {
    return (
      <footer className="page-footer default_color">
        <div className="container">
          <div className="row">
            <div className="col l6 s12">
              <h5 className="white-text">Instruction</h5>
              <p className="grey-text text-lighten-4">To use this app properly, you will need the chrome extension.</p>
              <br/>
              <p className="grey-text text-lighten-4">{this.state.user.profile.name}</p>
              <br/>
              <p className="grey-text text-lighten-4"><a className="waves-effect waves-light btn blue darken-4" onClick={this.onLogout}>Logout</a></p>
          </div>
            <div className="col l4 offset-l2 s12">
              <h5 className="white-text">Links</h5>
              <ul>
                <a className="grey-text text-lighten-4 right" href="https://drive.google.com/open?id=0BxESHlfBQRFGazlwYzVYaThRczA">Download</a>
              </ul>
            </div>
          </div>
        </div>
        <div className="footer-copyright">
          <div className="container">
            © 2019 Copyright Youiest LLC
          </div>
        </div>
      </footer>
      );
  }
}

module.exports = { Footer }
