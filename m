Return-Path: <linux-integrity+bounces-7348-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE58BAEC28
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 01:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D0532108A
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443752D24A9;
	Tue, 30 Sep 2025 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ7PZiVl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620D2D0634;
	Tue, 30 Sep 2025 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274436; cv=none; b=IoCjBAdDy6iRmaVY3C8hIGS9feyE8RsT9VBh6MwoURXvOEfv2eXj4KcOKMSxIXOnoLHNLHDjyHaR55fR/RyG+7sISdJcuUur5mff4nXwMIpP0GiGV72ZdKIva0k9bMD2vew/muq5MQIknyLEyEHJAMqM0rA/RvqMPadBk++w9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274436; c=relaxed/simple;
	bh=e+Hq89cOeLWVV6clf1MlgKl/7jpDuLWfqCWqWH4LKaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2K2jij7+mpSAm5OH98BKNyaLMbF3AIs62RZVilRRTU4B64TTuScZBymwGpQBiOlIg+RkL7TYCnR2tcllzHJ8pzpn0/rdqiEvpRrTl/B1js0vuCRlJlOeXqTScCs7JR0co3gPcQQswoxSZ1caY84cqA99ildOxAHwdb3HOWNjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ7PZiVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92617C4CEF0;
	Tue, 30 Sep 2025 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759274436;
	bh=e+Hq89cOeLWVV6clf1MlgKl/7jpDuLWfqCWqWH4LKaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZ7PZiVlPQx1oaJpW4XGwTkvXuQygYeK64/uJ+6pODUdGLmEHXoBU/MNRBAuj6hNN
	 P69z2tQEOMdsipW6V8nCFiDBBgoUPXWhMHeXJmLjoMcbDCP1a/+NdqX/ViiqqSAR9h
	 Y17Vy76lJF+8nm3kHfG49Pq9ERQY1EwxSAKFPf78u9/6bvjM1s1iEcP6X/jr0UxhU/
	 d7oDWUI4KNkrgjb96QyRVduYC7k9cao0L5G2xkEE9Gzoe+1ff56W6pWVtEv4Z9dYVO
	 QVZu3FGOVVA5JCiM/29s1fsFUqHs+/8RKi+q4MChWyY0977Aa043pQuu494gbz8Uwy
	 d8GwshqUU1Ldg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v5 7/9] tpm-buf: check for corruption in tpm_buf_append_handle()
Date: Wed,  1 Oct 2025 02:19:56 +0300
Message-Id: <20250930231958.1437783-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930231958.1437783-1-jarkko@kernel.org>
References: <20250930231958.1437783-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Unify TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW into TPM_BUF_INVALID
flag because semantically they are identical.

Test and set TPM_BUF_INVALID in tpm_buf_append_handle() following the
pattern from other functions in tpm-buf.c.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
v4:
- No changes.
v3:
- No changes.
v2:
- A new patch.
---
 drivers/char/tpm/tpm-buf.c                | 14 ++++++++------
 include/linux/tpm.h                       |  8 +++-----
 security/keys/trusted-keys/trusted_tpm2.c |  6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index dc882fc9fa9e..69ee77400539 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -104,13 +104,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
  */
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_OVERFLOW)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	if ((buf->length + new_length) > PAGE_SIZE) {
 		WARN(1, "tpm_buf: write overflow\n");
-		buf->flags |= TPM_BUF_OVERFLOW;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
@@ -157,8 +156,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
  */
 void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
 {
+	if (buf->flags & TPM_BUF_INVALID)
+		return;
+
 	if (buf->flags & TPM_BUF_TPM2B) {
 		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
@@ -177,14 +180,13 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
 {
 	off_t next_offset;
 
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	next_offset = *offset + count;
 	if (next_offset > buf->length) {
 		WARN(1, "tpm_buf: read out of boundary\n");
-		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e3c65d33e041..4613216e9d95 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -370,12 +370,10 @@ struct tpm_header {
 } __packed;
 
 enum tpm_buf_flags {
-	/* the capacity exceeded: */
-	TPM_BUF_OVERFLOW	= BIT(0),
 	/* TPM2B format: */
-	TPM_BUF_TPM2B		= BIT(1),
-	/* read out of boundary: */
-	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
+	TPM_BUF_TPM2B		= BIT(0),
+	/* The buffer is in invalid and unusable state: */
+	TPM_BUF_INVALID		= BIT(1),
 };
 
 /*
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 8e3b283a59b2..119d5152c0db 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -295,7 +295,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	/* creation PCR */
 	tpm_buf_append_u32(&buf, 0);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
@@ -308,7 +308,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	blob_len = tpm_buf_read_u32(&buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
+	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		goto out;
 	}
@@ -414,7 +414,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 
 	tpm_buf_append(&buf, blob, blob_len);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
-- 
2.39.5


