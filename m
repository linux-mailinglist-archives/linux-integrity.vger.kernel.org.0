Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033AD33294B
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Mar 2021 15:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhCIOzU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Mar 2021 09:55:20 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:33128
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhCIOzG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Mar 2021 09:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301705; bh=81yGunU8L5v2kyXXu1EKy02xORPdxecNuXIpIqC5nTM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=t90oRP0I9riMM8icyk2abKaaxZ6bj9sNe0jq37XNkkXMNnsg7fqMgMU9DLgjfsapVsyY1tkFtTab0kPy4CYaa4iVCuIq/YGLOAxDYDa4Y+EoVMh6Hx7OZn9f3KsT/JLBpugXyoptmxa25geUd/k4DbTegXyJkNK1AagtasFk5ReXjI3+jllqHUI++4S2nCaY+ZttfjaSC5svXWVYAobk8dr55S8/2z0ZnA2IH4zqY4Yl0+5rrO31tNKayHh4AMp9ygenqhQBEMlLZL+E1sQ1cbHb9P3QynkGfKquby7dTv5LpSvM3IV8jOoW/deHpmiCewZePo6Z2hq4CS4w9/5YFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301705; bh=MCQHmC90LZMeHKiujCf8q33QRkR57d43yUiOyxIwwDv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QVuzQdNYfJYqA48R7XYY/xjsXGP96NQN2wktfN0HfsgIEPOy455tbKwemcwGqKnUf/YQ8lIqRhMvBsa9Uykis4y+q7QOJNaEw9tZx8p8vfx9nyDuloZ12hLDIQOwA3hpozb+x85q9Okm3ZSzM4ZljuZP+np/x529qoAt3pB8+xlYgjYIFm1no++W/0yC2RHc8P/NmxNM/O3tvvuzOl2VTBafLLAphfGxJuqPSXDebplUoMx6y+s9WF+1Iphxkji3jCiuN1J58M1vCFfVNHBJ1zH+1vrJtS5ovCh2b+auAQxNIYIHCQQSZOpOG+naJ6exGpBuZZVq393b4XhdDk0C9Q==
X-YMail-OSG: lpQGXRQVM1lEgAAr5CUd6lAESi25MynAb6WyHWh2buYIHtkDBUTRN29goN18xw9
 cAFYPISJHE.AUZ5Ob3tyy1eK_0Rm0CFxmWp8Z5vYzC.0Guydri9IXrjuxZtel_WixU7xBPWesfAl
 _Kf9HH1EPgHZf36fSVzjyesjec0OSvKk5gLei1557yCTbihFAQ_XporlzXI61d6VTAIlI.nejUdo
 kXX1Y4awbAoHzALQE685MAD0dSSkYU3SRPzBwy6T3eGoR1MdP.EMZSfNStKX6xcO9etzAKZZBmgB
 yuQKJ_kx0oZMvWhlPaAuRCx1HRSCFqN1n89Bqy._yD2BHqIEtB.p1zrUoidE9WU3lP30XjhV28C5
 PNeERf9zZyODSmUCMFRqtTrLFKzq30O8GLYka.qhKMZdDMHOFCPfIAJM3pPd4ufcHkLCEZhbPKoD
 y6QR.wckkDvm8OUseWXPDSY4NNFRzuqkU54o815VWLK12lZ2LmB5Kirq0vVu6S0OFSOtpZK1d7Gv
 zEk1kIRFmQUk3BrwlNfZf.nxx6QO6lO_9tAO5Gq8z3UAxQssnuFWRzJNG8ez8kTb2MT3jUYTh2OP
 uhTC_t9lk8ocgvfE7cqG_zVZSOg5uOmhvM6DmbeGtOOrnkSbuiwhD0Bwu3Khk4fOIEYa8ItxzJ9g
 Rgkco.q0Un_nlbZdHmDlpjTfrilU_SrzHYH_ktupxpSGs4QCbU8OaJlppfuNa2VwTkX7dwfLO5mG
 3OwbccLoNP5i4bwsLmtTeX9wZlWxwJRq71IahamYGSxur0eFHzQb9yyqGbjN_HR3GxDXoxFr3Ef2
 3hmNFKPYYBLK8T5pilPFnk2huBk.05gZHA8ikddsM7_omoA1QjkKnE6S.NY980KPtcPQ3pGr3g0G
 NQwEsTd.U772Nx0ERrw.Lkh5UzUQ5yrtQPPfm9FqWa1K98KK4WaB.edUWGgUSOl1_tuXgki3AZBS
 ueBEptKVlubYxBvtzvUHrlnd8kKH_63e7yLcz1BJPYvlYoi.OFKRVp7PU7re1vNGNGL9xjO0wanF
 9vfiOnAafTyparNounSDZIzuzYiUZ9iZgOZFGkmMZ14n7x6Nh7gUgGUpuMKCD6lKUtMpb84xekfw
 yPHv1iJdVPaoE0lzynzy9pa3E9TI4tFCprK6i.y.p.1ZXKGvesIkgTjaA.0CV7OEWmpJwR3_aeKc
 23mauqsbNA98TBGxxei2_NVJpVTAGPHA8qaDRLGgTRFFhTQ70S98mAxBiVVLfeZKvgKE6pZP3aU_
 Wxs2_58aMYQk1RykozBEm.U1DjVEohSVcZ4KnJU1.llNACYrJuW8Zv3qi.YyFi74ngEV6EUw5MNR
 c2UWJ2KPZrnOiOzLd3LIlsHFbjXp04qzisy4QmHGlPaUjkCUGDOG.M4N2tLEyDO1j47Jabxlptq8
 OQ8xMCaCGKRI8i8DSBshb3_Zvy9f09onHlIlP0EqEsfTnfzDiTsa95L_rvZYH8kUbHSX81FtrlZc
 v2oyCkG0e8wVSLh982CecP0TdaRdzzAAoKkdNvls2IxI6bbi0NM2vwWoyfMaKyLNHjDBusrLjLKD
 buGepU1gIC1J_gfsez0JgOiJa344HrQ79I9i4aRPQ_JQSTuIMXBp_q5lD3w1G7fB6am2Z30rGlPq
 uxNOaKkRCgU6CEJt1hEYjBXVEPJmgYkzZ8F.P4HaUXSPTUNAfRjOzP2RGZfE0opKP92lImq4MgHu
 crW142C6ezUCoTI7IK9aaWfQ9BcGSZ5oQAaM0ggBIAcnkQ1cOho2vDHc04bb9em1ZdHYUSKyay2Z
 elHeQwM6pKF1rQq2gKo_k_X0uKyvq8QWWp4dDJlivofHr_uQr2hmw_eVyHUQrF7nV7td5zLNH0.H
 j2hY1L9DB027Si0qc2JhySdUaItWI2lxZs5__.Z85_xphRLJ4SwzxPuhRXXmLVIGs.ecqgNGc.LB
 ACGNmLbLGmivvxlSGoHfD9at6.TYVB77aCOwPn.nORpbduVYTr7ZR_IXX1uOOPz_cQR1mwLBSwIN
 vXvTleCb1WErv6gynjjIrFBXUubpNc7PLAuPxyjwdSyFCRD8RAXNUsVAPu7DMvddS1e9FKqsAh9T
 eaqmL3mwKbzRmNwsRJlppKoEfI.0eihu9NRNUf7W9qH_4mz.4iEDGJq3Gho.II1psg_M5akez.ha
 IFcb0VKJhOcPV0CyUG0inO1sqdMhSt.6hotoHYor0t9lyyG_bV5rH9QkIsz14yTpx3VNwSHptKWf
 3t_A2WumiDEwxCX_KNVjyfkpM2ckelPyyb9rKp6v7fX2djOTpmbsoHSY2YU0R.LLJBe4VR_MfBR9
 fQ5bH0pVpN.SOmqoMKXqRFwjUxIumITNVIFdxhtk535P7WcBOyXdlIf6xvDGgMW89ftKVQaBwfhp
 gcKe6Rdwd_AM2BYO0qvrBgKz.B04z.uQqwc1BTLKIfqoeRYDdYdLlIVQJMJbIwWRGEG4v_oVJ3_q
 m3fqnSuQglhc7b6JyN7xWodlvOVsTIB1LU4ho44Rfm2uTIrMTMamggS_cwWJCLPi1cYzQFrx2_Gn
 uZOgiSGnTTXWCfUHfXxV1wa9ET8.sbxaX3I9g0aXVr2c3kQ3ootEPfGzwEA8JFDUWlD63GvSIK3d
 bYX3gSl7A7akLMWEifwj5IbYtEjIi1LRiwM46IIoQf2gnR9lbvIrMGO_tlCk0cOz2m3aPqvm63mN
 bE1uZkCym7_mzXkDWPxR2APHOSOc1ev8LHJfRPdpb85SmY_eUg8KVb0i5oj3nouukIo9zqzFIuPj
 EEzYADe9Z.MBHSMzByCYccodsBvJQeYchHLL_e_oSzQVdlmMbnXWZlaa3O03wUyLMTeAT2_HHpbf
 ey5B_qMHGqfRfxgU0yPTzNTw7Gy6Dq52IgCydLaS50EJ1nWKcX70UXlBiLxeabRIxpVvkZU8VTo_
 y3nZfr32BYYZBAmI_AmCOXOgOVHTilJ2486X6OiKwktGfG8liz4FtH3xZ.HdWMFzB8Av6avDVixo
 1hqrgthfaNb1idwAMPWwaptP.crDMC82sg7Y7QvkgFTeW.CDuMoiBFAwwfpvx9e8SX5OiVkyPBaT
 A2GjD88A90OZJvpJYwzzLOXS22GUnr0gV51Ync2o0wKH6gBO4ChTil_g8aiZM9bZeDsnTR0rP2.N
 .N1W_nqXCl7Dt5Rs56EWwqMEFd8zvmlBWxaaSxJr50rWSBCVzlGf1UtHGHe9ZoIr8mXPg9aG2OWg
 b
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:55:05 +0000
Received: by smtp416.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID bc431f58c3d808e2525c2432f93caa75;
          Tue, 09 Mar 2021 14:55:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v25 11/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue,  9 Mar 2021 06:42:29 -0800
Message-Id: <20210309144243.12519-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 852a4764a609..6fa19899903e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -452,7 +452,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -992,9 +992,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index c2fe8d6f0238..59cb2c4ad149 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1966,13 +1966,17 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
+	struct lsmblob blob;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getsecid(inode, &blob);
+	/* scaffolding until osid is updated */
+	name->osid = blob.secid[0];
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 81d45b471a62..1cadd61533d7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -606,7 +606,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule, i)) {
@@ -619,8 +618,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&lsmdata, osid);
+			security_inode_getsecid(inode, &lsmdata);
 			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index 67127b6f1710..54bca6d52ab7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1502,9 +1502,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.inode_getsecid(inode, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
-- 
2.29.2

