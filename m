Return-Path: <linux-integrity+bounces-3035-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E82929639
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jul 2024 03:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE671C20A86
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jul 2024 01:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23817F8;
	Sun,  7 Jul 2024 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTj9gFb6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBBED8;
	Sun,  7 Jul 2024 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720314566; cv=none; b=YqdHTAOAmEcvW7AwaO8B+0tGsExRtDGBeivgJku5D63txDtOW/XkVy4Eu2iOGiHhJxmnBLBWkoppsoX3iIQK/DVbkaMzay/adEA9iAfczq2hBHQFue54/tctQ23uJ2pGSzMVGuxGnnBjzaACLhIDU0jlxY+/PW5TqHPcaEjM+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720314566; c=relaxed/simple;
	bh=1Z2JekH8bQbJb2VrdHQTIAGnVd/8YrH/JPnKBJc0BUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kcz1n0swJejeoBhV9ZR+PkCZ15YQO6p8UoZ01YkX7zPGkwpm2BRI+YC6VnEOWQ241QbifJVodAfP7dpuh9w888MO4BTU5/+xQlFYxNrns0QIGKs32LDG15ulG/CScSqzmXrQWS1EuhgkximLc8VjUj1iZ9U5wzNhvLWInx71bIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTj9gFb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED1AC2BD10;
	Sun,  7 Jul 2024 01:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720314565;
	bh=1Z2JekH8bQbJb2VrdHQTIAGnVd/8YrH/JPnKBJc0BUs=;
	h=From:To:Cc:Subject:Date:From;
	b=BTj9gFb6DhX+GPb/mkjLF77acAhcP1dhqO7cs2pxriEiOXA8mCdgEwVso/DC+9Xrp
	 JkMQydHSnJQrmh718tDWLDh871fL01By4WamFJr1g3ezdFdm8ptWJYCyRrnOIoMnWZ
	 J4NGjeb/yg9zlrQCJkXG0ba+SwzsmOvFkXvwLiy9qGUnIjWegN59xGSAvM+8/PiQzC
	 UTa7NEATLxYZz4OnAT2c5IEHmthEBliZI1hrqQo0LPzKP46NnYIzZNtQQ5ww901YKv
	 OtEORDWPDM6SKnoPBJzbMP8Tmyl0PZEuSMTF5MLPlfnz2z62QIxZTK6bkvRUdYv1YX
	 fAKu5dQ6bPYiQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: validate object type in tpm2_handle_mso()
Date: Sun,  7 Jul 2024 04:09:15 +0300
Message-ID: <20240707010916.78918-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_handle_mso() lacks validation for the object type. Validate that
value is one of the allowed values in order to detect errors.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 44 +++++++++++++++++++++++---------
 include/linux/tpm.h              | 22 ++++++++++++++--
 2 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 907ac9956a78..95f38af605d7 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -419,6 +419,27 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 }
 EXPORT_SYMBOL(tpm_buf_append_hmac_session);
 
+static int tpm2_sha256_update_name(struct sha256_state *sctx, u32 handle, void *name)
+{
+	__be32 handle_be32;
+	int mso;
+
+	mso = tpm2_mso_handle(handle);
+	if (mso < 0)
+		return mso;
+
+	if (mso == TPM2_MSO_PERSISTENT || mso == TPM2_MSO_VOLATILE ||
+	    mso == TPM2_MSO_NVRAM) {
+		sha256_update(sctx, name, name_size(name));
+	} else {
+		handle_be32 = cpu_to_be32(handle);
+
+		sha256_update(sctx, (u8 *)&handle_be32, 4);
+	}
+
+	return 0;
+}
+
 /**
  * tpm_buf_fill_hmac_session() - finalize the session HMAC
  * @chip: the TPM chip structure
@@ -537,17 +558,10 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
 	/* add the handle names */
 	for (i = 0; i < handles; i++) {
-		enum tpm2_mso_type mso = tpm2_handle_mso(auth->name_h[i]);
-
-		if (mso == TPM2_MSO_PERSISTENT ||
-		    mso == TPM2_MSO_VOLATILE ||
-		    mso == TPM2_MSO_NVRAM) {
-			sha256_update(&sctx, auth->name[i],
-				      name_size(auth->name[i]));
-		} else {
-			__be32 h = cpu_to_be32(auth->name_h[i]);
-
-			sha256_update(&sctx, (u8 *)&h, 4);
+		if (tpm2_sha256_update_name(&sctx, auth->name_h[i], auth->name[i]) < 0) {
+			dev_err(&chip->dev, "handle with an invalid MSO: 0x%08x\n",
+				auth->name_h[i]);
+			return;
 		}
 	}
 	if (offset_s != tpm_buf_length(buf))
@@ -635,9 +649,15 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
 void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u32 handle, u8 *name)
 {
-	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
 	struct tpm2_auth *auth = chip->auth;
 	int slot;
+	int mso;
+
+	mso = tpm2_mso_handle(handle);
+	if (mso < 0) {
+		dev_err(&chip->dev, "handle with an invalid MSO: 0x%08x\n", handle);
+		return;
+	}
 
 	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE)/4;
 	if (slot >= AUTH_MAX_NAMES) {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 21a67dc9efe8..478513cda698 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -304,9 +304,27 @@ enum tpm2_mso_type {
 	TPM2_MSO_PERSISTENT	= 0x81,
 };
 
-static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
+/**
+ * tpm2_mso_handle() - Extract handle type from the handle
+ * @handle:	an object handle
+ *
+ * Return:
+ * * A value from &tpm_mso_type on success.
+ * * -EINVAL on failure.
+ */
+static inline int tpm2_mso_handle(u32 handle)
 {
-	return handle >> 24;
+	int mso = handle >> 24;
+
+	if (mso == TPM2_MSO_NVRAM ||
+	    mso == TPM2_MSO_SESSION ||
+	    mso == TPM2_MSO_POLICY ||
+	    mso == TPM2_MSO_PERMANENT ||
+	    mso == TPM2_MSO_VOLATILE ||
+	    mso == TPM2_MSO_PERSISTENT)
+		return mso;
+
+	return -EINVAL;
 }
 
 enum tpm2_capabilities {
-- 
2.45.2


