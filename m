Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E15E20459B
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 02:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgFWAec (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 20:34:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47624 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbgFWAeb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:31 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id BAE2320B7192;
        Mon, 22 Jun 2020 17:34:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAE2320B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872470;
        bh=e9PJlhPkykcZATy30Q0lKIBQ00emcOdSXNFq9ix8gpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9YODZFlNUvnkOndWCYdavPRFFTczxu8F8puiq5gUp0vxhjTP3n1abtAHEamYfuwX
         oOWJlAHlvBpqOSISuiOJIalEWiayLy1l7YgbEzQZQHTHtpMP3Q8R2FSTT+/7b5aIpw
         a9wrzJ1jmMGJizk7M9RM/IibE0hmU2SLp0GSg6Gw=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Subject: [PATCH 12/12] ima: Support additional conditionals in the KEXEC_CMDLINE hook function
Date:   Mon, 22 Jun 2020 19:32:36 -0500
Message-Id: <20200623003236.830149-13-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Take the properties of the kexec kernel's inode and the current task
ownership into consideration when matching a KEXEC_CMDLINE operation to
the rules in the IMA policy. This allows for some uniformity when
writing IMA policy rules for KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK,
and KEXEC_CMDLINE operations.

Prior to this patch, it was not possible to write a set of rules like
this:

 dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
 dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
 dont_measure func=KEXEC_CMDLINE obj_type=foo_t
 measure func=KEXEC_KERNEL_CHECK
 measure func=KEXEC_INITRAMFS_CHECK
 measure func=KEXEC_CMDLINE

The inode information associated with the kernel being loaded by a
kexec_kernel_load(2) syscall can now be included in the decision to
measure or not

Additonally, the uid, euid, and subj_* conditionals can also now be
used in KEXEC_CMDLINE rules. There was no technical reason as to why
those conditionals weren't being considered previously other than
ima_match_rules() didn't have a valid inode to use so it immediately
bailed out for KEXEC_CMDLINE operations rather than going through the
full list of conditional comparisons.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
---
 include/linux/ima.h                          |  4 ++--
 kernel/kexec_file.c                          |  2 +-
 security/integrity/ima/ima.h                 |  3 ++-
 security/integrity/ima/ima_api.c             |  2 +-
 security/integrity/ima/ima_appraise.c        |  2 +-
 security/integrity/ima/ima_asymmetric_keys.c |  2 +-
 security/integrity/ima/ima_main.c            | 24 +++++++++++++++-----
 security/integrity/ima/ima_policy.c          | 17 +++++---------
 security/integrity/ima/ima_queue_keys.c      |  2 +-
 9 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 9164e1534ec9..d15100de6cdd 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -25,7 +25,7 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
-extern void ima_kexec_cmdline(const void *buf, int size);
+extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -103,7 +103,7 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 	return -EOPNOTSUPP;
 }
 
-static inline void ima_kexec_cmdline(const void *buf, int size) {}
+static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bb05fd52de85..07df431c1f21 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -287,7 +287,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
-		ima_kexec_cmdline(image->cmdline_buf,
+		ima_kexec_cmdline(kernel_fd, image->cmdline_buf,
 				  image->cmdline_buf_len - 1);
 	}
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index de05d7f1d3ec..ed9307dd0e60 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -251,7 +251,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring);
+				int pcr, struct inode *inode,
+				const char *keyring);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index bf22de8b7ce0..4f39fb93f278 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -162,7 +162,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 
 /**
  * ima_get_action - appraise & measure decision based on policy.
- * @inode: pointer to inode to measure
+ * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
  * @secid: secid of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a9649b04b9f1..0c11aeefea24 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -330,7 +330,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr, NULL);
+						   pcr, NULL, NULL);
 	}
 
 	return rc;
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index aaae80c4e376..585b64557094 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -60,5 +60,5 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 */
 	process_buffer_measurement(payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
-				   keyring->description);
+				   NULL, keyring->description);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c1583d98c5e5..82acd66bf653 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -731,13 +731,15 @@ int ima_load_data(enum kernel_load_data_id id)
  * @eventname: event name to be used for the buffer entry.
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
+ * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
  * @keyring: keyring name to determine the action to be performed
  *
  * Based on policy, the buffer is measured into the ima log.
  */
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring)
+				int pcr, struct inode *inode,
+				const char *keyring)
 {
 	int ret = 0;
 	struct ima_template_entry *entry = NULL;
@@ -767,7 +769,7 @@ void process_buffer_measurement(const void *buf, int size,
 	 */
 	if (func) {
 		security_task_getsecid(current, &secid);
-		action = ima_get_action(NULL, current_cred(), secid, 0, func,
+		action = ima_get_action(inode, current_cred(), secid, 0, func,
 					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
@@ -815,16 +817,26 @@ void process_buffer_measurement(const void *buf, int size,
 
 /**
  * ima_kexec_cmdline - measure kexec cmdline boot args
+ * @kernel_fd: file descriptor of the kexec kernel being loaded
  * @buf: pointer to buffer
  * @size: size of buffer
  *
  * Buffers can only be measured, not appraised.
  */
-void ima_kexec_cmdline(const void *buf, int size)
+void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 {
-	if (buf && size != 0)
-		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   KEXEC_CMDLINE, 0, NULL);
+	struct fd f;
+
+	if (!buf || !size)
+		return;
+
+	f = fdget(kernel_fd);
+	if (!f.file)
+		return;
+
+	process_buffer_measurement(buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
+				   file_inode(f.file), NULL);
+	fdput(f);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 0ca9902287bf..5a6aee530011 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -442,13 +442,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
-		if ((rule->flags & IMA_FUNC) && (rule->func == func)) {
-			if (func == KEY_CHECK)
-				return ima_match_keyring(rule, keyring, cred);
-			return true;
-		}
-		return false;
+	if (func == KEY_CHECK) {
+		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
+		       ima_match_keyring(rule, keyring, cred);
 	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
@@ -1003,10 +999,9 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			if (entry->action & ~(MEASURE | DONT_MEASURE))
 				return false;
 
-			if (entry->flags & ~(IMA_FUNC | IMA_PCR))
-				return false;
-
-			if (ima_rule_contains_lsm_cond(entry))
+			if (entry->flags & ~(IMA_FUNC | IMA_FSMAGIC | IMA_UID |
+					     IMA_FOWNER | IMA_FSUUID |
+					     IMA_EUID | IMA_PCR | IMA_FSNAME))
 				return false;
 
 			break;
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index cb3e3f501593..7c69d7397832 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -156,7 +156,7 @@ void ima_process_queued_keys(void)
 			process_buffer_measurement(entry->payload,
 						   entry->payload_len,
 						   entry->keyring_name,
-						   KEY_CHECK, 0,
+						   KEY_CHECK, 0, NULL,
 						   entry->keyring_name);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
-- 
2.25.1

