Return-Path: <linux-integrity+bounces-7755-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DF2C996B7
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Dec 2025 23:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E59794E2381
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 22:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB4299AAA;
	Mon,  1 Dec 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvN2fNhA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B24299A82;
	Mon,  1 Dec 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629175; cv=none; b=PELo2YN45epvBMHtZ40/QO3mrZCDdPsMJWYG48a+SVpkAlg+ygX4PzDIV9wOqTaY0uCWVSpvpN/9Sjl3dlCzN2OAGWYOpUPYGwByF4SEZRTh4EOXzTcPIiSpqxoB0vGZdk9RcgHIig2XhYj71AaBMZftLxs+cc0YyysYNyZjP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629175; c=relaxed/simple;
	bh=lghMIWcoAMO2UqemhgpnDfw0sFzpW4OPCayQxWihy9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebbrm7zCYyTpW2/40anqf9f2dazjvUoZZf+ZrVO7OO5ZA7ztpZlXF/4zKsK94r7CNsALcpDdJmjSebVYfdsGOdi0xSl9YR3ZyYlvFJaW7odk2HIP/ab0tt7aEvJD375hVZBNSmn6bJUImHdw1VUnbojQ8evTY+OYgAetX0qMqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvN2fNhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB93C116D0;
	Mon,  1 Dec 2025 22:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629174;
	bh=lghMIWcoAMO2UqemhgpnDfw0sFzpW4OPCayQxWihy9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvN2fNhAVuLoJjomO/F0AIE1wX4DUsINvWI6qYw2p2quBDkRnSeT30qXzbJ2RbGuG
	 425muwLSq5xZMLaXK4lTiBD0jk/WKw87vxEaOarSk8KFoqxm4Fp4FT/Ybi2TDshV2k
	 BwCm5HbCrqipltBX8UJQefOFSE+vprCHRFlBARvp2UjQCX9ry3M8P6J0RP69thbcA2
	 5raUFW8VXYo4kmWfvXYez8/QEfiKWaPZjqalwh3ITMN73iUkZIJe1dFv4OL5JX2zbM
	 LiU6KN5t3Y2W3QA+qm0a1aTPGMPKyu6G9aeAzvFXdlqNrSqs6RcmGF8Rt7WuZwgFsh
	 AZfDqzKMEAxoQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] tpm2-sessions: Fix tpm2_read_public range checks
Date: Tue,  2 Dec 2025 00:45:50 +0200
Message-ID: <20251201224554.1717104-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201224554.1717104-1-jarkko@kernel.org>
References: <20251201224554.1717104-1-jarkko@kernel.org>
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
---
 drivers/char/tpm/tpm2-cmd.c      |  3 ++
 drivers/char/tpm/tpm2-sessions.c | 77 +++++++++++++++++---------------
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 4473b81122e8..58a8477cda85 100644
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
index 33ad0d668e1a..afbca03f639e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -164,54 +164,59 @@ static int name_size(const u8 *name)
 	return -EINVAL;
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


