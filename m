Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D1137FEAB
	for <lists+linux-integrity@lfdr.de>; Thu, 13 May 2021 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhEMUPD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 May 2021 16:15:03 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:37564
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231539AbhEMUPC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 May 2021 16:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620936832; bh=OFynm7Fw2GPfTv1ptUt/Gy9TgwZaREJMG/33YxcNKcE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qJIYnMjoz3yl+1TVYVi9Wrvj3iMuBPS4JT2ai/O1amApdDwfepNLzXlC5CH1auZi1GWbSemrI1oBPoyyh73Tr8q4GdyfxtsXBQ9v7M50tnN1yehdE+MwILYyU3yENg7ZZ9tnSo4TR2tV1uRiVBsO7DojMDiCjb24Lq4FB8zTjRdeZgJK8ohTvzR4VRH4R2ZomC76qtLT1LBq0UkUN1jXotFNAgqw0e2AakLg+fGMer1/mHB3NE05me/ddzlyN5/JGpZpVYv66d0oARoV0yxavbETwrdJ3UKQYqoViuEOKRdCRP9Jzam4KTCA/DjoZP4CrctLb+rGGCo9Xow0JrcEvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620936832; bh=7ru4Xw1PGwBw+K1Y9dag/fJvO7/sDXFIlqPbH1ITwPk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=b3jEsJqsrcKJa7QrSeV9HlXw2NCwPTIMZrZI9tj+8xZtVTCR+fSlXz8vaFLYlJu8MLhzdHEsq1DG8nBAIyKKh4EqvZSehv8kf7mY9KepOsZGDFoECoApZX3pk+QKHahJ+e/d6nuDxIV9m4PivdCZd3Kp0OJkcYc2xh8VnwDgbc54UGTTcN96BMqmUkIDpdsM2qAIjIqAO8eIJDZTNJS/L4D4mWCmpS6b4J8PU4UZzd+YRXciMryLM6GRn1cL/lFh7L5jSVsyOi9T9hDSji8DklsvXZLfAeAZAwcSZC68HPSxeuikTBK5Z4iG/1QRRL/4Tn2/Gm/fFqNmfsEeDrcBaA==
X-YMail-OSG: 9DpdEtYVM1k9Cgov9oecC6sUIzbTLM5wMHvm8IpSu8hMSiTwQsGppOSmJIJ5Cnw
 nqPoVyy3kytyY7_AzG_dHQpfH0o_vXszE24.B.JQykGiAvh8ko9XL5ep9qIZrwJOhIQKiqwnt0b9
 yFgo9Y6UnkMEEfjsCxX5_kHDKjvGe_G25WO3Do3xZfwnSqzpc2eURT5TTz1L8hPkwS.PG6m8DSt6
 tLF99fPaVLqoB6dGIGybYocLu61u6TGwP02fKr.BHvwf3u4Vme50xfYXWCCfrivwU3VtbAboI0mk
 qFtGymv5eTPr_3YZb03HI.IRpf5utS_ltl5NmdLDZHrY2jKiKUgpRu2MOofPmQkdobx8iZjwUuxc
 Ls9lPq16_t1HIxtQZcsHkI5c4Vvy_AGhV7_zL5KoKJMBaf41tLDN5aMPWuXpIUg_ruTpwMS9KJnv
 rCBWgkfvl2f8IHJzxV5V7lZyiNCOfiGlr88tkvjBSZJdgSh0o8KB3K6p2EzvUeV.Jr_8ayri6yaP
 6WueH6rgRYthqkH2TEPuSJ5DLovOYOQyF80Mp8PhQxCwVosbs_dQUqhxXCYB5vc7vcGRC71T96ae
 6TOsuvobxel54kpqBPIPGP2FxXIpCUpAwNb9ZByWVzaWGgeG_Nb28Fecho53O0icenjoqfJNkRC0
 tw8W09bnbkBv6mYd0XSYpA1p1wlrJIrRS1tD6uuGRJONi7hWmrwBcKXqqQzVtXk6Tcc3giruUghZ
 uvxhbKZlNqu4l62By1TBke5zCCiPHE3bAI0w07LkoZl1O9euk2pIiRmr1GUVcx1HZ0Y3Eu6jGCPj
 cwQLTYJeIMJgbcCC_r0ZFr46kwM5Kc9NZUSVH5YKG5bCGTKERLTBBAlaXYvSrzkhZMyvLyK5QGSp
 uOM6oU6ij56HL60rj0rHKluCgTLZ2OvXVBtZNtl.lNfvIQcVPAeJC9r1sSkt3tS_GQuMInbAdVBm
 FB3FvpVWHTZL8BIAedQY_VEvf.gwnHrhuW.8y.N0Wir0ClRvcHcyuIu0MSnYwlYC8dmX0PdcWHCm
 DfTJ35FgCjNszlJFC_dky74D9dfO9rnGLxIEKE.YnUCvNlnYYGspqixZ64SGPjNQtDPclEDDoVZf
 fwhUfe44EUaIavovZrOVg5RMt7C8pRFCP9LaHh5Fu2gQIxguhn1sIfQBTQsjLSFM1rOyplmDsw3d
 QBkDWdY_KR.XQgEzdgiJ4rm4Wh3zBNnzrKev1W6uO1u9_DrtTZ.kgF0FcnB6wGFSeCnyUZa1qfql
 IuzeYVB8G_cySHYSQ.x_7i4vgHt.h.ibqmOpQhCbLcFZRrj8FLpFJPeyQED6id0OexjtK9k9ZpXG
 KZIz8AIqUO2dfecsSQcWIGnhuhQPvq9EKK8cZKx0Y.8tD4tpObd670yBOONHQrRthDLWPo0kv2hg
 BQhM7DQt5UuiwiqI9oPsdUwNTskezBZg4yiwt7IN0yGHge80onsbBMSIqpLBlap9tZeQG5dAA2Q_
 dG4_vIvQMfIh7LwcMy5EdiOuqgJHNowHNxhrve1e1CGRszZqiImuaj.ctxSss.VsBWXXQapMCqjA
 NASQHCQ3JoyIJCFMe0JogecUFieu4vfh4.7SfGls19uILVGPFUoWBSUWVaJUdskxRAL_R8WNnEKx
 RrPG2uWiDeQcxd.kAJOvqYoxof_m4o5e0kwHKUzqWbNan8KdfpsrkyDK1XlYVT86tO1O8rrXg0RX
 ukFxlmvz9jtPCdKwSaKZG3uUJw8p_EYbe7dcbA8GzHPH4n3gxKVaJVsOerjT9kh70Ktdvz5uvE._
 GGEzY1snGezJZihmlj3eb8KCMMMKTRasL7oFCy8Qfa4.Dha3NlX_ihv_79K8BpdlyyOxK.AoqvdG
 EXwtLd2hukZqyeOu843xzuGWKPN2yOgT0PjDINr2JDUn4R4oC8JanAE0bqnKZzXfJW1NTUQ3PdbX
 gmjitARg2z.kkGC5MKhXACWB5PuXVUu766phzlE7QhP9v8r1pi5ZDcPIdM8CcmqRyefmsW6NZaDK
 fSnC5bV2B4QjM1Jg.KGllvBbjQt5k0pO7lBiuQAXgG8WtjyyLd2htCz6P99Rmpren84idIFg37Wv
 ondzAK5xXTnRPGTGEjFXtIA9VDT9YsK__1V62PnQFqe13vrGwMEyos14xxotPWkGtm_HvgEEtjRc
 HH2I0UQNVyGinGuDJQTap13PNOQlISk6BuB92ZZ.NDxnwD3mUHMIdSReZkzVksXZcTyVkBorv4FG
 jhgtZ2Jj2lzPuunSOA9rDofXxXiXurdQzMextRefl_d7ltRAvyYvRO2Wu5Db55LnKAuxVlXWE8Pp
 X5j3H_Zz3ATPAzs2lHE.Yza4ojIF3rY1gEJaIB9fBsQ0pztGqnjtYMRFd_MIR790TPgGODa59SK5
 NPJ5v3MCz44F_E3kRry6iWeeJ445sYt6udTHNDhErMbrfDPAz.PDq1Sp_TONdYK34S2tj_bqZRgP
 9UVPNdl8R1bkBdQyYGWPX2GLqp8RXHYbmBjyd7sWRbifBQ4B0Zjl7g6qQu.eTSkP4nnGbXerKWnE
 JfTdfuOf5J3uXngL3z6NofR1tqgwZJrldZtPJOSBBcUfkQlxQ6J8QF2q6jM921s_mY.LVPreguTh
 5X2rH9VYzXcN0wLFsjwX0drvSvGxdunfxF_VesPLSbfApw9N_B90pcyChb9e59N2MkMkeKlqLBlm
 juiJZ4cf2zhaUgkhzfTG0mU0Mjsaavhr.5RBus.KOBB1AU8sm9M9r_7fuHV4L4KePNto3pCfWEm5
 YayJKf8erv9VDqN.rYGqWeGzq7YUDLjB3i9wePMCF.0jRWM9lZ.1fYAxHuVELHfJWeRdewiZ68DS
 INxeOBvoFgNKDsurci_IMNB7ufqQcgpRXs7usDOVzzX0STJzWNQsHzRRrDYZyndVrMWlAj2AaGud
 NGCbKTrO49Ok2b0Lu6zujPRK6j.tPKo7BpTg_0XZqOc3v7VNSG.SzvwFQOVyzsQyvIVp2NY3hWAZ
 gjtfAcPgipE.rAq4PDtYc7PzYhZifveOR_Lii4yXmAs.i1nwqAi1nhPODWos_8nKDagXxHyuCJO4
 LSISQLgRVZNoyyT2aMGXdf1.Pn1oFbVpKgGxHaGATKhebSSx8qXruJRq3ISRPpn8UnWMbIlGcyF2
 YK1R01.NJZ4mWxe5lh0mizVwrh1JD8lRGiwoa_XT_PotM1PGekR6bc1DbP5W23x0_am3X2fEr
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:13:52 +0000
Received: by kubenode548.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ceca9e904f329847202ac738b4e9f228;
          Thu, 13 May 2021 20:13:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v26 05/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Thu, 13 May 2021 13:07:47 -0700
Message-Id: <20210513200807.15910-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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
 kernel/auditsc.c                    | 16 +++++++++++-----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 10 ++++++++--
 6 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ca9485105f00..916a0f606035 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1944,7 +1944,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1960,8 +1961,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index a2340e81cfa7..6a04d762d272 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1331,6 +1331,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1362,8 +1363,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 				if (f->lsm_isset) {
 					security_task_getsecid_subj(current,
 								    &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 392afe3e2fd6..71d894dcdc01 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -472,6 +472,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -670,8 +671,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid_subj(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
-							f->op, f->lsm_rules);
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+							f->type, f->op,
+							f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -684,15 +687,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -704,7 +709,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index f0e448ed1f9f..55f3bd4f0b01 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -433,8 +433,8 @@ static inline void ima_filter_rule_free(void *lsmrule)
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
index d804b9a0dd95..a05841e1012b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -607,6 +607,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule, i)) {
 			if (!rule->lsm[i].args_p)
@@ -619,14 +620,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, osid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, secid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
 			break;
diff --git a/security/security.c b/security/security.c
index 9471bcecc052..a5793b4bf684 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2669,11 +2669,14 @@ void security_audit_rule_free(void **lsmrule)
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
@@ -2681,7 +2684,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
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
2.29.2

