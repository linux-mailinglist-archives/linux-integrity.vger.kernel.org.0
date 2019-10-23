Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABEAE0F1B
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 02:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfJWASo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Oct 2019 20:18:44 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45260 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732221AbfJWASZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Oct 2019 20:18:25 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 746FA2010AC4;
        Tue, 22 Oct 2019 17:18:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 746FA2010AC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571789904;
        bh=XMnesZyw0QRVpbTGsE9Hc/rqUu5GYJWuVQuZdKM+XUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlBqLSaBU2u6bMM8N2CJLmtSSyrj8x+DxdgP4YQcrsfxPrZOnClZCgPZOYF2YcAHc
         3ppV4GSQ+xO1NVy1kN7rB4MTn03tNVepQIOL/FALEZqDoaOoHL3eoArCEClDX+gfEL
         zRe+Ml5aK0gq0sJyT3c3XZGCdwsAMuJmUBdQ2lRY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v1 2/6] KEYS: ima: Refactored process_buffer_measurement function so that it can measure any buffer (and not just KEXEC_CMDLINE one)
Date:   Tue, 22 Oct 2019 17:18:14 -0700
Message-Id: <20191023001818.3684-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023001818.3684-1-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement currently supports measuring kexec command line
only. This function has been refactored to support more than kexec_cmdline.
With this change this function can be used for measuring any buffer.
This function is now also used by ima to measure keys besides used for
measuring kexec command line.

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
index 584019728660..8e965d18fb21 100644
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
+	struct ima_template_desc *template_desc = ima_template_desc_current();
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

