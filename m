Return-Path: <linux-integrity+bounces-770-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA082CE12
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 19:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15C21C20F5E
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB05672;
	Sat, 13 Jan 2024 18:07:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C05257;
	Sat, 13 Jan 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D8D51100F00CE;
	Sat, 13 Jan 2024 19:06:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AAC5E1314C; Sat, 13 Jan 2024 19:06:57 +0100 (CET)
Message-Id: <e6d7768e2a257e0bd5948bcf168909b6c670851b.1705168605.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 13 Jan 2024 19:06:56 +0100
Subject: [PATCH] arm64: dts: Fix TPM schema violations
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: Yannic Moog <Y.Moog@phytec.de>, Alexander Bauer <a.bauer@phytec.de>, upstream@lists.phytec.de, Teresa Remmet <T.Remmet@phytec.de>, Tim Harvey <tharvey@gateworks.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, Adam Ford <aford173@gmail.com>, Heiko Thiery <heiko.thiery@gmail.com>, "Enric Balletbo i Serra" <eballetbo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, Nicolas Prado <nfraprado@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
bindings"), several issues are reported by "make dtbs_check" for arm64
devicetrees:

The compatible property needs to contain the chip's name in addition to
the generic "tcg,tpm_tis-spi" and the nodename needs to be "tpm@0"
rather than "cr50@0":

  tpm@1: compatible: ['tcg,tpm_tis-spi'] is too short
        from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#

  cr50@0: $nodename:0: 'cr50@0' does not match '^tpm(@[0-9a-f]+)?$'
        from schema $id: http://devicetree.org/schemas/tpm/google,cr50.yaml#

Fix these schema violations.

phyGATE-Tauri uses an Infineon SLB9670:
https://lore.kernel.org/all/ab45c82485fa272f74adf560cbb58ee60cc42689.camel@phytec.de/

Gateworks Venice uses an Atmel ATTPM20P:
https://trac.gateworks.com/wiki/tpm

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
The commit mentioned above, 26c9d152ebf3 ("dt-bindings: tpm: Consolidate
TCG TIS bindings") landed in Linus' tree yesterday.

Because this consists only of fixes, I think it could be picked up and
forwarded to Linus at any time, even outside the merge window.

The issues reported for imx8m*-venice-gw7*xx.dts* devicetrees will not
go away until Jarrko picks up this amendment patch for the dt-bindings:
https://lore.kernel.org/all/8886271d52025065eddf5915bb7778ab14362255.1705140898.git.lukas@wunner.de/

 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts    | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi     | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi     | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts         | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi     | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi     | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts      | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi              | 2 +-
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts             | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi        | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
index 968f475..27a9025 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
@@ -120,7 +120,7 @@
 	};
 
 	tpm: tpm@1 {
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-parent = <&gpio2>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
index 3f3f2a2..752caa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
@@ -89,7 +89,7 @@
 	status = "okay";
 
 	tpm@1 {
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
 		spi-max-frequency = <36000000>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
index 06fed93..2aa6c10 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
@@ -109,7 +109,7 @@
 	status = "okay";
 
 	tpm@1 {
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
 		spi-max-frequency = <36000000>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index feae77e..a080574 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -234,7 +234,7 @@
 	status = "okay";
 
 	tpm: tpm@0 {
-		compatible = "infineon,slb9670";
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 		reg = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_tpm>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
index c24587c..41c79d2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
@@ -103,7 +103,7 @@
 	status = "okay";
 
 	tpm@1 {
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
 		spi-max-frequency = <36000000>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
index 628ffba6..d5c400b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
@@ -115,7 +115,7 @@
 	status = "okay";
 
 	tpm@1 {
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
 		spi-max-frequency = <36000000>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 9caf7ca..cae586c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -196,7 +196,7 @@
 	status = "okay";
 
 	tpm@0 {
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x0>;
 		spi-max-frequency = <36000000>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
index 6376417..d8cf1f2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
@@ -65,7 +65,7 @@
 	status = "okay";
 
 	tpm@0 {
-		compatible = "infineon,slb9670";
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 		reg = <0>;
 		spi-max-frequency = <43000000>;
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 5506de8..1b3396b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -888,7 +888,7 @@
 	status = "okay";
 	cs-gpios = <&pio 86 GPIO_ACTIVE_LOW>;
 
-	cr50@0 {
+	tpm@0 {
 		compatible = "google,cr50";
 		reg = <0>;
 		spi-max-frequency = <1000000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index f228125..d87aab8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1402,7 +1402,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi5_pins>;
 
-	cr50@0 {
+	tpm@0 {
 		compatible = "google,cr50";
 		reg = <0>;
 		interrupts-extended = <&pio 171 IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
index 0f9cc04..1cba1d8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
@@ -70,7 +70,7 @@
 &spi0 {
 	status = "okay";
 
-	cr50@0 {
+	tpm@0 {
 		compatible = "google,cr50";
 		reg = <0>;
 		interrupt-parent = <&gpio0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index c5e7de6..5846a11 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -706,7 +706,7 @@ camera: &i2c7 {
 &spi2 {
 	status = "okay";
 
-	cr50@0 {
+	tpm@0 {
 		compatible = "google,cr50";
 		reg = <0>;
 		interrupt-parent = <&gpio1>;
-- 
2.40.1


