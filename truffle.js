module.exports = {
  build: {
    "index.html": "index.html",
    "app.js": [
      "javascripts/app.js"
    ],
    "app.css": [
      "stylesheets/app.css"
    ],
    "images/": "images/"
  },
  deploy: [
    "Campaign"
  ],
  rpc: {
    host: "crowdfunding-NAME_HERE.c9users.io",
    port: 8081
  }
};
