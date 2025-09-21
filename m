Return-Path: <linux-integrity+bounces-7211-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36669B8D379
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 04:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 299744E066E
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 02:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08B1D88D0;
	Sun, 21 Sep 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxNr7LHd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CC19F12D;
	Sun, 21 Sep 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758420510; cv=none; b=a9+ZE70U3LOYBNpzBvTa/qLq6RDNDL1t9cLemVjM+CnM9fAd2LHQFe8qEpVPavBPSHA9qiLq3CvNuCAPYHeXhMhJUuj4lwPIu2kBaVcs4gMVX6AL1tGJ7RUlbjYfNyrKtU8siHRUzi8cv7btVTPyqYjAP7wDpj2OrrJqDVZSO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758420510; c=relaxed/simple;
	bh=4M8/GFhV3sFOzAP8bNuOQU4N9+FY30m8pjHxRtU9C9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fyRJdbp2mK/Ly+513MMksFiIeK0fo+t2u2Ebri5CdUDhcJ4mQixGqiPso9snbQlQ4qXGsnXVRFliSYHvnEccKV9fUJ+p9DfSo93X/vgKb565L2S5dDsUXK2H6pd6nMQgZG/CLHdZ0IGmt4l4tJ6aH19y4vi9qg3is7rgj+b7Nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxNr7LHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71A1C4CEF1;
	Sun, 21 Sep 2025 02:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758420510;
	bh=4M8/GFhV3sFOzAP8bNuOQU4N9+FY30m8pjHxRtU9C9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxNr7LHdeOwqPfE4X36y8+4ACSu05p095WDmar8fCw1Wh66SbZ9RGEaddfQJqw3+t
	 Q6FCFpLf2gK+416Ym3njaz0gZAp2TQ+OBkGcix4tgaOUaTBDj+QXTYmc81//3e85p/
	 g4ICJdVdUXSsTs2orMu6VS1QfukHjr55O7pasCjF18Zng6VwAA7G+t06EIviLAaBSP
	 9NM6GsVHfR8tLGNk8ySaG1DDwZUGiczfUNbWRrcvW55iRmNEU8f1COttdkuDRwPlxX
	 ZuZh77JJ4zpRVTO0A7axKVvX+jB4UTgqT2D7Yo5GXQ7sM1Y1Q+44k9LVGQrsb/5du2
	 0RXFGKLCL8QKQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v10 4/4] tpm_vpm_proxy: Use stack for TPM_CC_SET_LOCALITY
Date: Sun, 21 Sep 2025 05:08:04 +0300
Message-Id: <20250921020804.1088824-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250921020804.1088824-1-jarkko@kernel.org>
References: <20250921020804.1088824-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Use stack allocation for TPM_CC_SET_LOCALITY, as it has known fixed size.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 drivers/char/tpm/tpm1-cmd.c       |  2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 11c16ad9b2a7..433908cfb4a9 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -328,7 +328,7 @@ static int tpm1_startup(struct tpm_chip *chip)
 	int rc;
 
 	dev_info(&chip->dev, "TPM_Startup\n");
-	tpm_buf_init(buf, TPM_BUF_INT_SIZE);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
 	tpm_buf_append_u16(buf, TPM_ST_CLEAR);
 	rc = tpm_transmit_cmd(chip, buf, 0, "TPM_Startup");
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index e5de14379eb2..0f1b1b67ed4e 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -395,15 +395,13 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
 
 static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 {
-	int rc;
-	const struct tpm_header *header;
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
+	const struct tpm_header *header;
+	int rc;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_SET_LOCALITY);
 	else
-- 
2.39.5


