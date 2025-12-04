Return-Path: <linux-integrity+bounces-7803-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C93CA5294
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Dec 2025 20:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 872923025025
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Dec 2025 19:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9983C2F99BD;
	Thu,  4 Dec 2025 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUw9gpa9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFCF2F2613;
	Thu,  4 Dec 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764877694; cv=none; b=JfuH3ZK2jVQX/I15m/OOCCE+S+iy0TiW3cpctJ7GugBU/YiQ3qRPalgO61CAicKztZUPRf/68CljRIBJxxRrWPSRlcZBQOyDoQcmjh6HyHyGd97soI9RzQt4mwiLWsZRYHsADreBmfYkKVwftG4ikTAmUPZJtRC7E9KAWbf7Geg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764877694; c=relaxed/simple;
	bh=qXCMQZofwEPiP4EgNg63otIHasX4gFH3S6+kr+0lWQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l49Q5zhHRpR4P80h2P36TtwvAUj4oYHMgQmztCuDeVkMOi5sJqtDP/t/RcQRpgHMGXVZcTJVnvbucOWGhG2LdTv11/jpUoBQsw+MjdtUuUPe2TgPncEKvfKh5f4+0PDjnuUx3hGDvynwv4QkbKeXVBTy/3uSubageqb41ybDPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUw9gpa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADB4C4CEFB;
	Thu,  4 Dec 2025 19:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764877693;
	bh=qXCMQZofwEPiP4EgNg63otIHasX4gFH3S6+kr+0lWQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUw9gpa9Gr43KKDcdgKCBMRYvK+T8uWnp66L9hmflO6uSscj+7SkB+ntUg7bijKuc
	 1juw9m0b4PkMXqDLHz2FbRa33sOYoHkICe6bbgcliy01oxRWAHDe7aS1N9qXBhodqx
	 OaTaSarSqeVO8QYf6/+mtvjrXnRm2KeI9skJjEmFbiSc/vtStMUoHOkaEeRnGkKmPo
	 aRtNwGXTfPS9AaFJcYOyOg+b2qfPy8pvwKPmMaAwJl0J7Mv40QHOg27Ta/+qkmvGXc
	 8CMBRH92RlQ58yOYF02BSlk7Smld/skeO+kj78xLV6tLLsq0WsLjZ4A29hY0tq1Uj1
	 ALJD8qt2rDI7A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list),
	stable@vger.kernel.org,
	Jonathan McDowell <noodles@meta.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 2/4] tpm2-sessions: Fix tpm2_read_public range checks
Date: Thu,  4 Dec 2025 21:47:40 +0200
Message-ID: <20251204194743.69035-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204194743.69035-1-jarkko@kernel.org>
References: <20251204194743.69035-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_read_public() has some rudimentary range checks but the function does
not ensure that the response buffer has enough bytes for the full TPMT_HA
payload.

Re-implement the function with necessary checks and validation, and return
name and name size for all handle types back to the caller.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- Rename 'rc2' as 'name_size_alg'.
- It makes a lot of sense to add additional robustness in name handling
  to tpm2_read_public. Thus also process handles whose handle name is
  the handle itself, and return name size back to the caller.
v3:
- No changes.
v2:
- Made the fix localized instead of spread all over the place.
---
 drivers/char/tpm/tpm2-cmd.c      |  3 +
 drivers/char/tpm/tpm2-sessions.c | 94 +++++++++++++++++---------------
 2 files changed, 53 insertions(+), 44 deletions(-)

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
index 385014dbca39..3f389e2f6f58 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -163,53 +163,61 @@ static int name_size(const u8 *name)
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
-	val = tpm_buf_read_u16(buf, &offset);
-	ret = name_size(&buf->data[offset]);
-	if (ret < 0)
-		return ret;
-
-	if (val != ret)
-		return -EINVAL;
-
-	memcpy(name, &buf->data[offset], val);
-	/* forget the rest */
-	return 0;
-}
-
-static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
-{
+	int rc, name_size_alg;
 	struct tpm_buf buf;
-	int rc;
+
+	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
+	    mso != TPM2_MSO_NVRAM) {
+		memcpy(name, &handle, sizeof(u32));
+		return sizeof(u32);
+	}
 
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
+	name_size_alg = name_size(&buf.data[offset]);
+
+	if (name_size_alg < 0)
+		return name_size_alg;
+
+	if (rc != name_size_alg) {
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
+	return name_size_alg;
 }
 #endif /* CONFIG_TCG_TPM2_HMAC */
 
@@ -243,6 +251,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #ifdef CONFIG_TCG_TPM2_HMAC
 	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
 	struct tpm2_auth *auth;
+	u16 name_size_alg;
 	int slot;
 	int ret;
 #endif
@@ -273,8 +282,10 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	    mso == TPM2_MSO_NVRAM) {
 		if (!name) {
 			ret = tpm2_read_public(chip, handle, auth->name[slot]);
-			if (ret)
+			if (ret < 0)
 				goto err;
+
+			name_size_alg = ret;
 		}
 	} else {
 		if (name) {
@@ -286,13 +297,8 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 
 	auth->name_h[slot] = handle;
-	if (name) {
-		ret = name_size(name);
-		if (ret < 0)
-			goto err;
-
-		memcpy(auth->name[slot], name, ret);
-	}
+	if (name)
+		memcpy(auth->name[slot], name, name_size_alg);
 #endif
 	return 0;
 
-- 
2.52.0


