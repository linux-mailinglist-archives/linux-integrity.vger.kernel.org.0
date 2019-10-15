Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79846D833A
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 00:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbfJOWF3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 18:05:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58478 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389074AbfJOWF3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 18:05:29 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5185920B7116;
        Tue, 15 Oct 2019 15:05:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5185920B7116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571177128;
        bh=HhXECfxN0vflH1yC5lzMuZZbRFDnKd5yxw+GpVfeLDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaJuIaoqbElAZU9i7m8BkwW+1WEehVN853F1kHXKbK8acj/OhXde6Ksr59mJNCSXP
         yL6Y4TCjLv7anbgmCUG1WDp28BtPCYb0K6ZD7IULV3MmJrUx6EgD38+9YCjyiNZcp2
         50Vp2FfJ5knSBbQd0wK10y5Lm722o/J5Y1XqQlQA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, prsriva@linux.microsoft.com
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v0 1/1] ima: Refactor process_buffer_measurement() to make it generic
Date:   Tue, 15 Oct 2019 15:05:24 -0700
Message-Id: <20191015220524.20659-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015220524.20659-1-nramas@linux.microsoft.com>
References: <20191015220524.20659-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch makes the function process_buffer_measurement() generic so that
it can be used to measure more than just the KEXEC_CMDLINE. This function
will also be used for measuring keys, blacklisted binaries, etc.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h      |  3 +++
 security/integrity/ima/ima_main.c | 29 ++++++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 011b91c79351..b6847ee1f47a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -209,6 +209,9 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, int pcr,
 			   struct ima_template_desc *template_desc);
+void process_buffer_measurement(const void *buf, int size,
+				const char *eventname, int pcr,
+				struct ima_template_desc *template_desc);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 584019728660..3d5ce4fd4dcc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -610,14 +610,14 @@ int ima_load_data(enum kernel_load_data_id id)
  * @buf: pointer to the buffer that needs to be added to the log.
  * @size: size of buffer(in bytes).
  * @eventname: event name to be used for the buffer entry.
- * @cred: a pointer to a credentials structure for user validation.
- * @secid: the secid of the task to be validated.
+ * @pcr: pcr to extend the measurement
+ * @template_desc: template description
  *
  * Based on policy, the buffer is measured into the ima log.
  */
-static void process_buffer_measurement(const void *buf, int size,
-				       const char *eventname,
-				       const struct cred *cred, u32 secid)
+void process_buffer_measurement(const void *buf, int size,
+				const char *eventname, int pcr,
+				struct ima_template_desc *template_desc)
 {
 	int ret = 0;
 	struct ima_template_entry *entry = NULL;
@@ -626,19 +626,11 @@ static void process_buffer_measurement(const void *buf, int size,
 					    .filename = eventname,
 					    .buf = buf,
 					    .buf_len = size};
-	struct ima_template_desc *template_desc = NULL;
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash = {};
 	int violation = 0;
-	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
-	int action = 0;
-
-	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
-				&template_desc);
-	if (!(action & IMA_MEASURE))
-		return;
 
 	iint.ima_hash = &hash.hdr;
 	iint.ima_hash->algo = ima_hash_algo;
@@ -670,12 +662,19 @@ static void process_buffer_measurement(const void *buf, int size,
  */
 void ima_kexec_cmdline(const void *buf, int size)
 {
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct ima_template_desc *template_desc = NULL;
+	int action;
 	u32 secid;
 
 	if (buf && size != 0) {
 		security_task_getsecid(current, &secid);
-		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   current_cred(), secid);
+		action = ima_get_action(NULL, current_cred(), secid, 0,
+					KEXEC_CMDLINE, &pcr, &template_desc);
+		if (!(action & IMA_MEASURE))
+			return;
+		process_buffer_measurement(buf, size, "kexec-cmdline", pcr,
+					   template_desc);
 	}
 }
 
-- 
2.17.1
