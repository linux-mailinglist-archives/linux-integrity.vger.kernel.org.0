Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF10746532
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 23:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjGCV5U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGCV5T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 17:57:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB9619F
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 14:57:18 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id BB30520AECBD;
        Mon,  3 Jul 2023 14:57:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB30520AECBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688421437;
        bh=eQiDdiGszFkOMDk1+HM/N9CWYJ7B5kMdxIp/HrxE+hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkEH6GqHefQ3IMcFxi9qEcIzWzVymw0R8WlJWcRaLzDQrMAjoC4b12i7FO/gs3Nzr
         tza0yGt9YBhhvrbxELq/kXt4VgnxfcI8HX3H1pLpDPSoBRClFRIMtpfgOgv9Xywlh0
         rTaUj84l6vax9yjdp1eGP5a8jYR2XwaWm7FworH8=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 01/10] ima: implement function to allocate buffer at kexec load
Date:   Mon,  3 Jul 2023 14:57:00 -0700
Message-Id: <20230703215709.1195644-2-tusharsu@linux.microsoft.com>
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

IMA does not provide a mechanism to allocate memory for IMA log storage
during kexec operation.  The function should handle the scenario where
the kexec load is called multiple times. 

Implement a function to allocate buffer of size kexec_segment_size at
kexec load.  If the buffer was already allocated, free that buffer and
reallocate.  Finally, initialize ima_khdr struct. 

The patch operates under the assumption that the segment size does not
change between kexec load and execute.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 419dc405c831..48a683874044 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,6 +15,53 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+struct seq_file ima_kexec_file;
+struct ima_kexec_hdr ima_khdr;
+static size_t kexec_segment_size;
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
+static int ima_allocate_buf_at_kexec_load(void)
+{
+	if ((kexec_segment_size == 0) ||
+	    (kexec_segment_size == ULONG_MAX) ||
+	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
+		pr_err("%s: Invalid segment size for kexec: %zu\n",
+			__func__, kexec_segment_size);
+		return -EINVAL;
+	}
+
+	/* if kexec load was called before, clear the existing buffer
+	 *  before allocating a new one
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
-- 
2.25.1

