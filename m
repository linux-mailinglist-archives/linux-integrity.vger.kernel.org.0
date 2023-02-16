Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A0699D82
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 21:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBPUSx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 15:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBPUSw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 15:18:52 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA014CCB0;
        Thu, 16 Feb 2023 12:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1676578729;
        bh=sFMhwvzqwlDOu75+YbpIFRanc0XIbEDOxzORk5liJas=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=ShXObklnja7UU1LmbEWwpS+SYxm91QIFSzwNrmRf84n8aUOCIYy+ioGLPtY3YAx3m
         Y6Ws64miTQLZG2ma/hB5HRHNvkwesWV0n47aFv0WT2udFnLuW8Zj1hJLu3YeqBGsNg
         tiDbdPGXWa3s7sNGAe7TEugF0LQREH7ukVWcFpDE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4E5C51286F6C;
        Thu, 16 Feb 2023 15:18:49 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KgSD9_3pW9_X; Thu, 16 Feb 2023 15:18:49 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B4D2C1286F45;
        Thu, 16 Feb 2023 15:18:48 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 08/12] tpm: add hmac checks to tpm2_pcr_extend()
Date:   Thu, 16 Feb 2023 15:14:06 -0500
Message-Id: <20230216201410.15010-9-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We use tpm2_pcr_extend() in trusted keys to extend a PCR to prevent a
key from being re-loaded until the next reboot.  To use this
functionality securely, that extend must be protected by a session
hmac.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-cmd.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 056dad3dd5c9..ef038cc71f9c 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -216,13 +216,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
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
@@ -236,24 +229,22 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests)
 {
 	struct tpm_buf buf;
-	struct tpm2_null_auth_area auth_area;
 	int rc;
 	int i;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	rc = tpm2_start_auth_session(chip);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, pcr_idx);
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	if (rc) {
+		tpm2_end_auth_session(chip);
+		return rc;
+	}
 
-	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
-	auth_area.nonce_size = 0;
-	auth_area.attributes = 0;
-	auth_area.auth_size = 0;
+	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 
-	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
-	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
-		       sizeof(auth_area));
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
 
 	for (i = 0; i < chip->nr_allocated_banks; i++) {
@@ -262,7 +253,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			       chip->allocated_banks[i].digest_size);
 	}
 
+	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
+	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 
 	tpm_buf_destroy(&buf);
 
-- 
2.35.3

