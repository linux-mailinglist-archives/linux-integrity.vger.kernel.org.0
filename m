Return-Path: <linux-integrity+bounces-223-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEB7FA2E1
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 15:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01FB2B21067
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF5131752;
	Mon, 27 Nov 2023 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B9469B
	for <linux-integrity@vger.kernel.org>; Mon, 27 Nov 2023 06:33:08 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 311CF10189CF9;
	Mon, 27 Nov 2023 15:33:07 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 0E1F260E6433;
	Mon, 27 Nov 2023 15:33:07 +0100 (CET)
X-Mailbox-Line: From 096e5d9d22eaed0a256d2d9b315a77245bd423c6 Mon Sep 17 00:00:00 2001
Message-Id: <096e5d9d22eaed0a256d2d9b315a77245bd423c6.1701095446.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 27 Nov 2023 15:32:04 +0100
Subject: [PATCH] tpm_tis: Add compatible string atmel,at97sc3204
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Commit 420d439849ca ("tpm_tis: Allow tpm_tis to be bound using DT")
added the fallback compatible "tcg,tpm-tis-mmio" to the TPM TIS driver,
but not the chip-specific "atmel,at97sc3204".  However it did document
it as a valid compatible string.

Add it to tis_of_platform_match[] for consistency.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
---
 drivers/char/tpm/tpm_tis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 2c52b7905b07..14652aaf8254 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -347,6 +347,7 @@ static void tpm_tis_plat_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id tis_of_platform_match[] = {
+	{.compatible = "atmel,at97sc3204"},
 	{.compatible = "tcg,tpm-tis-mmio"},
 	{},
 };
-- 
2.40.1


