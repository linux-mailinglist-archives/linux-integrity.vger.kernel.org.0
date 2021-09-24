Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D712C417A95
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Sep 2021 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbhIXSK4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Sep 2021 14:10:56 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:37029
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345799AbhIXSKz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Sep 2021 14:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506962; bh=3pmmgD9t4z8NQSI4p1azkNcMGXOlGepTVasZIQiZvCA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DNIrxsFZScsb+SoVRi/rH6SvussDc1YVH4a/oGVPZLwpQj3LktPEZSIwUXmMh5Gcp8QCkTLhqK/mAmHbdmux9Z78cZXzLugKR/1hlqjiff5oQh8Q/CjhLcW2LNStBwvgzIcVLnoS8o2YOfP066fMwCC53wnwe+Q/QbQjMK1o8l8SaRTTyuGJ9EIshVMjQ9qOBc8M6r7rmPzoi+O1UfPUM8bbwNDOwPDc4NxSdh47xS5s67K8dBR1HckvyXtWp//+HxMxoCWCibnq+WWfEPz3rY2EBcYcRZnEotCYvSvaLq8/DHJ0WUfQSWmGPQt5WRHmq05yJY/wGJtuSC4LPK9b+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506962; bh=fgc29GRrXTZa1Vl+DtuHKa+Fe5gpE/9Uuzbg1Q9YUPA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=s7o2qDzpcT3zAjCpyrkYJqtZkYUDy5184aI8+bisW03f2xPbBA9eMZvurguH8QKiyRBfneNFNNao7shJrgztAep5a5opOvojgAv/OdtYJxD8BFYhZc5OVcS+6Mx2/oUjDKxceU/Xfl6H1TzwVqASUDkTi+y/DjoqCvlB8oaXaEe6Gsdb+coerI2a/ESu1NgtslTXlbPbQ5DPY1os+OyJ6wjf8Cl1zv+Th6rGq3qLTakYSI66FgfsF3QxYXTH0Y+OUnNc1H0TqFtjAbWCl3atDuyQeyUDVNOBZl3yWnbq/7+irIIvqHhsu0hOg/YWLkufuNJbtbBfMCyKVnt8+1UFmQ==
X-YMail-OSG: ni7vDc8VM1ntq6.WXBiQYwiATX74bzTV7_sa7yOP2G8V0d9lZ9zj1_XsumEgpYA
 8zIlJ8MVCPb806vHM1SMm4NRY_Hy.8EeHTTdthEUVEe3jAbSOCd0Wq81cMzRJoNnx_u_atuBu0w3
 BffIYR11Q9Uar9DfdU9AwWfWwaYHWdubwFsNILlbgz4tPu43aGuQDCNsVy3TzZAah8nFX7ik2eoz
 36CUooxlf2x_Xo2QVj_CX8a1WQyR_Rj_2SpIiB6mCHkiPyaSkXGtFpyYbMqByKZlWtdBOMJ0K1X9
 ZJqvcnWv955D6cJxpHthwj9cEZG8DmtRoBCE2i.CNcE_sAVfEGNfR2uZ2niiI4o0eiWKbTPv.ZCx
 2YlEqaFYMOdF0FileL9ktb9BbRIJ8E9cUVTtbtNpmFdbcEplJAK_jtOSyiplLdFrqepPyJwUx1MQ
 PROOsv4PCTOTqdWwmnSwgfvonLmUR5.zn.gSWQ4ZhwHpWmdqUoqogCnT1RnDguX0V0WGuj3mLX1D
 eYBV6k1sYmPDjie38v0vLQguefgUDo.Ds6YKDMOL5ni2j05S0_3hSIbAtcyYK8m_aT5ExCSvRdMK
 USu3Do9VSDHzVLQHKt4Y8GbOAsIwB7x8v1DOjeRfY6MDhvyE1Dt7K2pE7ARrcNM75h1IKOoLSfaC
 dg4ReQQMb6lsUvLYOsJMRr4p6x9F_B8GkeFnHiEMY4PUQlonyiDtvHk0an6A0l_Y2_I.4zTY3_4L
 jJUQ9sUpBB9KC7wEGiigxR96D5yzJCvMkMr7n9i_OaCHKRvpck20GthNoKrM1tHiJRT7aC68_ylY
 nGVvUsmMIvDHcRSA4rfbKjpNcaBbSsWAuqNaGteksAEmRspywU145n7HOlVgMNFqfE_GUCCMyNZO
 DowZpCj9KKS_nsVelnkI14D6srrmQVH5.STAlDAlYj6hY.3x21l78sV.CwT0SNW.a58.Qc3H_CzT
 JRqGFhJ6xNm9bfR0ozhDjdxpYlvacGnuiLnnkrX5DVvmlcUeKgy4C6MUyDpi4LNyPBZ3F_q1edtF
 icD7SOucF0BcF31FVD8b_56eHS7ikVfgOdYjdgOZ1h6fpcJDulMaeA7NqlzNBdQe0459JuNCAykv
 l.3uz7M70XOP3tU97YCaJdokeCUizZ95ZCponXLZXjIkkjtQU1dSsn58JDWSeN3LhUNewHb_WknH
 Y3_jW4NOZQF.6PJY.9Npbc2sl8cDt.Qil5jSKNmD0Z7T_ssv9omQ3wuTPwF6hh8r25QU7lhFmeBb
 XywSYgjWAey5nJEPYWmgDLPdcyoO.gP0MNSjeWR53maSosJQ9hP2ufHdLbLbDepQouIKVCQB4m23
 aozXE9fSYyU4LMeZFAB9FGcOKv.mASpRHKrOFFG88IkyiZW4somalm0TWRiqWXrpYOUncu_dhxg3
 HdEdpQmskoX8iM15J0Or3n1th_jCDRE.cLz0LRDY67Xree.Y92O.0gmwdt2EGJ43Vp7WrkAyeH6n
 dOlQkZwtam4LByfwMCioLiGZylqmpKAVQJ.k2L2hSvfHwvIqPFTqWIrkTMX.IHcUCBPrcxYnr8q2
 FG1HN09gmMBVGe.u3j2XgyYP4CWcG5KaBwOjOvtBZlgIu2b13vcIsfm5lkSQpReNtz9kOKlkaR72
 DwwuauZpyqTmRaS6w6tmfAyGBD9ulhSAyo6JohbK4JL3.LNe5d9CrClPcqgbtdvcayBJo_lyzNEy
 qh3KLRAOgvlhV3ALzawO1f0DI.Xt3Rx7NwHfrQA3ujSs_TSVaP3wJZHBoczP5pndHeIWzR7mG8Qu
 tGtBnQZBAX.ojPvrhlWb0oS.yIaFoNnppVmPJtsXu1fhCyrsgsjF3QBKRfzOjgClyp1erD9Wge2B
 s6yuSr2N9dqALZOnZdkzcmu4qx8GDEcAm_0nDSz2ZTzl4VNXwLOOM1gbxcS23cU.E7VbvReS5UKC
 isIw4lmfNfqzwzj0De5u6xgrG3Hp4uZltGi4CibjUMzHULgwuNpRdQVc1BW2r7OHYGEDiYu6s_qC
 kFXyTYAY4j8jp5hDhidKp5WkPe2fptxp.UvfjoxLbk9E0xdmje6wIE71k14Hljqk0V26hq02bwRo
 dKlck6rzG4HI6HAtYWeqkorMEg_oUajx7pJWAWLSacgrqZOd6wu.HcDrhU6q2kWjxpQwBqfXm9hv
 .KaVqq669rTM95Yy.QdJwz6wDalTUgAm9Ux2zp6FWn0326HmHvKnxpXggeUOf8_RCTZynD6seEiq
 fO_aK_.2V6fSfn_7TR8EBrW1_4vl7R9pZVgbfwMb1OE8FvEP._P4SJdnpsDTTf8H55mTw8bSMDOm
 pdapHoDLwMWWZO408BJIQUl.mv18zjeRBODpkNBmKR9HhCaHQIZweyw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:09:22 +0000
Received: by kubenode550.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d05a32d7b279403a153a7aae7034a619;
          Fri, 24 Sep 2021 18:09:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v29 13/28] IMA: Change internal interfaces to use lsmblobs
Date:   Fri, 24 Sep 2021 10:54:26 -0700
Message-Id: <20210924175441.7943-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA interfaces ima_get_action() and ima_match_policy()
call LSM functions that use lsmblobs. Change the IMA functions
to pass the lsmblob to be compatible with the LSM functions.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
To: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h          |  6 ++---
 security/integrity/ima/ima_api.c      |  6 ++---
 security/integrity/ima/ima_appraise.c |  3 +--
 security/integrity/ima/ima_main.c     | 38 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 17 ++++++------
 5 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 1f025ff1f011..dfa6cf5115c3 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -255,7 +255,7 @@ static inline void ima_process_queued_keys(void) {}
 
 /* LIM API function definitions */
 int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsmblob *blob, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos);
@@ -286,8 +286,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
 int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsmblob *blob,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos);
 void ima_init_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 2c6c3a5228b5..aa27f2144476 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -165,7 +165,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: LSM data of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -186,7 +186,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *
  */
 int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
-		   const struct cred *cred, u32 secid, int mask,
+		   const struct cred *cred, struct lsmblob *blob, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos)
@@ -195,7 +195,7 @@ int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(mnt_userns, inode, cred, secid, func, mask,
+	return ima_match_policy(mnt_userns, inode, cred, blob, func, mask,
 				flags, pcr, template_desc, func_data,
 				allowed_algos);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 2fedda131a39..d7244a5eb69d 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -77,9 +77,8 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
 		return 0;
 
 	security_task_getsecid_subj(current, &blob);
-	/* scaffolding the .secid[0] */
 	return ima_match_policy(mnt_userns, inode, current_cred(),
-				blob.secid[0], func, mask,
+				&blob, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL,
 				NULL);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1a4f7b00253b..4789d5256693 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -199,8 +199,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *blob, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -224,7 +224,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(file_mnt_user_ns(file), inode, cred, secid,
+	action = ima_get_action(file_mnt_user_ns(file), inode, cred, blob,
 				mask, func, &pcr, &template_desc, NULL,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
@@ -409,8 +409,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid_subj(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -450,8 +449,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	security_task_getsecid_subj(current, &blob);
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
-				current_cred(), blob.secid[0], MAY_EXEC,
-				MMAP_CHECK, &pcr, &template, NULL, NULL);
+				current_cred(), &blob, MAY_EXEC, MMAP_CHECK,
+				&pcr, &template, NULL, NULL);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -489,16 +488,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	struct lsmblob blob;
 
 	security_task_getsecid_subj(current, &blob);
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
@@ -516,8 +513,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid_subj(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -714,9 +710,8 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &blob);
-	/* scaffolding - until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL,
-				   0, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
+				   MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
@@ -758,9 +753,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -914,7 +908,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 		security_task_getsecid_subj(current, &blob);
 		/* scaffolding */
 		action = ima_get_action(mnt_userns, inode, current_cred(),
-					blob.secid[0], 0, func, &pcr, &template,
+					&blob, 0, func, &pcr, &template,
 					func_data, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 67c7762b2533..99d6f6499094 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -560,7 +560,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the lsm data of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @func_data: func specific data, may be NULL
@@ -570,8 +570,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 static bool ima_match_rules(struct ima_rule_entry *rule,
 			    struct user_namespace *mnt_userns,
 			    struct inode *inode, const struct cred *cred,
-			    u32 secid, enum ima_hooks func, int mask,
-			    const char *func_data)
+			    struct lsmblob *blob, enum ima_hooks func,
+			    int mask, const char *func_data)
 {
 	int i;
 
@@ -640,8 +640,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&lsmdata, secid);
-			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
+			rc = ima_filter_rule_match(blob, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
 			break;
@@ -685,7 +684,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -701,8 +700,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * than writes so ima_match_policy() is classical RCU candidate.
  */
 int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
-		     const struct cred *cred, u32 secid, enum ima_hooks func,
-		     int mask, int flags, int *pcr,
+		     const struct cred *cred, struct lsmblob *blob,
+		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos)
 {
@@ -718,7 +717,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, mnt_userns, inode, cred, secid,
+		if (!ima_match_rules(entry, mnt_userns, inode, cred, blob,
 				     func, mask, func_data))
 			continue;
 
-- 
2.31.1

