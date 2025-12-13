Return-Path: <linux-integrity+bounces-7959-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8605CBB397
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 21:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD2CB3037519
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B478284686;
	Sat, 13 Dec 2025 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqJiFqXK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A0287263;
	Sat, 13 Dec 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765658001; cv=none; b=Kx9SDqmmoAkb7ENGq0JtycR0rNuGGw8g3/InA6wT0nlilT8DE5GExJD4Xky5X1S/N59ZYSFwpL81Vsx8SAS14deyEVBCeaitrCZk3HahB634c4Vla7XKO46C4hFFvGyHkHSlkVL+3ucrp93JQgPBezCTwES9Vz83Gmg4NtryhL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765658001; c=relaxed/simple;
	bh=Wz61wVnDzRdflPtBF10cm2FsT3zRCVnTKs79IJUARzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FDg7pXon/jwZqDRlvcKpgtW/udZbYyDkUkWE4VMmCjlaieFlj4n5M81bSSu+MxxruGBJx6QTUZo7wr2Maqc8MV4d3pI7sK9u8j/prWYgvtNI9kgsBNPHvC8jRo1HcrzZEqL+3L3fA6bgC+LWT3K8eNNokQEle3A1yE9qOJGRSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqJiFqXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CBDC4CEF7;
	Sat, 13 Dec 2025 20:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765658000;
	bh=Wz61wVnDzRdflPtBF10cm2FsT3zRCVnTKs79IJUARzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqJiFqXKr1eUbCwfI2ovk7oThSw2eqJcHvz0f11Z1/L3UQGykBmc+BadeMxD/bQI8
	 89jtnRmZv2TGEtIZepAlaFJUNxN9San2NhR83cm0cEHHlBU/PrUklCci4VORPAO1tv
	 p/aOu8dFfkqVhrnyqCA+bXqgHbD6IsHMAKSeBb7dzYaGqLTxpewhxgY3sEDRynpBL/
	 sxDEimKxwDaAnLCu4dWcGF/xhizSTPBySuZ7D63If7WQeoGkpn2P1WkYmQp4qHrxM0
	 qTprkpm6+lYTVhJZU9cFeDxTvsovr/J1pRgH9b7XdjtdAY/Iw/quJHhgEf+ua1un7Q
	 aFWVUwgM0WdbQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v5 08/12] tpm2-sessions: Remove AUTH_MAX_NAMES
Date: Sat, 13 Dec 2025 22:32:15 +0200
Message-Id: <20251213203220.317498-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251213203220.317498-1-jarkko@kernel.org>
References: <20251213203220.317498-1-jarkko@kernel.org>
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
2.39.5


