Return-Path: <linux-integrity+bounces-7790-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71712CA1C8A
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 23:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E87B03015E2A
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E742DEA8C;
	Wed,  3 Dec 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0DZty2n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659FB2DEA79;
	Wed,  3 Dec 2025 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799953; cv=none; b=l8In0THkBpDfUYrJZaZBPZ2A9aVQyRRQ26aE8iv5erwrg7RPRLO/T4BQOuNrcbCTWyvNh6tPHSoY5UPAvWFM4YL/Hiy5mX7dluROirbfAfJ2SEuFksx5WZJh0WA4Teu4NFLpFdT2BgDwlNeM0Vy8ARQT/4iWIOnvpI+bpRtnqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799953; c=relaxed/simple;
	bh=pEroIieDV0yILHi+qd0Kw6/doaQeGzsOJ0pf58PbQwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaTSy1eEJYCy4OSqNed6cWDNZFlOuITGkjR4tGs8t8F2twMne2+RgKCOJBAM6lnja9Z9VT0d+L/eY/uXKO1DIWs4zQ9icJGshh8Q5LKJKc2G3prlNytTxuc4hn0Xd/H9MuN+DSMM/XAD7IVVj/4nnDpRrbq34IoPHumrISmACdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0DZty2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF99C116C6;
	Wed,  3 Dec 2025 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764799952;
	bh=pEroIieDV0yILHi+qd0Kw6/doaQeGzsOJ0pf58PbQwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0DZty2n2AhAGmyoQKq5vTxejWi8Z74IGkDyFZRWRqVpHzn3w/aZ9g/h4YfZx920I
	 XwTzOtS5r/KmufN+l+QIwUYL/HDd2JV1vkGn7KHEAnulXcJrUkiBq7oTlnV18YXm8H
	 07hicCXbjstV4RQ//0H2CD5WOShsYwn9J31n177Ry3Co8EHVoD071BDMNiT0ejDKAM
	 MdYkE2Q561T5LexBPie0NW7SqbpXNcrR/+tno2wfoh+Bbq13Z0GXxB4dmY74TOdMWc
	 7MJntUlXKWqxet0SuFVY7O8lesTfqflHHd3i9v0Q4dhVm+a7B7u5AvZsDEHu/cYzPv
	 mnARD1agS+8cg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan McDowell <noodles@earth.li>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list),
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 2/4] tpm2-sessions: Fix tpm2_read_public range checks
Date: Thu,  4 Dec 2025 00:12:12 +0200
Message-ID: <20251203221215.536031-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203221215.536031-1-jarkko@kernel.org>
References: <20251203221215.536031-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'tpm2_read_public' has some rudimentary range checks but the function
does not ensure that the response buffer has enough bytes for the full
TPMT_HA payload.

Re-implement the function with necessary checks and validation.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

v2:
- Made the fix localized instead of spread all over the place.
---
 drivers/char/tpm/tpm2-cmd.c      |  3 ++
 drivers/char/tpm/tpm2-sessions.c | 77 +++++++++++++++++---------------
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index be4a9c7f2e1a..34e3599f094f 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -11,8 +11,11 @@
  * used by the kernel internally.
  */
 
+#include "linux/dev_printk.h"
+#include "linux/tpm.h"
 #include "tpm.h"
 #include <crypto/hash_info.h>
+#include <linux/unaligned.h>
 
 static bool disable_pcr_integrity;
 module_param(disable_pcr_integrity, bool, 0444);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index a265e9752a5e..e9f439be3916 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -163,54 +163,59 @@ static int name_size(const u8 *name)
 	}
 }
 
-static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
+static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
 {
-	struct tpm_header *head = (struct tpm_header *)buf->data;
+	u32 mso = tpm2_handle_mso(handle);
 	off_t offset = TPM_HEADER_SIZE;
-	u32 tot_len = be32_to_cpu(head->length);
-	int ret;
-	u32 val;
-
-	/* we're starting after the header so adjust the length */
-	tot_len -= TPM_HEADER_SIZE;
-
-	/* skip public */
-	val = tpm_buf_read_u16(buf, &offset);
-	if (val > tot_len)
-		return -EINVAL;
-	offset += val;
-	/* name */
-
-	val = tpm_buf_read_u16(buf, &offset);
-	ret = name_size(&buf->data[offset]);
-	if (ret < 0)
-		return ret;
+	struct tpm_buf buf;
+	int rc, rc2;
 
-	if (val != ret)
+	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
+	    mso != TPM2_MSO_NVRAM)
 		return -EINVAL;
 
-	memcpy(name, &buf->data[offset], val);
-	/* forget the rest */
-	return 0;
-}
-
-static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
-{
-	struct tpm_buf buf;
-	int rc;
-
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
 	if (rc)
 		return rc;
 
 	tpm_buf_append_u32(&buf, handle);
-	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
-	if (rc == TPM2_RC_SUCCESS)
-		rc = tpm2_parse_read_public(name, &buf);
 
-	tpm_buf_destroy(&buf);
+	rc = tpm_transmit_cmd(chip, &buf, 0, "TPM2_ReadPublic");
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		return tpm_ret_to_err(rc);
+	}
 
-	return rc;
+	/* Skip TPMT_PUBLIC: */
+	offset += tpm_buf_read_u16(&buf, &offset);
+
+	/*
+	 * Ensure space for the length field of TPM2B_NAME and hashAlg field of
+	 * TPMT_HA (the extra four bytes).
+	 */
+	if (offset + 4 > tpm_buf_length(&buf)) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	rc = tpm_buf_read_u16(&buf, &offset);
+	rc2 = name_size(&buf.data[offset]);
+
+	if (rc2 < 0)
+		return rc2;
+
+	if (rc != rc2) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	if (offset + rc > tpm_buf_length(&buf)) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	memcpy(name, &buf.data[offset], rc);
+	return 0;
 }
 #endif /* CONFIG_TCG_TPM2_HMAC */
 
-- 
2.52.0


