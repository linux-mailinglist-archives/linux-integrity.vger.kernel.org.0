Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00392552DA
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 03:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgH1B5t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 21:57:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38460 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1B5U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 21:57:20 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id ADBF520B36E7;
        Thu, 27 Aug 2020 18:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ADBF520B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598579839;
        bh=o9Z9QfzzzN11WX4/gSUa5n5ylZI8mL1EV7qAQIWMWHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=so+9OqKEkkfmC9UVTYeX2PUcF/rvRkDODMg9H5BMwOwZ6fX57DQ1MyqZZImv4hhep
         cEUzyzlAH846QPaB0sNfr8GQBXwUNy6TMYBr6igKmgEdrrHsAHiBqCQkc03UilDZPW
         YsnojcjvqrucDpk7YCJunJi6hIbv9YvqIiSijjqY=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 3/6] IMA: update process_buffer_measurement to measure buffer hash
Date:   Thu, 27 Aug 2020 18:57:01 -0700
Message-Id: <20200828015704.6629-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() currently only measures the input buffer.
When the buffer being measured is too large, it may result in bloated
IMA logs.

Introduce a boolean parameter measure_buf_hash to support measuring
hash of a buffer, which would be much smaller, instead of the buffer
itself.
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 |  3 +-
 security/integrity/ima/ima_appraise.c        |  2 +-
 security/integrity/ima/ima_asymmetric_keys.c |  2 +-
 security/integrity/ima/ima_main.c            | 29 ++++++++++++++++++--
 security/integrity/ima/ima_queue_keys.c      |  3 +-
 5 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 83ed57147e68..ba332de8ed0b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -267,7 +267,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 int process_buffer_measurement(struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
-			       int pcr, const char *func_data);
+			       int pcr, const char *func_data,
+			       bool measure_buf_hash);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 372d16382960..20adffe5bf58 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -336,7 +336,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr, NULL);
+						   pcr, NULL, false);
 	}
 
 	return rc;
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 1c68c500c26f..a74095793936 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -60,5 +60,5 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 */
 	process_buffer_measurement(NULL, payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
-				   keyring->description);
+				   keyring->description, false);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 0979a62a9257..52cbbc1f7ea2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -733,17 +733,21 @@ int ima_load_data(enum kernel_load_data_id id)
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
  * @func_data: private data specific to @func, can be NULL.
+ * @measure_buf_hash: if set to true - will measure hash of the buf,
+ *                    instead of buf
  *
  * Based on policy, the buffer is measured into the ima log.
  */
 int process_buffer_measurement(struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
-			       int pcr, const char *func_data)
+			       int pcr, const char *func_data,
+			       bool measure_buf_hash)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
 	struct ima_template_entry *entry = NULL;
 	struct integrity_iint_cache iint = {};
+	struct integrity_iint_cache digest_iint = {};
 	struct ima_event_data event_data = {.iint = &iint,
 					    .filename = eventname,
 					    .buf = buf,
@@ -752,7 +756,7 @@ int process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
-	} hash = {};
+	} hash = {}, digest_hash = {};
 	int violation = 0;
 	int action = 0;
 	u32 secid;
@@ -801,6 +805,24 @@ int process_buffer_measurement(struct inode *inode, const void *buf, int size,
 		goto out;
 	}
 
+	if (measure_buf_hash) {
+		digest_iint.ima_hash = &digest_hash.hdr;
+		digest_iint.ima_hash->algo = ima_hash_algo;
+		digest_iint.ima_hash->length = hash_digest_size[ima_hash_algo];
+
+		ret = ima_calc_buffer_hash(hash.hdr.digest,
+					   iint.ima_hash->length,
+					   digest_iint.ima_hash);
+		if (ret < 0) {
+			audit_cause = "digest_hashing_error";
+			goto out;
+		}
+
+		event_data.iint = &digest_iint;
+		event_data.buf = hash.hdr.digest;
+		event_data.buf_len = iint.ima_hash->length;
+	}
+
 	ret = ima_alloc_init_template(&event_data, &entry, template);
 	if (ret < 0) {
 		audit_cause = "alloc_entry";
@@ -842,7 +864,8 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 		return;
 
 	process_buffer_measurement(file_inode(f.file), buf, size,
-				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL);
+				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL,
+				   false);
 	fdput(f);
 }
 
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 69a8626a35c0..c2f2ad34f9b7 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -162,7 +162,8 @@ void ima_process_queued_keys(void)
 						   entry->payload_len,
 						   entry->keyring_name,
 						   KEY_CHECK, 0,
-						   entry->keyring_name);
+						   entry->keyring_name,
+						   false);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
 	}
-- 
2.17.1

