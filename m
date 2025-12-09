Return-Path: <linux-integrity+bounces-7863-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53FCAF2B6
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 08:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32474300A54A
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA55A27280C;
	Tue,  9 Dec 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwM0ss64"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33C25A645;
	Tue,  9 Dec 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265966; cv=none; b=haFamzz7XeJqAZdwEVpa2qc8EGgq03PEr3eq/I4fZNN4cZI2D0LAZIg3IwiYTVNFQMpqzgLBaZFVg0ieJ4FplNt9M9S8ywT5g8Sa7ml/egEXdTpB76YwBilqpWGBSaRNOexQV39UVR61Xm0GQO38c0s08xdir8E7J1Y/qAcl50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265966; c=relaxed/simple;
	bh=j3sRY/5DqDHwhme3v+bOihyZBmakSNazCo3LEzMzmDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgUs2hVprVn9CAFgAIACvPJPvFrMq7BSCE4o6lxtpCxkFyeCmPzxdP4vozy9ocEmbM4BBmzk22TgJncP8m5s69rgaPX4mHahEDmVTQ7yRBJXH3RtO6wbqhxyYvt9s6PtwHR9/Qg2k9zpIou23Tr6B3LGnNmvms8ooXhqAVFnxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwM0ss64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824EDC4CEF5;
	Tue,  9 Dec 2025 07:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765265966;
	bh=j3sRY/5DqDHwhme3v+bOihyZBmakSNazCo3LEzMzmDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwM0ss64wf2/mscrqUG1jMWGbwSQnca8DRmBJVCP/b9T4t2tFK1tminLcaK/72HE8
	 G0pGItrTX82UspBgykef10TZnYMMsJZr8Y/unzTb3Km8FCa4k2AoEyGmMuVgyJoZMJ
	 emG13OQErikFUV0Kmigi3UMxxT558ApmtzAztBwwNfrMy/UbvjwFXAMX7aRO4MlrS0
	 3lkZoYhPPJLbNyUxTI7/NAJd8pFtERwjULOkd9KLSgzfGTRRYCDNPpK+c81sWjcUmR
	 BzZnUfbptIl2zt9as1qAgok65lsV4LW898U/iXro4OP4C/PeKWwkXp2/MBj3fz2Ys6
	 cR/c8gaIIxl/Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] tpm2-sessions: Remove AUTH_MAX_NAMES
Date: Tue,  9 Dec 2025 09:39:01 +0200
Message-ID: <20251209073903.767518-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209073903.767518-1-jarkko@kernel.org>
References: <20251209073903.767518-1-jarkko@kernel.org>
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
2.52.0


