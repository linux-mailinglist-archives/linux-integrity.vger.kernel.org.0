Return-Path: <linux-integrity+bounces-7955-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D648CBB36C
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 21:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18C0A3021763
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 20:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4851E8320;
	Sat, 13 Dec 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZChRD6Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19A26B08F;
	Sat, 13 Dec 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765657975; cv=none; b=OjZxC4lNBqgUotSvsR2AzO1WjZ4tOywNX56GXVLfSYPiutq1w/7cQuz4V7F5NGQfuWban6KAdU+m9poPK5vhSg41i8xMMnyEZ/y8TQBcs3i/mCZuKkDCi0WGh4cYuKxQtFJZKvfm+YGPRBlSqDP+WgSIPY8RjHrVpBy9XF1Q1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765657975; c=relaxed/simple;
	bh=hxwPp5Kh8vY7Xhmoj4PuuPypO608i5v2okDBhE+dEP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Epb2BdwCEgtuVDjZLTDBYv0RNFl4lna21tLr4FxKkeq3P/Of/XWzziP4YwoULF2/7nfrE8ZDKmnNO5byWy0bFeLonUSrxkinJFtKU0gD0ue3yAVuK7OaVbmaBkFqFsyol42zb9xiK+OlLcDu7bDEyldL7gTsIA3W49yGiaYMCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZChRD6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07099C113D0;
	Sat, 13 Dec 2025 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765657975;
	bh=hxwPp5Kh8vY7Xhmoj4PuuPypO608i5v2okDBhE+dEP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZChRD6YwuwnqqDzF3o08NVrIQQd3IppM8uCqlKpMlJS7x0vc8khkjT9bLkH2rSHe
	 hLVGH3zPigAscp4WFrEcLSkrhTWH/TGTOHCeWFu13g9kXiaADxbo3ImOI/qYva1AU5
	 rn1ECbgpARn8FRTtaaY5H2YJC3R1ReiFMT4yKzDXaNYkEFSO+u/4CXSsNRACH/tkNA
	 kqTLViZkmYznTnjcoqnopQtKcZ/7mcmcUk4gpsYNHde+pyuJsFad8wnacRcnDwDhhe
	 nyYV/fGneqgGv06zssD0OawiKsMblXJKYlWJdCWy/tLNU4VtoJdvk8GWlu5DSI63Px
	 mBgl64i/Gkf4g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
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
Subject: [PATCH v5 04/12] tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
Date: Sat, 13 Dec 2025 22:32:11 +0200
Message-Id: <20251213203220.317498-5-jarkko@kernel.org>
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

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW into TPM_BUF_INVALID,
given that they are identical. The only difference are the log messages.

In addition, add a missing TPM_BUF_INVALID check to tpm_buf_append_handle()
following the pattern from other functions in tpm-buf.c.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
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
index e10f2096eae7..f43725c52204 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -382,12 +382,10 @@ struct tpm_header {
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
index 77e1532ef9d4..ef6dd88e56cf 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -283,7 +283,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	/* creation PCR */
 	tpm_buf_append_u32(&buf, 0);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
@@ -299,7 +299,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	blob_len = tpm_buf_read_u32(&buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
+	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		goto out;
 	}
@@ -412,7 +412,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 
 	tpm_buf_append(&buf, blob, blob_len);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
-- 
2.39.5


