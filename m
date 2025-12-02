Return-Path: <linux-integrity+bounces-7767-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C9C9CE65
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Dec 2025 21:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1734E31D9
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Dec 2025 20:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224872F3614;
	Tue,  2 Dec 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFIapIWz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F02F3605;
	Tue,  2 Dec 2025 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707221; cv=none; b=eDvuuSW2aHVaGfGsTOyR/CwS/QtAwWpBm7C9DivTTTUMkJ6sMntvXWhG1nYnVA5TzWlBd2UqqS2zwqZJHglJzXei2SlfH45U68v9jCVaxRq1R2T4spoAfFpFxD4nQOYqtmF6fbARGTvuoHo6iANjtNE0bFH2GZHrwJTmgbTR32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707221; c=relaxed/simple;
	bh=A+KBwrEGw+Q66tMB4kTs9WcRGbEetXnPSCqTR053tDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgXUTaCA6M1zA0WDAcNMpUWCFSmj97I4NMFRSYnTN4nSVvAsp7q3hLIc+dMUC+xfx/v4YRDfZ4/xCANHuZb5k5afNubS/SJg158L539fFWeoi8IVjJwq0QN/pZn1H5ADIq4Klb2M0VsHYO0BtDE36S+x0iZSDWdgVO6bmKWbiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFIapIWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5561AC4CEF1;
	Tue,  2 Dec 2025 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764707220;
	bh=A+KBwrEGw+Q66tMB4kTs9WcRGbEetXnPSCqTR053tDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFIapIWzY+MIBJRg1ScP2oZerWjda600/KK2nRiuO1AtMLARD85UfgzRL5pQW6irK
	 qZcPJ8AWrNSucLAt6yWG8Hr6nkAxLWd7WITajMeG5QFYLQXvw2tdzl29RCuG4r6E4X
	 5dpAhq0t030HL+nauGxOPEwImOwoK48V2OAdrmQ7hk0IUrJSyQ/heldRGsF0ZvjokJ
	 GWvMovmnWn+QMLYtBDF6f+RY69LhJWz36XiSsZySikguaFKQWAVxzKyI8G6ptPH+z1
	 D5qzT98EVSA/5wlhZMTvf7XwJ2iQuOyVeeAvCPzjED10aCTt/MfSyE7eBYxVIUKpEl
	 ReTrm3XE5Y7rw==
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
Subject: [PATCH v2 2/4] tpm2-sessions: Fix tpm2_read_public range checks
Date: Tue,  2 Dec 2025 22:26:39 +0200
Message-ID: <20251202202643.107108-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202202643.107108-1-jarkko@kernel.org>
References: <20251202202643.107108-1-jarkko@kernel.org>
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
index dc6bee7e1ef6..964f44c2255d 100644
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


