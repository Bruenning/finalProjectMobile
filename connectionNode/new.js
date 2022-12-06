const axios = require("axios");
const http = require("http");
const url = require("url");

const options = {
	method: "POST",
	url: "https://translate-plus.p.rapidapi.com/translate",
	headers: {
		"content-type": "application/json",
		"X-RapidAPI-Key": "f4a282167bmshbe46af26508ccd1p168f03jsnd32ad05c4f58",
		"X-RapidAPI-Host": "translate-plus.p.rapidapi.com",
	},
};

const getText = async (req, res) => {
	try {
		res.writeHead(200, {
			"Content-Type": "application/json; charset=utf-8",
		});

		let q = url.parse(req.url, true).query;

		options.data = JSON.stringify({
			text: q.input,
			target: q.target,
			source: q.source,
		});

		const response = await axios.request(options);
		return response.data;
	} catch (error) {
		console.log(error);
	}
};

const server = http
	.createServer(async (req, res) => {
		const data = await getText(req, res);
		res.write(JSON.stringify(data.translations.translation));
		res.end();
	})
	.listen(8080);
