React = require("react")
ReactDOM = require("react-dom")

// class HomePage extends React.Component {
//   render () {
//     return (
//       <nav>
//         <div className="nav-wrapper cyan">
//           <a href="" className="brand-logo">Linkstates for </a>
//           <ul id="nav-mobile" className="right hide-on-med-and-down">
//             <LoginHeader />
//           </ul>
//         </div>
//       </nav>
//     );
//   }
// }

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
};

class HomePage extends React.Component {
  constructor(props){
    super(props);
    const self = this;

    this.onState = this.onState.bind(this);
    this.onLogout = this.onLogout.bind(this);
    this.onLogin = this.onLogin.bind(this);
    this.loginComponent = this.loginComponent.bind(this);
    this.menu = this.menu.bind(this);

    this.state = this.onState();

  }
  componentDidMount() {
    this._ismounted = true;
    const self = this;
    Tracker.autorun(function(){
      if(self._ismounted){
        self.setState(self.onState());
      }
    });
  }

  componentWillUnmount() {
     this._ismounted = false;
  }
  onState(){
    return {
      user : Meteor.user() || {profile: {name: ''}},
      userId : Meteor.userId()
    };
  }
  onLogout(){
    const self = this;
    Meteor.logout(function(){
      self.setState(self.onState());
    });
  };

  onLogin(){
    const self = this;
    Meteor.loginWithFacebook(function(){
      self.setState(self.onState());
      FlowRouter.go('/about?from=https%253A%252F%252Flinkstate.youiest.com%252F&lastTitle=Linkstates')
    });
  };

  loginComponent(){
    if(this.state.userId){
      return(<li><a href="#">{this.state.user.profile.name}</a></li>);
    }else{
      return(<li onClick={this.onLogin}><a href="#">Login with Facebook</a></li>);
    }
  }

  menu(){
    if($('.side-nav').css('left') === '0px'){
      $(".side-nav").css({'left': '-105%', 'transform': 'translateX(-105%)'});
    }else{
      $(".side-nav").css({'left': '0px', 'transform': 'translateX(0px)'});
    }
  }

  // https://drive.google.com/open?id=0BxESHlfBQRFGazlwYzVYaThRczA
  render() {
    const loginComponent = this.loginComponent();
    return (
      <div>
        {/*Navigation*/}
        <div className="navbar-fixed">
          <nav id="nav_f" className="default_color" role="navigation">
            <div className="container">
              <div className="nav-wrapper">
                <a href="#" id="logo-container" className="brand-logo">Linkstate for </a>
                <ul className="right hide-on-med-and-down">
                  {loginComponent}
                  <li><a target="_blank" href="https://drive.google.com/open?id=0BxESHlfBQRFGazlwYzVYaThRczA">Download</a></li>
                </ul>
                <ul id="nav-mobile" className="side-nav">
                  {loginComponent}
                  <li><a target="_blank" href="https://drive.google.com/open?id=0BxESHlfBQRFGazlwYzVYaThRczA">Download</a></li>
                  <li onClick={this.menu} ><a href="#">Close</a></li>
                </ul>
                <a onClick={this.menu} href="#" data-activates="nav-mobile" className="button-collapse"><i className="mdi-navigation-menu" /></a>
              </div>
            </div>
          </nav>
        </div>
        {/*Work*/}
        <div className="section scrollspy" id="work">
          <div className="container">
            <h2 className="header text_b">What you've been missing</h2>
            <div className="row">
              <div className="col s12 m4 l4">
                <div className="card">
                  <div className="card-image waves-effect waves-block waves-light">
                    <img className="activator" src="/carousel/s1whysense.gif" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">Meaningful <i className="mdi-navigation-more-vert right" /></span>
                    <p><a href="#">Contributions</a></p>
                  </div>
                  <div className="card-reveal">
                    <span className="card-title grey-text text-darken-4">Meaningful <i className="mdi-navigation-close right" /></span>
                    <br></br>
                    <p>What would it take to make your clicks add up to something greater? Linkstate adds all those moments together so they count.</p>
                  </div>
                </div>
              </div>
              <div className="col s12 m4 l4">
                <div className="card">
                  <div className="card-image waves-effect waves-block waves-light">
                    <img className="activator" src="/carousel/s2duo.gif" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">Collaboration <i className="mdi-navigation-more-vert right" /></span>
                    <p><a href="#">See their voices</a></p>
                  </div>
                  <div className="card-reveal">
                    <span className="card-title grey-text text-darken-4">Collaboration <i className="mdi-navigation-close right" /></span>
                    <br></br>
                    <p>Rally your team and watch the a quantum leap. See them connect in real-time. Decide what this is about as together - or - stash it in the right place yourself.</p>
                  </div>
                </div>
              </div>
              <div className="col s12 m4 l4">
                <div className="card">
                  <div className="card-image waves-effect waves-block waves-light">
                    <img className="activator" src="/carousel/slide3c.gif" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">Context <i className="mdi-navigation-more-vert right" /></span>
                    <p><a href="#">Cogntitive Ease</a></p>
                  </div>
                  <div className="card-reveal">
                    <span className="card-title grey-text text-darken-4">Context <i className="mdi-navigation-close right" /></span>
                    <br></br>
                    <p>It's easy to keep your attention yours with context.</p>
                    <br></br>
                    <p>Linkstate creates context to supercharge your senses. Think of it as your superpower!</p>
                  </div>
                </div>
              </div>
              <div className="col s12 m4 l4">
                <div className="card">
                  <div className="card-image waves-effect waves-block waves-light">
                    <img className="activator" src="img/project4.jpg" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">Research<i className="mdi-navigation-more-vert right" /></span>
                    <p><a href="#">Externalise</a></p>
                  </div>
                  <div className="card-reveal">
                    <span className="card-title grey-text text-darken-4">Project Title <i className="mdi-navigation-close right" /></span>
                    <br></br>
                    <p>Born out of the desire for a simple way to rally around a subject. This tool - or visual language - is many things to many. Try using it as a way to send links, comments and clips to a google doc. </p>
                  </div>
                </div>
              </div>
              <div className="col s12 m4 l4">
                <div className="card">
                  <div className="card-image waves-effect waves-block waves-light">
                    <img className="activator" src="img/project5.png" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">Feedback<i className="mdi-navigation-more-vert right" /></span>
                    <p><a href="#">Voice made visible</a></p>
                  </div>
                  <div className="card-reveal">
                    <span className="card-title grey-text text-darken-4">Visualise qualitative and quantitative feedback together. <i className="mdi-navigation-close right" /></span>
                    <br></br>
                    <p>Overcome information overload like you organize the physical world.</p>
                  </div>
                </div>
              </div>
              <div className="col s12 m4 l4">
                <div className="card">
                  <div className="card-image waves-effect waves-block waves-light">
                    <img className="activator" src="img/project6.jpeg" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">Organize<i className="mdi-navigation-more-vert right" /></span>
                    <p><a href="#">Relevant here</a></p>
                  </div>
                  <div className="card-reveal">
                    <span className="card-title grey-text text-darken-4">Stick it to a page<i className="mdi-navigation-close right" /></span>
                    <br></br>
                    <p>Keep your bookmarks sorted and ranked by page not subject. Everyone sees the links about the webpage or google doc when they leave that page.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        {/*Team*/}
        <div className="section scrollspy" id="team">
          <div className="container">
            <h2 className="header text_b"> Our Team </h2>
            <div className="row">
              <div className="col s12 m3">
                <div className="card card-avatar">
                  <div className="waves-effect waves-block waves-light">
                    <img className="activator" src="/img/elias.jpeg" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">Elias <br />
                      <small><em><a className="red-text text-darken-1" href="#">Founder</a></em></small>
                    </span>
                  </div>
                </div>
              </div>
              <div className="col s12 m3">
                <div className="card card-avatar">
                  <div className="waves-effect waves-block waves-light">
                    <img className="activator" src="/img/nicolson.jpeg" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">Nicolson<br />
                      <small><em><a className="red-text text-darken-1" href="#">Designer</a></em></small>
                    </span>
                  </div>
                </div>
              </div>
              <div className="col s12 m3">
                <div className="card card-avatar">
                  <div className="waves-effect waves-block waves-light">
                    <img className="activator" src="img/avatar3.png" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">
                      Capt. America <br />
                      <small><em><a className="red-text text-darken-1" href="#">CMO</a></em></small>
                    </span>
                  </div>
                </div>
              </div>
              <div className="col s12 m3">
                <div className="card card-avatar">
                  <div className="waves-effect waves-block waves-light">
                    <img className="activator" src="img/avatar4.png" />
                  </div>
                  <div className="card-content">
                    <span className="card-title activator grey-text text-darken-4">Robin<br />
                      <small><em><a className="red-text text-darken-1" href="#">Developer</a></em></small>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    )};
};

module.exports = { HomePage }
