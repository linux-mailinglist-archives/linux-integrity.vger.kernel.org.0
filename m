Return-Path: <linux-integrity+bounces-7825-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3DDCA83B4
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 16:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4DD533F0C4B
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86C135A95F;
	Fri,  5 Dec 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUwXPJVc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0A32827F;
	Fri,  5 Dec 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948024; cv=none; b=XbVPm4Ke01cNL5dJa1JsD1JQ/ITCyFnhGCXWPX7+vj19GkV82azs9xWqxbcpzLN+lQIUC6gIjSORw7A0j4I1fCmpm7wmFC9d8z/Fx9X0hgM671ikN+Wb7Kglfr1OlOPO9PPfPBJxwMKi+k43a9FOSPUnm6VKkGnyryKHhcgB4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948024; c=relaxed/simple;
	bh=3sMilHnTa3OfMr6J4hL8Qm9CoLASXmf5Ou9zS3NXsBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLMaZO/DBk39ZKgyoxr9969MQkpUPNE1B2R6vv/eWGq8++MaI7tsZK4KTMSjKXKlJ6aQ5vVvOfTMG/bae42B4NbRWbE/Djs4SlsLpTAGhBTBOKrwsAwVJmD8efQcODh5wOSjkCGptO4OB4iOH9iMCkHgdcRNqaLmYQ33zrP8H2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUwXPJVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DAEC4CEF1;
	Fri,  5 Dec 2025 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764948023;
	bh=3sMilHnTa3OfMr6J4hL8Qm9CoLASXmf5Ou9zS3NXsBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUwXPJVcLpyvbJXARGbCnFecz+XjahfeTUH1Ei91utgKtY/ggovcRmjvoDC7EW5uI
	 CV7o0IFX5m/qGLrp/4BwNx0zq/4pHbg7ZZBmb3ws0s32AagKTC9Y76eS47V/r+FPxa
	 Jnrv8vw5Hqb2cDsYH4xn9kXnPKrTUsbTxa5P0txNU49jOwoe0GrME5BS9Yc6Mlj5AZ
	 q41Hjtjdi8NQakK1UGyAYcHswqvZrNJ6LzQR41h+RIpQvhzpr/nzdTNGIExRrh6BzW
	 ybVo9L6R6+Ec54p3PPSx9HQBYWwqdYZXcKvOEsQ6aOHi3GsuCth7rvoxfqbve6T5FP
	 JSQ/PgtwlBtyA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/4] tpm2-sessions: Enforce single authorized handle
Date: Fri,  5 Dec 2025 17:19:53 +0200
Message-ID: <20251205151955.298182-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251205151955.298182-1-jarkko@kernel.org>
References: <20251205151955.298182-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate AUTH_MAX_NAMES and replace array of names with a buffer for
single TPM name, as this what call sites expect at worst.

Benefits are obvious i.e., removing dead code is usually a good idea
:-)

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index c8b44b1a6cb6..8bfe2875faf2 100644
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
-	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
-	u16 name_size_tbl[AUTH_MAX_NAMES];
+	u8 name[2 + SHA512_DIGEST_SIZE];
+	u16 name_size;
 };
 
 /**
@@ -182,7 +179,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE) / 4;
-	if (slot >= AUTH_MAX_NAMES) {
+	if (slot > 0) {
 		dev_err(&chip->dev, "too many handles\n");
 		ret = -EIO;
 		goto err;
@@ -195,8 +192,8 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 	tpm_buf_append_u32(buf, handle);
 	auth->session += 4;
-	memcpy(auth->name[slot], name, name_size);
-	auth->name_size_tbl[slot] = name_size;
+	memcpy(auth->name, name, name_size);
+	auth->name_size = name_size;
 #endif
 	return 0;
 
@@ -573,8 +570,7 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
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
2.52.0


