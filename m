Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E794B12A46D
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2019 00:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfLXXPr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Dec 2019 18:15:47 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44750
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbfLXXPr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Dec 2019 18:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229344; bh=vAY+BSSlZvLKw6BmZsbfSaSyBBrsJ1eETqHGtnGVNto=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=X0Ofe9U25BpQBoMs/rX062m+JekxHiEX1SgZnlkQ2IUU+9+sN6t3iut1l+Uqku48bue79+sYtvDBno+ccIXpOIS0LNpzIRn3GDti6+YC2epMZPD9+pRM7t/1McDesSjSKNV505AVAIKV5B/4RO5MWp/Ko3U0vz4nJIUOqT6MKGoXGNPg9J5XfHDyjJk+mRaBZx6DMbW+B7qw4Ibgp2K8c++mZbQbw7szYBcpaGH2K6WdEhtU65ERQWLkPogLrc29jJ39iYMfFJDSBW3GVDmfbIZrlKyGzWf6kEdAA2QgHYdGBTY2qOdXKHhxgWb4k/PBaQNBuFnKcP4cxTpc942sWQ==
X-YMail-OSG: 6egs9bIVM1lzPHEgLvtmpYOqyngBBC2UBstGXFw1d1EubcLYWLp_SMW8hXbhYyH
 UJRpGqz3gF.NOPEqYw5wPeAuRdeS3cL.HHApP354M0yCIH6CHw4siQYsAq9doGAm56yrbPaxl0aO
 04L9Gr4IXZlvbcLAh.jh46ec0qbA06L8zEk.dXp9nqtCSmgJnmvE8LpignBRWZwLV0zkIlZTHLTF
 JaGRH4b0uR_8eq8zRWJwekkt0C.ESYjmqVURCLwJ7p5jV1aOKf_DCce1uvDezMbBNCrMUMv6vqm7
 7HuW_hiO.Snz0a9.Ss_C6DH.J.XI5q8DJzpZ2rF2sTnNEUUr3bYM4Lil0JKfdOiSfJqPf..4mbub
 X8UEsLaViLcE1Y8AWPupUuzscbj1gRip1xdooxxj.YpMIHC.vwytCvXFTMPT4p.TlQhJMNxs5FI6
 Mvc2Op_4rbAowSsI.VIGDmhfdV80huCgLV_79HDO0NbSmoipya6BriH.uc2w.Bdb7.Ux50Zq5P1A
 nEMSVqC8CjVV6pf8JWtshufwozvt.eM0OC9VgFlJWIB_BrqKhMmdTmGZFuSlRZkkg502qUyIcw.k
 ilTyjWSxm.ZDkX2h1zJKz81bV9Eon6vRTTHFjfSygCFNEHNBcoJHIC.BV0qfk7DeIUCWESs1aqHL
 tulaKsEHrbpBiONrxAEwKKSM2BkSnOf6KlyGI_D1T0.NqfFZ1StrDDk4hQ43H2KYIey67ciGAkio
 n_wWDrnqw.LX1YOSMB2mMHmPdRGdTiWN2kdaPFzOVbKlj99G6GzqBisD1dexaovTaV70rADTxQdQ
 mewCCfj3SlPzgD8WiRqtEcQybVFdPsg3IfPL8Kv1urNqu0pRVp9d6DWcG0pQFOr.spqWUFp3jbLA
 o7sAE6JwEZOqA75o60IoVVrujbyGHAxVikfOAxQeNEYFnAR4cXMG4XnILMOgYHvdEl2KzFKBhneR
 QlHoTy0IPhXhwKLOlXY0.J_wq8lbD9g.89KhiJmlsPLiWOi4k1TPbQ6ntc7MjuYKuSCdT6AcB2BP
 u8TUTrqWeaarRpHjbBWQnXd6UOao0PW1XoGRXb48pRWQC3oVm4Nq17LnpKPGzfER7jS5EYEUoHMz
 .zQeRhhGDbyDn3K.l08G7l6fZMTxLnryRcetX23bmW.pYi.AjQX45dz.HV_vKTf6C.ppXNSSdzG5
 z7al.K82B7MhaDv52JLbe8FQGu15w_ynSP0p55CWm5MHX6js.FU_5CELjBgKq3bYg2Qon50TraNY
 r0AmxmoV.Jak8X9Ls9H53fRvSqyjgQqzRXRBcw58byrZ5gu632Akw7jp1L7CRMD6Zn_1fxdQYqOj
 62xhPSDRl25t47wqAlPVRkJjXSyr01I9josFISM7R8XA3pEudRUpGQCw_zdOycFLKWwcekPy.kri
 .gjHTWcEh4K6knmqUi6F5AnYFUGlS3fOfceyJ5ue.x.1jpSJKapwOkJJf7.1pAw0D
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:15:44 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 91949fd4ef023055ee2243b97d05f641;
          Tue, 24 Dec 2019 23:15:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com
Cc:     casey@schaufler-ca.com, Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v12 12/25] IMA: Change internal interfaces to use lsmblobs
Date:   Tue, 24 Dec 2019 15:13:26 -0800
Message-Id: <20191224231339.7130-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231339.7130-1-casey@schaufler-ca.com>
References: <20191224231339.7130-1-casey@schaufler-ca.com>
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
 security/integrity/ima/ima.h          | 11 ++++-----
 security/integrity/ima/ima_api.c      | 10 ++++-----
 security/integrity/ima/ima_appraise.c |  4 +---
 security/integrity/ima/ima_main.c     | 32 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 12 +++++-----
 5 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d95b0ece7434..96b6662ea39f 100644
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
@@ -232,8 +232,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
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
index 69e549164949..01c755a242ac 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -48,15 +48,13 @@ bool is_ima_appraise_enabled(void)
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
index c8e3e234d446..86cc1419587e 100644
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
@@ -388,8 +388,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -415,16 +414,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
@@ -442,8 +439,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -575,9 +571,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -669,9 +664,8 @@ void process_buffer_measurement(const void *buf, int size,
 	 */
 	if (func) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding */
-		action = ima_get_action(NULL, current_cred(), blob.secid[0],
-					0, func, &pcr, &template);
+		action = ima_get_action(NULL, current_cred(), &blob, 0, func,
+					&pcr, &template);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c7d2ea47a326..b089d4a8b27b 100644
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

