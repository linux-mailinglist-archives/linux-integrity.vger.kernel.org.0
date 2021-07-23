Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BA83D3E6D
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhGWQkx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 12:40:53 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:51134
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231166AbhGWQkx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 12:40:53 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AC9073F325;
        Fri, 23 Jul 2021 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627060884;
        bh=7FQD/B711wUP78UGWXd/xXfRyIQyD6tfXLIddfxdlcc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=MIpg2zVyane9SunkaQ6m9KeX6+ptvvm8nBjPPToZ+jE+O8Udpx2/Hbt3KIM9AsnKT
         15av06BGurLcNcGDj6vbShhx7AEj2S5U1YUJVBo9G4n5qkVO+o03wYR+ClVinO47rd
         YMzTHOBW3XCPNf1b6cwBNLfQTObnplThPTRn+cf7LMBC9zC8dIWVJNMT5cCleyilum
         +jYVy0XJ0ILlsAQMEspBu4tpIAeQsH2wBw3i+HsmtuGkTjr3kJUlkfl4wsxcDgIDcY
         /D1H9HfoBkcbFQEKQWuVU5VAosMEY1/JylzJ5x8vS2kVVbFDoK7MVAjg+GNLXzAPKS
         yPzFytvYsyq/g==
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
Subject: [PATCH] security: keys: trusted: Fix memory leaks on allocated blob
Date:   Fri, 23 Jul 2021 18:21:21 +0100
Message-Id: <20210723172121.156687-1-colin.king@canonical.com>
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
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 30 ++++++++++++++++-------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 0165da386289..930c67f98611 100644
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
@@ -441,6 +449,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		rc = -EPERM;
 
 	return rc;
+
+err:
+	kfree(blob);
+	return rc;
 }
 
 /**
-- 
2.31.1

