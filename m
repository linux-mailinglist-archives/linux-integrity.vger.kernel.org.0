Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966EC304545
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Jan 2021 18:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbhAZR0g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Jan 2021 12:26:36 -0500
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:37352
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388217AbhAZQ5p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jan 2021 11:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680218; bh=InRcyhhJuzgiVCj9DpUa99gVCQBHjUsRI8eU6VrdUIc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JrD3lugQ3WSmPdH/8zZ7ECI+xjTga08GKTLdotFWoc7XmU3HZ84WGDZtF/O+3042pvcoO8BnOM/uh6EFeOzySUWB6VORzH2+YYXk/rh4sYnukYc5Nypth+YXDSgGnQoLX4FC7iZbEfTPap1zyOcRPB/Qt+CdL8JilACHIFZFfVimIBSpam5vH45svV5sNZ0z0qvXqjzBMbCzQzlZd4Ws+q8bsHy6HXAaFA5c+aZMSHqbzNdErJ8klADeEuBcwIjcVJ4vNCHRtNFZbqhZXtmiXotKhdRMb/rdNUq0xKVPLT7TYY04XVovb5eRn56RvCh2p4iN9GlesOwkriLhjPLTEQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680218; bh=ffYXVAs4EJhTsq0osU1r5dNX99KWLHnfbAV41oWcqkf=; h=From:To:Subject:Date:From:Subject:Reply-To; b=o7zSv6R0vKBT2e9UuVNGErjEZag9D05PmQpjMNBXWSGdZXFOwH//vzm7vTdexuVTLNZtGgBbQ5+zmAwWv1HwXpSrVJTerIr1129WJE0fe1Gcz7COrgJ+wvRsmceXiBPyKNTOQsaX7bfL8qG92tUWWdsOBsLF0eg4fmntaUyb2fh6EHlDyceMgcPtTLVAM/PawMj3yZO1I+xU2dsxxR840/1VinjqgN+qD5xgtl0rB5oEog18UkY4m6sbAkza5aZfOT3j+5BrhF83B5uI5SXy6bRbYW8F8sGhuRHwwoyrkETqgnaAvSoBmCMjK0angb2LxOI4F1zPScDot7tM1ufHFg==
X-YMail-OSG: izcoDdkVM1mx_Ac3NTEsNJJUn0koRn5zIdGZ5S5KZ6RzOIUluVzv4WgzYq2bCpe
 XNMb8QGVRrNtqNP27zptGH9X9PpGqzXCR.yzC5hMC50b388pzqUoLIqQ7w2EknrdlFrwbchfebhY
 JPgKFMPmPBKx_Pxk3A9vBY.0YGOxnacYCw4D83LMTe5LJq_1HqYVRZmEOUoIirM5osBK0qDJdub5
 Zj9_nIzFmlPwgmlOabhx4360sLSzAdxAaOecMp3brAa6BR.4q4QglIX8NqumadszIlpduVLmhFCz
 tpLght7HpheKdDMEXyPLyBPU7sLXUynIkpx4MfqVpNES5I0bD2lUkruKjDpfChvxraOb6hhXfd5Z
 tWMmdok3ZVGyQTLDcS3FgeQvzg5qfDp7Umy2n4nnY5KhYlBoHVAtkPatWagkD5w62kEutZWGy6Xm
 w1hrCNoCKdpWM6mPfYOevh2pna4YDBCF9Yi7TqEjqYhsvI2gqdyHrfWbMUA0NNquqJ1aokAgo4RE
 AO5CIa4MOVEPBlZurBUChZsHqAVBgtdsrEbAkMr8YXHlCpUFSrenGV1N6efJx2FryGOncvE25E6R
 0CxdbEx.MKB0XwIq9hAXnyecQScNg9_YozPqarXdwW.haVSy5IvANpbLMeuEwQST_vqvklhOm9JV
 2srBUpru.C8PdAg7vW.le5jyGTaEK1YqcK9edv6euItZ7tN5T6oRqswJSI83v0VzboLjEkyZEPcS
 Y53IEYNzcZHwmtqsjUt6Or_msJZZCxeOdLk_laYDhUmiFIX5foSVcFrtYikg2knrp.8h5Eaq253w
 .P3H.YIcCM266PozyqvIUAl1hRVG2RRnriD90.BwLt2v_kqax3aF7ER_IVTOCY5Xpg.BN1nYk4NF
 jiChgxkiOqCzVodPDDk2edFPpFDNa4ZMIHLX_cNdyd8.58hguVp4rN8o16_i9hcI3w2CIIttmuK3
 ksoM7X.HI2SBI.LekvA1ExZk29uHWK32DHVY4qXbxE7eGEHhN1gshIKhIkYqdf1MgjCsC0z8WmaY
 cLIWUpHc.T9V2aSJKhnqbCXBpOuiXPMhY7eAgsGQdpDKafpez6JzhM8f18jCQnpp0eTPTnBowx3p
 LIHxEXQagR95ubV.bcfHc3pMADDALEgflyCzWSQOmaHxcQKUM_CfZTo8.Y_zfSK3o2bqSk81t_89
 BElrXGlJ6nEtWkXB7XYmNP3fypDywg5UuU3TpAf8rFfMTVpCfRXNeYCogCvXeKJ_wXaOP_v9MYO.
 ShiMHRpwJsDZhOt4MCjTvE9VO0Rzq4Yh064ngA.kK0dPn5NhKpB6Hk8zva_rAAw7c3cdHkfloZ.5
 zhG88aY8QUGaO40yKyFTpZSr2ar9QgFO0dXPyuwTiR6VWS.IYDV1UTFY8jZ9oucKQH_Y0actWBVB
 0rhtQiQJ7QI.pTrAgvTzlBbLD6Ace_dNTeF2ahBYfYHXX0Ef.IU.lAjfW5UOE3FkEZFgdXUM8zDu
 jDNcAryd1j.i6nhlGp_.lb5qfBsfA0Bz6sVcw4a08ivBa5vBaQ4MoF1ShmYIjlXVBBe6uphwDLGQ
 jg9TXPFl1qsr9lioOT36aGIZFXQMe4OCo77gTn3xA4luPGWrDQP4IK1AaIRCRodTodJ8dE9bFPTn
 HUWV6Afa9Cp6qAwFGiHNAUqjdbd0Psih.jtNsHsFOyJm2PU0oWJOlXsIm18yVBQ_BTGTKfASk0YA
 QCkeGARtSvdyeoRQ1gPa5TcniRYRvmV0LAHaKr3P_xE7VTFqh0_SmxWDry8Z2pDsqjIndJENDoka
 RMJRdPHxQy5nEROBCt_SdH8dAX7AqubKdhcLcK7VWcM6hvSR9MpQ86r73lrxRZNGloN.cN3CuCyI
 MOZW7FNReZNLGB5RAlV.a7tYIAyvq1PZliJJMkdFgS0Sgv7cdi4RnOTY3xQQ3kAuExiaeght_FCE
 2JU3veJMP9Ng_O5pcUvn8qC.0DyKhEM0yvYBp8XcI7lCU4.52LW53Lftsk4kBR.EpbvSyb1tIsJd
 a5NOzWGTu5KO7Nay8IANH5LggDWX_m2DvCohNK1ZjVXKfqIAyuHQZZRq_zqGaiXJy9mNpUgC1YH_
 8ID8YG87JaIcSkrbUoIqx_6d5Wqg6e4Ghc6zthBl7NfDqFsTsstD.Y2_2..A90x7l1GQ0BswA678
 8ZC9P.6hlVw0FQvyVcDvWqj2WMVuSlGHQaT7JgBIjxLmZbucYUNa8u3jUe1AfnMH0CowRq4Xjgbz
 M1LZou0m__lCkRtMiKMMsnt0dN375Xy2dO1tw5rzdXHtgKRnSEERs7Y3fj9UYS4EYfwV3UETsxQe
 LA0h_HzUMockgAD_ARBCIL91pehYo4_2tT3vB20bBjfnnHTDYC5ECsbsbFZnG35j36AeZOi_jK7Y
 ZZgXL.OuEpMZiYbSHuenAuvNPr_DagN375bmHMVrA_VWYlMl5Z7P1Z6O2FLfiRvTu6cEqfJ6Rf6G
 uFxkQmV6EqdLcZIXtNJRl6G7aSg4jevT0iKRRXMJSe5Z.8vHwyWt50qD4h.1ra4iimxYfhpTb4uT
 Z_wCi7FUprkePnOGZl2mxsmNGS4zNOeZGudL8EM9esRdCCQ7umZ.d55hr_2tTpzfS.Z3VnZg.vnz
 bRXxF1w2cBWLuA_JPOUn2sn1Mo8_ygJd1nhj2zA9mQid7Uh.ldOpwWBM4INzQUVKxXe06ugf2dcu
 3XoQzgRZ7XmmEqM60OeBZnjpZANSpcZTImPzKheVFCPRq7lLfPbxx_gScw8o13Wwfzt3h5EBmuTw
 JvOwO0YN5QHhf42tSVSTVFZDqTJQafQjA2ZL0.C1otAIpejHy0UDRtKxzrhAu3G_zj75a66RmKY5
 _rzs9JQY4Ro_EXjoUdnoPn6a44e8Lzs9mxQqGRELeVva9ZicO9fan4wQG8AhjlcNTMETMJWIyOpo
 3GgLICkR1N4txBiGMpkc2FetklGV0i.aixs6bVfw9gDqf.kGsp4SCJMevFmAJzWBQyvnzEmZD3VK
 5eQYb2nYfF_TmwMiAxz0q2esn4hMzpjaSdQQdICPi3wWIxCWxh_VA1HMBLe82K9ITFw.veYwlhCj
 yEZUMnWT6LV.VwXcLfQeCC6Ruu5kW9Y12aeejqd1ASNX2te3C4L09zaCahnjzgLYnMhNpGBDBR_y
 BdEWjVhe6GSjldPaKtT2DEyCQzNIvwEMDTdc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 16:56:58 +0000
Received: by smtp423.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 32fbc15af0745cf1933c31a9f9c8038e;
          Tue, 26 Jan 2021 16:46:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v24 05/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Tue, 26 Jan 2021 08:40:48 -0800
Message-Id: <20210126164108.1958-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. The scaffolding function lsmblob_init()
fills the blob with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the blob structure later in the series.
At the point the use of lsmblob_init() is dropped.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
Cc: linux-integrity@vger.kernel.org
To: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  6 ++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 10 ++++++++--
 6 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index a99a4307176f..112aadf3e7f9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1902,7 +1902,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1918,8 +1919,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void **lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void **lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 45da229f9f1f..e27424216159 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1331,6 +1331,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1361,8 +1362,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_isset) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 9eea55525480..a8335cbe0091 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -472,6 +472,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -670,7 +671,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rules);
 			}
@@ -685,15 +688,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rules)) {
@@ -705,7 +710,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 8e8b1e3cb847..0c520ea21677 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -430,8 +430,8 @@ static inline void ima_filter_rule_free(void *lsmrule)
 {
 }
 
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					void *lsmrule)
+static inline int ima_filter_rule_match(struct lsmblob *blob, u32 field,
+					u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index de72b719c90c..265184921eef 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -576,6 +576,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule, i)) {
 			if (!rule->lsm[i].args_p)
@@ -588,14 +589,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, osid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, secid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 		default:
diff --git a/security/security.c b/security/security.c
index 05ce02ae7c46..291db266fdc2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2605,11 +2605,14 @@ void security_audit_rule_free(void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
+		if (lsmrule[hp->lsmid->slot] == NULL)
+			continue;
 		hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2617,7 +2620,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		if (lsmrule[hp->lsmid->slot] == NULL)
+			continue;
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op,
 					       &lsmrule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.25.4

