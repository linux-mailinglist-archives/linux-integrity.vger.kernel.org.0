Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8275A3D58B0
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhGZLEH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 07:04:07 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:34996
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233371AbhGZLEH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 07:04:07 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 258C13F357;
        Mon, 26 Jul 2021 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627299874;
        bh=k6BQBYMxs42A0l5eZc18V3p4ovBk2bBgUoL8N/8VpPs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=V2nQr5gmN7GdiofCc/F5kLnGNPeOGwMBcaYD1biglTrOmrJsYIq5zmQnR+LmgMNrf
         cCGd7RgAZio8T68t6nuVKyurJxYN+ilV/VTW4GLT/KSc4NJUsFBaghNxm7dIdFouua
         sz2ViYIijWuj9uJu7rjJael6ydRxKxHAGJJkapeIgwk9FqxmMYYkUpRH2ZJVwlVxtu
         adTVR8yaHVxkse/obCsQUoyAWShCH/Zl2Yk2cGx9qV8SUKXj6ec4A7luXgfR6ZHyZQ
         9LfCTrc0S9CWu3Dh1BU166jFe7E4xY5v/YjdE/v29u4l4AbG1a5xxgTP5bY8zln1lZ
         JDXp37hlebV0A==
From:   Colin King <colin.king@canonical.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] security: keys: trusted: Fix memory leaks on allocated blob
Date:   Mon, 26 Jul 2021 12:44:31 +0100
Message-Id: <20210726114431.18042-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several error return paths that don't kfree the allocated
blob, leading to memory leaks. Ensure blob is initialized to null as
some of the error return paths in function tpm2_key_decode do not
change blob. Add an error return path to kfree blob and use this on
the current leaky returns.

Addresses-Coverity: ("Resource leak")
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Colin Ian King <colin.king@canonical.com>

---

V2: Add a couple more leaky return path fixes as noted by Sumit Garg
    Add the if (blob != payload->blob) check on the kfree as
    noted by Dan Carpenter

---
 security/keys/trusted-keys/trusted_tpm2.c | 39 ++++++++++++++++-------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 0165da386289..a2cfdfdf17fa 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -366,7 +366,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
-	u8 *blob, *pub;
+	u8 *blob = NULL, *pub;
 	int rc;
 	u32 attrs;
 
@@ -378,22 +378,30 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	}
 
 	/* new format carries keyhandle but old format doesn't */
-	if (!options->keyhandle)
-		return -EINVAL;
+	if (!options->keyhandle) {
+		rc = -EINVAL;
+		goto err;
+	}
 
 	/* must be big enough for at least the two be16 size counts */
-	if (payload->blob_len < 4)
-		return -EINVAL;
+	if (payload->blob_len < 4) {
+		rc = -EINVAL;
+		goto err;
+	}
 
 	private_len = get_unaligned_be16(blob);
 
 	/* must be big enough for following public_len */
-	if (private_len + 2 + 2 > (payload->blob_len))
-		return -E2BIG;
+	if (private_len + 2 + 2 > (payload->blob_len)) {
+		rc = -E2BIG;
+		goto err;
+	}
 
 	public_len = get_unaligned_be16(blob + 2 + private_len);
-	if (private_len + 2 + public_len + 2 > payload->blob_len)
-		return -E2BIG;
+	if (private_len + 2 + public_len + 2 > payload->blob_len) {
+		rc = -E2BIG;
+		goto err;
+	}
 
 	pub = blob + 2 + private_len + 2;
 	/* key attributes are always at offset 4 */
@@ -406,12 +414,14 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		payload->migratable = 1;
 
 	blob_len = private_len + public_len + 4;
-	if (blob_len > payload->blob_len)
-		return -E2BIG;
+	if (blob_len > payload->blob_len) {
+		rc = -E2BIG;
+		goto err;
+	}
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
 	if (rc)
-		return rc;
+		goto err;
 
 	tpm_buf_append_u32(&buf, options->keyhandle);
 	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
@@ -441,6 +451,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		rc = -EPERM;
 
 	return rc;
+
+err:
+	if (blob != payload->blob)
+		kfree(blob);
+	return rc;
 }
 
 /**
-- 
2.31.1

