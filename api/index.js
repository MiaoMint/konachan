const { createProxyMiddleware } = require("http-proxy-middleware");

const proxy = createProxyMiddleware({
  target: "https://konachan.net",
  changeOrigin: true,
  pathRewrite: {
    "^/api": "",
  },
});

// Expose the proxy on the "/api/*" endpoint.
export default function (req, res) {
  return proxy(req, res);
}
