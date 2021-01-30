Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCA309437
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 11:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhA3KQa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 05:16:30 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59524 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhA3A4Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 19:56:16 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id C0E1A20B6C41;
        Fri, 29 Jan 2021 16:45:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0E1A20B6C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611967529;
        bh=2j8Pk/tJozQLAKykulBJht0UA8oi2+j9h5xFmfPQnxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2FGOBBrSEL+7wMIhzX9K3uPjaMIbgGqBp4xPb/CEbRgfFmL5Wh7UAQgUpUOXmzAm
         X6FqnOEZT3yIjMVKU8u+ORxlU2mbFeSVIcO1pGmAnKFIxS7o1LETLhbxKjCxjdont6
         cgcXMZXYgVRRR12eq21IacrcmYNzVV66wuLOCwlg=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 2/3] IMA: update functions to read allow_dup policy condition
Date:   Fri, 29 Jan 2021 16:45:18 -0800
Message-Id: <20210130004519.25106-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA functions ima_get_action() and ima_match_policy() do not consume the
policy condition to allow measuring duplicate entries for integrity
critical data.

Update ima_get_action() and ima_match_policy() to consume the IMA policy
condition to measure duplicate buffer entries for integrity critical
data.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h          | 4 ++--
 security/integrity/ima/ima_api.c      | 6 ++++--
 security/integrity/ima/ima_appraise.c | 2 +-
 security/integrity/ima/ima_main.c     | 6 +++---
 security/integrity/ima/ima_policy.c   | 7 ++++++-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index aa312472c7c5..59324173497f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -257,7 +257,7 @@ static inline void ima_process_queued_keys(void) {}
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data);
+		   const char *func_data, bool *allow_dup);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -286,7 +286,7 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data);
+		     const char *func_data, bool *allow_dup);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 1dd70dc68ffd..d273373e6be9 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -171,6 +171,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @pcr: pointer filled in if matched measure policy sets pcr=
  * @template_desc: pointer filled in if matched measure policy sets template=
  * @func_data: func specific data, may be NULL
+ * @allow_dup: pointer filled in to decide if a duplicate buffer entry
+ *             should be measured
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -186,14 +188,14 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data)
+		   const char *func_data, bool *allow_dup)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc, func_data);
+				template_desc, func_data, allow_dup);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 46ffa38bab12..e317a7698a47 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -77,7 +77,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 
 	security_task_getsecid(current, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
+				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6a429846f90a..2774139845b6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -219,7 +219,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * Included is the appraise submask.
 	 */
 	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
-				&template_desc, NULL);
+				&template_desc, NULL, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -432,7 +432,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	security_task_getsecid(current, &secid);
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
-				MMAP_CHECK, &pcr, &template, 0);
+				MMAP_CHECK, &pcr, &template, 0, NULL);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -865,7 +865,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(inode, current_cred(), secid, 0, func,
-					&pcr, &template, func_data);
+					&pcr, &template, func_data, NULL);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b89eb768dd05..4147c677eb24 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -644,6 +644,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
+ * @allow_dup: pointer filled in to decide if a duplicate buffer entry
+ *             should be measured
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -655,7 +657,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data)
+		     const char *func_data, bool *allow_dup)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -673,6 +675,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 				     func_data))
 			continue;
 
+		if ((allow_dup) && (func == CRITICAL_DATA))
+			*allow_dup = entry->allow_dup;
+
 		action |= entry->flags & IMA_ACTION_FLAGS;
 
 		action |= entry->action & IMA_DO_MASK;
-- 
2.17.1

