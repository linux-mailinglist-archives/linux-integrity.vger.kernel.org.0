Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF0AAD8E4
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfIIMW7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:22:59 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48340 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfIIMW7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:22:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 317EA8EE180;
        Mon,  9 Sep 2019 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031779;
        bh=GNP+gHeI4s79+X5IM/V6E9d0xl0tXMpD96EM6vlgWyg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gPLen9xBqz2cZGnyZTq2J3USkSk2FoYuc1l2HlvDShPfY9bl6pI9UGUxwZCGz55WC
         kg1rF0lWh2Wrf9sf2ad8AwSJWo+oZGoo0QoXof9DnQ+AHTNuio3ybNyk53ybatbDvy
         sATKOpLq/DJqCPQtqoDWVAaZBXF3GHQ3HMZP9Yy0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q71fB7vQDYMO; Mon,  9 Sep 2019 05:22:59 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DAEB68EE105;
        Mon,  9 Sep 2019 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031779;
        bh=GNP+gHeI4s79+X5IM/V6E9d0xl0tXMpD96EM6vlgWyg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gPLen9xBqz2cZGnyZTq2J3USkSk2FoYuc1l2HlvDShPfY9bl6pI9UGUxwZCGz55WC
         kg1rF0lWh2Wrf9sf2ad8AwSJWo+oZGoo0QoXof9DnQ+AHTNuio3ybNyk53ybatbDvy
         sATKOpLq/DJqCPQtqoDWVAaZBXF3GHQ3HMZP9Yy0=
Message-ID: <1568031775.6613.37.camel@HansenPartnership.com>
Subject: [PATCH v6 08/12] tpm2: add session encryption protection to
 tpm2_get_random()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:22:55 +0100
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

If some entity is snooping the TPM bus, they can see the random
numbers we're extracting from the TPM and do prediction attacks
against their consumers.  Foil this attack by using response
encryption to prevent the attacker from seeing the random sequence.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v3: add error handling to sessions and redo to be outside loop
---
 drivers/char/tpm/tpm2-cmd.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 0012657d3617..572d05966b77 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -296,29 +296,40 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	int total = 0;
 	int retries = 5;
 	u8 *dest_ptr = dest;
+	struct tpm2_auth *auth;
 
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	err = tpm_buf_init(&buf, 0, 0);
+	err = tpm2_start_auth_session(chip, &auth);
 	if (err)
 		return err;
 
+	err = tpm_buf_init(&buf, 0, 0);
+	if (err) {
+		tpm2_end_auth_session(auth);
+		return err;
+	}
+
 	do {
-		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_append_hmac_session_opt(&buf, auth, TPM2_SA_ENCRYPT
+						| TPM2_SA_CONTINUE_SESSION,
+						NULL, 0);
 		tpm_buf_append_u16(&buf, num_bytes);
+		tpm_buf_fill_hmac_session(&buf, auth);
 		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
 				       "attempting get random");
+		err = tpm_buf_check_hmac_response(&buf, auth, err);
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
@@ -335,6 +346,8 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	} while (retries-- && total < max);
 
 	tpm_buf_destroy(&buf);
+	tpm2_end_auth_session(auth);
+
 	return total ? total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
-- 
2.16.4

