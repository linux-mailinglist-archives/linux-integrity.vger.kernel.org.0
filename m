Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C71F5F08
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 02:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgFKAEH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Jun 2020 20:04:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52026 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgFKAEG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Jun 2020 20:04:06 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 88F7920B477A;
        Wed, 10 Jun 2020 17:04:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88F7920B477A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591833845;
        bh=JTp5VB2LuDwbQnkCAtdVN5+foPZ/TM+uqTMRD/QSb5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZ1JBd6CHohPDlJ53aKQb5IsMqN5q/qAhXcEbNjBGZoq/bqBJag1QtmAV8s75UQpb
         rKpi98kpyoI9Y1OvCbJvWAkrrLZIKICh3p0DTjn4t5V1FDe4TBWm8Q97mK6y3OZaYM
         bSFROvclZz87DGlCBV/0+pd1h0rdIrBjVVZ1fcFE=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] IMA: Add audit log for failure conditions
Date:   Wed, 10 Jun 2020 17:04:00 -0700
Message-Id: <20200611000400.3771-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611000400.3771-1-nramas@linux.microsoft.com>
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The final log statement in process_buffer_measurement() for failure
condition is at debug level. This does not log the message unless
the system log level is raised which would significantly increase
the messages in the system log. Change this to an audit message to
audit integrity failures with the "op" field of the audit message
set to indicate the measurement operation that failed.

Also, add an audit message for failures in ima_alloc_key_entry().

Sample audit messages:

[    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=measuring_kexec_cmdline cause=alloc_entry errno=-12 comm="swapper/0" name="kexec-cmdline" res=0

[    8.017126] audit: type=1804 audit(1591756725.360:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=measuring_key cause=hashing_error errno=-22 comm="systemd" name=".builtin_trusted_keys" res=0

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h            | 48 ++++++++++++++++---------
 security/integrity/ima/ima_main.c       | 18 +++++++---
 security/integrity/ima/ima_policy.c     |  2 +-
 security/integrity/ima/ima_queue_keys.c |  5 +++
 4 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df93ac258e01..e42101eebd69 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -186,27 +186,43 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	return (digest[0] | digest[1] << 8) % IMA_MEASURE_HTABLE_SIZE;
 }
 
-#define __ima_hooks(hook)		\
-	hook(NONE)			\
-	hook(FILE_CHECK)		\
-	hook(MMAP_CHECK)		\
-	hook(BPRM_CHECK)		\
-	hook(CREDS_CHECK)		\
-	hook(POST_SETATTR)		\
-	hook(MODULE_CHECK)		\
-	hook(FIRMWARE_CHECK)		\
-	hook(KEXEC_KERNEL_CHECK)	\
-	hook(KEXEC_INITRAMFS_CHECK)	\
-	hook(POLICY_CHECK)		\
-	hook(KEXEC_CMDLINE)		\
-	hook(KEY_CHECK)			\
-	hook(MAX_CHECK)
-#define __ima_hook_enumify(ENUM)	ENUM,
+#define __ima_hooks(hook)				\
+	hook(NONE, none)				\
+	hook(FILE_CHECK, file)				\
+	hook(MMAP_CHECK, mmap)				\
+	hook(BPRM_CHECK, bprm)				\
+	hook(CREDS_CHECK, creds)			\
+	hook(POST_SETATTR, post_setattr)		\
+	hook(MODULE_CHECK, module)			\
+	hook(FIRMWARE_CHECK, firmware)			\
+	hook(KEXEC_KERNEL_CHECK, kexec_kernel)		\
+	hook(KEXEC_INITRAMFS_CHECK, kexec_initramfs)	\
+	hook(POLICY_CHECK, policy)			\
+	hook(KEXEC_CMDLINE, kexec_cmdline)		\
+	hook(KEY_CHECK, key)				\
+	hook(MAX_CHECK, none)
+
+#define __ima_hook_enumify(ENUM, str)	ENUM,
+#define __ima_stringify(arg) (#arg)
+#define __ima_hook_measuring_stringify(ENUM, str) \
+		(__ima_stringify(measuring_ ##str)),
 
 enum ima_hooks {
 	__ima_hooks(__ima_hook_enumify)
 };
 
+static const char * const ima_hooks_measure_str[] = {
+	__ima_hooks(__ima_hook_measuring_stringify)
+};
+
+static inline const char *ima_hooks_func_measure_str(enum ima_hooks func)
+{
+	if (func >= MAX_CHECK)
+		return ima_hooks_measure_str[NONE];
+
+	return ima_hooks_measure_str[func];
+}
+
 extern const char *const func_tokens[];
 
 struct modsig;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 800fb3bba418..114b0699fb02 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -739,6 +739,7 @@ void process_buffer_measurement(const void *buf, int size,
 				int pcr, const char *keyring)
 {
 	int ret = 0;
+	const char *audit_cause = "ENOMEM";
 	struct ima_template_entry *entry = NULL;
 	struct integrity_iint_cache iint = {};
 	struct ima_event_data event_data = {.iint = &iint,
@@ -793,21 +794,28 @@ void process_buffer_measurement(const void *buf, int size,
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
 	if (ret < 0)
-		pr_devel("%s: failed, result: %d\n", __func__, ret);
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, eventname,
+				    ima_hooks_func_measure_str(func),
+				    audit_cause, ret, 0);
 
 	return;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e493063a3c34..66aa3e17a888 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1414,7 +1414,7 @@ void ima_delete_rules(void)
 	}
 }
 
-#define __ima_hook_stringify(str)	(#str),
+#define __ima_hook_stringify(func, str)	(#func),
 
 const char *const func_tokens[] = {
 	__ima_hooks(__ima_hook_stringify)
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index cb3e3f501593..f1105e0b8eef 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -68,6 +68,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 						 size_t payload_len)
 {
 	int rc = 0;
+	const char *audit_cause = "ENOMEM";
 	struct ima_key_entry *entry;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -88,6 +89,10 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 
 out:
 	if (rc) {
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
+				    keyring->description,
+				    ima_hooks_func_measure_str(KEY_CHECK),
+				    audit_cause, rc, 0);
 		ima_free_key_entry(entry);
 		entry = NULL;
 	}
-- 
2.27.0

