Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F513117C12
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 01:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLJAFb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 19:05:31 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37854 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfLJAFa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 19:05:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AAF048EE112;
        Mon,  9 Dec 2019 16:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575936330;
        bh=d1fuSknOHfbVoIjckfTDmfT5wxztl0cmhyOV1XejJTE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qKTSnpFVsPeiyEobwnvlvOOuHJjyum034LhQNz9AqzaPD+hiWq9H0Hv29zjat5xlk
         Zx1uKrHWNSRyXUH2Tki4Pzoh7rDDAc3CSlve7fch9uuRS9L08wbcbx1g1SeuG2i7Oh
         HqJR4jTOWTiK9eXFHrKH5c2U++logXjTnNa+IKh0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1VEohNMelbxY; Mon,  9 Dec 2019 16:05:30 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 374A58EE0FC;
        Mon,  9 Dec 2019 16:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575936330;
        bh=d1fuSknOHfbVoIjckfTDmfT5wxztl0cmhyOV1XejJTE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qKTSnpFVsPeiyEobwnvlvOOuHJjyum034LhQNz9AqzaPD+hiWq9H0Hv29zjat5xlk
         Zx1uKrHWNSRyXUH2Tki4Pzoh7rDDAc3CSlve7fch9uuRS9L08wbcbx1g1SeuG2i7Oh
         HqJR4jTOWTiK9eXFHrKH5c2U++logXjTnNa+IKh0=
Message-ID: <1575936329.31378.51.camel@HansenPartnership.com>
Subject: [PATCH v2 1/8] security: keys: trusted: flush the key handle after
 use
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 09 Dec 2019 16:05:29 -0800
In-Reply-To: <1575936272.31378.50.camel@HansenPartnership.com>
References: <1575936272.31378.50.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The trusted keys code currently loads a blob into the TPM and unseals
on the handle.  However, it never flushes the handle meaning that
volatile contexts build up until the TPM becomes unusable.  Fix this
by flushing the handle after the unseal.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: use EXPORT_SYMBOL_GPL
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

