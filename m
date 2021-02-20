Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471C0320284
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 02:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBTBe2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 20:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhBTBe1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 20:34:27 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDEEC061793
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:09 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m1so4329418qvp.0
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CtLRPHa6vVfWJfnUvKFAfqInMZ/2zkbzy/KaLuvq/RY=;
        b=np6G+qmB02m6CtsdX1J98BauvoCRqwR9uUAoQZ22HnNJ8AErOq7qAe01yv81qnazq7
         7bmJqaZaEgG8ceyd+8a5WTsKEgcbxIK2fYrKz41nff+TJH3yWqdUMkWWFx62d5DLgJqZ
         n5/KdFSRNpxtx0Q+UEJQxrJfHUm3F4XGFEhSRwlZeLop/Ez9xYlluW4mTSJE8FE97q1v
         cosSPTLjucB4Jk1Cyy3x0f/w0r7Fv4vja9ht+0qyAIOFidMadt/oE6GmN2Wx24XSpQcx
         62/kE5HdcY/YJL1Q5kiK5ftf3dCNwHukTsdRn8vzZZHFcU/3+A1jYEvb7iboCMpeH5L7
         X+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CtLRPHa6vVfWJfnUvKFAfqInMZ/2zkbzy/KaLuvq/RY=;
        b=EXluNe1qjrCUk+CZIugU6E0ojfwb/lih3cvdCwmfR/E5/h/DRhV+h6grwMzwb2k2MA
         sOMqWTFEyyJnyxOmC6lt5sSD/yy4e6e1J6gRPUjq0uC1BtAqMjfu47WhTAayLUczdy4m
         pqWc/k1/dv/SSbDLF7KWIlNpN7UeXp7sISxniLzMYaUHeBjCpgVjG7LZphlNYtgIq4fV
         Gygh/DB3ZvcObbWwjszFE4OD8cHkZBvMpR6V3Z1GgjzLhWjCfefBpOyoydXqZWi4VTcq
         wXKN9hCJeIEH259o2msaRXabn7A51Mf2nwupk21OS055TUKZCq45JM0HXspyoFnFt16v
         CmNg==
X-Gm-Message-State: AOAM532b+IbOcvOTJTF3MIc7jAmhnnpILpavAe7IpVWRWS0rnGCoBclr
        eib8gssiu5IoAoe11zVa5OKfrY1/VAFinPyxU8pykQ==
X-Google-Smtp-Source: ABdhPJxgycPtcGyLtpEWUmPPRqEvf5yxoDeFB4QBUiNxo/8m3G60P8mXpFrAXLh1D4foiHWOPPTgCdpjOwOooBtVjqzOIQ==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a0c:ac43:: with SMTP id
 m3mr12016912qvb.37.1613784787904; Fri, 19 Feb 2021 17:33:07 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:47 +0000
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
Message-Id: <20210220013255.1083202-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 1/9] tpm: Add support for in-kernel resetting of PCRs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add an internal command for resetting a PCR.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++++++++++
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm1-cmd.c      | 34 ++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c      | 36 ++++++++++++++++++++++++++++++++
 include/linux/tpm.h              |  7 +++++++
 5 files changed, 107 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce818705..17b8643ee109 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -342,6 +342,34 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 }
 EXPORT_SYMBOL_GPL(tpm_pcr_extend);
 
+/**
+ * tpm_pcr_reset - reset the specified PCR
+ * @chip:	a &struct tpm_chip instance, %NULL for the default chip
+ * @pcr_idx:	the PCR to be reset
+ *
+ * Return: same as with tpm_transmit_cmd()
+ */
+int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
+{
+	int rc;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip)
+		return -ENODEV;
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		rc = tpm2_pcr_reset(chip, pcr_idx);
+		goto out;
+	}
+
+	rc = tpm1_pcr_reset(chip, pcr_idx, "attempting to reset a PCR");
+
+out:
+	tpm_put_ops(chip);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm_pcr_reset);
+
 /**
  * tpm_send - send a TPM command
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 947d1db0a5cc..746f7696bdc0 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -176,6 +176,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg);
+int tpm1_pcr_reset(struct tpm_chip *chip, u32 pcr_idx, const char *log_msg);
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
@@ -220,6 +221,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
+int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ca7158fa6e6c..36990e9d2dc1 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -478,6 +478,40 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	return rc;
 }
 
+struct tpm_pcr_selection {
+	u16 size_of_select;
+	u8  pcr_select[3];
+} __packed;
+
+#define TPM_ORD_PCR_RESET 200
+int tpm1_pcr_reset(struct tpm_chip *chip, u32 pcr_idx, const char *log_msg)
+{
+	struct tpm_pcr_selection selection;
+	struct tpm_buf buf;
+	int i, rc;
+	char tmp;
+
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_RESET);
+	if (rc)
+		return rc;
+
+	selection.size_of_select = 3;
+
+	for (i = 0; i < selection.size_of_select; i++) {
+		tmp = 0;
+		if (pcr_idx / 3 == i) {
+			pcr_idx -= i * 8;
+			tmp |= 1 << pcr_idx;
+		}
+		selection.pcr_select[i] = tmp;
+	}
+	tpm_buf_append(&buf, (u8 *)&selection, sizeof(selection));
+
+	rc = tpm_transmit_cmd(chip, &buf, sizeof(selection), log_msg);
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
 #define TPM_ORD_GET_CAP 101
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length)
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index eff1f12d981a..9609ae8086c6 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -269,6 +269,42 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
+/**
+ * tpm2_pcr_reset() - reset a PCR
+ *
+ * @chip:	TPM chip to use.
+ * @pcr_idx:	index of the PCR.
+ *
+ * Return: Same as with tpm_transmit_cmd.
+ */
+int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
+{
+	struct tpm_buf buf;
+	struct tpm2_null_auth_area auth_area;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_RESET);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, pcr_idx);
+
+	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
+	auth_area.nonce_size = 0;
+	auth_area.attributes = 0;
+	auth_area.auth_size = 0;
+
+	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
+	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
+		       sizeof(auth_area));
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to reset a PCR");
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
 struct tpm2_get_random_out {
 	__be16 size;
 	u8 buffer[TPM_MAX_RNG_DATA];
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8f4ff39f51e7..e2075e2242a0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -211,6 +211,7 @@ enum tpm2_command_codes {
 	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
 	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
 	TPM2_CC_CREATE_PRIMARY          = 0x0131,
+	TPM2_CC_PCR_RESET		= 0x013D,
 	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
 	TPM2_CC_SELF_TEST	        = 0x0143,
 	TPM2_CC_STARTUP		        = 0x0144,
@@ -399,6 +400,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
+extern int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
@@ -417,6 +419,11 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
 	return -ENODEV;
 }
 
+static inline int tpm_pcr_reset(struct tpm_chip *chip, int pcr_idx)
+{
+	return -ENODEV;
+}
+
 static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 				 struct tpm_digest *digests)
 {
-- 
2.30.0.617.g56c4b15f3c-goog

