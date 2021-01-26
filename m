Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59E5304EE7
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 02:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbhA0BWL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Jan 2021 20:22:11 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:36151
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389835AbhAZRVG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jan 2021 12:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611681619; bh=i3IlIYBj1fzs2pYf9aU7wxCDed6cr6VKZvV1tzuseXE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZRpVEWgqXYe+Hz+PWjdd+gzjgLhdmCHXtqQ4U6uaCIQcilszx0glqQeZZ6ExU12a7luanlIs/mwvStH977vNyImAWN+hMatluMe8gSHBL97VktDhMi7e/zuvKZ11Fn62WIGgtwuXzi495B+RDXmZ3rX3jHsfIx0bRdXxYbg0PMOX/RrW2Su6ysXIoGIODY/QdbdPNlsx/cY3TSrwzB9qaYzc05auAeUFDJ2oN8fS08S5MZX/9UnHSSH/vdtEoS1wU/xwAgSFlk7nkzFFW9OqSbZ1YJMDhdMgCBf6zjBvozO6XkE6faQlBI0z5CR7CZpMc7IxdSwuaKnwyVI/U9WCvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611681619; bh=ZCzjKB+6gI5LIqBwqyi1ysLQjDNdZEPNBxMZ6VJ4fS8=; h=From:To:Subject:Date:From:Subject:Reply-To; b=d2g/XB5t1qRtsrwge8UcpE4QLUDs6JjEM3k6NuhFE1xV3BA0nNtnSZukjaYAXeF08Z7nk/sJVrV9+cVhbUjymDzamebQ2EtTJdCmBGbJKx3tx0tnU84S/q3KJz2rbaHh3f2cIEb2RG4ZIyO4wPkNTS83Mx6QwgfJOBfKh0ZgjI9odDqDufxxdO9odeZSAW3AkfF2wZ+mgmQLySpZKGViogG5FsgjYK4ARAXA9fk1w2FuX/IefheWg74Ra32sm4GF+ji/8YA1p0lxijkRYM6I/89lYuq1MYkOPfDazWAVqePutLCgeDo96bYHFE1jCcQtjWQQrnUSENaA+b38kLkcRg==
X-YMail-OSG: bQPnHXcVM1k8FB9YSWhmQABSQ5g4USc4GaWoWgXFWUvJzyVD6Q9Qg8Pi_zruV1c
 WHqfOnzEtp6I4kwYX4GQiv3PFoVReBPYTWPd9y35fgc1YhRzYh_p8DePTwVPhtJ9W2dqbVpKUiYN
 yKT6zf61C2WFq7smajpSd8wWfkKNfEMyNE4CbRuqMquEIvDUKoPn9gDz6wP.NoydhQ01gUS8DPfU
 j4pZE1o8QwcbnNZbl3GmkiWT8SwrMzvJwzfp7qFYgcRGW6uhV4Gqyr2WINHCs4_1WO.mSR8mBsLH
 tl072HOFBlDkxrrDQBKnnN6pmMASo75z_wguHMNE0tO6iFc7DhTKyLHAJcKpY3OLDlVl3IaVgEUu
 7f8m2qDSmhgt4EPjQSpzY6R4xTvcpHRIiCzxJORNXipTiLEbeCkNdrOWNz6vc8AIQSVh3ycCvba1
 rimVZfETpAzEYS.GNMN5f0QRsCuAgkjR9GRO.K4eRUAAWZgaBbB9TNl3Y2TKVtfc6T4JMC.Ddvxs
 D0d1dF8M5qjjgqO.HRv.Apo4Os68aF_oVZbjhCP_JCdeEeKeJsOxSXS.NqyRIJuputGHKOrpVKgU
 YOUsP2KqWuUfEyRT8htD6sq6zFGtbjvuwOELSFlDcD7GDr7.sF3FrFh0ts3nFJn9IeXrkD6zG64G
 .4JL_VfrYpYhBpQD0Q2BKwDMiPsAF5148zuHoygRbNSAVz1VvC6PgCAO1GINj13sFXgXUKe6Q8_.
 fmW4VIgwsu6gGpzCvu4la74ft2c0lkUVW6zYyO3eq2YPiB1dsDZwqn3MCqEG1_U_EkIz3T8i.EeT
 fpmYMGFwFW5dZU4PDdyPgfO0NuAAb0_t5.DB9ZgVwQaJttmVLdTTM2XCLfNt.SysymZvH7gEWhIV
 yQwtI3pQL_Z2gmUCisVPB.fwNFL6mwZNpj4PkZqmIOT6xLaZc.w1ejo6URofju9YFROGZX1jBlDi
 p66kYgG0hHzDSszW1bL2nNFBCtQwB9V1e2TwXNpLJxeIiH8h1lvtKNqedHChONV0flkMbsKv5l9t
 x2TaDQ.5hXYb5_AUMMUHURqB5hVI5lS8JWX33.Nq_QVsGTwCDbcOLcuOPeB4i5IVpChLwIwkii9X
 v4weqiGVwhpAL3kLs32Y8GJY3_M023Dts03HhISLL_bFlzTWI4mgCtOBrSkUuol12OE93vZcM8bi
 hCRDTkPiSgIEZ_2FEpnTW9619ip1HpyAm_j_qRR1ZmvjxjiTC0YatTjA0s4Q3yn0VLAobtGtDT9_
 ph3GNwJuELJWzqZLEfd_nT3csA3b2zw40vVWwRwH8TEO3yoe6x0Y3qM9m06NFsu4LsSYBDM_CaLX
 HKiDQNQCFM3aY53giLb4vjR10EW.luWZsFPqM8XSK8fDDRc8V.rNyWVt0YDOTHE4saUP8ucSSNlF
 KbqT0lqwS4HL4AtMnZFAANJbhKFkR4.XdXT5m1BaWX_i8A7WDHiJFSXMDs5H5w6OL1aM2h.ZM6pe
 BITZvRQ.8jrCqXpr5fZmn0orVr1JdKxJOrNApVG9CAe3XNfu3IzgNPsBP6ijqTsvreXK4acqofGC
 Sjur52wx9.2r8Qtuy0pd9UXhhpfa3yrW.E2.zCqaUCVC3aqOi6UHHmh3a6jesGeptGu9ifkRaybf
 RE509pRBDLJezMSpnrAVV8nvPTSkmZppSmk5.KvQdTx3z1lKXLtjKkz5DErhz4wQtQuOmdt7YAXJ
 l9ZBQRupC6BDpmdnqW3pDvwrvQwSVM2XjxKQYWeJB6ojygQTkH.Xox1eoUTkMwSMIdyqUE0LERAq
 DNhuSv.rWpcBoEB8EImq8gOsZwov9sSAL..fh7f_PMWWr4hWl1FmaHZinoWC11yGOzJDfq9UlOCD
 OJUrhGvu1Sl.bgI2ljEK7B3B9VnlWdk5ugn4WA_re3Z9d5.gOoe1pYnMzyu9a8nRWLKpFiVA7VOW
 VG2AvFYkyQiwcg2t32uJQEhiJVxzlVwS7z2USEudYNJnokKWzCbw5guuXGP8oTEn0kNxMY2XpSFy
 a4XouJg5x4D3boDFzwgvbIhZZOlbLZYzq7uhJWKdfyAVK94H7Dta7XzOFG2N3FoUtOELdXXMkGjg
 i7aTBmlUMjSPdHhW9CIU73RueX6hRTccfxecourZy0.dvbZ0ZYQXUa7pKLl2WtCT8iAVhrU3MWd5
 Z1w31xIi8IqtTQamaYRmyzUrhoYb0SAmdRdMJcwRUs7kfrN30emFKsGgzIjoG.FT5rGGFo8ldf.S
 50PcNe2CFZagCAU_VhDXBZ1EdyrB14mDZMVqkc4uTf.NvwBXXp.tF3V8nuF9.tZfKcBXsDq35q8W
 Cc1x7c3168SEmjrrlz9UfOIx7s85QHkNz6VkCs3e8D3735Yu2AsAF6ISRooWLE3Zm0uoUvkOVr2l
 mmQoLhUQop1Q04QAMGmid6hVl7yINUL7fiy7GmUzgLyskb6IOEGzhvMQTMG.4NpBz_vaAlQ9IvBn
 0SElzx_9U5BUj4fR0WHAt5Bhoy3c7p5cv4TApx72OYH7KufCo7tFFQ4KhL_tAqEtldFeHcHOYbGn
 MPp5GMHKhhY5TU_OBcFAEaEoS7yC_k2d8L4hDzIujHvg6sW7_grn.R2pqlKQEcrf2YJdFTYYSLCe
 LCLHurZKHCz2JaPhtn49GpcfP8WP8ZiYroZeKTXd4w72Pr3iKGOVpDRDk8ZBJyRAXgTJRY2B_OXI
 B0Hs8WJmHowbx.1OCWUdd4oLj7Bun.2xhNQuqdGztgDmCKrGTo7YWUD4kRvWVGX2264x514sMaIs
 E23pNpo.c.rB8Ae4bEKdGRgYDKkhvjR1p_lMgBIyogDoxEORgpmGhE8gJnhQt8xj74rfdaVIBdIs
 ED.SXO0E2bvR5VPTTGCwIdnkBRoX8a.EeY5SeUU_2mdh5DbbaQcbfjd0fcCJNk3.7iEgqpaRioUp
 EaoXNVxZQJOBPVKceLIE8e586D.449KeFTnnEpDMURE0QVL4J8_RiN9yJMSdXNZhrqEhRONhmz21
 WN8idY2mcVLXloP4LgaNT4lfN9Br.M1cNZ5cnYwUznCWh1wnMGqA.xlQwavT5aPSm.gTfYLitTN5
 tg10O81X1pZjz5udC7ArOs2.T.BIGil3vjZQtSmzT7GD2WojbOMgt8m8.kdKV.sHDuzsopaV53Uq
 yE9q9OUtlDjXQGuEkFM3K8TRA69fSB1k0Jd3xWxwBPBbhu3Q6AcG6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 17:20:19 +0000
Received: by smtp417.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 050e4752b152522fa65bb67840094f50;
          Tue, 26 Jan 2021 16:55:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v24 13/25] IMA: Change internal interfaces to use lsmblobs
Date:   Tue, 26 Jan 2021 08:40:56 -0800
Message-Id: <20210126164108.1958-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
To: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h          | 11 ++++----
 security/integrity/ima/ima_api.c      | 10 +++----
 security/integrity/ima/ima_appraise.c |  6 ++---
 security/integrity/ima/ima_main.c     | 38 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 16 +++++------
 5 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0c520ea21677..c0c225335cb1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -253,9 +253,9 @@ static inline void ima_process_queued_keys(void) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
 
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc,
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc,
 		   const char *keyring);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
@@ -281,8 +281,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *keyring);
 void ima_init_policy(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..e83fa1c32843 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -164,7 +164,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * ima_get_action - appraise & measure decision based on policy.
  * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
- * @secid: secid of the task being validated
+ * @blob: LSM data of the task being validated
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
  *        MAY_APPEND)
  * @func: caller identifier
@@ -183,16 +183,16 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc,
+int ima_get_action(struct inode *inode, const struct cred *cred,
+		   struct lsmblob *blob, int mask, enum ima_hooks func,
+		   int *pcr, struct ima_template_desc **template_desc,
 		   const char *keyring)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
+	return ima_match_policy(inode, cred, blob, func, mask, flags, pcr,
 				template_desc, keyring);
 }
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index afcf715de585..1309d2092dc9 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -76,10 +76,8 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 		return 0;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding the .secid[0] */
-	return ima_match_policy(inode, current_cred(), blob.secid[0], func,
-				mask, IMA_APPRAISE | IMA_HASH, NULL, NULL,
-				NULL);
+	return ima_match_policy(inode, current_cred(), &blob, func, mask,
+				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e4ed01b1919a..f3400605292d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -194,8 +194,8 @@ void ima_file_free(struct file *file)
 }
 
 static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       struct lsmblob *blob, char *buf, loff_t size,
+			       int mask, enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -218,7 +218,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
+	action = ima_get_action(inode, cred, blob, mask, func, &pcr,
 				&template_desc, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -392,8 +392,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding - until process_measurement changes */
-		return process_measurement(file, current_cred(), blob.secid[0],
+		return process_measurement(file, current_cred(), &blob,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
@@ -432,8 +431,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 
 	security_task_getsecid(current, &blob);
 	inode = file_inode(vma->vm_file);
-	/* scaffolding */
-	action = ima_get_action(NULL, current_cred(), blob.secid[0], 0,
+	action = ima_get_action(NULL, current_cred(), &blob, 0,
 				MMAP_CHECK, &pcr, &template, 0);
 
 	/* Is the mmap'ed file in policy? */
@@ -472,16 +470,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
@@ -499,8 +495,7 @@ int ima_file_check(struct file *file, int mask)
 	struct lsmblob blob;
 
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
+	return process_measurement(file, current_cred(), &blob, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -685,8 +680,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding - until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL,
+	return process_measurement(file, current_cred(), &blob, NULL,
 				   0, MAY_READ, func);
 }
 
@@ -729,9 +723,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -867,9 +860,8 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	 */
 	if (func) {
 		security_task_getsecid(current, &blob);
-		/* scaffolding */
-		action = ima_get_action(inode, current_cred(), blob.secid[0],
-					0, func, &pcr, &template, keyring);
+		action = ima_get_action(inode, current_cred(), &blob, 0, func,
+					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ab66266fe932..9ac673472781 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -522,7 +522,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * @rule: a pointer to a rule
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the lsm data of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @keyring: keyring name to check in policy for KEY_CHECK func
@@ -530,7 +530,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *blob,
 			    enum ima_hooks func, int mask,
 			    const char *keyring)
 {
@@ -595,8 +595,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&lsmdata, secid);
-			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
+			rc = ima_filter_rule_match(blob, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 		default:
@@ -638,7 +637,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -653,8 +652,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr,
+int ima_match_policy(struct inode *inode, const struct cred *cred,
+		     struct lsmblob *blob, enum ima_hooks func, int mask,
+		     int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *keyring)
 {
@@ -670,7 +670,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
+		if (!ima_match_rules(entry, inode, cred, blob, func, mask,
 				     keyring))
 			continue;
 
-- 
2.25.4

