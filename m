Return-Path: <linux-integrity+bounces-563-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DFC81D356
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Dec 2023 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1211C20B11
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Dec 2023 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3E68F56;
	Sat, 23 Dec 2023 09:34:51 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5038F62
	for <linux-integrity@vger.kernel.org>; Sat, 23 Dec 2023 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 7FCCE101E6AA0;
	Sat, 23 Dec 2023 10:34:39 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 3CA6F600E54F;
	Sat, 23 Dec 2023 10:34:39 +0100 (CET)
X-Mailbox-Line: From 188b88ffeeae958847370dcd1fb28fe708a2aeb7 Mon Sep 17 00:00:00 2001
Message-Id: <188b88ffeeae958847370dcd1fb28fe708a2aeb7.1703323863.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 23 Dec 2023 10:34:39 +0100
Subject: [PATCH] tpm_tis_spi: Add compatible string atmel,attpm20p
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Tim Harvey <tharvey@gateworks.com>
Cc: linux-integrity@vger.kernel.org
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
Cc: Tim Harvey <tharvey@gateworks.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index c5c3197ee29f..7d376a642807 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -327,6 +327,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
 
 static const struct of_device_id of_tis_spi_match[] __maybe_unused = {
+	{ .compatible = "atmel,attpm20p", .data = tpm_tis_spi_probe },
 	{ .compatible = "st,st33htpm-spi", .data = tpm_tis_spi_probe },
 	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
 	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
-- 
2.40.1


