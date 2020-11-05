Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FB62A7442
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 02:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgKEBCT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Nov 2020 20:02:19 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:33756
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387989AbgKEBCT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Nov 2020 20:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538137; bh=sn233g3yrLDkG9XqXk4WNuW+QliBdnrF8a2qtcNu7yk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZwKCxYv8pixFpe+cDwk6/XDNICRYmtI90jv5Q9mZhZ70i5gLGiD8jEofbVJN1xetyH0+qoAZgoTMHhGmPxvcPikSRmr/kOQDT6H7/XACehgabXBlAHOydNvjRUvrrPTh5WeNclh3ll/lZDttqDTykzZEng8xn+HvvPjQuA9w/A7sjRpaMfafW0EfGoSv0pdOwuf16VLmXT6R5l18BZmhZqFB3Y+xm9T+KbGgIWKJd4p8k3IYq0HqTbxKv6ocMZBvDEZSTIUKRYBSbdY/U1E1mfRu2dyY1oUwKJbPv1+whvUStJsNXSr4j97YXp85lkNMtsUlAY5Z7pHMUCvXCkQEEw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538137; bh=ftFptD8KH2Z45yQ7mtArINNpfWLjp/zojcbMRz1U+fE=; h=From:To:Subject:Date; b=iPoHMnEUVKzmZI4a2aFYE5SH9ygZ97WSKqCNx91L6rqRCfNvNv88aX4ii5VYau4NTM5M8EjOKGsASJchYy4OeVNPI9Y3BX8Lrc/TDTSQDy2O4Z0QbQ3rTMH3y/amdS+mZ6NI1AZBelGQnyzou93hM9te0R1CD1XiohT5vzUyCujicfixiDDqMLBLaCJXONG6HVt2A2eTBD3N1vu34UGxYAYA92JtooSYvVR73klhBigo4M2BgJub35RnL4wQsVrVuYUE7PJ7sPzR7p6qN96YLCnNCP1tyMfW1ImAU1BlL/lAFDbnZsYaUUzEQNppe5GkzsVdEqrewid/KgcOclb8pA==
X-YMail-OSG: Mj7JtzEVM1n3JIde.1cl4kHcooKDKDWnsV2u5KSLTnUKJzAS7wfK7ewkVHKeu19
 KYJXNC4FlfZUP2Ioi0ZZcQUSHcaAwmrU0S6OjZgNfpXJTqesAwmqRoRSXv17z5CSBqzSdkAEO6Lo
 GYHnJMyB2yL.TpsYQfYgcBNzkVARl3Bk5NsfkZbRoB7VDFX2kBgbh1aI1_FQTnN2OXIOgU9TtGOX
 8H8991BLu3Nbb1_gvRtC1wI_GCzGyrSg4qkXLzqikCtun1HAbtHnNuqpdI1DhCVJfZl1HUTSbwis
 wShYayexX6fhpeLkLSGJUWAgMcg1tIGZ96lx8Q6pbW7Re0AC83s67aHeIjFZ9H5g0YV.XE391U3h
 v_YFYcc8xq1SD4e4cLFIyUalboVutbiSCzDPXqiolQUTEIwnKm2.LKyjK54XM.rFBvQQFBfTuhL8
 jAQJ8e_LsuXVRAeHAqBQ_nKFgUmOlzqOPByvSD37NRzCYGH_dypnEhh2jpbneHVC4SySY1CHuQ1m
 a_CtjfS9wi8.h6on1.HYAuXHSmcAIhPzXpyX3tv_kJ3SFnLkvAvT.sWSniaXSfucD6mG4TvOxaaa
 r1bt6hnTqFKUhEgisxmnm7rp9IxP.sSIv.D1cpcC.zDCiwmghdgx3tiep_jN6ddSXHAqD4CWfF1F
 Kw7p6NNNqLkORefDi3Uohi3FVKPBwnLeQJ6PmhqE6OfbH49BiQdTczUQt7SwD_keVhJKeAgvuJgn
 5d7bAnvBPHglRIpT1AwpOArUluWBsm9XPtJaLbJvX9KRpyh0U9V7.SjmNPx.3rpWxVm6PI6irRDv
 kcnfbQjnaWdoKm9wvuYThSgJJYQbECIr_FORvPp4DDNn5Hg1t9pCttrKQtYBcz7KfvbnNND2wAo0
 de6fPAzfr5f3nktcaDhsjFFWos.fA6uu53NSUpAsghl3rg7Hd5UKQdhDgE_.jb89Xav_mLLn099Z
 U_UmhW9TyNkhDsBtwg84TeIYRAb9foOrIUOrE8oiB3XhK3h5JnpvFBNWQRLxzZq.SmhBNnIqQyH0
 Ea1Dy38lVJMGp7l5LTL4Hdv53Ea6smMhcfFW9aQtQPkK.SU_I.OkLH5nePhFBrQZZOR54hOTDTKA
 BAiiPgy6I7hJQKF3D.fOVaYzVrRqRrXsYFYJilm4NbbECbdNLw8udgjUrfX59Hh2UaTgjw8B4TDk
 hTK_f1xuwoz6ciKnO8PZ09zA38LicQgHIaHt5zlXtxgjN.MP.mAARuV.2YpG6eEgNYSBGn_6CKx.
 kMj3dEuAn5BeATQ2w_3glnhYiQXJUxpWKggMXZJlOid1_4aGGoGPR_QVbQ8ewhTGwkCzQf0Huvs1
 TlSgzq.PLmdJ1BJLVpot0coTdmp6GwbewbzS33mRwPM17bEXqS1HRVoN6fQWM_LSP6.RxLCCHPNL
 JiFSwfQtgJHZ76Qo7aglmy4lhZUwLF5ikkjZ5z6QLfR3Yvt_AdpXDVMBzgVgxumLtAbrisOpVgMW
 pKtGg3_G9xaCaADSlXU3.Xjr_r9Asx1lMlYSo_p901M2vLZUXMJY1PCdKVBNI4vEoTXFjH9946q1
 a3Bw7hRqEYjSC_1EO35bObihXHlnhXsrUvi_6PKhXY1v6KRAtugCxfyQDndPwme6.tomvq4dgjmQ
 R1pLMZ0UV65R.hvVx5nQVFmqXK5yJGLRcMIgXAc0Las0B0dX10yOdn8tXZ7Y34yqQOY.huM_HjZo
 DXJut20K2F9lIj2.7dEClrSNBovf.MW8fS1mUwl.m.r6miUaMdVpq_FwcFjlqYSA_QHzkXQYSF7v
 O2E7iUhNFJFkbN88SCm.M3_R0Tr4kZUeXjc2WWlA6xgYeMJLb3ZXAabsf6gft3mytx3mUE7miWEd
 7HJmDK98zSSO_rBCzm_4eZCQFHVZA9aDBeYVjusPJtLIAQj_RcgY.X0xHhtDU5omC0sxPsUSY8BZ
 lPSreqGB11AWOhHNm019vIldieoX9hiEeQk0bXTutLlmypLIEAUXhBAeCEX93oWsXZSEfu3A2DdT
 Nb9AKwMaC5gjM6x1pXB3EZIZfavNTnQwUtUVbbHiet8CWF8uFig7vJfcVS5ct9ctTkMz.mEBriKu
 FOBwKrx.dkBn3I_6JQZhqMGQXzdJhJwy39lp3_l_FO2KIQ4W1VYkhARP_sDC6FsHMxZapkJWwmCI
 PROHIX0en88r..3jFYFtNBovrHT06Ok.4sTO8w2dToGAAOwKh1mCAeV2yrDmCu3eKxrFzJNvXgA4
 Fy6HoXleVdKBt4FpechVkkE9fm_g89tJd4lgmcgGPMad1MVz3ajt_k1eE0MFbUNXQxKZk2IJOvw_
 p8TKzTi_8HLt8yic_YbhlGgvyIUQdd8JetpTXOHjDBbiDoUj3uE5gRoH1pX5ABttmn96ohvIm1dT
 gA.DV3pJAOk06Q8aNBQzyLcu_87zOUDRiDxfelAp.q33dqcSALR1UUhhyE39s7vZCyOKUjSyn8xv
 CGP6j1oXe1LgogCKfFoPD0CuCDMa1mHABuKaisacmOkdH0_7y1itphBrL8z0.AsbL9wlHdK099Oh
 4zlbzmzoJoDwwcu.WinboWBd.29M7ncie1Qf3opp3IHcBHyfehhOb4qECd0xIM95.TSCWk1uC6UL
 xph.GWCpbja09ulamnUoMf7b7kG_tvFrpU7nm7Cnodpsc2NIbf4MorNLzaKffYl0MPg.N54algDv
 TPmll1biu2i8u2dXLZ_kbTrYQteYzdG3E1GbhTfnztOtiqY2xERNT0f9iTgNnZVDbibC8TR.FThK
 v6PyOGi1KfdhxGbT21vA3rj7BCkmN8QnRUQhUmMwIsPxQbQRyqqRX4KK_fkoK6ABSn4uLduyM0Gk
 9IqxFeKu3rGSXoTzCLFU5YD_CqddLMRYsFcbnRRfXaLazKTlHLKtaAG57b3i7uhoMKeRLFI7bvH.
 rtcnBHOjHF6k.Zf.zD_r0Ds7T7Yr1KsnOw0qDgl0ewLuWEobxGH2tPBGtOlA2Ghm9XtOUdFgdPTp
 Bdb.O7hyFXjAVfx_Tt1mGbTh3ClW11p1dzkVdmUYFdudgUmA59YJZfcxOh__38ilrv2qpiIyJdqa
 LJW49NphEHoTv3RVrnI_RHWTvloZERmAho4IdDRjuCOz_ZPDCf1e_z1G9AmGEyrvAtM3fZjampz.
 ln5rTWXaJGFgPINsyXbyUNuH7Xj9qg_Hv_kErjtfiaMjRUSzdT_jB_1Z6I1deIE1A9gHbeqcU2Sk
 hM0VOFogUTwhyJTvr5_K7fkPoQRPYg03qiFD2Hs8yyvr2gK_0NtoQ4kRj.8a44ifDqv8qddnx1OY
 Fe4x3Wrq3d9PlvhI.aP8BABay1xVnQP4h5Dj0pzcUsFKmKh2BOEJf1FdC0xcuqnrUGXbs2eNpZSf
 HkAxGcmqUOVwnwojbQkbKdaYRtEGs2LqkctbSvKzGtZ0ekrlXo7n92w6lteGrbwOG28uE8MT7h1m
 eKO696Ogg2PA9pzbxp_P7AbPttTlpucUFGrs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 01:02:17 +0000
Received: by smtp421.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8cb9fc6bd4831f998a56aed3eeb56cd9;
          Thu, 05 Nov 2020 01:02:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v22 11/23] IMA: Change internal interfaces to use lsmblobs
Date:   Wed,  4 Nov 2020 16:49:12 -0800
Message-Id: <20201105004924.11651-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
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

