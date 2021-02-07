require("dotenv").config();
const express = require("express");
const Mux = require("@mux/mux-node");
const { Video } = new Mux(
  process.env.MUX_TOKEN_ID,
  process.env.MUX_TOKEN_SECRET
);
const app = express();
const port = 3000;

app.post("/assets", async (req, res) => {
  const asset = await Video.Assets.create({
    input: req.body.videoUrl,
    playback_policy: "public",
  });

  res.json({
    id: asset.id,
    status: asset.status,
    playback_ids: asset.playback_ids,
    created_at: asset.created_at,
  });
});

app.get("/assets", async (req, res) => {
  const assets = await Video.Assets.list();

  res.json(
    assets.map((asset) => ({
      id: asset.id,
      status: asset.status,
      playback_ids: asset.playback_ids,
      created_at: asset.created_at,
      duration: asset.duration,
    }))
  );
});

app.get("/asset", async (req, res) => {
  const asset = await Video.Assets.get(updatedUpload[req.body.id]);

  res.json({
    id: asset.id,
    status: asset.status,
    playback_ids: asset.playback_ids,
    created_at: asset.created_at,
    duration: asset.duration,
    max_resolution: asset.max_stored_resolution,
    max_frame_rate: asset.max_stored_frame_rate,
    aspect_ratio: asset.aspect_ratio,
  });
});

app.listen(port, () => {
  console.log(`Mux API listening on port ${port}`);
});
