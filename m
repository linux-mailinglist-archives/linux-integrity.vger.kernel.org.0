Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1461A76BC26
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjHASTb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHAST3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 14:19:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 803F72136
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 11:19:28 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id B4CF7238AEA2;
        Tue,  1 Aug 2023 11:19:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4CF7238AEA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690913968;
        bh=XSu/u8+vyhoyKdaPC5jr7V2GlLG5uFfsCE+21U5Fofs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvgYNT7GmYF5rOZ0k6+hig3x2xbFWxcTxTpYi21DHDFieGhqLlltEKw8FAEJpZLrH
         6QxtNqqZU/uXBPLiSHeM2QJZfwNMVRuHhALQR8rUYFT6b4d4QNP8CjPN8j5XFAWJw8
         +qurG3UrKDaIX/7Ix/i4zVpJXAStZ2gAtQYp1znI=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 3/6] ima: get TPM update counter
Date:   Tue,  1 Aug 2023 11:19:14 -0700
Message-Id: <20230801181917.8535-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Measuring the TPM PCR update counter will help the remote attestation
service to validate if there are any missing entries in the IMA log, when
the system goes through certain important state changes (e.g. kexec soft
boot, IMA log snapshotting etc.).  Detecting such missing entries would
help the remote attestation service functionality to be more robust.
It should also help the system administrators with manual investigations
when TPM PCR quotes go out of sync with IMA measurements.

Implement a new function, 'ima_tpm_get_update_counter()', which uses
the 'tpm_pcr_get_update_counter()' function from the TPM driver interface
to retrieve the PCR update counter of the TPM chip in use.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_queue.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..4acd0e5a830f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -167,6 +167,7 @@ void ima_init_template_list(void);
 int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
+int ima_tpm_get_update_counter(u32 *cpu_update_counter);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..38f5c35b23b2 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -135,6 +135,22 @@ unsigned long ima_get_binary_runtime_size(void)
 		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
 }
 
+int ima_tpm_get_update_counter(u32 *update_counter)
+{
+	int result;
+
+	if (!update_counter)
+		return -EINVAL;
+
+	result = tpm_pcr_get_update_counter(ima_tpm_chip,
+				CONFIG_IMA_MEASURE_PCR_IDX, TPM_ALG_SHA1, update_counter);
+
+	if (result != 0)
+		pr_err("Failed to get TPM PCR update counter, result: %d\n", result);
+
+	return result;
+}
+
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 {
 	int result = 0;
-- 
2.25.1

