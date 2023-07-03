Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28AA74653A
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGCV5Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjGCV5V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 17:57:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C90FFE58
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2E33320C0900;
        Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E33320C0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688421440;
        bh=jZlpyLIYjpWzttcfW8imXFANOTtzePBpV7z2w9ly2cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4ET/YXnwrZx/o2zwb9WVbHnUdn87s3v7wBVX1I4GI2yGxfzfGu27/Qcx2h9bZ58S
         LUhgYEaI0/x9n4hf0sISkKDkLwUCr+w2deOIKfDcfpdheYuW0KrfEfJWUTPTxyMIDv
         too7lIzFyrO4Oh7y1MBFrJoyBx2yKoDc/D8zXIwI=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 08/10] ima: implement and register a reboot notifier function to update kexec buffer
Date:   Mon,  3 Jul 2023 14:57:07 -0700
Message-Id: <20230703215709.1195644-9-tusharsu@linux.microsoft.com>
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

The IMA subsystem needs to ensure that the measurement list is up to date
during a kexec operation, i.e., when the kernel is rebooted without going
through the full system reboot process. Currently, there is no mechanism
to update the measurement list when the system is soft booted using kexec.

Add a notifier function ima_update_kexec_buffer that is called during a
kexec soft reboot.  Implement ima_kexec_post_load, which maps the IMA
buffer after a kexec load and registers the reboot notifier.

Define a new notifier block update_buffer_nb, with ima_update_kexec_buffer
as its notifier function.  Register the notifier function in
ima_kexec_post_load if it hasn't been already, indicated by the
ima_kexec_update_registered flag.

When a kexec soft reboot is triggered, ima_update_kexec_buffer will be
executed to update the IMA buffer.  This ensures that the events between
kexec 'load' and 'execute' are captured and integrity of measurements
remains intact across kexec reboots.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/ima.h                |  3 +++
 security/integrity/ima/ima_kexec.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 86b57757c7b1..006db20f852d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -49,6 +49,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
+extern void ima_kexec_post_load(struct kimage *image);
+#else
+static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
 
 #else
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 424930085c18..363c107dc4a5 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,6 +12,8 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/reboot.h>
+#include <asm/page.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
@@ -19,6 +21,7 @@ struct seq_file ima_kexec_file;
 struct ima_kexec_hdr ima_khdr;
 static size_t kexec_segment_size;
 static void *ima_kexec_buffer;
+static bool ima_kexec_update_registered;
 
 void ima_clear_kexec_file(void)
 {
@@ -222,6 +225,38 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
+struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+};
+
+/*
+ * Create a mapping for the source pages that contain the IMA buffer
+ * so we can update it later.
+ */
+void ima_kexec_post_load(struct kimage *image)
+{
+	if (ima_kexec_buffer) {
+		kimage_unmap_segment(ima_kexec_buffer);
+		ima_kexec_buffer = NULL;
+	}
+
+	if (!image->ima_buffer_addr)
+		return;
+
+	ima_kexec_buffer = kimage_map_segment(image,
+					      image->ima_buffer_addr,
+					      image->ima_buffer_size);
+	if (!ima_kexec_buffer) {
+		pr_err("%s: Could not map measurements buffer.\n", __func__);
+		return;
+	}
+
+	if (!ima_kexec_update_registered) {
+		register_reboot_notifier(&update_buffer_nb);
+		ima_kexec_update_registered = true;
+	}
+}
+
 #endif /* IMA_KEXEC */
 
 /*
-- 
2.25.1

