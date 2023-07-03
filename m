Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E266746539
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGCV5X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjGCV5V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 17:57:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEED1E5B
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 80FE920C091F;
        Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80FE920C091F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688421440;
        bh=gnWZBlqyn9Og/TXFeYVjeHamDdASDQOleIS25w3NzJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BP7uwA9Z4rK9VvYzQq/a+oZbqsOSr96N5eD6OztrEuWAGoJF73lvv03v3otvWdi6J
         a/ZcVxEWbMTH8QmHKkaxVKNC5VATJGF3EEgrxGhKni2SM6bhCfKxi/DPZEhLzA+RpE
         CxMBNbGoeEZH0ggjkoRK6QcZwnYEKWCCcuTtutXw=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 09/10] ima: suspend measurements while the kexec buffer is being copied
Date:   Mon,  3 Jul 2023 14:57:08 -0700
Message-Id: <20230703215709.1195644-10-tusharsu@linux.microsoft.com>
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

If the new measurements are added to the list while the kexec buffer is
being copied during kexec execute, the buffer may get corrupted, or it can
go out of sync with TPM PCRs.  This could potentially lead to breaking the
integrity of the measurements after the kexec soft reboot to the new
kernel.

Introduce a check in the ima_add_template_entry function not to measure
events and return from the function early when the suspend_ima_measurements
flag is set.

This ensures the consistency of the IMA measurement list during the copying
of the kexec buffer.  When the suspend_ima_measurements flag is set, any
new measurements will be ignored until the flag is unset.  This allows the
buffer to be safely copied without worrying about concurrent modifications
to the measurement list.  This is crucial for maintaining the integrity of
the measurements during a kexec soft reboot.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_queue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index cb9abc02a304..5946a26a2849 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -195,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		}
 	}
 
+	/*
+	 * suspend_ima_measurements will be set if the system is
+	 * undergoing kexec soft boot to a new kernel.
+	 * suspending measurements in this short window ensures the
+	 * consistency of the IMA measurement list during copying
+	 * of the kexec buffer.
+	 */
+	if (atomic_read(&suspend_ima_measurements)) {
+		audit_cause = "measurements_suspended";
+		audit_info = 0;
+		goto out;
+	}
+
 	result = ima_add_digest_entry(entry,
 				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
 	if (result < 0) {
-- 
2.25.1

