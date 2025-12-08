Return-Path: <linux-integrity+bounces-7850-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D79CAC0D8
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 06:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4DA304A285
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 05:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1039E26C3AE;
	Mon,  8 Dec 2025 05:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/ybw1KR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19432690D5;
	Mon,  8 Dec 2025 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765170400; cv=none; b=r+cuNCSpVgg/lwReKK+bpJvw9Z7p9C6dsPwOg5jiVYDOkfZaIXqM7ugEvopIyvPrfSnat16CBQSKHKOUvtTErQ3AgiI2dKBOSxEdnw1y0h+/6GL/ghgiXKDgzDh9kp28QIvrqP3EZMqBNYzgrlWhIITmI+QbsZMxqV6u44Olui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765170400; c=relaxed/simple;
	bh=U1w7L8RYrnNkAyV5f23ZnG5MeTrBA7KGouwsk+rMv/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUDRpAeojVATG2fbEaUHB7OzEm5T13zr7T3y5SHb9JyWlAhctGwgkJy2V/Nc9sZxDYFTnSsi/9KfKK6wHbGfaI+UPXVhkrozld9zRq6/tyMf0NOHngcfxXQs5MuXPh5p14DcPrye/Q1c+F6Z6hcU3o1zhNB1bScQrzWdoUNxKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/ybw1KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44734C116B1;
	Mon,  8 Dec 2025 05:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765170399;
	bh=U1w7L8RYrnNkAyV5f23ZnG5MeTrBA7KGouwsk+rMv/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/ybw1KRnbdueGWDNLjqkLFDDfdM4z8GvJwpnmEpuFSIXfhzyz6MLvqGcxTtFf5cv
	 bo+d9TAS1OT7s3P+a19s4WTCPCSJQapT3Wa5G0s0RJ0RAQ/DMMWKyINxX67PIVnv6L
	 AVP+wskurIv7SNcGFDfKV/Bex+ko/TDOn9OUX6LYjKICCe9ygG4PyVvKgMDkijY9DU
	 c5vFvNr/gyKZVsid+KPagiotW8AIfmCQNMr15BGja1d5PSFQ2uO0D2DXlfgVSkA0fz
	 2nz6+lq2zsl0TLKV9kn0Ga6CjmXP7QQ/LhkMk06K299gUyrWO2Jf52n9bod4kPwOi+
	 oJTS198SqdKWg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: tpm2@lists.linux.dev,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v7 3/3] tpm2-sessions: Remove AUTH_MAX_NAMES
Date: Mon,  8 Dec 2025 07:06:19 +0200
Message-Id: <20251208050620.339408-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251208050620.339408-1-jarkko@kernel.org>
References: <20251208050620.339408-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In all of the call sites only one session is ever append. Thus, reduce
AUTH_MAX_NAMES, which leads into removing constant completely.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v7:
- A new patch.
---
 drivers/char/tpm/tpm2-sessions.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 0816a91134fc..62a200ae72d7 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -72,9 +72,6 @@
 #include <crypto/sha2.h>
 #include <crypto/utils.h>
 
-/* maximum number of names the TPM must remember for authorization */
-#define AUTH_MAX_NAMES	3
-
 #define AES_KEY_BYTES	AES_KEYSIZE_128
 #define AES_KEY_BITS	(AES_KEY_BYTES*8)
 
@@ -136,8 +133,8 @@ struct tpm2_auth {
 	 * handle, but they are part of the session by name, which
 	 * we must compute and remember
 	 */
-	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
-	u16 name_size_tbl[AUTH_MAX_NAMES];
+	u8 name[TPM2_MAX_NAME_SIZE];
+	u16 name_size;
 };
 
 #ifdef CONFIG_TCG_TPM2_HMAC
@@ -254,11 +251,14 @@ EXPORT_SYMBOL_GPL(tpm2_read_public);
 int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			u32 handle, u8 *name, u16 name_size)
 {
-#ifdef CONFIG_TCG_TPM2_HMAC
 	struct tpm2_auth *auth;
-	int slot;
 	int ret;
-#endif
+
+	if (tpm_buf_length(buf) != TPM_HEADER_SIZE) {
+		dev_err(&chip->dev, "too many handles\n");
+		ret = -EIO;
+		goto err;
+	}
 
 	if (!tpm2_chip_auth(chip)) {
 		tpm_buf_append_handle(buf, handle);
@@ -266,12 +266,6 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 
 #ifdef CONFIG_TCG_TPM2_HMAC
-	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE) / 4;
-	if (slot >= AUTH_MAX_NAMES) {
-		dev_err(&chip->dev, "too many handles\n");
-		ret = -EIO;
-		goto err;
-	}
 	auth = chip->auth;
 	if (auth->session != tpm_buf_length(buf)) {
 		dev_err(&chip->dev, "session state malformed");
@@ -280,16 +274,14 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 	tpm_buf_append_u32(buf, handle);
 	auth->session += 4;
-	memcpy(auth->name[slot], name, name_size);
-	auth->name_size_tbl[slot] = name_size;
+	memcpy(auth->name, name, name_size);
+	auth->name_size = name_size;
 #endif
 	return 0;
 
-#ifdef CONFIG_TCG_TPM2_HMAC
 err:
 	tpm2_end_auth_session(chip);
 	return ret;
-#endif
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
@@ -658,8 +650,7 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	/* ordinal is already BE */
 	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
 	/* add the handle names */
-	for (i = 0; i < handles; i++)
-		sha256_update(&sctx, auth->name[i], auth->name_size_tbl[i]);
+	sha256_update(&sctx, auth->name, auth->name_size);
 	if (offset_s != tpm_buf_length(buf))
 		sha256_update(&sctx, &buf->data[offset_s],
 			      tpm_buf_length(buf) - offset_s);
-- 
2.39.5


