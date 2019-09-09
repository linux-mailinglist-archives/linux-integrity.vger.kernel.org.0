Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D58AD8DE
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfIIMWX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:22:23 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48312 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731677AbfIIMWW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:22:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7F87D8EE180;
        Mon,  9 Sep 2019 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031742;
        bh=i7MrhvQ94JMBQj1p8wKiylhyLzjjRYfsQm4gyztxsWs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZwlPUCMge59+Lbf3+zTN10yyl4Tdi/aB4FTJXnIic9Xk3bwCK4CjamlvHMnGj4SXl
         q28wM68xLMRyN8//fbwr6prUuqOAscc7tsNI7vyqLuplBfEr44UMGxezXTWPQIZvba
         yeTWkSNFskCCpoNSn+zSCaq3trC/7xh1iTi6l2lo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q4e4JzhYcOCP; Mon,  9 Sep 2019 05:22:22 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3B5878EE105;
        Mon,  9 Sep 2019 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031742;
        bh=i7MrhvQ94JMBQj1p8wKiylhyLzjjRYfsQm4gyztxsWs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZwlPUCMge59+Lbf3+zTN10yyl4Tdi/aB4FTJXnIic9Xk3bwCK4CjamlvHMnGj4SXl
         q28wM68xLMRyN8//fbwr6prUuqOAscc7tsNI7vyqLuplBfEr44UMGxezXTWPQIZvba
         yeTWkSNFskCCpoNSn+zSCaq3trC/7xh1iTi6l2lo=
Message-ID: <1568031739.6613.36.camel@HansenPartnership.com>
Subject: [PATCH v6 07/12] tpm2: add hmac checks to tpm2_pcr_extend()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:22:19 +0100
In-Reply-To: <1568031408.6613.29.camel@HansenPartnership.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We use tpm2_pcr_extend() in trusted keys to extend a PCR to prevent a
key from being re-loaded until the next reboot.  To use this
functionality securely, that extend must be protected by a session
hmac.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v3: add error handling to sessions
---
 drivers/char/tpm/tpm2-cmd.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index d120b0a260eb..0012657d3617 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -223,13 +223,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
-struct tpm2_null_auth_area {
-	__be32  handle;
-	__be16  nonce_size;
-	u8  attributes;
-	__be16  auth_size;
-} __packed;
-
 /**
  * tpm2_pcr_extend() - extend a PCR value
  *
@@ -243,24 +236,23 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests)
 {
 	struct tpm_buf buf;
-	struct tpm2_null_auth_area auth_area;
+	struct tpm2_auth *auth;
 	int rc;
 	int i;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	rc = tpm2_start_auth_session(chip, &auth);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, pcr_idx);
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	if (rc) {
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
 
-	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
-	auth_area.nonce_size = 0;
-	auth_area.attributes = 0;
-	auth_area.auth_size = 0;
+	tpm_buf_append_name(&buf, auth, pcr_idx, NULL);
+	tpm_buf_append_hmac_session(&buf, auth, 0, NULL, 0);
 
-	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
-	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
-		       sizeof(auth_area));
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
 
 	for (i = 0; i < chip->nr_allocated_banks; i++) {
@@ -269,7 +261,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			       chip->allocated_banks[i].digest_size);
 	}
 
+	tpm_buf_fill_hmac_session(&buf, auth);
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 
 	tpm_buf_destroy(&buf);
 
-- 
2.16.4

