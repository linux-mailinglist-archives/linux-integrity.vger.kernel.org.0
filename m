Return-Path: <linux-integrity+bounces-769-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 563EF82CE02
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A661EB21D5E
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1B53A7;
	Sat, 13 Jan 2024 17:41:17 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA4566B;
	Sat, 13 Jan 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id AA9622800B4BB;
	Sat, 13 Jan 2024 18:32:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8F3FF54AE4; Sat, 13 Jan 2024 18:32:30 +0100 (CET)
Message-Id: <6ec711056f5d87d8504f033a404ed14a2e449331.1705140898.git.lukas@wunner.de>
In-Reply-To: <cover.1705140898.git.lukas@wunner.de>
References: <cover.1705140898.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 13 Jan 2024 18:10:54 +0100
Subject: [PATCH v2 4/4] tpm: tis_i2c: Add compatible string nuvoton,npct75x
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>

Add "nuvoton,npct75x" as well as the fallback compatible string
"tcg,tpm-tis-i2c" to the TPM TIS I²C driver.  They're used by:

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
index a897402..9511c0d 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -383,6 +383,8 @@ static void tpm_tis_i2c_remove(struct i2c_client *client)
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


