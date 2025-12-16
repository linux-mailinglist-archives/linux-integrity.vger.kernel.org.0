Return-Path: <linux-integrity+bounces-8068-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13FCC1D19
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 10:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 074F6304639A
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A50342148;
	Tue, 16 Dec 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPgwwXYG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C5341AC5;
	Tue, 16 Dec 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876954; cv=none; b=U6KtixEXPH68hNkaAsf8rVF/BiQhVropN6YzRrBFIn68JxZjvIO2ScUbmRXkIEvFLjpW8/TVuCWWUhz/vQCqjV24FVjLna5s9Vyrw1NcRHCVOHl5157NtAEB9GAfqHaFWZwkKvFl4LQtmvQjB6fHAzcNT8Fg4jWMIfFW7vnPorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876954; c=relaxed/simple;
	bh=hyBomRnmC81D9m1aMMljcC0yEMlcBNCAQ1OU6gFR4v4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FoXcMH8QZTCrzOSEtBJEnnvZrS3VRwVQFIW/JhJ5HhINIs1lV/xn18gpZcoTdSy479Z28W1uBX7T0wKmmyVsG2pfzUA+16ZJr3ICJBrWW+ZFHDNrRsaFeo5dTqWp8jmnL07qBSlG7e2f2A/cNWg6gi/PcwYoyFrqghK5zgjOwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPgwwXYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95486C4CEF1;
	Tue, 16 Dec 2025 09:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765876954;
	bh=hyBomRnmC81D9m1aMMljcC0yEMlcBNCAQ1OU6gFR4v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPgwwXYG9Jqn5J07ghhgvtVGEp5Ux+AL/tJY1zLpxAthXV1kUGhEENaKzW5mRmqUx
	 okEIgbEXET51lfgJfIR37m1sbtPGBCo17L/x/wSH0KKKGc/eX0G+ABm6QWx1jX8vNT
	 sX3zTzpHg/DerxL55NPiSFW+3JL/y05dfnKwnrjd6C5yL9m3zTMJLr950NrRUYSYX5
	 TZgoqjo/Z/Wz4C7N2jJspnSYXTy5h7wxz7NO+s4F5OKSoG6qdYWlBtTLGChQDky9L4
	 T1LJ+0VOX6ws9gpJlLTw7gp51pwB+2WiSDiByIGn7rM7SADYVNLIvUfBPBU4dYLYfR
	 WdnjDFWm504fQ==
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
Subject: [PATCH v8 09/12] tpm2-sessions: Remove the support for more than one authorization
Date: Tue, 16 Dec 2025 11:21:43 +0200
Message-Id: <20251216092147.2326606-10-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216092147.2326606-1-jarkko@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel uses at most a single HMAC authorization at a time.

From that basis, remove the unused machinery for managing multiple
authorizations.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v8:
- Rewrote the commit message.
- Added an inline comment explaining why unconditional sha256_update() call
  for the name is safe.
---
 drivers/char/tpm/tpm2-sessions.c | 40 ++++++++++++++------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3bc3c31cf512..98cea20040cf 100644
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
 
@@ -662,14 +654,18 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	}
 
 	sha256_init(&sctx);
-	/* ordinal is already BE */
 	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
-	/* add the handle names */
-	for (i = 0; i < handles; i++)
-		sha256_update(&sctx, auth->name[i], auth->name_size_tbl[i]);
+
+	/*
+	 * If tpm2_buf_append_name() has not been called, this is a no-op, as
+	 * auth->name_size is zero.
+	 */
+	sha256_update(&sctx, auth->name, auth->name_size);
+
 	if (offset_s != tpm_buf_length(buf))
 		sha256_update(&sctx, &buf->data[offset_s],
 			      tpm_buf_length(buf) - offset_s);
+
 	sha256_final(&sctx, cphash);
 
 	/* now calculate the hmac */
-- 
2.39.5


