Return-Path: <linux-integrity+bounces-2647-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F178CEFE7
	for <lists+linux-integrity@lfdr.de>; Sat, 25 May 2024 17:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06D128263E
	for <lists+linux-integrity@lfdr.de>; Sat, 25 May 2024 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03BD8593B;
	Sat, 25 May 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhTAFEAH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8368565D;
	Sat, 25 May 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651856; cv=none; b=oNPJ7UFmk1ha4ujt6gY3URIQkaLxPwMIUDVtZ6X+6IkX+loQEhYM0QvRLh6SV4BgpH4CrfEYaIFt8mV+TYIjoOwFgWTkehzzIb0VXZzC4Wsniouub3IqA+jVRqLQtaaUj6JmCzUMa5UUldGBd2ng6Xf3ej7TAHVMAqaVHqcjiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651856; c=relaxed/simple;
	bh=fx96WQ3CA4fuu9xuV7Rhy8dNDsj3dwwERPeQsBhGeRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxAsrSCVUz5UltUMXjx/PpRSI1lTOfQQmcOaKuUDoApoAeX6HyEv3pmIBtYeD8vsE04ii32j5rnQMCtD7iSH/ZXu1AECBnMVPOvsza63aDyNqYemkMJbuEhGp++vMMPuqZuDmHm0m4SJXoHCoGESmviDLFqsSKof0SXWus/EyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhTAFEAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8063C2BD11;
	Sat, 25 May 2024 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716651856;
	bh=fx96WQ3CA4fuu9xuV7Rhy8dNDsj3dwwERPeQsBhGeRM=;
	h=From:To:Cc:Subject:Date:From;
	b=bhTAFEAHw0HlX86mVI0bdn8jf47V7qQ4dKQj2qSwTpS1TMoUP3/FfAcTOA9Ye4prr
	 n3Z0Dgo4HvmlwaIG2wdYxD6Jb/R3tLh6iZ2gMLtJBEjsKrN+JyFUJQgayGhZO6qv29
	 rtDStv9+/PvPpUsyokXLDPqm1iHzvNSdOOPfllA2+IcOAfhKxT+YPi6QngYOd90ddt
	 ITywiGgPHyfIqDO21byZmrnp5WeTyBRVzUw5B8RELVmnoCyp5Qk+agL0pRev2MJNgV
	 VfBWQxW3MLDj0X6l9AMq9s3XIBuwGNw7xNHhkRolbX9Ocm0oQnEbTTRYrTqODJ2efi
	 XXazKmB5sraHQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] tpm: Open code tpm_buf_parameters()
Date: Sat, 25 May 2024 18:44:01 +0300
Message-ID: <20240525154406.4811-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With only single call site, this no sense, and it actually slipped out
of the radar during the review. Open code and document the action
directly to the site, to make it more readable.

Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Just a glitch but would be better land to v6.10 so that we don't have
to deal with this post-release.
 drivers/char/tpm/tpm-buf.c  | 26 --------------------------
 drivers/char/tpm/tpm2-cmd.c | 10 +++++++++-
 include/linux/tpm.h         |  2 --
 3 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 647c6ca92ac3..cad0048bcc3c 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -223,30 +223,4 @@ u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
 
-static u16 tpm_buf_tag(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be16_to_cpu(head->tag);
-}
-
-/**
- * tpm_buf_parameters - return the TPM response parameters area of the tpm_buf
- * @buf: tpm_buf to use
- *
- * Where the parameters are located depends on the tag of a TPM
- * command (it's immediately after the header for TPM_ST_NO_SESSIONS
- * or 4 bytes after for TPM_ST_SESSIONS). Evaluate this and return a
- * pointer to the first byte of the parameters area.
- *
- * @return: pointer to parameters area
- */
-u8 *tpm_buf_parameters(struct tpm_buf *buf)
-{
-	int offset = TPM_HEADER_SIZE;
-
-	if (tpm_buf_tag(buf) == TPM2_ST_SESSIONS)
-		offset += 4;
 
-	return &buf->data[offset];
-}
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 0cdf892ec2a7..1e856259219e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -281,6 +281,7 @@ struct tpm2_get_random_out {
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
 	struct tpm2_get_random_out *out;
+	struct tpm_header *head;
 	struct tpm_buf buf;
 	u32 recd;
 	u32 num_bytes = max;
@@ -288,6 +289,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	int total = 0;
 	int retries = 5;
 	u8 *dest_ptr = dest;
+	off_t offset;
 
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
@@ -320,7 +322,13 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 			goto out;
 		}
 
-		out = (struct tpm2_get_random_out *)tpm_buf_parameters(&buf);
+		head = (struct tpm_header *)buf.data;
+		offset = TPM_HEADER_SIZE;
+		/* Skip the parameter size field: */
+		if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
+			offset += 4;
+
+		out = (struct tpm2_get_random_out *)&buf.data[offset];
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(&buf) <
 		    TPM_HEADER_SIZE +
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index c17e4efbb2e5..b3217200df28 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -437,8 +437,6 @@ u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
 
-u8 *tpm_buf_parameters(struct tpm_buf *buf);
-
 /*
  * Check if TPM device is in the firmware upgrade mode.
  */
-- 
2.45.1


