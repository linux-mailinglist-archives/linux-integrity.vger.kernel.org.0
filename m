Return-Path: <linux-integrity+bounces-7830-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD6CAA539
	for <lists+linux-integrity@lfdr.de>; Sat, 06 Dec 2025 12:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 392AC3032257
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Dec 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFE1F03D9;
	Sat,  6 Dec 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsiRoyA2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BFD3B8D70;
	Sat,  6 Dec 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765020687; cv=none; b=YK00gJSljCJ+aMo6OL4TCopYpc8y25VC5LXzI5iT2N9WF+//Qb69Z+NaV7mLbNa21vkUNZEqQpaxitMDg+x7aA84Cldy8m6iq7E+78wT2euLw4yg4Q2s8swidfBf/XW9leJiMUlkdRrG2Fg5L4IuOvUb4lbMDw10VNcBHeP1mxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765020687; c=relaxed/simple;
	bh=0NTqmK0sP9NWngg3Q0qP5FtoHiuddFmCR5+NkhQleuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFX8zGXmF8k/c0PDVTe/rkg5ePr9mVwini+3hBFShsNr2n1TJaAHcuN3Ni4h8a8Up7nsN+yS+1X6gEWFrcDdeBwf1oMmTX4oRVe4qvN4ay0Vh2D68Yg8e0tGpPizenPMJ62Fk1QmRSsSVqyXB96ecAJdBZyGyEWXsFuR/DwkVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsiRoyA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E341C4CEF5;
	Sat,  6 Dec 2025 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765020686;
	bh=0NTqmK0sP9NWngg3Q0qP5FtoHiuddFmCR5+NkhQleuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsiRoyA2H1WPkbAcQMYboLmxT/Avf5PdBBqLkX6Z6FCVetkaHLgRQKWzH7PbQMk6U
	 lJWUpMBzdCU/Fyqwp2mogwYIy2bQsI0ea9RJpruG9o8OoAyGu+Vsue23B9vek3cZgE
	 Ynveqql1pnKILvtkJdNu1PGOdf9ov51yX70BL/mpoTdU8RU/ebMeJcahLU+qItwOB0
	 yT3rdbDzOHTBZjObO/j2MxlKyEwRnpHU4EKWjmxAb680LRBVnhbtrR7EJLjgtSrx9R
	 +2G78emU98G0EJ/hes37OXngirnhaJh/Ycu+JsYB1sQRD7z5aBK9wBW3jwoGEgg2uZ
	 tGpjeeCFcRf5w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH 1/3] tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
Date: Sat,  6 Dec 2025 13:31:08 +0200
Message-Id: <20251206113110.1793407-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251206113110.1793407-1-jarkko@kernel.org>
References: <20251206113110.1793407-1-jarkko@kernel.org>
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
index 202da079d500..aed34f119e8c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -369,12 +369,10 @@ struct tpm_header {
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
index a7ea4a1c3bed..fdba641fefdb 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -313,7 +313,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	/* creation PCR */
 	tpm_buf_append_u32(&buf, 0);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
@@ -329,7 +329,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	blob_len = tpm_buf_read_u32(&buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
+	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		goto out;
 	}
@@ -442,7 +442,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 
 	tpm_buf_append(&buf, blob, blob_len);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
-- 
2.39.5


