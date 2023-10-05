Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EF57BA908
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Oct 2023 20:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjJES0Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Oct 2023 14:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjJES0P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Oct 2023 14:26:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A61D69E
        for <linux-integrity@vger.kernel.org>; Thu,  5 Oct 2023 11:26:14 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id 261C320B74C7;
        Thu,  5 Oct 2023 11:26:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 261C320B74C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696530374;
        bh=8DnZqCRLNl2kH912XJt+JUclDDYq4fKWT4+5FgK5Duw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2PI4GCwKQxYpriwcXUCTi9/ezNh0cgu0fXOh1iGEhpLBtzp1+sGIc/XItOPZMIPa
         JscSayHolG3wD/1ah2wKfuhJegtnChjdXsHkk8a81PNU1rjDbCGNCkGQtMHb0522mG
         gFyoRjBookAHHwQPwok5P3wOrm73/P+dT1G8Xx8s=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH v2 6/7] ima: make the memory for events between kexec load and exec configurable
Date:   Thu,  5 Oct 2023 11:26:01 -0700
Message-Id: <20231005182602.634615-7-tusharsu@linux.microsoft.com>
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

IMA currently allocates half a PAGE_SIZE for the extra events that would
be measured between kexec 'load' and 'execute'.  Depending on the IMA
policy and the system state, that memory may not be sufficient to hold
the extra IMA events measured after kexec 'load'.  The memory
requirements vary from system to system and they should be configurable.

Define a Kconfig option, IMA_KEXEC_EXTRA_PAGES, to configure the number
of extra pages to be allocated for IMA measurements added in the window
from kexec 'load' to kexec 'execute'.

Update ima_add_kexec_buffer() function to allocate memory based on the 
Kconfig option value, rather than the currently hardcoded one.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/Kconfig     |  9 +++++++++
 security/integrity/ima/ima_kexec.c | 13 ++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 60a511c6b583..1b55cd2bcb36 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
 	default n
 	help
 	   This option disables htable to allow measurement of duplicate records.
+
+config IMA_KEXEC_EXTRA_PAGES
+	int
+	depends on IMA && IMA_KEXEC
+	default 16
+	help
+	  IMA_KEXEC_EXTRA_PAGES determines the number of extra
+	  pages to be allocated for IMA measurements added in the
+	  window from kexec 'load' to kexec 'execute'.
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 13fbbb90319b..6cd5f46a7208 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -150,15 +150,18 @@ void ima_add_kexec_buffer(struct kimage *image)
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
+			      (CONFIG_IMA_KEXEC_EXTRA_PAGES * PAGE_SIZE);
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
-- 
2.25.1

