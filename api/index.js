const { createProxyMiddleware } = require("http-proxy-middleware");

const proxy = createProxyMiddleware({
  target: "https://konachan.net",
  changeOrigin: true,
  pathRewrite: {
    "^/api": "",
  },
  headers: {
    "user-agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36 Edg/115.0.1901.183",
    referer: "https://konachan.net",
  },
});

// Expose the proxy on the "/api/*" endpoint.
export default function (req, res) {
  return proxy(req, res);
}
