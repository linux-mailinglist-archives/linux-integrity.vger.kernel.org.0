Return-Path: <linux-integrity+bounces-763-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59682CAB1
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 10:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22851C20D33
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EFBA2A;
	Sat, 13 Jan 2024 09:04:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99153A38;
	Sat, 13 Jan 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2C8E5100D943C;
	Sat, 13 Jan 2024 10:03:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F15972DEC30; Sat, 13 Jan 2024 10:03:48 +0100 (CET)
Message-Id: <8b49a64d5946792f01e75fab74076557ef4f7d60.1705135956.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 13 Jan 2024 10:03:51 +0100
Subject: [PATCH] ARM: dts: Fix TPM schema violations
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: Patrick Williams <patrick@stwcx.xyz>, Tao Ren <rentao.bupt@gmail.com>, Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Bruno Thomsen <bruno.thomsen@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, Wes Huang <wes.huang@moxa.com>, Fero JD Zhou <FeroJD.Zhou@moxa.com>, SZ Lin <sz.lin@moxa.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Yannic Moog <Y.Moog@phytec.de>, Alexander Bauer <a.bauer@phytec.de>, upstream@lists.phytec.de, Teresa Remmet <T.Remmet@phytec.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
bindings"), several issues are reported by "make dtbs_check" for ARM
devicetrees:

The nodename needs to be "tpm@0" rather than "tpmdev@0" and the
compatible property needs to contain the chip's name in addition to the
generic "tcg,tpm_tis-spi" or "tcg,tpm-tis-i2c":

  tpmdev@0: $nodename:0: 'tpmdev@0' does not match '^tpm(@[0-9a-f]+)?$'
        from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#

  tpm@2e: compatible: 'oneOf' conditional failed, one must be fixed:
        ['tcg,tpm-tis-i2c'] is too short
        from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#

Fix these schema violations.

Aspeed Facebook BMCs use an Infineon SLB9670:
https://lore.kernel.org/all/ZZSmMJ%2F%2Fl972Qbxu@fedora/
https://lore.kernel.org/all/ZZT4%2Fw2eVzMhtsPx@fedora/
https://lore.kernel.org/all/ZZTS0p1hdAchIbKp@heinlein.vulture-banana.ts.net/

Aspeed Tacoma uses a Nuvoton NPCT75X per commit 39d8a73c53a2 ("ARM: dts:
aspeed: tacoma: Add TPM").

phyGATE-Tauri uses an Infineon SLB9670:
https://lore.kernel.org/all/ab45c82485fa272f74adf560cbb58ee60cc42689.camel@phytec.de/

A single schema violation remains in am335x-moxa-uc-2100-common.dtsi
because it is unknown which chip is used on the board.  The devicetree's
author has been asked for clarification but has not responded so far:
https://lore.kernel.org/all/20231220090910.GA32182@wunner.de/

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
---
The commit mentioned above, 26c9d152ebf3 ("dt-bindings: tpm: Consolidate
TCG TIS bindings") landed in Linus' tree 8 hours ago.

Because this consists only of fixes, I think it could be picked up and
forwarded to Linus at any time, even outside the merge window.

The Reviewed-by tags from Patrick and Tao were offered here:
https://lore.kernel.org/all/ZZWB4wRiAyDtlLJM@heinlein.vulture-banana.ts.net/
https://lore.kernel.org/all/ZZWkhaiDFOGvcPQy@fedora/

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts   | 4 ++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts    | 4 ++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts           | 2 +-
 arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi          | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts        | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi    | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index e899de6..5be0e8f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -45,8 +45,8 @@
 		num-chipselects = <1>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 
-		tpmdev@0 {
-			compatible = "tcg,tpm_tis-spi";
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 			spi-max-frequency = <33000000>;
 			reg = <0>;
 		};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index a677c82..5a8169b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -80,8 +80,8 @@
 		gpio-miso = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 
-		tpmdev@0 {
-			compatible = "tcg,tpm_tis-spi";
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 			spi-max-frequency = <33000000>;
 			reg = <0>;
 		};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index 3f6010e..213023b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -456,7 +456,7 @@
 	status = "okay";
 
 	tpm: tpm@2e {
-		compatible = "tcg,tpm-tis-i2c";
+		compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
 		reg = <0x2e>;
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 31590d3..00e5887 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -35,8 +35,8 @@
 		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
 		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
 
-		tpmdev@0 {
-			compatible = "tcg,tpm_tis-spi";
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 			spi-max-frequency = <33000000>;
 			reg = <0>;
 		};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
index 44cc4ff..d12fb44 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
@@ -116,7 +116,7 @@
 	tpm_tis: tpm@1 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_tpm>;
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 		reg = <1>;
 		spi-max-frequency = <20000000>;
 		interrupt-parent = <&gpio5>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts b/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
index 3a72384..9984b34 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
@@ -130,7 +130,7 @@
 	 * TCG specification - Section 6.4.1 Clocking:
 	 * TPM shall support a SPI clock frequency range of 10-24 MHz.
 	 */
-	st33htph: tpm-tis@0 {
+	st33htph: tpm@0 {
 		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";
 		reg = <0>;
 		spi-max-frequency = <24000000>;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi
index b8730aa..a59331a 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi
@@ -217,7 +217,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins>;
 
-	tpm_spi_tis@0 {
+	tpm@0 {
 		compatible = "tcg,tpm_tis-spi";
 		reg = <0>;
 		spi-max-frequency = <500000>;
-- 
2.40.1


