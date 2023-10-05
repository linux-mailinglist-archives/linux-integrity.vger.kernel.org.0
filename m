Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3A7BA906
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Oct 2023 20:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjJES0Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Oct 2023 14:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjJES0P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Oct 2023 14:26:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42FA198
        for <linux-integrity@vger.kernel.org>; Thu,  5 Oct 2023 11:26:14 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8025220B74C6;
        Thu,  5 Oct 2023 11:26:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8025220B74C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696530373;
        bh=VHNJbkXP2Wry2HZE8GFrjvOrwKghhTsyMpLWbzjkl+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=go0HoJpMCMDS37lqZY/AWEAnteVK7SZ8Pu5nQ+9OUg2hBmxs6KzaThIisRqotOFis
         RgsehbUgEef832IKkBFEMaGEHRUc1jjwNvC6cawb2MJulGBFhV2tKUamXv7PfMrpQZ
         SyjCfFxscPStx+asUk7fVKQFrpf+9cEOHgBHDeDs=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH v2 5/7] ima: suspend measurements while the buffer is being copied during kexec reboot
Date:   Thu,  5 Oct 2023 11:26:00 -0700
Message-Id: <20231005182602.634615-6-tusharsu@linux.microsoft.com>
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

If the new measurements are added to the IMA log while it is being 
being copied to the kexec buffer during kexec 'execute', it can miss
copying those new measurements to the kexec buffer, and the buffer can go
out of sync with TPM PCRs.  This could result in breaking the integrity
of the measurements after the kexec soft reboot to the new Kernel.

Add a check in the ima_add_template_entry() function not to measure
events and return from the function early when 'suspend_ima_measurements'
flag is set.

This ensures the consistency of the IMA measurement list while copying 
them to the kexec buffer.  When the 'suspend_ima_measurements' flag is
set, any new measurements will be ignored until the flag is unset.  This
allows the buffer to be safely copied without worrying about concurrent
modifications to the measurement list.  This is crucial for maintaining
the integrity of the measurements during a kexec soft reboot.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_queue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 9e7d1196006e..498b6b92f3f0 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -194,6 +194,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
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

