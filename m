Return-Path: <linux-integrity+bounces-524-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69F815EA7
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 12:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FCC282E9C
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC814265;
	Sun, 17 Dec 2023 11:10:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F74134C5
	for <linux-integrity@vger.kernel.org>; Sun, 17 Dec 2023 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 1381F101E6A8D;
	Sun, 17 Dec 2023 12:10:31 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id B40446073EFF;
	Sun, 17 Dec 2023 12:10:30 +0100 (CET)
X-Mailbox-Line: From 5c92620082189dc4e6be277952d0b46df26a6478 Mon Sep 17 00:00:00 2001
Message-Id: <5c92620082189dc4e6be277952d0b46df26a6478.1702811113.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 17 Dec 2023 12:10:11 +0100
Subject: [PATCH v2] tpm: tis_i2c: Add compatible string nuvoton,npct75x
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Oshri Alkoby <oshri.alkoby@nuvoton.com>, Dan Morav <dan.morav@nuvoton.com>, Dana Cohen <dana.cohen@nuvoton.com>, Alexander Steffen <alexander.steffen@infineon.com>, Peter Delevoryas <peter@pjd.dev>

Add "nuvoton,npct75x" as well as the fallback compatible string
"tcg,tpm-tis-i2c" to the TPM TIS I²C driver.  They're used by:

  arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
  arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts

And by all accounts, NPCT75x is supported by the driver:

  https://lore.kernel.org/all/60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com/
  https://lore.kernel.org/all/20220808220839.1006341-8-peter@pjd.dev/

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:
 * s/TPM TIS driver/TPM TIS I²C driver/ in commit message (Stefan).

 drivers/char/tpm/tpm_tis_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index a897402cc36a..9511c0d50185 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 #ifdef CONFIG_OF
 static const struct of_device_id of_tis_i2c_match[] = {
 	{ .compatible = "infineon,slb9673", },
+	{ .compatible = "nuvoton,npct75x", },
+	{ .compatible = "tcg,tpm-tis-i2c", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
-- 
2.40.1


