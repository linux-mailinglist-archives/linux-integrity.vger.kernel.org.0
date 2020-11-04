Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3822A7347
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 00:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgKDXyw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Nov 2020 18:54:52 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:32834
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732652AbgKDXyw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Nov 2020 18:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604534090; bh=sn233g3yrLDkG9XqXk4WNuW+QliBdnrF8a2qtcNu7yk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gZ5+/46spdEGuTi8ylPlhzD07w1eizRwkYzNMp+iztY3nHxiqSRfsS/S+LAFxN94jaUBsh9OYHzfqE385m5U9pc0nPPpFXyZqVK16TBUR7W9ynhtc9NLbI4kLRU2YL0HJyZWoVeobhlc+2amuJ/3vr3LK5i24SJb/xf9XvplnblVuEvHuBAbbVGu05tlJ61CX1eMvGcXgXMVrQqFcmm2FRX/bloqY4vn0rQvd7oWxivrq/RULcwl69E5XPcaF39uRn7AzyWVKNlzBAKa9y36k2qD7iCUBNUAZmg5FRoNUbwDAhYeU1579kZdOqHnHZNHZexXu2ua0KGg70HgZ7xWTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604534090; bh=s3V36KpnPAW1Bwo67ozixpI+w0bHihZxyxPIYOTYzkC=; h=From:To:Subject:Date; b=Ho6wnZ0vA3yf0guDO3vr7g7OMiLY4lQC/IS673qU7c+oNN8Ho1k/IcxF+xIxvRUGQtavreKG1GfkpVTKHeFNOamKO5Iq/5zqBRoactY7u78yDrvn21qqGIm2l/XJhmGdog2W53Vq76puxaqrb6NC1UPAJggvdZ+moepgbmNbJkZM2L1F6SeUslMGEobg5WUUN3wIAQ9V6L0EjlpkbmNQSNjP/11mZIV3j9Nr+fD/NSuHF48d6DNoywaYbETNiMP/n5bEo5XrPHiTXvSbeprm7RuWH9VqtiH1hOnWv3MbU+yTX1R8OI7uRnW7FEbMY6RsWCIbf6nvbFIBpQxIY2f98A==
X-YMail-OSG: ini5vyoVM1m3arVDwkwLnamoxeTYcJyjidv9qPMdL5qkvaaLMY6PFI8yGNSX4td
 tZfETGuR57_cBBAJzWluGQnxhMBlOzy7VKYNnxjheK1.OriKHaD19MklCjPydBtoq1BzGAB9mhIl
 JHQNmGH9rOjyWaeLU4CH.T7xhwpnBvtMUZIHVvtlLHO6ntwfmSJmqfUX19GyoOfZ2WZtos0Gt9Lm
 GXNERMYWlNB3Ul2oUal0jXt4RAreWPPwf70SfXQm5f0mdVp_HIqgC5wBo8nQ6oY285sqKN2uhDBM
 hOLmIPQwDIOvze9CiKnu6foHgjj30o_rCv5vUWaxf_Fvqr.dPIcUeGa9omyDAc1cmC_Ohe7FZc5G
 pYYGViKR2AyrnQ6LosgAeKAytwcf9oeIr1uVxMIgEagEnEZaRNdmfHR55gUMRgO3nOxHmUSN4.E_
 xS_K.rxWt58NpFmRHp3PBnJeEKWbMZIz.Tk1E2XY1YiiTSjag7j2PpzcDQaW2.qNPwP5rimu4_Ad
 e7HC.yI2YGCTIeem7UwGr7ga3BVRp6KUKm8sZTqIyQFZZEchygMf6b8_TIoWsLSACfc7bx9aZfwJ
 .1E54OBUM5pQtg4rp4rwfcAFYOpPmbRaS.andGwegwXOn29d7p2WDLpYLFYEbO_IDF3d0_vrJLe_
 Q4gEB_FzpjTRm92pQ5KcX1M5XoBWxsmwRw5dXhZ2eYoL1EUAQ8sB7F8v7Rtd.oounYp3PqIa4jXM
 Hyp0RQquVNt.uNZDy1XTZoPpPeBmP6lyCdWSAaUSo871D4IxMpFnwHN8mR_GGcgPWvQpXiwN6lwL
 tfpkdngmdMcEtGZAZBNwWmsh8895qgL6eizkI1ySL12EWkBJFuKOaboyqoRmVXeSyX3TybJTcmSz
 RN9kTl01NN8NLt1QBd9Zm55piV85LBEdP2vwVYrfHHZpgTHfpVdcI9Vx.dD6Ghi9HdaEHACA66qU
 MulEeV6rC59Xu47PgBzEZwd5e4kW3IrRnKHQB0xV.wm5sF_FWNRjwrfjipTW.NAxrnvq7S1ZDmfG
 PLhTjzPXxyDQe7PAJsusy3nhpXS63HP1heRKOVVsGrGwVbKPmDLUyD1mlBk.1TVbwWrJ.adjoy0n
 h8xn1fezJ5oEAOzQfpKuJJUQ555r1L7wvU9Z8uScpHIrtf2FcJYlpFsrPyAGiODvyxRDRcxbBW81
 037hwmsKXKHyvef8Spe1IDNirZh6FbS616u2osWlDQLQRej0ACE1fsfTAibmCzqJJoXktD6Hhk_3
 IS0HxGdHI9T3XcB87v1HtTPiKiYLvNqRMYLbpKhLeB_S.jhPvB71QUIm.f3abnJ57b__i99rIi4Z
 D8BHvStjVIhYCllZZs8RQXzU_kPi.G5lImEBbfQhLDXqQ3uIbxtA8snPqPYiofQQQKGkKyD8CBqU
 m6rod4iKdT321fmDBco9bAVHIiKjLeuMzUt8a8aUcW7.6pD8j2zri_mzc19St8V_D6TtJ.OeLPD7
 v78njuE1l4TTMp0LiNCf3zQt87v._ifURJIQa9lRZVlRsS0wO0XieKqvXaJAoIFTwUJnLR6evXGl
 pVxQ_908bHhUFCqjl325hdeLztrNj62OjrKQWvIL730pEBNYxFT3vXMoCFIBLu4i9unqhQsN5kSX
 BPi__rcQH2zGQNJJuaE65ZwFGuG3g8nvLSXVFg_aJxdsUJaz3WxoUB2z9DK0kjZ8xBMcxBIhxtaE
 aeYtgXBVZwOpvkBYQt3avilEm1dX4JLmd5m4wn4QWZngkCw0B8i3ILzr0hhxVF7CSKyODKGGe_mi
 knu1a5D0PAGtrJZl1fZpHOuZrsWnPzqiHkZ1T_rxyHvs5njbO_wDMGv5o_nXRoYMoghOzqJqKy9S
 HoRSaSqVuauZe4Id19rbG99re5Z6Dg1edfUc49eTylXE.u8OlvAHzGkpHMtViwW2ESo5vz_CFyoB
 eKOVAM5Rks.iYsAUEPEWZrQaga40eo59UnJbIOWPADnRham0vYJC.U_VlI6QvaZmnOYHMP3JDwpP
 Xmu75pglZb8Bp9Gh8CMf0Nwrct7rJuD7Lsf4ndCvdxNJssyzPqFmacyqfEbHoqt.EPnXdyg8TKZe
 THZmVrpn9NFy9aOFqC5pN6nHr8cIFrhQcKe2hjHOfND3ZNw1y9WDsCbSvdAvaAklVmrRGHEpjbPy
 DfOpOgnztIHDrEMaq1_Ab6nKK5Q6WVywovxtaUl5Xg_0q5X0MlMiNDMBHbfyh0FCi1EXgUbJEA28
 ijU2VRuCuWftYHupkkpisd4.EqzTIxOOWJtLQ2AYk2xV_c3VkkoyJxzmfgQ9OmHxtrbXj1gTsXO_
 8y62wlz2otQhuv3LrPUrqesPkUbPkTBIgN_3O2TULUenwsi.haLBApbvVK34La98U8uC1.hO3u4u
 2Cw9mUhCvPMxXTnSN9yo89dvkWTKVWEnNXt1.M6ZawYr_sbUWkK.Uo5ZnZKJaA57TswMFU9eLxjE
 IoRwzF0ajSqVJePSDrC7tSbomUsUCkAwNFrZ9qW0LbJdjw1nFii5Yr9sW0IX8n0zg2tM_WOQRU0F
 W9U7mlKcj8AsHMvVIEBVTTxm.iLgq_3ATDBKUNKWCR2qq.KjigOGRK7C2v_OtpffTrVpO.YqCVFm
 VxPh4g.DcF87iYW9POI6n7.VV4GiddkkA0JVvA6jUYPd_itK87AayREMEQEt_mq7DmrjjjI2Yma_
 nU8vMpv3nsdCBdiuLYNyx9T8CG3EEfo6QAnQwZ7uVYDNY4a1leOVa04Fc0oHzfSzUUdIgbvFjeim
 CUJSmx8C_Z5_bP.M8.Nt6u8BYid1kUTfu2S9K_R7aG3aSa3GLBk7zBTXJgnUTmsL90EQF5beIgZ_
 z2Ihr1VYOpaK5Ip3INZf2bHxFvwUx2qWY2Le8nek_bW2cRyG66twa5m0cjsoqe3_jXAysA82I6aT
 vBUNrDF38R3Dx.3rNjZuSqE9wJGfsHJ0d7GzOW1877YlDlxn2TEnRDevHos0pBhe2IO05nzqxJlJ
 njsviZ_iWx3sARnJob2sdOx3YWCVMAYzxxGvkbyU8BeT2shN3cdnJ84oebZxSkChl9_jLnlkJZ7w
 DnbSdSAJg3eO3psx9vfEv2mY6GkiKWwkgiUKyffSUZX.PJzmwlG0v3liwa16u4pSq.8bLgE_zSUO
 req9UmGc9QoGUL8YXkEL6aRQ4prrkUhcUpxYWSlPjO9leIeFlx8R4EdtgTvWypwEwgBdlQDeem9H
 fFY9rIEHg.4aIqOr77V_YDFJnppKsSlXbRPzHQzX5IeS4UactK3MjjQueFDOaVJTFlVKyXlzQ783
 o0RVbCo2PhDyoJI23FPvXWE2S40.45a6b1O5nWHwD5CJnVz9151UEUGmNcgyRMyQ1IMcx.KZK7Mo
 8EN6wOq0RuzcOiYvYGFIeBTdEffEfXThAOdQsBMOaLdER8hCvb2zac_IVuVe0dQN6dlWFIGuEsZV
 9vyhgmugiqIL.XxnuwBRSS1t.9yRL__K6SmvdEA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Nov 2020 23:54:50 +0000
Received: by smtp406.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 68f40420d8ea732223d2145b31b3510b;
          Wed, 04 Nov 2020 23:54:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v22 11/23] IMA: Change internal interfaces to use lsmblobs
Date:   Wed,  4 Nov 2020 15:41:02 -0800
Message-Id: <20201104234114.11346-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201104234114.11346-1-casey@schaufler-ca.com>
References: <20201104234114.11346-1-casey@schaufler-ca.com>
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
---
 security/integrity/ima/ima.h          | 11 ++++----
 security/integrity/ima/ima_api.c      | 10 +++----
 security/integrity/ima/ima_appraise.c |  6 ++---
 security/integrity/ima/ima_main.c     | 38 +++++++++++----------------
 security/integrity/ima/ima_policy.c   | 16 +++++------
 5 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d7fe1d5ee8c9..81b00d07490f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -252,9 +252,9 @@ static inline void ima_process_queued_keys(void) {}
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
@@ -280,8 +280,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
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
index 2a18124af429..7c4e43399269 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -71,10 +71,8 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
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
index e2fd092a1023..39ca17586c6c 100644
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
@@ -655,8 +650,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding - until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], NULL,
+	return process_measurement(file, current_cred(), &blob, NULL,
 				   0, MAY_READ, func);
 }
 
@@ -699,9 +693,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &blob);
-	/* scaffolding until process_measurement changes */
-	return process_measurement(file, current_cred(), blob.secid[0], buf,
-				   size, MAY_READ, func);
+	return process_measurement(file, current_cred(), &blob, buf, size,
+				   MAY_READ, func);
 }
 
 /**
@@ -830,9 +823,8 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
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
index bbf9fa79740a..a95eb37937dd 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -508,7 +508,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * @rule: a pointer to a rule
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
- * @secid: the secid of the task to be validated
+ * @blob: the lsm data of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @keyring: keyring name to check in policy for KEY_CHECK func
@@ -516,7 +516,7 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
-			    const struct cred *cred, u32 secid,
+			    const struct cred *cred, struct lsmblob *blob,
 			    enum ima_hooks func, int mask,
 			    const char *keyring)
 {
@@ -581,8 +581,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			lsmblob_init(&lsmdata, secid);
-			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
+			rc = ima_filter_rule_match(blob, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 		default:
@@ -624,7 +623,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
- * @secid: LSM secid of the task to be validated
+ * @blob: LSM data of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
@@ -639,8 +638,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
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
@@ -656,7 +656,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
+		if (!ima_match_rules(entry, inode, cred, blob, func, mask,
 				     keyring))
 			continue;
 
-- 
2.24.1

