// Generated by Finicky Kickstart 
// Save as ~/.finicky.js

module.exports = {
  defaultBrowser: "Brave Browser",      

  handlers: [
    {
      match: ({ opener }) =>
        ["Slack"].includes(opener.name),
      browser: {
        name: "Google Chrome",
      },
    },
    {
      match: ({ url }) => url.protocol === "slack",
      browser: "/Applications/Slack.app",
    },
    {
      match: ["https://accounts.google.com/o/oauth2/auth*"],
      browser: {
        name: "Google Chrome",
      },
    },
  ],
};
