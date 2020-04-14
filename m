Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBC61A7A15
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgDNLug (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 07:50:36 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40751 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728476AbgDNLuf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 07:50:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TvX5XkD_1586865020;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TvX5XkD_1586865020)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Apr 2020 19:50:20 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com
Subject: [PATCH] ima: optimize ima_pcr_extend function by asynchronous
Date:   Tue, 14 Apr 2020 19:50:20 +0800
Message-Id: <20200414115020.99288-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Because ima_pcr_extend() to operate the TPM chip, this process is
very time-consuming, for IMA, this is a blocking action, especially
when the TPM is in self test state, this process will block for up
to ten seconds.

Because the return result of ima_pcr_extend() is of no concern to IMA,
it only affects the audit of IMA, so this patch use async_schedule()
to asynchronously perform the ima_pcr_extend() operation and do an
audit operation at the end.

In a vtpm scenario, I added the measure policy of BPRM and MMAP to
compare the efficiency before and after applying the patch. The results
show that the overall startup efficiency of conventional processes can
be increased by 5% to 10%. I believe this efficiency increase It will
be more obvious on real hardware tpm.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/integrity/ima/ima_queue.c | 80 ++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 21 deletions(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 8753212ddb18..12cbf69c2442 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -17,6 +17,7 @@
 
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <linux/async.h>
 #include "ima.h"
 
 #define AUDIT_CAUSE_LEN_MAX 32
@@ -151,6 +152,42 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
 	return result;
 }
 
+struct ima_pcr_extend_async_ctx {
+	struct ima_template_entry *entry;
+	int violation;
+	const char *op;
+	struct inode *inode;
+	const unsigned char *filename;
+	const char *audit_cause;
+	int audit_info;
+	int result;
+};
+
+static void ima_pcr_extend_async(void *data, async_cookie_t cookie)
+{
+	struct ima_pcr_extend_async_ctx *ctx = data;
+	u8 digest[TPM_DIGEST_SIZE];
+	char tpm_audit_cause[AUDIT_CAUSE_LEN_MAX];
+	int result;
+
+	if (ctx->violation)		/* invalidate pcr */
+		memset(digest, 0xff, sizeof(digest));
+	else
+		memcpy(digest, ctx->entry->digest, sizeof(digest));
+
+	result = ima_pcr_extend(digest, ctx->entry->pcr);
+	if (result != 0) {
+		snprintf(tpm_audit_cause, AUDIT_CAUSE_LEN_MAX, "TPM_error(%d)",
+			 result);
+		ctx->audit_cause = tpm_audit_cause;
+		ctx->audit_info = 0;
+	}
+	integrity_audit_msg(AUDIT_INTEGRITY_PCR, ctx->inode, ctx->filename,
+				ctx->op, ctx->audit_cause, ctx->result, ctx->audit_info);
+
+	kfree(ctx);
+}
+
 /*
  * Add template entry to the measurement list and hash table, and
  * extend the pcr.
@@ -163,20 +200,16 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename)
 {
-	u8 digest[TPM_DIGEST_SIZE];
 	const char *audit_cause = "hash_added";
-	char tpm_audit_cause[AUDIT_CAUSE_LEN_MAX];
 	int audit_info = 1;
-	int result = 0, tpmresult = 0;
+	int result = 0;
+	struct ima_pcr_extend_async_ctx *ctx;
 
 	mutex_lock(&ima_extend_list_mutex);
-	if (!violation) {
-		memcpy(digest, entry->digest, sizeof(digest));
-		if (ima_lookup_digest_entry(digest, entry->pcr)) {
-			audit_cause = "hash_exists";
-			result = -EEXIST;
-			goto out;
-		}
+	if (!violation && ima_lookup_digest_entry(entry->digest, entry->pcr)) {
+		audit_cause = "hash_exists";
+		result = -EEXIST;
+		goto out;
 	}
 
 	result = ima_add_digest_entry(entry, 1);
@@ -186,20 +219,25 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		goto out;
 	}
 
-	if (violation)		/* invalidate pcr */
-		memset(digest, 0xff, sizeof(digest));
-
-	tpmresult = ima_pcr_extend(digest, entry->pcr);
-	if (tpmresult != 0) {
-		snprintf(tpm_audit_cause, AUDIT_CAUSE_LEN_MAX, "TPM_error(%d)",
-			 tpmresult);
-		audit_cause = tpm_audit_cause;
-		audit_info = 0;
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		audit_cause = "ENOMEM";
+		result = -ENOMEM;
+		goto out;
 	}
+
+	ctx->entry = entry;
+	ctx->violation = violation;
+	ctx->op = op;
+	ctx->inode = inode;
+	ctx->filename = filename;
+	ctx->audit_cause = audit_cause;
+	ctx->audit_info = audit_info;
+	ctx->result = result;
+	async_schedule(ima_pcr_extend_async, ctx);
+
 out:
 	mutex_unlock(&ima_extend_list_mutex);
-	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
-			    op, audit_cause, result, audit_info);
 	return result;
 }
 
-- 
2.17.1

