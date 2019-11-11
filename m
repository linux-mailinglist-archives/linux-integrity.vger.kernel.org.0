Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AABF8010
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfKKTdT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 14:33:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44840 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfKKTdK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 14:33:10 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5C8F720B4904;
        Mon, 11 Nov 2019 11:33:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C8F720B4904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573500789;
        bh=NHhWlOjhyTo97IQ9E/ztF61qTkOieJmDh/1ZNXjWPtQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=djPK/eI2xpLe9Sl9yt6iOMPW3EaX4yMLzPteCRdnC+4yKyOcAI6M9jS4ZY2BfjNy1
         fpHj/vCxRIFCV1zVK7WRXG1HZifdsvajyi18P3uh9i1fCFjrycwfLluXGzfVG18acX
         CBxy4ppe22ThxBXfHj/gf1R1AMz0h5e5TXq7xCX8=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/10] IMA: Updated IMA policy functions to return keyrings option read from the policy
Date:   Mon, 11 Nov 2019 11:32:57 -0800
Message-Id: <20191111193303.12781-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

keyrings option read from the IMA policy needs to be provided to
the callers that determine the action to be performed.

This patch updates ima_get_action() and ima_match_policy() functions
to return the keyrings option specified in the IMA policy.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h          | 6 ++++--
 security/integrity/ima/ima_api.c      | 8 +++++---
 security/integrity/ima/ima_appraise.c | 2 +-
 security/integrity/ima/ima_main.c     | 5 +++--
 security/integrity/ima/ima_policy.c   | 7 ++++++-
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7f23405b2718..387829afb9a2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -208,7 +208,8 @@ struct modsig;
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc);
+		   struct ima_template_desc **template_desc,
+		   char **keyrings);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -235,7 +236,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
-		     struct ima_template_desc **template_desc);
+		     struct ima_template_desc **template_desc,
+		     char **keyrings);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 610759fe63b8..fa2cd71ddf1a 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -169,12 +169,13 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr=
  * @template_desc: pointer filled in if matched measure policy sets template=
+ * @keyrings: pointer filled in if matched measure policy sets keyrings=
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| KEXEC_CMDLINE
+ *	| KEXEC_CMDLINE | KEYRING_CHECK
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
@@ -183,14 +184,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc)
+		   struct ima_template_desc **template_desc,
+		   char **keyrings)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc);
+				template_desc, keyrings);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 300c8d2943c5..47ad4f56c0a8 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -55,7 +55,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 
 	security_task_getsecid(current, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL);
+				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..68e15ff1fe8d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -215,7 +215,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * Included is the appraise submask.
 	 */
 	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
-				&template_desc);
+				&template_desc, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -647,6 +647,7 @@ void process_buffer_measurement(const void *buf, int size,
 					    .buf = buf,
 					    .buf_len = size};
 	struct ima_template_desc *template = NULL;
+	char *keyrings = NULL;
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
@@ -665,7 +666,7 @@ void process_buffer_measurement(const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(NULL, current_cred(), secid, 0, func,
-					&pcr, &template);
+					&pcr, &template, &keyrings);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1aee3c8b9cf6..d1889eee9287 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -481,6 +481,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
+ * @keyrings: set the keyrings for this rule, if specified
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -491,7 +492,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
-		     struct ima_template_desc **template_desc)
+		     struct ima_template_desc **template_desc,
+		     char **keyrings)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -527,6 +529,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if ((pcr) && (entry->flags & IMA_PCR))
 			*pcr = entry->pcr;
 
+		if ((keyrings) && (entry->flags & IMA_KEYRINGS))
+			*keyrings = entry->keyrings;
+
 		if (template_desc && entry->template)
 			*template_desc = entry->template;
 
-- 
2.17.1

