Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2687A11D4B2
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 18:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfLLR6i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 12:58:38 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49404 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729771AbfLLR6i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 12:58:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ADA428EE18E;
        Thu, 12 Dec 2019 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576173517;
        bh=zSA5vEZXE9xCTtWGIKVrRDuKgN6VsdKbhb5/T3DsX/g=;
        h=Subject:From:To:Cc:Date:From;
        b=cbLToYKhJp+VoWeSyLJ6DfZEgqvS4fnbwmGdb/r+ueWRHo/oUympdMDo5+iJrqqhz
         60k2Iuo1RM0gUFuslCUR9lvD0GPp6JJe2YaVQrFhoN7NBOxupfLARfJOyPVgrMxDuZ
         VON754zrY+pfXC8HZ6xgh8UjkbBeOqX3zRXXRjDk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OTnLXpYwQLqE; Thu, 12 Dec 2019 09:58:37 -0800 (PST)
Received: from [9.232.197.95] (unknown [129.33.253.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2135C8EE0C7;
        Thu, 12 Dec 2019 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576173517;
        bh=zSA5vEZXE9xCTtWGIKVrRDuKgN6VsdKbhb5/T3DsX/g=;
        h=Subject:From:To:Cc:Date:From;
        b=cbLToYKhJp+VoWeSyLJ6DfZEgqvS4fnbwmGdb/r+ueWRHo/oUympdMDo5+iJrqqhz
         60k2Iuo1RM0gUFuslCUR9lvD0GPp6JJe2YaVQrFhoN7NBOxupfLARfJOyPVgrMxDuZ
         VON754zrY+pfXC8HZ6xgh8UjkbBeOqX3zRXXRjDk=
Message-ID: <1576173515.15886.7.camel@HansenPartnership.com>
Subject: [PATCH URGENT FIX] security: keys: trusted: fix lost handle flush
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Thu, 12 Dec 2019 12:58:35 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The original code, before it was moved into security/keys/trusted-keys
had a flush after the blob unseal.  Without that flush, the volatile
handles increase in the TPM until it becomes unusable and the system
either has to be rebooted or the TPM volatile area manually flushed. 
Fix by adding back the lost flush, which we now have to export because
of the relocation of the trusted key code may cause the consumer to be
modular.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Fixes: 2e19e10131a0 ("KEYS: trusted: Move TPM2 trusted keys code")

---
 drivers/char/tpm/tpm.h                    | 1 -
 drivers/char/tpm/tpm2-cmd.c               | 1 +
 include/linux/tpm.h                       | 1 +
 security/keys/trusted-keys/trusted_tpm2.c | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index b9e1547be6b5..5620747da0cf 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -218,7 +218,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
-void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index fdb457704aa7..13696deceae8 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -362,6 +362,7 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
 	tpm_buf_destroy(&buf);
 }
+EXPORT_SYMBOL_GPL(tpm2_flush_context);
 
 struct tpm2_get_cap_out {
 	u8 more_data;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0d6e949ba315..03e9b184411b 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -403,6 +403,7 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
+void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index a9810ac2776f..08ec7f48f01d 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -309,6 +309,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 		return rc;
 
 	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
+	tpm2_flush_context(chip, blob_handle);
 
 	return rc;
 }
-- 
2.16.4

