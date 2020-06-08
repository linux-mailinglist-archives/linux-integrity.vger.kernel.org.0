Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7901F21A3
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2020 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgFHVxt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jun 2020 17:53:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41658 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgFHVxt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jun 2020 17:53:49 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2885D20B717B;
        Mon,  8 Jun 2020 14:53:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2885D20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591653228;
        bh=xc2Cr5Aohy9MgGfLPpnVpGSQbatWni8qwfQ89wE0oIM=;
        h=From:To:Cc:Subject:Date:From;
        b=VSpg9qrBKfCgAMHGahpi4/S7yxgM50HxOkFqUt8A36BBQXm2iuiMrWeiLqr0o0i/J
         7a2voa1QrwWey/8Q7acuzusWc/dgJ1hvYbid5bOel0EibtPvnlDJ9xGDi40dZJPdDN
         31tHWyOAcGAd4AeoUCwS/5qaR8Gwz0ulb2UdgNH0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] IMA: Add audit log for failure conditions
Date:   Mon,  8 Jun 2020 14:53:43 -0700
Message-Id: <20200608215343.4491-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The final log statement in process_buffer_measurement() for failure
condition is at debug level. This does not log the message unless
the system log level is raised which would significantly increase
the messages in the system log. Change this log message to an audit
message for better triaging failures in the function.

ima_alloc_key_entry() does not log a message for failure condition.
Add an audit message for failure condition in this function.

Sample audit messages:

[    8.051937] audit: type=1804 audit(1591633422.365:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=measuring_keys cause=hashing_error(-22) comm="systemd" name=".builtin_trusted_keys" res=0

[    8.063218] audit: type=1804 audit(1591633422.377:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=measuring_kexec_cmdline cause=alloc_entry(-12) comm="systemd" name="kexec-cmdline" res=0

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h            |  2 ++
 security/integrity/ima/ima_main.c       | 37 +++++++++++++++++++++----
 security/integrity/ima/ima_queue.c      |  2 --
 security/integrity/ima/ima_queue_keys.c |  4 +++
 4 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df93ac258e01..8a47249c6238 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -47,6 +47,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
+#define AUDIT_CAUSE_LEN_MAX 32
+
 /* current content of the policy */
 extern int ima_policy_flag;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 800fb3bba418..b10f09bc7eca 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -739,6 +739,9 @@ void process_buffer_measurement(const void *buf, int size,
 				int pcr, const char *keyring)
 {
 	int ret = 0;
+	const char *audit_cause = "ENOMEM";
+	const char *op = "measuring_keys";
+	char measurement_audit_cause[AUDIT_CAUSE_LEN_MAX];
 	struct ima_template_entry *entry = NULL;
 	struct integrity_iint_cache iint = {};
 	struct ima_event_data event_data = {.iint = &iint,
@@ -793,21 +796,43 @@ void process_buffer_measurement(const void *buf, int size,
 	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
 
 	ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
-	if (ret < 0)
+	if (ret < 0) {
+		audit_cause = "hashing_error";
 		goto out;
+	}
 
 	ret = ima_alloc_init_template(&event_data, &entry, template);
-	if (ret < 0)
+	if (ret < 0) {
+		audit_cause = "alloc_entry";
 		goto out;
+	}
 
 	ret = ima_store_template(entry, violation, NULL, buf, pcr);
-
-	if (ret < 0)
+	if (ret < 0) {
+		audit_cause = "store_entry";
 		ima_free_template_entry(entry);
+	}
 
 out:
-	if (ret < 0)
-		pr_devel("%s: failed, result: %d\n", __func__, ret);
+	if (ret < 0) {
+		snprintf(measurement_audit_cause, AUDIT_CAUSE_LEN_MAX,
+			 "%s(%d)", audit_cause, ret);
+
+		switch (func) {
+		case KEXEC_CMDLINE:
+			op = "measuring_kexec_cmdline";
+			break;
+		case KEY_CHECK:
+			op = "measuring_keys";
+			break;
+		default:
+			op = "measuring_blacklisted_hash";
+			break;
+		}
+
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, eventname,
+				    op, measurement_audit_cause, ret, 0);
+	}
 
 	return;
 }
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index fb4ec270f620..4a761d765c6c 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -19,8 +19,6 @@
 #include <linux/slab.h>
 #include "ima.h"
 
-#define AUDIT_CAUSE_LEN_MAX 32
-
 /* pre-allocated array of tpm_digest structures to extend a PCR */
 static struct tpm_digest *digests;
 
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index cb3e3f501593..4de31ff172aa 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -68,6 +68,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 						 size_t payload_len)
 {
 	int rc = 0;
+	const char *audit_cause = "ENOMEM";
 	struct ima_key_entry *entry;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -88,6 +89,9 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 
 out:
 	if (rc) {
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
+				    keyring->description, "measuring_keys",
+				    audit_cause, rc, 0);
 		ima_free_key_entry(entry);
 		entry = NULL;
 	}
-- 
2.27.0

