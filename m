Return-Path: <linux-integrity+bounces-7804-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06175CA52A3
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Dec 2025 20:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7575F3025D6E
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Dec 2025 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10AC2DCC1B;
	Thu,  4 Dec 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbAgugGC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992511FBC92;
	Thu,  4 Dec 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764877699; cv=none; b=s1Rxst4YDZXk8Fp3ojp02imSXF11kr4ro9gQo9Zy63z/Zn5dYCT4S1tilx/YXYkP0zb4/tQ5HvQR6e4yVOwGRDJ8H5IlwQGP6dKdbiXIqUiTnHrn1PuQ6JZSSsXIgOetESSDMkeIxDmVeoGguPdUJEEoYKDh/qQUysU1jO+9jF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764877699; c=relaxed/simple;
	bh=I7K7oNFesRUylWKwKSiaCCet48T41jCpBDnCvmzkDHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuOSPVxAA/7C76dKmy+aF3sMlaOnMwXUMxzte+xYqQ0Rn9gPtNdK2gz95yoE//vOSD/uMFV1hqNVMGp3gz+e7iL2CBoecwACD8Cl83jD7KNR7d0cdcXhAwZHNl/J9vUnBiFhQ5/XBv/mI4Mx4ygIWldNQ/G9HKPRfIoVEgKMl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbAgugGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C191C4CEFB;
	Thu,  4 Dec 2025 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764877699;
	bh=I7K7oNFesRUylWKwKSiaCCet48T41jCpBDnCvmzkDHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbAgugGC4xGPRYTqVAqKhcGthL5mp0D8RRfT2/y8JPg1mBrp0UGpTYrsUahVJI+wd
	 alshmXzKlnH3LBn7j50WoyD0C7z/NvqjO+20iGDhEwPD1amixyLWTodVU+3vtUKXmq
	 ohy4Dc9enS5+vR7qnUJWdj/Q4Mu2UvdKnpMeKUQidSevkysr3xld9+StX3XhYv/SxU
	 9LN2YmmsvunG6AB//7aC4cjhQC6T8wKrs1AzWaHTffe3Z0wP7DazCOLTHTtlHb++9P
	 jz/x+ezXyb2FhxMIaTu0XErXaxbo2OZ4w439PY73F/eJCA5a6l8B8aJjEknh9KGoe9
	 jGeKJFh5HclaA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list),
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 3/4] tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
Date: Thu,  4 Dec 2025 21:47:41 +0200
Message-ID: <20251204194743.69035-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204194743.69035-1-jarkko@kernel.org>
References: <20251204194743.69035-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Remove 'attributes' parameter from 'tpm_buf_append_auth', as it is not used
by the function.

Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 5 ++---
 include/linux/tpm.h              | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 34e3599f094f..ce0a1c6b0596 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -210,7 +210,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
 		tpm_buf_append_handle(chip, &buf, pcr_idx);
-		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
+		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3f389e2f6f58..4149379665c4 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -311,7 +311,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u8 attributes, u8 *passphrase, int passphrase_len)
+			 u8 *passphrase, int passphrase_len)
 {
 	/* offset tells us where the sessions area begins */
 	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
@@ -372,8 +372,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_auth(chip, buf, attributes, passphrase,
-				    passphrase_len);
+		tpm_buf_append_auth(chip, buf, passphrase, passphrase_len);
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index aa816b144ab3..afa51723296a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -535,7 +535,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u8 attributes, u8 *passphrase, int passphraselen);
+			 u8 *passphrase, int passphraselen);
 static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 						   struct tpm_buf *buf,
 						   u8 attributes,
-- 
2.52.0


