export default async function handler(req, res) {
	res.setHeader("Access-Control-Allow-Origin", "*");
	res.setHeader("Access-Control-Allow-Methods", "GET,OPTIONS");
	res.setHeader("Access-Control-Allow-Headers", "Content-Type");
	if (req.method === "OPTIONS") return res.status(204).end();

	const { url, lang = "vi" } = req.query;
	if (!url) return res.status(400).json({ error: "missing url" });

	const upstream = `https://api.phimtat.vn/snapvideo/json.php?url=${encodeURIComponent(
		url
	)}&lang=${encodeURIComponent(lang)}`;

	try {
		const r = await fetch(upstream, {
			headers: { Accept: "application/json" },
		});
		const text = await r.text();
		res.setHeader(
			"Content-Type",
			r.headers.get("content-type") || "application/json; charset=utf-8"
		);
		res.status(r.status).send(text);
	} catch (e) {
		res.status(500).json({ error: e.message });
	}
}
