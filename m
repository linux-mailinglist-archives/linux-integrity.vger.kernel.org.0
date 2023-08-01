Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2E76BC27
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjHASTc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 14:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjHASTa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 14:19:30 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 043C02139
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 11:19:29 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 33332238AEA4;
        Tue,  1 Aug 2023 11:19:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33332238AEA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690913968;
        bh=MpKvOwQMNEthm2QKriOvs4GtmxKmM80/6fFiBHzjinA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2ixVQ8WDavWmb+L174cjCs5Oh4eGgvJ8wIlmbnuQzZNuZpNBga2zJvkWBJ3C4IYX
         ng1eik6dzuZAS5s8CGmo4wnjJswaoxangJ51BJQ8Y2NZ3uQY30kEp53c29LMT7VH3Y
         u/59mDYN34L+bPtgD/CYnB/doawJcGKAJZTahS1M=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 4/6] ima: implement functionality to measure TPM update counter
Date:   Tue,  1 Aug 2023 11:19:15 -0700
Message-Id: <20230801181917.8535-5-tusharsu@linux.microsoft.com>
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

Currently TPM update counter is not available external to the system,
for instance, a remote attestation service.  It is a problem because
the service cannot easily determine if the IMA log entries are missing.
The IMA functionality needs to be extended to measure the TPM update
counter from various subsystems in Linux kernel to help detect if
the IMA log entries are missing.

Implement a function, 'ima_measure_update_counter()' which would retrieve
the TPM update counter using the previously defined function
'ima_tpm_get_update_counter()'.  Format it as a string with the value 
"update_counter=<N>;", and measure it using the function
'ima_measure_critical_data()'.

The function takes an event name as input, and the update counter value
is measured as part of this event.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/ima.h               |  1 +
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 86b57757c7b1..f15f3a6a4c72 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -40,6 +40,7 @@ extern int ima_measure_critical_data(const char *event_label,
 				     const char *event_name,
 				     const void *buf, size_t buf_len,
 				     bool hash, u8 *digest, size_t digest_len);
+int ima_measure_update_counter(const char *event_name);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4acd0e5a830f..5484bd362237 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -168,6 +168,7 @@ int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
 int ima_tpm_get_update_counter(u32 *cpu_update_counter);
+int ima_measure_update_counter(const char *event_name);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d66a0a36415e..1bcd45cc5a6a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1071,6 +1071,34 @@ int ima_measure_critical_data(const char *event_label,
 }
 EXPORT_SYMBOL_GPL(ima_measure_critical_data);
 
+#define IMA_TPM_UPDATE_CTR_BUF_SIZE 128
+int ima_measure_update_counter(const char *event_name)
+{
+	int result;
+	u32 update_counter = 0;
+	char buf[IMA_TPM_UPDATE_CTR_BUF_SIZE];
+	int buf_len;
+
+	if (!event_name)
+		return -ENOPARAM;
+
+	result = ima_tpm_get_update_counter(&update_counter);
+
+	if (result != 0)
+		return result;
+
+	scnprintf(buf, IMA_TPM_UPDATE_CTR_BUF_SIZE, "update_counter=%u;",
+			  update_counter);
+
+	buf_len = strlen(buf);
+
+	result = ima_measure_critical_data("tpm_pcr_update_counter", event_name,
+				  buf, buf_len, false, NULL, 0);
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(ima_measure_update_counter);
+
 static int __init init_ima(void)
 {
 	int error;
-- 
2.25.1

