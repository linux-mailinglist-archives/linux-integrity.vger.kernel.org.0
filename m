Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E7102E7C
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2019 22:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKSVqW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Nov 2019 16:46:22 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44092
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727532AbfKSVqW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Nov 2019 16:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574199981; bh=LfZjM4efI1ndLKOfcohV7YwoVdWrRHtus0U2gr1s04M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=phiocXAD8NGgqGw7gKWXZtb+59HhouXzZyHcpWwgkNFvV8A4NfPyULy+HUdCc7pj5CFx7MlxcZqnXraHAiYjxqccvAn0a12qAVIGutNsm0buym4zsnflY9qf81PI5pHVwpfIWdifAG3y05V/CG+uOBgsR6aX6MB52YswxomX6tE59PW2D4d7Vd8JVPvcYiVhgz02YcGu3Ae0D2I2UcLg92JmFImlJutqDcvdGZyv0lc6r1A0ewltvU4TWmu/jp+wPqvzxbmo4HiF4p48INsWWavLQ6WTYKMScchjW9jFPNvAjspC0qY/qJ8JLti+RDgabDsOV2iG3isKH3Y3s1TfDQ==
X-YMail-OSG: bZjmC50VM1kzPITO_IwEojEEdOwvykG1K1HlztRD7W7UoSZAcGY023mjc5MOlW0
 lYnwnHmbZ1cdD3lGeOVI_P7JgjkPayq5Ub15ljWAofU5DD9n1qq6gcohIzcwpmuTIHjk2AiAnm3z
 zhIzxl7MPK7j17_50c1gWmIIbUEOv6rGxYJ_Dx.48qm6QS8Y2zXnwoEjZ2diqmvGc0na9DSmG35o
 Y3eF5iDFfmXpgA9bxSt9Bndr2GBB0v.FBjMcVDx32LoK4sVZ4p.9Hx4sYoQLVRev6J5mCUu6lLLK
 W3V3YdAZhW5vCCy_4HsAnAYOYBe4JSExudq8E3AvRHrTVsPsrabKaF6bwASQl6dZWNKfw_Fxu0Mr
 ZSI49BeQA0i9.TG0XWz30uuYHf2I0xSsTk_2xnbgo0qmIsPc4tMdFt5qlURBK4rm54Ek3ITAgK.j
 lreZFTLehZr3Z4HdA7125nfZmh.1QeT0gM3KVzaPRkfKfInYYQT.VPYkJtIk.CeuUQXQOx.A1RWh
 7AUqD9Ok7.VwmascnloVp7cvJEzPjnVwj4Xp4qXsGD1_kAk5Ik8ZnhqHHyEyKWQU6z90wrr70osg
 3uXvkTVWFmeOntBoK6ChKpqwR2J52JTnhAWGpuiA4.Sz4qyIU8XJ_ZQ2WDPK9pyA_fJ1XdlE8Yey
 JPcoPPheKZnIQwYb9EHfAiu16hMPrOjisEOmMsdkkgvGqg2XGH_TuZ4nSS.NWfy1EbJY__8rWzya
 CTnHvWuHoQsnpp1Fu9xi5KdwWuX.dCpmlTcCVXtqLw2gHUjydoG682HO1sS5H7arF73tsDM4kLeZ
 bu.YEJgvDE3CUk5wh_h_vi9jeZoNnHD4ydYwmR0lgAf72ileRjwbrxNx25PpiKlwsMpUP3UTXm8V
 zJGXtOqiQF8qbxyrO5TKnFAtdJ4LVJD8GM8YQDKBmuX6QURnJWaKT3.2P6orJT_7I9Xmb4Iw5nOQ
 OXIaV57rEUPSw_WsRL5vrD6U0CNQafu0h.QY4IPpkdbgUnF8qYidlOa9eCOW3ieP4cEjtiXOCD2r
 smHyoDTYTASVBYxnlzJGY.BCvkriYHSf.SlGhg0TBxLvnigCLNQZuzVRKeej6HmEWttvj6B1lVki
 coJsYIYTxghH014fh_rKGRDfwgoRp5refkcTRCOkOitVE1O_jeqd5_7tUFWqITv9i5_j_.BIkyNW
 zCC_Kw2AmKF059WVjHKqR1iWjm_1svL_zPGibKOC3TT3zot7F5FDbnLkjPqLxW6U4zFVsHnJj8Hu
 k.obXM27nyq_dwvIcDo0ASuzPYWvmPlJz57Z97ssTcB65XaFhikUUg8qdpX5jRCsXMeVj0PvG7lD
 k3BigT4ZYCmq8dMRgycW1BIVreR2C0xcVVqH55D03L9lvod.Fv_5L0fpL5N9aJnInoubuyXlygip
 EHDOLWg6.bGwtVR6GICRW4cc041rro_cf0tMZ6FWsjX8zdA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Nov 2019 21:46:21 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ee2e3e844c72ed99628860647e58ca83;
          Tue, 19 Nov 2019 21:46:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com
Subject: [PATCH v11 12/25] IMA: Change internal interfaces to use lsmblobs
Date:   Tue, 19 Nov 2019 13:46:00 -0800
Message-Id: <20191119214601.13238-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119214601.13238-1-casey@schaufler-ca.com>
References: <20191119214601.13238-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA interfaces ima_get_action() and ima_match_policy()
call LSM functions that use lsmblobs. Change the IMA functions
to pass the lsmblob to be compatible with the LSM functions.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 security/integrity/ima/ima.h          | 11 ++++----
 security/integrity/ima/ima_api.c      | 10 +++----
 security/integrity/ima/ima_appraise.c |  4 +--
 security/integrity/ima/ima_main.c     | 38 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 12 ++++-----
 5 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 5bcd6011ef8c..4226622f50b1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -205,9 +205,9 @@ extern const char *const func_tokens[];
 struct modsig;
 
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc);
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -229,8 +229,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc);
 void ima_init_policy(void);
 void ima_update_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 610759fe63b8..1ab769fa7df6 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -163,7 +163,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * ima_get_action - appraise & measure decision based on policy.
  * @inode: pointer to inode to measure
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: LSM data of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -181,15 +181,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc)
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
+	return ima_match_policy(inode, cred, blob, func, mask, flags, pcr,
 				template_desc);
 }
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 7288a574459b..bc04c6f4bb20 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -47,15 +47,13 @@ bool is_ima_appraise_enabled(void)
  */
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
-	u32 secid;
 	struct lsmblob blob;
 
 	if (!ima_appraise)
 		return 0;
 
 	security_task_getsecid(current, &blob);
-	lsmblob_secid(&blob, &secid);
-	return ima_match_policy(inode, current_cred(), secid, func, mask,
+	return ima_match_policy(inode, current_cred(), &blob, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL, NULL);
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 305a00a6b087..a8e7e11b1c84 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -190,8 +190,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *blob, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -214,7 +214,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
+	action = ima_get_action(inode, cred, blob, mask, func, &pcr,
 				&template_desc);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -384,8 +384,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -411,16 +410,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
-				  NULL, 0, MAY_EXEC, BPRM_CHECK);
+	ret = process_measurement(bprm->file, current_cred(), &blob, NULL, 0,
+				  MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(bprm->file, bprm->cred, blob.secid[0],
-				   NULL, 0, MAY_EXEC, CREDS_CHECK);
+	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
+				   MAY_EXEC, CREDS_CHECK);
 }
 
 /**
@@ -438,8 +435,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -571,9 +567,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -632,13 +627,14 @@ int ima_load_data(enum kernel_load_data_id id)
  * @size: size of buffer(in bytes).
  * @eventname: event name to be used for the buffer entry.
  * @cred: a pointer to a credentials structure for user validation.
- * @secid: the secid of the task to be validated.
+ * @blob: the LSM data of the task to be validated.
  *
  * Based on policy, the buffer is measured into the ima log.
  */
 static void process_buffer_measurement(const void *buf, int size,
 				       const char *eventname,
-				       const struct cred *cred, u32 secid)
+				       const struct cred *cred,
+				       struct lsmblob *blob)
 {
 	int ret = 0;
 	struct ima_template_entry *entry = NULL;
@@ -656,7 +652,7 @@ static void process_buffer_measurement(const void *buf, int size,
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	int action = 0;
 
-	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
+	action = ima_get_action(NULL, cred, blob, 0, KEXEC_CMDLINE, &pcr,
 				&template_desc);
 	if (!(action & IMA_MEASURE))
 		return;
@@ -691,14 +687,12 @@ static void process_buffer_measurement(const void *buf, int size,
  */
 void ima_kexec_cmdline(const void *buf, int size)
 {
-	u32 secid;
 	struct lsmblob blob;
 
 	if (buf && size != 0) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding */
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   current_cred(), blob.secid[0]);
+					   current_cred(), &blob);
 	}
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c5417045e165..e863c0d0f9b7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -368,7 +368,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *blob,
 			    enum ima_hooks func, int mask)
 {
 	int i;
@@ -431,7 +431,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&blob, secid);
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
@@ -475,7 +474,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -488,8 +487,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc)
 {
 	struct ima_rule_entry *entry;
@@ -504,7 +504,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask))
+		if (!ima_match_rules(entry, inode, cred, blob, func, mask))
 			continue;
 
 		action |= entry->flags & IMA_ACTION_FLAGS;
-- 
2.20.1

