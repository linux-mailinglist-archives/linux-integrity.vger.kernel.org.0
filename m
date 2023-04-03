Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ABB6D53EE
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Apr 2023 23:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjDCVsk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Apr 2023 17:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjDCVsi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Apr 2023 17:48:38 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3B340DE;
        Mon,  3 Apr 2023 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680558507;
        bh=A+M9s0nB90bo2aS1p3MdkJUw0cnzWI58jtC4yD2p9zQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=IIk0IhvWlZjstpXHF0BkQr09rVEMzlJ4bVAJ/K7iE7rNZ1wVWsaAy28Sbz+1ZF5s+
         hZLgTB/Ed5qiGtCEuktUPnINl5zYhKzX1sqcnFF+IQszwaf23/KuePDe2lyremD6m0
         3Lw79QuhM7n9Wu7ZoGLqZNWCKUozrLBEZWBAH1ek=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8B747128020F;
        Mon,  3 Apr 2023 17:48:27 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id cwMNbTAq_O0s; Mon,  3 Apr 2023 17:48:27 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A74DE1280097;
        Mon,  3 Apr 2023 17:48:26 -0400 (EDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 10/13] tpm: add session encryption protection to tpm2_get_random()
Date:   Mon,  3 Apr 2023 17:40:00 -0400
Message-Id: <20230403214003.32093-11-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If some entity is snooping the TPM bus, they can see the random
numbers we're extracting from the TPM and do prediction attacks
against their consumers.  Foil this attack by using response
encryption to prevent the attacker from seeing the random sequence.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-cmd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a53a843294ed..acc944591b91 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -292,25 +292,35 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	err = tpm_buf_init(&buf, 0, 0);
+	err = tpm2_start_auth_session(chip);
 	if (err)
 		return err;
 
+	err = tpm_buf_init(&buf, 0, 0);
+	if (err) {
+		tpm2_end_auth_session(chip);
+		return err;
+	}
+
 	do {
-		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
+						| TPM2_SA_CONTINUE_SESSION,
+						NULL, 0);
 		tpm_buf_append_u16(&buf, num_bytes);
+		tpm_buf_fill_hmac_session(chip, &buf);
 		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
 				       "attempting get random");
+		err = tpm_buf_check_hmac_response(chip, &buf, err);
 		if (err) {
 			if (err > 0)
 				err = -EIO;
 			goto out;
 		}
 
-		out = (struct tpm2_get_random_out *)
-			&buf.data[TPM_HEADER_SIZE];
+		out = (struct tpm2_get_random_out *)tpm_buf_parameters(&buf);
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(&buf) <
 		    TPM_HEADER_SIZE +
@@ -327,6 +337,8 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	} while (retries-- && total < max);
 
 	tpm_buf_destroy(&buf);
+	tpm2_end_auth_session(chip);
+
 	return total ? total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
-- 
2.35.3

