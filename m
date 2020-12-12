Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7A92D88E9
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 19:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439699AbgLLSEI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Dec 2020 13:04:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51028 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439661AbgLLSD4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Dec 2020 13:03:56 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 88F3C20B7185;
        Sat, 12 Dec 2020 10:03:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88F3C20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607796195;
        bh=tnSuY3aEm//0kWDaANBjLySCSxMhHr0qADi1Kwt/xqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrFSwz9nNnV27wjX6OOfeG7Zg83Sj7wNHQ00b7FkdUTgPatIz0fH8G4zOeo+7iAve
         bYZauQIIfPvQaTsOIW7Cb4wiIbncg1v6Rut6ayTAXanBZhLc97GCIdwUA7SLk/dqLf
         r8AKPJvyBFAtq0OkbqQj3S8LwsiYDnvkSS1nJTRI=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v9 2/8] IMA: add support to measure buffer data hash
Date:   Sat, 12 Dec 2020 10:02:45 -0800
Message-Id: <20201212180251.9943-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The original IMA buffer data measurement sizes were small (e.g. boot
command line), but the new buffer data measurement use cases have data 
sizes that are a lot larger.  Just as IMA measures the file data hash,
not the file data, IMA should similarly support the option for measuring 
the hash of the buffer data.

Measuring in-memory buffer-data/buffer-data-hash is different than
measuring file-data/file-data-hash. For the file, IMA stores the
measurements in both measurement log and the file's extended attribute -
which can later be used for appraisal as well. For buffer, the
measurements are only stored in the IMA log, since the buffer has no
extended attributes associated with it.

Introduce a boolean parameter measure_buf_hash to support measuring
hash of a buffer, which would be much smaller, instead of the buffer
itself.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 |  3 +-
 security/integrity/ima/ima_appraise.c        |  2 +-
 security/integrity/ima/ima_asymmetric_keys.c |  2 +-
 security/integrity/ima/ima_main.c            | 38 +++++++++++++++++---
 security/integrity/ima/ima_queue_keys.c      |  3 +-
 5 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e5622ce8cbb1..fa3044a7539f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -268,7 +268,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *func_data);
+				int pcr, const char *func_data,
+				bool measure_buf_hash);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8361941ee0a1..46ffa38bab12 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -352,7 +352,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
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
index e76ef4bfd0f4..0f8409d77602 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -779,7 +779,7 @@ int ima_post_load_data(char *buf, loff_t size,
 }
 
 /*
- * process_buffer_measurement - Measure the buffer to ima log.
+ * process_buffer_measurement - Measure the buffer or the buffer data hash
  * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
  * @buf: pointer to the buffer that needs to be added to the log.
  * @size: size of buffer(in bytes).
@@ -787,12 +787,23 @@ int ima_post_load_data(char *buf, loff_t size,
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
  * @func_data: private data specific to @func, can be NULL.
+ * @measure_buf_hash: measure buffer hash
  *
- * Based on policy, the buffer is measured into the ima log.
+ * Measure the buffer into the IMA log, and extend the @pcr.
+ *
+ * Determine what buffers are allowed to be measured, based on the policy rules
+ * and the IMA hook passed using @func.
+ *
+ * Use @func_data, if provided, to match against the measurement policy rule
+ * data for @func.
+ *
+ * If @measure_buf_hash is set to true - measure hash of the buffer data,
+ * else measure the buffer data itself.
  */
 void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *func_data)
+				int pcr, const char *func_data,
+				bool measure_buf_hash)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -807,6 +818,8 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash = {};
+	char buf_hash[IMA_MAX_DIGEST_SIZE];
+	int buf_hash_len = hash_digest_size[ima_hash_algo];
 	int violation = 0;
 	int action = 0;
 	u32 secid;
@@ -849,13 +862,27 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 		goto out;
 	}
 
+	if (measure_buf_hash) {
+		memcpy(buf_hash, hash.hdr.digest, buf_hash_len);
+
+		ret = ima_calc_buffer_hash(buf_hash, buf_hash_len,
+					   iint.ima_hash);
+		if (ret < 0) {
+			audit_cause = "measure_buf_hash_error";
+			goto out;
+		}
+
+		event_data.buf = buf_hash;
+		event_data.buf_len = buf_hash_len;
+	}
+
 	ret = ima_alloc_init_template(&event_data, &entry, template);
 	if (ret < 0) {
 		audit_cause = "alloc_entry";
 		goto out;
 	}
 
-	ret = ima_store_template(entry, violation, NULL, buf, pcr);
+	ret = ima_store_template(entry, violation, NULL, event_data.buf, pcr);
 	if (ret < 0) {
 		audit_cause = "store_entry";
 		ima_free_template_entry(entry);
@@ -890,7 +917,8 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
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

