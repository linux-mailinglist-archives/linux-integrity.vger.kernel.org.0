Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E87746535
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGCV5V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjGCV5U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 17:57:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24ED0E58
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 14:57:19 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 79AE720C08E7;
        Mon,  3 Jul 2023 14:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79AE720C08E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688421438;
        bh=0H385rr4xvv2DCWeqKIKQV5s1y2DVPMF7eZDISj7L0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSVf05PhU8/5t+iU4STAK+h9lawJ/Oq58BG3TG2kS6zP2adxu0b6vPS9OXmdKU0Qi
         +dmZnQiLTWeTwaYoj4eujuKJIyZjuVFooBOnyXgrCirfaye7sM6tINN5nX/yZbO0QA
         wppF1MNyGYUPQZHZT6gJYp94PHDEJaFPMMU9vEdI=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 03/10] ima: allocate buffer at kexec load to hold ima measurements
Date:   Mon,  3 Jul 2023 14:57:02 -0700
Message-Id: <20230703215709.1195644-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
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

The IMA subsystem needs a dedicated mechanism to reserve extra memory for
measurements added between the kexec 'load' and kexec 'execute'.

Update ima_add_kexec_buffer to allocate a buffer of a sufficient size
taking ima binary runtime measurements size, size of ima_kexec_hdr, and
IMA_KEXEC_EXTRA_SIZE into account.  Adjust the kexec_segment_size to align
to the PAGE_SIZE.  Call ima_allocate_buf_at_kexec_load() to allocate the
buffer.

This patch assumes the extra space defined (IMA_KEXEC_EXTRA_SIZE) is
sufficient to handle the additional measurements.  This should be as per
the system requirements and based on the number of additional measurements
expected during the window from kexec 'load' to kexec 'execute'.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  2 ++
 security/integrity/ima/ima_kexec.c | 21 ++++++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..2ffda9449b9b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -43,6 +43,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
+#define IMA_KEXEC_EXTRA_SIZE (16 * PAGE_SIZE)
+
 /* current content of the policy */
 extern int ima_policy_flag;
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 858b67689701..7deb8df31485 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -188,31 +188,30 @@ void ima_add_kexec_buffer(struct kimage *image)
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
-	 * Reserve an extra half page of memory for additional measurements
-	 * added during the kexec load.
+	 * Reserve extra memory for measurements added in the window from
+	 * kexec 'load' to kexec 'execute'.
 	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
+	binary_runtime_size = ima_get_binary_runtime_size() +
+			      sizeof(struct ima_kexec_hdr) +
+			      IMA_KEXEC_EXTRA_SIZE;
+
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
 		kexec_segment_size = ULONG_MAX;
 	else
-		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
-					   PAGE_SIZE / 2, PAGE_SIZE);
+		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
+
 	if ((kexec_segment_size == ULONG_MAX) ||
 	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
 		pr_err("Binary measurement list too large.\n");
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
-		pr_err("Not enough memory for the kexec measurement buffer.\n");
+	ret = ima_allocate_buf_at_kexec_load();
+	if (ret < 0)
 		return;
-	}
 
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
-- 
2.25.1

