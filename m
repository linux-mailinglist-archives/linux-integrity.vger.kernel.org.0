Return-Path: <linux-integrity+bounces-225-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333017FA32E
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 15:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4DDB20FCB
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4111031752;
	Mon, 27 Nov 2023 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
X-Greylist: delayed 1017 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 06:42:18 PST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F1FC2
	for <linux-integrity@vger.kernel.org>; Mon, 27 Nov 2023 06:42:17 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 06518101E6996;
	Mon, 27 Nov 2023 15:42:16 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id B6DE660E6433;
	Mon, 27 Nov 2023 15:42:15 +0100 (CET)
X-Mailbox-Line: From be92814061f20ed7ae6db4c0fab833cf4b7404b4 Mon Sep 17 00:00:00 2001
Message-Id: <be92814061f20ed7ae6db4c0fab833cf4b7404b4.1701095990.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 27 Nov 2023 15:42:11 +0100
Subject: [PATCH] tpm: tis_i2c: Add compatible string nuvoton,npct75x
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, Oshri Alkoby <oshri.alkoby@nuvoton.com>, Dan Morav <dan.morav@nuvoton.com>, Dana Cohen <dana.cohen@nuvoton.com>, Alexander Steffen <alexander.steffen@infineon.com>, Peter Delevoryas <peter@pjd.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Add "nuvoton,npct75x" as well as the fallback compatible string
"tcg,tpm-tis-i2c" to the TPM TIS driver.  They're used by:

  arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
  arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts

And by all accounts, NPCT75x is supported by the driver:

  https://lore.kernel.org/all/60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com/
  https://lore.kernel.org/all/20220808220839.1006341-8-peter@pjd.dev/

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
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


