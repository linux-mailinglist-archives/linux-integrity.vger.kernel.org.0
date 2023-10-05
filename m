Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEEB7BA903
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Oct 2023 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJES0O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Oct 2023 14:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJES0O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Oct 2023 14:26:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BAC59E
        for <linux-integrity@vger.kernel.org>; Thu,  5 Oct 2023 11:26:12 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id CDEC620B74C2;
        Thu,  5 Oct 2023 11:26:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDEC620B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696530371;
        bh=JzbNPfP8rsA3zKDRhrHM4A1C1P+3asNcarWREnGnRqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAWgvyqCkGSAPglJFh8N+rB6X3OLX3+25r6mswkyyU3LlPgeqMJULubtEi+XYH080
         76C1abZgZuKZACBOL7bLU3RYW7+3pPGptw0qBhAnISnh0XYPzSxQ2U697FoxWQgJ3e
         LwVe5SpHqYjwZh1BOKApY6djAo8sMhnNbRmRR90k=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move memory allocation to a separate function
Date:   Thu,  5 Oct 2023 11:25:56 -0700
Message-Id: <20231005182602.634615-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA allocates memory and dumps the measurement during kexec soft reboot
as a single function call ima_dump_measurement_list().  It gets called
during kexec 'load' operation.  It results in the IMA measurements
between the window of kexec 'load' and 'execute' getting dropped when the
system boots into the new Kernel.  One of the kexec requirements is the
segment size cannot change between the 'load' and the 'execute'.
Therefore, to address this problem, ima_dump_measurement_list() needs
to be refactored to allocate the memory at kexec 'load', and dump the
measurements at kexec 'execute'.  The function that allocates the memory
should handle the scenario where the kexec load is called multiple times.

Refactor ima_dump_measurement_list() to move the memory allocation part
to a separate function ima_alloc_kexec_buf() to allocate buffer of size
'kexec_segment_size' at kexec 'load'.  Make the local variables in
function ima_dump_measurement_list() global, so that they can be accessed
from ima_alloc_kexec_buf().  Make necessary changes to the function
ima_add_kexec_buffer() to call the above two functions.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 126 +++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 33 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 419dc405c831..307e07991865 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,61 +15,114 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+struct seq_file ima_kexec_file;
+struct ima_kexec_hdr ima_khdr;
+
+void ima_clear_kexec_file(void)
+{
+	vfree(ima_kexec_file.buf);
+	ima_kexec_file.buf = NULL;
+	ima_kexec_file.size = 0;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = 0;
+}
+
+static int ima_alloc_kexec_buf(size_t kexec_segment_size)
+{
+	if ((kexec_segment_size == 0) ||
+	    (kexec_segment_size == ULONG_MAX) ||
+	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
+		pr_err("%s: Invalid segment size for kexec: %zu\n",
+			__func__, kexec_segment_size);
+		return -EINVAL;
+	}
+
+	/*
+	 * If kexec load was called before, clear the existing buffer
+	 * before allocating a new one
+	 */
+	if (ima_kexec_file.buf)
+		ima_clear_kexec_file();
+
+	/* segment size can't change between kexec load and execute */
+	ima_kexec_file.buf = vmalloc(kexec_segment_size);
+	if (!ima_kexec_file.buf) {
+		pr_err("%s: No memory for ima kexec measurement buffer\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ima_kexec_file.size = kexec_segment_size;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(ima_khdr);	/* reserved space */
+
+	memset(&ima_khdr, 0, sizeof(ima_khdr));
+	ima_khdr.version = 1;
+
+	return 0;
+}
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
 	struct ima_queue_entry *qe;
-	struct seq_file file;
-	struct ima_kexec_hdr khdr;
 	int ret = 0;
 
-	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
-		ret = -ENOMEM;
-		goto out;
+	if (!ima_kexec_file.buf) {
+		pr_err("%s: Kexec file buf not allocated\n",
+			__func__);
+		return -EINVAL;
 	}
 
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
+	/*
+	 * Ensure the kexec buffer is large enough to hold ima_khdr
+	 */
+	if (ima_kexec_file.size < sizeof(ima_khdr)) {
+		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
+			__func__);
+		ima_clear_kexec_file();
+		return -ENOMEM;
+	}
 
-	memset(&khdr, 0, sizeof(khdr));
-	khdr.version = 1;
+	/*
+	 * If we reach here, then there is enough memory
+	 * of size kexec_segment_size in ima_kexec_file.buf
+	 * to copy at least partial IMA log.
+	 * Make best effort to copy as many IMA measurements
+	 * as possible.
+	 */
 	list_for_each_entry_rcu(qe, &ima_measurements, later) {
-		if (file.count < file.size) {
-			khdr.count++;
-			ima_measurements_show(&file, qe);
+		if (ima_kexec_file.count < ima_kexec_file.size) {
+			ima_khdr.count++;
+			ima_measurements_show(&ima_kexec_file, qe);
 		} else {
-			ret = -EINVAL;
+			ret = EFBIG;
+			pr_err("%s: IMA log file is too big for Kexec buf\n",
+				__func__);
 			break;
 		}
 	}
 
-	if (ret < 0)
-		goto out;
-
 	/*
 	 * fill in reserved space with some buffer details
 	 * (eg. version, buffer size, number of measurements)
 	 */
-	khdr.buffer_size = file.count;
+	ima_khdr.buffer_size = ima_kexec_file.count;
 	if (ima_canonical_fmt) {
-		khdr.version = cpu_to_le16(khdr.version);
-		khdr.count = cpu_to_le64(khdr.count);
-		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
+		ima_khdr.version = cpu_to_le16(ima_khdr.version);
+		ima_khdr.count = cpu_to_le64(ima_khdr.count);
+		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
 	}
-	memcpy(file.buf, &khdr, sizeof(khdr));
+	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
 
 	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
-			     file.buf, file.count < 100 ? file.count : 100,
+			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
+			     ima_kexec_file.count : 100,
 			     true);
 
-	*buffer_size = file.count;
-	*buffer = file.buf;
-out:
-	if (ret == -EINVAL)
-		vfree(file.buf);
+	*buffer_size = ima_kexec_file.count;
+	*buffer = ima_kexec_file.buf;
+
 	return ret;
 }
 
@@ -108,13 +161,20 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
+	ret = ima_alloc_kexec_buf(kexec_segment_size);
+	if (ret < 0) {
 		pr_err("Not enough memory for the kexec measurement buffer.\n");
 		return;
 	}
 
+	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
+					kexec_segment_size);
+	if (ret < 0) {
+		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
+		       __func__, ret);
+		return;
+	}
+
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
-- 
2.25.1

