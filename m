Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC48676BC25
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjHASTb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjHAST3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 14:19:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FBDD212D
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 11:19:28 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 15D8B238AE9F;
        Tue,  1 Aug 2023 11:19:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15D8B238AE9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690913967;
        bh=YyXNPicdPmDdugeuEdmn5ywOfCLWK1lBOFctYL8C0yQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGe+IK+ZCUEzGThf5xruHt+zZH8RdEZv3/7bSCd8xRqA+/pPR8a6AugPfo1EYBLJf
         +BqxUuQ0BEkLxoZYWdYITMc/Ze5dvJNdH72y3w+Yq4q+lrGBKixjSw4u/jlVc8zUn2
         vhwcIRUzcCNJYL81VuJ6RcdaspFIf3N3iXC4Izb0=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 2/6] tpm: provide functionality to get update counter
Date:   Tue,  1 Aug 2023 11:19:13 -0700
Message-Id: <20230801181917.8535-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA subsystem needs to measure pcrUpdateCounter value present in 
TPM2_PCR_Read Response struct [1].  However,the  pcrUpdateCounter value
is not exposed outside of the TPM subsystem by any of the existing
functions. 

Implement a new function 'tpm_pcr_get_update_counter()',  which provides
a way to retrieve the PCR update counter values from subsystems outside 
of TPM.  If the input tpm_chip is not a TPM2 chip, return an error as
the functionality is currently only implemented for TPM2 chips.

This function improves TPM capabilities in the Linux kernel by
facilitating access to the PCR update counter.

[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
Section 22.4.2, Page 206.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/char/tpm/tpm-interface.c | 28 ++++++++++++++++++++++++++++
 include/linux/tpm.h              |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7e513b771832..9a1088914487 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -300,6 +300,34 @@ int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 }
 EXPORT_SYMBOL_GPL(tpm_pcr_read);
 
+/**
+ * tpm_pcr_get_update_counter - gets an update counter value for a PCR bank
+ * @chip: a &struct tpm_chip instance, %NULL for the default chip
+ * @pcr_idx: PCR index used to retrieve the update counter
+ * @alg_id:	alg id used to retrieve the update counter
+ * @update_counter: output update counter value
+ *
+ * Return: same as with tpm_transmit_cmd()
+ */
+int tpm_pcr_get_update_counter(struct tpm_chip *chip, u32 pcr_idx,
+		 u16 alg_id, u32 *update_counter)
+{
+	int rc;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip)
+		return -ENODEV;
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		rc = tpm2_pcr_get_update_counter(chip, pcr_idx, alg_id,
+						 update_counter);
+	else
+		rc = -ENODEV;
+
+	tpm_put_ops(chip);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm_pcr_get_update_counter);
 /**
  * tpm_pcr_extend - extend a PCR value in SHA1 bank.
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4dc97b9f65fb..3b55218b70fa 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -424,6 +424,8 @@ extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
+extern int tpm_pcr_get_update_counter(struct tpm_chip *chip, u32 pcr_idx,
+		 u16 alg_id, u32 *update_counter);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
@@ -440,6 +442,12 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
 {
 	return -ENODEV;
 }
+static inline int tpm_pcr_get_update_counter(struct tpm_chip *chip,
+					     u32 pcr_idx, u16 alg_id,
+					     u32 *update_counter)
+{
+	return -ENODEV;
+}
 
 static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 				 struct tpm_digest *digests)
-- 
2.25.1

