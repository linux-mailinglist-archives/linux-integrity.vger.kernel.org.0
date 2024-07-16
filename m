Return-Path: <linux-integrity+bounces-3142-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D83A9330B7
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 20:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BD21F24594
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FBC1BC43;
	Tue, 16 Jul 2024 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btv5GK+G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42B1643A;
	Tue, 16 Jul 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155955; cv=none; b=ecqTbOZVmFy4nWnck6eNPFvEb9+d5TW31BGMkEoTXu74BIBkM/mF/ZtKE5xQCD9XNnmBHZGlajwlSkbroZ9tvMC8ljOCbmFH8d2Kf89WvTUhGbIfXJsApSMzsy1xu6ILB+gufBfs7/Xk16hqlnxzQ2EiKiJq+H643O8g2fyJQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155955; c=relaxed/simple;
	bh=X9OpwdZtZFTZbbC8V7nGKukaKQcflFFBotd4UiiS6jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RT+Sfzz0t6RvqT0Zu3pW0A/RMYNjvhCVy+PvU0Xk3SVs+/4DadnpnkA4M2xVX8wL/DU+4VpJk5P2q6HuBvojXuUtbYee49cS/v0LEvjabcMYnHbGe0K2f+KVwrORb+LjDvYjppAOU7OnlkiyRWp54PS+JbUfV/81Mx4CfUKXVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btv5GK+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394C8C116B1;
	Tue, 16 Jul 2024 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721155954;
	bh=X9OpwdZtZFTZbbC8V7nGKukaKQcflFFBotd4UiiS6jk=;
	h=From:To:Cc:Subject:Date:From;
	b=Btv5GK+GHpWpFgNUGAXhwF491WnEU1qSMBJhT0aqTx3Wo0FiUPDwzz6DMf0TEcKfP
	 69Wiqt0ydpi9IoNxqSCEHKcJQzlQ7EGH9XfSUeA+PxHkJXRNHhvLGw/9off8twSSfV
	 RUL2dfcD7qcQozPy666ljreu4OgKwn6rK0mxbYFV1X/zahQq6tPGks0AKtNDO2PtCB
	 DMISNjOAqeojj1esoLn04dkScVrDQ0cTw82ACQtmOVK4xqNTmb+VFdnRHHHeKboz2i
	 JJ3BX/2fPHIA//3uDPy0EkZKWXzivS7bWvyQ7AO2snIm9xtfCw9UksZLgOqcoyEJ2O
	 wBUwOlPNB3rsQ==
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
Subject: [PATCH v3] tpm: Relocate buf->handles to appropriate place
Date: Tue, 16 Jul 2024 21:52:24 +0300
Message-ID: <20240716185225.873090-1-jarkko@kernel.org>
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

v3:
* Reset chip->handles in the beginning of tpm2_start_auth_session()
  so that it shows correct value, when TCG_TPM2_HMAC is enabled but
  tpm2_sessions_init() has never been called.
v2:
* Was a bit more broken than I first thought, as 'handles' is only
  useful for tpm2-sessions.c and has zero relation to tpm-buf.c.
---
 drivers/char/tpm/tpm-buf.c       | 1 -
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 7 ++++---
 include/linux/tpm.h              | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

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
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 1e856259219e..b781e4406fc2 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -776,7 +776,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	if (rc)
 		goto out;
 
-	rc = tpm2_sessions_init(chip);
+	/* rc = tpm2_sessions_init(chip); */
 
 out:
 	/*
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..5e7c12d64ba8 100644
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
@@ -963,6 +962,8 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	int rc;
 	u32 null_key;
 
+	chip->handles = 0;
+
 	if (!auth) {
 		dev_warn_once(&chip->dev, "auth session is not active\n");
 		return 0;
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


