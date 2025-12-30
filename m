Return-Path: <linux-integrity+bounces-8145-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B8BCE87FF
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Dec 2025 02:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA162300E837
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Dec 2025 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897EC2DE717;
	Tue, 30 Dec 2025 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hSANXZeU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jLos9jBF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822AF2D9EEA;
	Tue, 30 Dec 2025 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767058871; cv=none; b=SrzN/wnQigigeId1kpA3wdmO7sD6Y20SK61kft+eS6zyQ/+S2AWJjhOxTQ/Zd055b07gh6ydFf1Pog7I8eudMuQe0bT+9rbmH3FBK3IcFDAqcEhuZ7XqLaw8reEByk0Wy5avc6jdgUv3FZ5vyhX0PyfWfKi3TGGQvVg65FUL7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767058871; c=relaxed/simple;
	bh=RdKDHFKMcAP+G5WMRevLg/Sdw4l98v6tsOoHrV8GOZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxdFXL7ROH8tO3eRo+CySyM4+QtViXJxpqllQ0B5TsJEBs1tML7TyE3ALIROfOFnCwBfAOEjviSInE70jKeCO6rhWexN9VllkkaqTxwgPYvH2+oLBSl2gAe6XM2JQkFNUz0e54hBjhyGBBm+JGTwAa6IL/ysXg/70fg/tYJwSHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hSANXZeU; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jLos9jBF; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dgG5H4jLMz9tdM;
	Tue, 30 Dec 2025 02:41:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767058867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmUAEGso/e7W3anGcR8xCuSpwYv5r5Z/wzKm2j4CwGM=;
	b=hSANXZeUur6gSLo/1adoLIiGr37ZvYGRhZPY3zbgbHBL64/mEcT7ctDoTMT8dfFkRGu9Mq
	DjdJpgF5R8ddBL4WDHfbsft6m1qerlyURDBsFDSE7Vfxb9X3TB4MotoA33BO9uQ6IVu9Hh
	IP9EDxEHMlpLhTj0HHjZmWdT6bxn7V7suiwuHKiENUq0FzVQ9r1/TCePJQkutWA1+zWtCp
	UwDv3N7SPkz++MJW49Vd1WW2rlH/WbhAdmElN+/aX9TiGtuiByq6jdrQiyIrsofLxCwf/N
	K3zUmMOmaDKDyU+XcN6nQXAM73DQwt/ejIPoeERyyikFYMeT2JEk/YEnEmHCug==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767058865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmUAEGso/e7W3anGcR8xCuSpwYv5r5Z/wzKm2j4CwGM=;
	b=jLos9jBF8UsaedZpwCbBBsNZ8tmLGr7dVBT/OvrdLVzqxSbrMTr0HFW/gB9t4LxaFpUrA/
	/LaUZvmwqWBvQpsXKOnXxFPYd/0XdvTotUZWron4JITBGOMMzBC7KwC99o7vsqluH4bAIz
	O+2VqvHnYxu5hTIyP33Dtr9t9WkLp8Ve5Bt2YIpQ5wIzPaMmVxNmg62KTryJ6aB8H6flZc
	DJnz8ZhEOVrhs/y+orOwQpdbiUL2tPQtFDZGQNhGiGDp6eK8R4jzV30sGDriDQnxXuJOLh
	slVCLPT3l86GMmSaPrwHjq+d/Oly+Q8qaKtXthMJMmNZuE+8XjacPLd/BOKzkw==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: imx8mp: Update Data Modul i.MX8M Plus eDM SBC DT to rev.903
Date: Tue, 30 Dec 2025 02:40:35 +0100
Message-ID: <20251230014047.149677-2-marek.vasut@mailbox.org>
In-Reply-To: <20251230014047.149677-1-marek.vasut@mailbox.org>
References: <20251230014047.149677-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1zbogmpoi1ww8a67fj835frqd5mpwkcm
X-MBO-RS-ID: 2d9ec7033f26c04665e

Update the DT to match newest Data Modul i.MX8M Plus eDM SBC rev.903
board which implements significant changes. Keep some of the rev.900
and rev.902 nodes in the DT so that a DTO can be used to support old
rev.900 and rev.902 boards easily.

The changes from rev.900 to rev.902 are:
- Both ethernet PHYs replaced from AR8031 to BCM54213PE
- Both ethernet PHYs MDIO address changed
- PCIe WiFi now comes with dedicated regulator
- I2C TPM chip address
- Additional GPIO expander for LVDS panel control added
- Current EEPROM I2C address changed
- Another optional EEPROM added onto another I2C bus

The changes from rev.902 to rev.903 are:
- Additional GPIO expander for WiFi and LVDS panel control added
- Multiple GPIOs are reassigned

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
V2: - Rebase on current next, update email address
---
 .../freescale/imx8mp-data-modul-edm-sbc.dts   | 148 +++++++++++++++---
 1 file changed, 129 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index 16078ff60ef08..7e46537a22a01 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -93,6 +93,17 @@ reg_panel_vcc: regulator-panel-vcc {
 		status = "disabled";
 	};
 
+	reg_pcie0: regulator-pcie {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi>;
+		regulator-name = "WIFI_BT_RST#";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -190,7 +201,7 @@ &ecspi3 {	/* Display connector SPI */
 &eqos {	/* First ethernet */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
-	phy-handle = <&phy_eqos>;
+	phy-handle = <&phy_eqos_bcm>;
 	phy-mode = "rgmii-id";
 	status = "okay";
 
@@ -200,7 +211,7 @@ mdio {
 		#size-cells = <0>;
 
 		/* Atheros AR8031 PHY */
-		phy_eqos: ethernet-phy@0 {
+		phy_eqos_ath: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 			/*
@@ -213,6 +224,7 @@ phy_eqos: ethernet-phy@0 {
 			reset-deassert-us = <10000>;
 			qca,keep-pll-enabled;
 			vddio-supply = <&vddio_eqos>;
+			status = "disabled";
 
 			vddio_eqos: vddio-regulator {
 				regulator-name = "VDDIO_EQOS";
@@ -224,13 +236,27 @@ vddh_eqos: vddh-regulator {
 				regulator-name = "VDDH_EQOS";
 			};
 		};
+
+		/* Broadcom BCM54213PE PHY */
+		phy_eqos_bcm: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			/*
+			 * Dedicated ENET_INT# and ENET_WOL# signals are
+			 * unused, the PHY does not provide cable detect
+			 * interrupt.
+			 */
+			reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <10000>;
+		};
 	};
 };
 
 &fec {	/* Second ethernet */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
-	phy-handle = <&phy_fec>;
+	phy-handle = <&phy_fec_bcm>;
 	phy-mode = "rgmii-id";
 	fsl,magic-packet;
 	status = "okay";
@@ -240,7 +266,7 @@ mdio {
 		#size-cells = <0>;
 
 		/* Atheros AR8031 PHY */
-		phy_fec: ethernet-phy@0 {
+		phy_fec_ath: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 			/*
@@ -253,6 +279,7 @@ phy_fec: ethernet-phy@0 {
 			reset-deassert-us = <10000>;
 			qca,keep-pll-enabled;
 			vddio-supply = <&vddio_fec>;
+			status = "disabled";
 
 			vddio_fec: vddio-regulator {
 				regulator-name = "VDDIO_FEC";
@@ -264,6 +291,20 @@ vddh_fec: vddh-regulator {
 				regulator-name = "VDDH_FEC";
 			};
 		};
+
+		/* Broadcom BCM54213PE PHY */
+		phy_fec_bcm: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			/*
+			 * Dedicated ENET_INT# and ENET_WOL# signals are
+			 * unused, the PHY does not provide cable detect
+			 * interrupt.
+			 */
+			reset-gpios = <&gpio2 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <10000>;
+		};
 	};
 };
 
@@ -378,13 +419,26 @@ usb-hub@2c {
 		self-powered;
 	};
 
-	eeprom: eeprom@50 {
+	tpm: tpm@2e {
+		compatible = "st,st33tphf2ei2c", "tcg,tpm-tis-i2c";
+		reg = <0x2e>;
+	};
+
+	eeprom900: eeprom@50 {	/* board rev.900 */
 		compatible = "atmel,24c32";
 		reg = <0x50>;
 		pagesize = <32>;
+		status = "disabled";
+	};
+
+	eeprom902: eeprom@51 {	/* board rev.902 */
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
 	};
 
 	rtc: rtc@68 {
+		#clock-cells = <1>;
 		compatible = "st,m41t62";
 		reg = <0x68>;
 		pinctrl-names = "default";
@@ -408,6 +462,46 @@ &i2c2 {
 	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
+
+	gpiolvds: io-expander@20 {
+		compatible = "nxp,pca9554";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"BL_ENABLE_V", "SEL_BL_12V",
+			"SEL_PANEL_5V", "SEL_PANEL_12V",
+			"SEL_BL_PWM", "SEL_BL_EN",
+			"REVERSE_SCAN_PANEL", "GND_REV903";
+	};
+
+	gpiowifi: io-expander@21 {
+		compatible = "nxp,pca9554";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"BL_LVDS_ENABLE_3V3", "BL_LVDS_PWM_3V3",
+			"M2_BT_WAKE_3V3#", "M2_W_DISABLE2_3V3#",
+			"TFT_PANEL_ENABLE_3V3", "TPM_RESET_3V3#",
+			"CSI2_PD_3V3", "CSI2_RESET_3V3#";
+
+		/* BL_LVDS_PWM_3V3 is patch-wired to BL_PWM_3V3 on rev.903 */
+		pwm-input-hog {
+			gpio-hog;
+			gpios = <1 0>;
+			input;
+			line-name = "BL_LVDS_PWM_3V3_HOG";
+		};
+	};
+
+	eepromlvds: eeprom@51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
+		/* Optional EEPROM, disabled by default. */
+		status = "disabled";
+	};
 };
 
 &i2c3 {
@@ -521,6 +615,7 @@ &pcie {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	fsl,max-link-speed = <3>;
 	reset-gpio = <&gpio1 5 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
 	status = "okay";
 };
 
@@ -598,7 +693,17 @@ &uart3 {	/* A53 Debug */
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
-	status = "disabled";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "infineon,cyw55572-bt";
+		brcm,requires-autobaud-mode;
+		clocks = <&rtc 0>;
+		clock-names = "txco";
+		max-speed = <921600>;
+		shutdown-gpios = <&gpiowifi 3 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &usb3_phy0 {
@@ -686,8 +791,6 @@ MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x91
 			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x91
 			/* ENET_RST# */
 			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x6
-			/* ENET_INT# */
-			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x40000090
 		>;
 	};
 
@@ -709,8 +812,6 @@ MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
 			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f
 			/* ENET2_RST# */
 			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x6
-			/* ENET2_INT# */
-			MX8MP_IOMUXC_SD1_DATA0__GPIO2_IO02		0x40000090
 		>;
 	};
 
@@ -754,10 +855,6 @@ MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x40000090
 
 			/* PG_V_IN_VAR# */
 			MX8MP_IOMUXC_NAND_CE0_B__GPIO3_IO01		0x40000000
-			/* CSI2_PD_1V8 */
-			MX8MP_IOMUXC_NAND_DATA02__GPIO3_IO08		0x0
-			/* CSI2_RESET_1V8# */
-			MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09		0x0
 
 			/* DIS_USB_DN1 */
 			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21		0x0
@@ -771,8 +868,14 @@ MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x0
 			/* GRAPHICS_PRSNT_1V8# */
 			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18		0x40000000
 
+			/* TOUCH_RESET_3V3# */
+			MX8MP_IOMUXC_GPIO1_IO00__GPIO1_IO00		0x2
+			/* TOUCH_INT# */
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x40000140
 			/* CLK_CCM_CLKO1_3V3 */
 			MX8MP_IOMUXC_GPIO1_IO14__CCM_CLKO1		0x10
+			/* ENET_INT# (rev.900,901) or M2_WDIS_BTIRQ_3V3# (rev.903) */
+			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x40000092
 		>;
 	};
 
@@ -875,12 +978,10 @@ pinctrl_pcie0: pcie-grp {
 		fsl,pins = <
 			/* M2_PCIE_RST# */
 			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x2
-			/* M2_W_DISABLE1_1V8# */
+			/* M2_PCIE_WAKE_1V8# */
 			MX8MP_IOMUXC_SAI5_RXD2__GPIO3_IO23		0x2
-			/* M2_W_DISABLE2_1V8# */
-			MX8MP_IOMUXC_SAI5_RXD3__GPIO3_IO24		0x2
-			/* CLK_M2_32K768 */
-			MX8MP_IOMUXC_GPIO1_IO00__CCM_EXT_CLK1		0x14
+			/* M2_UART_WAKE_1V8# */
+			MX8MP_IOMUXC_SAI5_RXD3__GPIO3_IO24		0x40000002
 			/* M2_PCIE_WAKE# */
 			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x40000140
 			/* M2_PCIE_CLKREQ# */
@@ -974,6 +1075,8 @@ pinctrl_uart4: uart4-grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX		0x49
 			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX		0x49
+			MX8MP_IOMUXC_NAND_DATA02__UART4_DCE_CTS		0x149
+			MX8MP_IOMUXC_NAND_DATA03__UART4_DCE_RTS		0x149
 		>;
 	};
 
@@ -1100,4 +1203,11 @@ MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05		0x6
 			MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08		0x26
 		>;
 	};
+
+	pinctrl_wifi: wifi-grp {
+		fsl,pins = <
+			/* WIFI_BT_RST_3V3# */
+			MX8MP_IOMUXC_SD1_DATA0__GPIO2_IO02		0x40000090
+		>;
+	};
 };
-- 
2.51.0


