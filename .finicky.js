
module.exports = {
  defaultBrowser: "Firefox",
  rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === "http",
      url: { protocol: "https" }
    }
  ],
  handlers: [
    {
      // Open apple.com and example.org urls in Safari
      match: /tgaau/,
      browser: "Safari"
    },
    {
      // Open apple.com and example.org urls in Safari
      match: /healthgov/,
      browser: "Safari"
    },
  ]
};
