```JavaScript
var edgeSchema = mongoose.Schema({
  from: {
    type: String,
    required: true,
    title: 'From',
    description: 'URL of the bookmark taken from.'
  },
  to: {
    type: String,
    required: true,
    title: 'To',
    description: 'URL of the bookmark.'
  },
  meta: {
    weight: {
      type: String,
      default: null,
      title: 'Weight',
      description: 'The score on the bookmark.'
    },
    title: {
      type: String,
      default: null,
      title: 'Title',
      description: 'The title of the bookmark from the bookmark.'
    },
    face: {
      type: String,
      default: null,
      title: 'Logo',
      description: 'The position of the users logo.'
    },
    FromLink: {
      type: String,
      default: null,
      title: 'From Link',
      description: ''
    },
    ToLink: {
      type: String,
      default: null,
      title: 'To Link',
      description: ''
    },
    ScreenshotUrl: {
      type: String,
      default: null,
      title: 'Screenshot',
      description: 'The url of the screenshot.'
    }
  }
  author: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
    default: null
  },
  createdAt: {
    type: Date,
    required: true,
    title: 'createdAt',
    description: 'post created date and time'
  },
  title: {
    type: String,
    required: true,
    title: 'title',
    description: 'web app name'
  },
}, {
  collection: 'edges',
  timestamps: {
    createdAt: 'dateCreated',
    updatedAt: 'lastUpdated'
  }
});
```