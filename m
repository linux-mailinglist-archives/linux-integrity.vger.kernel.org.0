Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE22746537
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjGCV5W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGCV5V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 17:57:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FB7419F
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7CA1D20C08FA;
        Mon,  3 Jul 2023 14:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CA1D20C08FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688421439;
        bh=s53o5tStuuzSkUcgt//18WizvpReGbqU0p1e6vxSELk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKUiDnfO8rTW9XniYBxK6bcBKeUB7OG4DIMTLeqWsCfgpxo6RMHKMPK3pWy5Ggpdn
         bPVR4XczWaRXt1vP99+fAVRj1whR62d8PeYpjATVYJ8sW7C3i3H0ow4UTQICKeacxa
         MuVvIxxVmLgBEOSKeOZJAzTMmQCESWcd0FC/yMqw=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 06/10] ima: update buffer at kexec execute with ima measurements
Date:   Mon,  3 Jul 2023 14:57:05 -0700
Message-Id: <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
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

In the current implementation, the measurement list is not updated in the
buffer during the window between kexec load and execute.  This leads to
measurement loss in the buffer when transitioning from the old to the new
kernel.  This patch provides a way to update the measurement list in the
buffer during a kexec execution.  Suspending the measurements during the
buffer update ensures the buffer doesn't get corrupted, or goes out of
sync with TPM PCRs. Thus it ensures the integrity of measurements is
maintained across kernel transitions during a kexec.

Introduce a new variable ima_kexec_buffer that is used to hold the address
of the IMA kexec buffer.

Implement a function ima_update_kexec_buffer() that is called during
kexec execute, allowing the IMA to update the measurement list with the
events between kexec load and execute.  First check if a kexec is in
progress and if the IMA kexec buffer is initialized.  If these conditions
are met, suspend IMA measurements and check if the new buffer size obtained
from ima_get_binary_runtime_size() is larger than the current buffer size.
If the new buffer size is too large, output an error message, and resume
the measurements.

If the new buffer size fits, populate the new buffer with the current
measurements using ima_populate_buf_at_kexec_execute() and copy it into
ima_kexec_buffer.

Unmap ima_kexec_buffer segment from the image.  Resuming the measurements
is not needed in case of successful measurements since the control is being
passed to the new kernel anyways through kexec execute.  However, the
measurements should be resumed if there are any errors flagged in the
function.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 7deb8df31485..224d88ccfe85 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -18,6 +18,7 @@
 struct seq_file ima_kexec_file;
 struct ima_kexec_hdr ima_khdr;
 static size_t kexec_segment_size;
+static void *ima_kexec_buffer;
 
 void ima_clear_kexec_file(void)
 {
@@ -230,6 +231,55 @@ void ima_add_kexec_buffer(struct kimage *image)
 	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		 kbuf.mem);
 }
+
+/*
+ * Called during kexec execute so that IMA can update the measurement list.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
+	void *new_buffer = NULL;
+	size_t new_buffer_size, cur_buffer_size;
+	bool resume = false;
+
+	if (!kexec_in_progress) {
+		pr_info("%s: No kexec in progress.\n", __func__);
+		return NOTIFY_OK;
+	}
+
+	if (!ima_kexec_buffer) {
+		pr_err("%s: Kexec buffer not set.\n", __func__);
+		return NOTIFY_OK;
+	}
+
+	ima_measurements_suspend();
+
+	cur_buffer_size = kexec_segment_size - sizeof(struct ima_kexec_hdr);
+	new_buffer_size = ima_get_binary_runtime_size();
+	if (new_buffer_size > cur_buffer_size) {
+		pr_err("%s: Measurement list grew too large.\n", __func__);
+		resume = true;
+		goto out;
+	}
+
+	ima_populate_buf_at_kexec_execute(&new_buffer_size, &new_buffer);
+
+	if (!new_buffer) {
+		pr_err("%s: Dump measurements failed.\n", __func__);
+		resume = true;
+		goto out;
+	}
+	memcpy(ima_kexec_buffer, new_buffer, new_buffer_size);
+out:
+	kimage_unmap_segment(ima_kexec_buffer);
+	ima_kexec_buffer = NULL;
+
+	if (resume)
+		ima_measurements_resume();
+
+	return NOTIFY_OK;
+}
+
 #endif /* IMA_KEXEC */
 
 /*
-- 
2.25.1

