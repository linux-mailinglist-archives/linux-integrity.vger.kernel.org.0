Return-Path: <linux-integrity+bounces-766-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018DA82CDE3
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 18:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2540F1C21169
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E281E4C9D;
	Sat, 13 Jan 2024 17:19:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB54C92;
	Sat, 13 Jan 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7343D300002A1;
	Sat, 13 Jan 2024 18:19:15 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6488B2BC2F7; Sat, 13 Jan 2024 18:19:15 +0100 (CET)
Message-Id: <ecf963e0bc7cd2d2e930eca59068d1a6f236e80e.1705140898.git.lukas@wunner.de>
In-Reply-To: <cover.1705140898.git.lukas@wunner.de>
References: <cover.1705140898.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 13 Jan 2024 18:10:52 +0100
Subject: [PATCH v2 2/4] tpm_tis_spi: Add compatible string atmel,attpm20p
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM device")
added a devicetree node for the Trusted Platform Module on certain
Gateworks boards.

The commit only used the generic "tcg,tpm_tis-spi" compatible string,
but public documentation shows that the chip is an ATTPM20P from Atmel
(nowadays Microchip):
https://trac.gateworks.com/wiki/tpm

Add the chip to the supported compatible strings of the TPM TIS SPI
driver.

For reference, a datasheet is available at:
https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index c5c3197..7d376a6 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -327,6 +327,7 @@ static void tpm_tis_spi_remove(struct spi_device *dev)
 MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
 
 static const struct of_device_id of_tis_spi_match[] __maybe_unused = {
+	{ .compatible = "atmel,attpm20p", .data = tpm_tis_spi_probe },
 	{ .compatible = "st,st33htpm-spi", .data = tpm_tis_spi_probe },
 	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
 	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
-- 
2.40.1


