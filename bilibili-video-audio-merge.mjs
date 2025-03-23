import fs from "node:fs/promises";
import pathLib from "node:path";
import childProcess from "node:child_process";

fs.mkdir("mergedVideos", { recursive: true });

for (const item of await fs.readdir("680890718", { withFileTypes: true })) {
    const itemBaseDir = pathLib.join(item.parentPath, item.name);
    const entryFile = pathLib.join(itemBaseDir, "entry.json");
    const entryData = JSON.parse(await fs.readFile(entryFile, "utf-8"));
    const { title: mainTitle, type_tag: typeTag, page_data: { part: pageName } } = entryData;
    const videoName = mainTitle + " " + pageName;
    const outFile = pathLib.join("mergedVideos", videoName + ".mp4");
    const outDanmakuFile = pathLib.join("mergedVideos", videoName + ".danmaku.xml");

    const inputAudioFile = pathLib.join(itemBaseDir, typeTag, "audio.m4s");
    const inputVideoFile = pathLib.join(itemBaseDir, typeTag, "video.m4s");
    const ffmpegArgs = ['-i', inputVideoFile, '-i', inputAudioFile, '-c', 'copy', outFile];
    const danmakuFile = pathLib.join(itemBaseDir, "danmaku.xml");
    childProcess.execFileSync("ffmpeg", ffmpegArgs, {stdio: "inherit"});
    fs.copyFile(danmakuFile, outDanmakuFile);
}
