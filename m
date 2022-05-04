Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D0B51B414
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 02:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383828AbiEEABe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 20:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiEDXZF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 19:25:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500104D9FD
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 16:21:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p6so2297505plr.12
        for <linux-integrity@vger.kernel.org>; Wed, 04 May 2022 16:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kOErKHWJujqLaWOkztm6Xtg2ojuojMVj+Fr4mvN2bHY=;
        b=jYMzIpOHiHfN+4bIj/5tb5+YNcUhAnEFKP1KNaU1R74wa7pXmowvB0kqxvMPbZiDX0
         ce4lExddCHHxXaFEgN/WpLdcoE4xyxvt+gbwyI00DWN4BxPSmJibPrsZuKSJB2Qp1sj2
         rog+u88u3r0YgEA4474NdK7ebeueNp8BCQJW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOErKHWJujqLaWOkztm6Xtg2ojuojMVj+Fr4mvN2bHY=;
        b=x7JS95+WnrsSdbR/VLGPxe3Dzs1z2GV+jOWujhnyTGxAzBqzOHmuvtvJBjQwEFF+lw
         QG6VXUaTHHGYiDWIIwyefgtwHFBTn9ketB23el4BakdnLzVBuF/ELWm4jHCi/+z1oW65
         0rxqwjihefIz9urFlNxExLr9A4HbUSdyUdViMcPJvRKI2pZ6JfmwvIyrEpojTZIrtIBm
         fcUtJ5s6KQofKh80kaF5AVNNAmBRpMMyTp3DmsL/SAmzkNJpsf09O8gGgXY5UU9xFAj6
         eTMB/fvoPC5Briq2VFeBYfVtgBn7dLPBuWGalG4eZr2YePwpOEKXMdFv3a+1029zt2E2
         +feA==
X-Gm-Message-State: AOAM532RdfgFxleI6nSbyQB5ue/j/w+4LKou0ImY6omsN2N13TSP6Nam
        93o1plFRSoMZBif1FdLZQ8nikA==
X-Google-Smtp-Source: ABdhPJyyPuRAXT9i6lNMadNV8m2hItTolkkOwTobBqzOGh/jcV0ZGvreW1VB1z9+Q9zAcbwiLZEuOg==
X-Received: by 2002:a17:902:da90:b0:15e:adc2:191d with SMTP id j16-20020a170902da9000b0015eadc2191dmr14406754plx.134.1651706479816;
        Wed, 04 May 2022 16:21:19 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902f78c00b0015e8d4eb2d6sm1901pln.288.2022.05.04.16.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:21:19 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>, Hao Wu <hao.wu@rubrik.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Subject: [PATCH 01/10] tpm: Add support for in-kernel resetting of PCRs
Date:   Wed,  4 May 2022 16:20:53 -0700
Message-Id: <20220504161439.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220504232102.469959-1-evgreen@chromium.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Matthew Garrett <matthewgarrett@google.com>

Add an internal command for resetting a PCR. This will be used by the
encrypted hibernation code to set PCR23 to a known value. The
hibernation code will seal the hibernation key with a policy specifying
PCR23 be set to this known value as a mechanism to ensure that the
hibernation key is genuine. But to do this repeatedly, resetting the PCR
is necessary as well.

From: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>

Signed-off-by: Evan Green <evgreen@chromium.org>
---
Matthew's original version of this patch was at:
https://patchwork.kernel.org/patch/12096487/

 drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++++++++++
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm1-cmd.c      | 34 ++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c      | 36 ++++++++++++++++++++++++++++++++
 include/linux/tpm.h              |  7 +++++++
 5 files changed, 107 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce8187052c..17b8643ee109c2 100644
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
index 2163c6ee0d364f..72b6c0873852c6 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -174,6 +174,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg);
+int tpm1_pcr_reset(struct tpm_chip *chip, u32 pcr_idx, const char *log_msg);
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
@@ -216,6 +217,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
+int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index f7dc986fa4a0a2..9b9ad1fc20ccfd 100644
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
index 4704fa553098b5..c0806b4447c8b2 100644
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
index dfeb25a0362dee..8320cbac6f4009 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -219,6 +219,7 @@ enum tpm2_command_codes {
 	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
 	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
 	TPM2_CC_CREATE_PRIMARY          = 0x0131,
+	TPM2_CC_PCR_RESET		= 0x013D,
 	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
 	TPM2_CC_SELF_TEST	        = 0x0143,
 	TPM2_CC_STARTUP		        = 0x0144,
@@ -423,6 +424,7 @@ extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
+extern int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
@@ -440,6 +442,11 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
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
2.31.0

