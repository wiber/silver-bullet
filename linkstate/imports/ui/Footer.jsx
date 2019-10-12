React = require("react")
ReactDOM = require("react-dom")

class Footer extends React.Component {
  constructor(props){
    super(props);
    this.onLogout = this.onLogout.bind(this);
  }

  onLogout(){
    Meteor.logout(function(){
      window.reload();
    });
  };

  render () {
    return (
      <footer className="page-footer default_color">
        <div className="container">
          <div className="row">
            <div className="col l6 s12">
              <h5 className="white-text">Instruction</h5>
              <p className="grey-text text-lighten-4">To use this app properly you need the chrome extension.</p>
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
            <a className="grey-text text-lighten-4 right" href="#!" onClick={this.onLogout}>Logout</a>
          </div>
        </div>
      </footer>
      );
  }
}

module.exports = { Footer }