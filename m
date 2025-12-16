Return-Path: <linux-integrity+bounces-8052-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C5CC161E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 08:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7003A303BEB5
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950FF34405D;
	Tue, 16 Dec 2025 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ0VQ0fc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B21344059;
	Tue, 16 Dec 2025 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871133; cv=none; b=gOui5gqYdXEe0qtvJ6INj1UAyEeVEZ/WcxCSwqPU+mWBRPI+Sh1w8pKw++cwuusm06MakZlDCpthIN5Lax82tG9IE26tVWa9KgJRJDAExxI80IUxa3QpEDOWIJNbF+XtUtMAIwdCuw5Ej7B0oXu/7lTh6Et+ScDJFBLfWjvN6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871133; c=relaxed/simple;
	bh=syj0MAULIysE2DgFxh7p8MUgTG4fCnV6ZnXbKSMGMYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SeMwvIwv4pn40JOmzutaoH5cXXgDIQFFJZd2mmedIfrogOWAZl+y6qLjjxwpWGRwTdtoCy32Ua/beBFmOcIQ6j0odf+qonr4JqUczdlmDgaXPAPORuqH9zKUzB0SMZtWqdaC+v1fJDur8kSlBz2bnfyGFI/90gwsSH0iphLVO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ0VQ0fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9494CC4CEF1;
	Tue, 16 Dec 2025 07:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765871133;
	bh=syj0MAULIysE2DgFxh7p8MUgTG4fCnV6ZnXbKSMGMYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZ0VQ0fcRcf+bCTKyxfU414adqAZw5T15ceG0W5uSzswNODg/U0zBmsoBC0kNMPBf
	 9ZRaYwh1M/vfh2mzd2jXQz0JM9Jx49xoE6uQWxPdzY+48MRROuusYLEyiytezKRu2r
	 iwA/+ovZEh31LN0f4OeVLBuvAJpYbTGTFJtz/ao1PCTJj1mpGdR3075Nf48njd3Er8
	 gREJ3/EBcW1O1Fo+/4uzgoyE22SC9/SNbsMJsl+BULvEhSQ6b/RhimxN5qcIi3em5G
	 Tzlk3Gba6MpWSk2CxE/z/N4HCmnE/iRdaATaY6kddVdZ9zF2InX1NGMKTv63z4kJmm
	 +RgtxFRWSeP5A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v7 07/12] tpm2-sessions: Remove AUTH_MAX_NAMES
Date: Tue, 16 Dec 2025 09:44:48 +0200
Message-Id: <20251216074454.2192499-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216074454.2192499-1-jarkko@kernel.org>
References: <20251216074454.2192499-1-jarkko@kernel.org>
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
 drivers/char/tpm/tpm2-sessions.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3bc3c31cf512..37570dc088cf 100644
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
@@ -261,11 +258,14 @@ EXPORT_SYMBOL_GPL(tpm2_read_public);
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
 		tpm_buf_append_handle(chip, buf, handle);
@@ -273,12 +273,6 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
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
@@ -287,16 +281,14 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
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
 
@@ -665,8 +657,7 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
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


