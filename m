Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD01727DC50
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 00:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgI2Wvq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 18:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgI2Wvq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 18:51:46 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0E2920756;
        Tue, 29 Sep 2020 22:51:45 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Kent Yoder <key@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 1/2] KEYS: trusted: Fix incorrect handling of tpm_get_random()
Date:   Wed, 30 Sep 2020 01:51:40 +0300
Message-Id: <20200929225141.804688-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When tpm_get_random() was introduced, it defined the following API for the
return value:

1. A positive value tells how many bytes of random data was generated.
2. A negative value on error.

However, in the call sites the API was used incorrectly, i.e. as it would
only return negative values and otherwise zero. Returning he positive read
counts to the user space does not make any possible sense.

Fix this by returning -EIO when tpm_get_random() returns a positive value.

Fixes: 41ab999c80f1 ("tpm: Move tpm_get_random api into the TPM device driver")
Cc: Kent Yoder <key@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index b9fe02e5f84f..c7b1701cdac5 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -403,9 +403,12 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 	int ret;
 
 	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
-	if (ret != TPM_NONCE_SIZE)
+	if (ret < 0)
 		return ret;
 
+	if (ret != TPM_NONCE_SIZE)
+		return -EIO;
+
 	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OSAP);
 	tpm_buf_append_u16(tb, type);
 	tpm_buf_append_u32(tb, handle);
@@ -496,8 +499,12 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 		goto out;
 
 	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
+	if (ret < 0)
+		return ret;
+
 	if (ret != TPM_NONCE_SIZE)
-		goto out;
+		return -EIO;
+
 	ordinal = htonl(TPM_ORD_SEAL);
 	datsize = htonl(datalen);
 	pcrsize = htonl(pcrinfosize);
@@ -601,9 +608,12 @@ static int tpm_unseal(struct tpm_buf *tb,
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
 	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
+	if (ret < 0)
+		return ret;
+
 	if (ret != TPM_NONCE_SIZE) {
 		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
-		return ret;
+		return -EIO;
 	}
 	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
 			   enonce1, nonceodd, cont, sizeof(uint32_t),
@@ -1013,8 +1023,12 @@ static int trusted_instantiate(struct key *key,
 	case Opt_new:
 		key_len = payload->key_len;
 		ret = tpm_get_random(chip, payload->key, key_len);
+		if (ret < 0)
+			goto out;
+
 		if (ret != key_len) {
 			pr_info("trusted_key: key_create failed (%d)\n", ret);
+			ret = -EIO;
 			goto out;
 		}
 		if (tpm2)
-- 
2.25.1

