window.addEventListener("DOMContentLoaded", function() {
	const captor = this.document.getElementById("captor");
	const image = this.document.querySelector("#main_image img");
	const textParent = this.document.getElementById("text_parent");
	const text = this.document.getElementById("text_content");

	captor.addEventListener("mouseenter", () => {
		image.style.filter = "invert(0) blur(0vw)";
		text.style.textShadow = "-1px -1px 0 white, 1px -1px 0 white, -1px 1px 0 white, 1px 1px 0 white"
		textParent.style.fill = "black";
	})

	captor.addEventListener("mouseleave", () => {
		image.style.filter = "invert(1) blur(0.2vw)";
		text.style.textShadow = "-1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px 1px 0 black"
		textParent.style.fill = "white";
	})

	const images = [
		"images/calm_desert.png",
		"images/calm_forest.png",
		"images/calm_movement.png",
		"images/calm_farm.png",
		"images/calm_human_paint.png",
		"images/calm_lake.png",
		"images/calm_moon.png",
		"images/calm_paint.png",
		"images/calm_subway.png"
	];

	const randomImg = images[Math.floor(Math.random() * images.length)];
	const imgBG = this.document.querySelector("#main_image img");
	if (imgBG) {
		imgBG.src = randomImg;
	}
	const imgCenter = this.document.querySelector("#child_image img");
	if (imgCenter) {
		imgCenter.src = randomImg;
	}

	const textes = [
		"She vanished between the waves, where silence remembers what the sky forgot.",
		"Not all ghosts haunt — some simply wait to be remembered in a stranger's dream.",
		"She whispered to the moon, hoping the tides would carry her secrets to forgotten shores.",
		"She spoke in colors the sky hadn't yet learned, but the wind listened quietly.",
		"She walked unseen, yet the earth knew her steps and blessed the path behind her",
		"he walked alone and could hear the whisper that only the soul can hear.",
	]
	const randomTxt = textes[Math.floor(Math.random() * textes.length)];
	const textPath = this.document.getElementById("text_content");
	if (textPath) {
		textPath.textContent = randomTxt;
	}
});
