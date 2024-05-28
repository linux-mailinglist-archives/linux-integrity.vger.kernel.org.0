Return-Path: <linux-integrity+bounces-2669-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF338D1301
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 05:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C62B20D5B
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 03:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251301BC2A;
	Tue, 28 May 2024 03:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWz2qLEs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80201B969;
	Tue, 28 May 2024 03:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868312; cv=none; b=QhE2k6s7I2c1q248CC1XbbuzayK7fuRrI7fAYRuJnUK+cMteqzSFg7/4HvbZ7YkLfZGSKpJ1EqouZeXqWF2SvyJzsqhKSgWeorysIafO6GnyjnxpRAxZCfVlCZs0+cC7d3oJBZocbzaB4wLFkCZMUVRxdKSH1xcFNsRBC+g7wJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868312; c=relaxed/simple;
	bh=ZgvWBP6tE4s9/snimxcOGEFivWgLx0Ri9cZOylfpUtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwVoLlUxz1PTFbgsNPxOJ78WoXpL8QuK77UmIzV7ZIHxRIhnXYWRnHNYnV7ARMOfdy+z1k3stZAJbPrWE6Ot65SZysmd72oBoWmNWuk1SNbnsyVUo2WOFPNreq726B8wE8NgrR6wOJ1MAyGMVfB8L04ueZbyFhYvMIMbBmhU3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWz2qLEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18704C32782;
	Tue, 28 May 2024 03:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716868311;
	bh=ZgvWBP6tE4s9/snimxcOGEFivWgLx0Ri9cZOylfpUtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWz2qLEsuPGoqRilvjGGhFYLpoa49Vdz9h5ql48FBVCCK1E2lO2ZWnYMTOxZjNeMj
	 WqbZUful+bX0pH00nrSNekDdxmdvjDfL3j/AAXP09tL3krHhUkesz2/eve6LtOFsCz
	 pdzwOUB3pMN+3XNn6WUm1wZ9HhIUpQJMtNpMdLWmaAOmNlreq40dgF3z0xO3KKsUI6
	 rPbrOSFHVrT/lXkWJUFT3a3ej3CS5nx7rOeC0XOvpb0mx/r6hktfk+DtS8VrxudufD
	 0o/5j126Kcyg2X5KQhESSjN9ZDUvNKrYzgiSH1ivPnRwKDx+VV979sZp1Xiq06fEN3
	 hdRmRedKZufRQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list),
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6 1/6] tpm: Open code tpm_buf_parameters()
Date: Tue, 28 May 2024 06:51:16 +0300
Message-ID: <20240528035136.11464-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528035136.11464-1-jarkko@kernel.org>
References: <20240528035136.11464-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With only single call site, this makes zero sense (slipped out of the
radar during the review). Open code and document the action directly
to the site, to make it more readable.

Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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


