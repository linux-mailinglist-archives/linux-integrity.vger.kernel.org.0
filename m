Return-Path: <linux-integrity+bounces-3139-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0A8932F10
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 19:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3663B2837C8
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA119FA89;
	Tue, 16 Jul 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBinjmLg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0A19E7D0;
	Tue, 16 Jul 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721150887; cv=none; b=Xi74abQNtwiJ4+w8Z9o15VmI1m4coanICfjwkkMoQd8akR1a5JXohO28jcbmfIbwaaBBOY72yrCcZ9vUgcqwxAXS7JoKUYTcBp3wKAEEp5/X48c+yHm/SGBTMNEX6sQE3nF/NYToxrJUbf8NUkyYtfExzQBAaKYjnbbr8RRpXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721150887; c=relaxed/simple;
	bh=zBxSrue6PTi9TlBB5NE2o6nu/bnjeOTBb2WxJOg2Mec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AhRJwkbtAZyf8awE9FGaJUlM3IkrM1Tc64UVGSMi3X3oXYCu8Z261p+PTfinVX/8tACJE5leK7i56THnmaPox3OpOJN1ZbTVhu7FYFlwSUVoLuzpCbApf9jS7YYgW0JNmvBXSk1I1UaDVHdrNeFTNVpcAiChN5UUn/BUnvtL8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBinjmLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C320C116B1;
	Tue, 16 Jul 2024 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721150886;
	bh=zBxSrue6PTi9TlBB5NE2o6nu/bnjeOTBb2WxJOg2Mec=;
	h=From:To:Cc:Subject:Date:From;
	b=LBinjmLgkYtma9BVEzMQ6nnDBRJ6lXIsi+D6INFkMmXv/WchFDusOPUHJSy9Vo2Wv
	 17zMAI/AI5zYwxU4lEhFHk3wpyCccqTtEV7OUlOUXzxlQ2zKPWQ1kVS9U65nrU2zSj
	 P5/Lvcs/1HvZCU73d9X6mlE3FU2BMg3o1UpH0aBZn2Fe1nV3jFTfJboGEtMRSMzpZh
	 ERbZ+gAc8PJCc0bLRu3wMVsgTvkqxLJooRAu86PJYGAmCCSHBc9k1aKvoEImogDvpU
	 qeO+YgFVKPkNfNfV7rvkhX9MXgh64AVsdY2LOrPBF4b8QntsJ3JTln/5vMpWgU+tHg
	 REK9FmHi5JXjg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: Relocate buf->handles to appropriate place
Date: Tue, 16 Jul 2024 20:27:52 +0300
Message-ID: <20240716172754.397801-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm_buf_append_name() has the following snippet in the beginning:

	if (!tpm2_chip_auth(chip)) {
		tpm_buf_append_u32(buf, handle);
		/* count the number of handles in the upper bits of flags */
		buf->handles++;
		return;
	}

The claim in the comment is wrong, and the comment is in the wrong place
as alignment in this case should not anyway be a concern of the call
site. In essence the comment is  lying about the code, and thus needs to
be adressed.

Further, 'handles' was incorrectly place to struct tpm_buf, as tpm-buf.c
does manage its state. It is easy to grep that only piece of code that
actually uses the field is tpm2-sessions.c.

Address the issues by moving the variable to struct tpm_chip.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
* Was a bit more broken than I first thought, as 'handles' is only
  useful for tpm2-sessions.c and has zero relation to tpm-buf.c.
---
 drivers/char/tpm/tpm-buf.c       |  1 -
 drivers/char/tpm/tpm2-sessions.c | 11 +++++------
 include/linux/tpm.h              |  8 ++++----
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index cad0048bcc3c..d06e8e063151 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -44,7 +44,6 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 	head->tag = cpu_to_be16(tag);
 	head->length = cpu_to_be32(sizeof(*head));
 	head->ordinal = cpu_to_be32(ordinal);
-	buf->handles = 0;
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..a4ff5bca61dd 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -238,8 +238,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 
 	if (!tpm2_chip_auth(chip)) {
 		tpm_buf_append_u32(buf, handle);
-		/* count the number of handles in the upper bits of flags */
-		buf->handles++;
+		chip->handles++;
 		return;
 	}
 
@@ -310,7 +309,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 
 	if (!tpm2_chip_auth(chip)) {
 		/* offset tells us where the sessions area begins */
-		int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+		int offset = chip->handles * 4 + TPM_HEADER_SIZE;
 		u32 len = 9 + passphrase_len;
 
 		if (tpm_buf_length(buf) != offset) {
@@ -1010,10 +1009,10 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 
 	tpm_buf_destroy(&buf);
 
-	if (rc)
-		goto out;
+	if (!rc)
+		chip->handles = 0;
 
- out:
+out:
 	return rc;
 }
 EXPORT_SYMBOL(tpm2_start_auth_session);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e93ee8d936a9..b664f7556494 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -202,9 +202,9 @@ struct tpm_chip {
 	/* active locality */
 	int locality;
 
+	/* handle count for session: */
+	u8 handles;
 #ifdef CONFIG_TCG_TPM2_HMAC
-	/* details for communication security via sessions */
-
 	/* saved context for NULL seed */
 	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
 	 /* name of NULL seed */
@@ -377,7 +377,6 @@ struct tpm_buf {
 	u32 flags;
 	u32 length;
 	u8 *data;
-	u8 handles;
 };
 
 enum tpm2_object_attributes {
@@ -517,7 +516,7 @@ static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 	if (tpm2_chip_auth(chip)) {
 		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
 	} else  {
-		offset = buf->handles * 4 + TPM_HEADER_SIZE;
+		offset = chip->handles * 4 + TPM_HEADER_SIZE;
 		head = (struct tpm_header *)buf->data;
 
 		/*
@@ -541,6 +540,7 @@ void tpm2_end_auth_session(struct tpm_chip *chip);
 
 static inline int tpm2_start_auth_session(struct tpm_chip *chip)
 {
+	chip->handles = 0;
 	return 0;
 }
 static inline void tpm2_end_auth_session(struct tpm_chip *chip)
-- 
2.45.2


