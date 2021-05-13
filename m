Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBA037FED9
	for <lists+linux-integrity@lfdr.de>; Thu, 13 May 2021 22:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhEMUVm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 May 2021 16:21:42 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:35447
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232555AbhEMUVk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 May 2021 16:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937230; bh=7GtHe3J5TFyvgnmWVe7l+HjNIkfgPM3b5UFEgLeQXE0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cxzFGgkbqxphC/jGth9MelT9TfSCALjojXD+yIfLTflkgwCdNyg2XFQQUSR7hdL2MP4AP8/75V3hvjlpewX03VtAIq55enr0rWBBiKlAOPpGh4vapxaNQbxWgtlX26+RRFeQx+FxAR/jgef3yYaXGfWhguV1i/35FYb3FJsASVjpC5pUrjK6PCZwagdjPOChhCOc5cwSj+sIjvd1/scDF+6cQSLmlps1nCFX5YnWCagHW3MbC4OEBOFye/86HRxlVyQDhCaqpthQ56VWqdG4Y926uklOq4ZVlSDhZNfQncoorVKH6s369kmZKY/MzVueVww4D5HFNaFDlldZMbMf3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937230; bh=CoaNrB3CRBpk6LX9pfQp7CMPBksU3zn51/3s1lo3MoX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=M6vyo22m24h85yXycefGyxIJPDWXxKP554WioNQMuuhuMCpfI4/Jyndb0n0WXR7lJQzqgALplHMubyy3DOJKz5ziq+Z1YsnxYNXJht4xHphWkh7pyRcUf8H9Vb5xFcs+PsBv/XNrRC7fm8WustF6gzhnRJsD9C5GL+NLJ44VBaPiT98c5y5t27gD7F8aXzD0+UY4N3aCJdoTifiNn3cMcsyneEO+K4EVPv6lPpUSmi32zudFp75y3iWRwmCGFGjjGaxUnJejv+5DJNRlexojqP5bE8Qu6LD7tD2IhiGmPo0mXF51U2adhYlJyL4ru9A28e1Sdrt5ks0ZlpFDUm4YcA==
X-YMail-OSG: oVSiAMsVM1l2nqAKLeraETLGtxNHRDHFFqouEU1bEPPhiDmAQNGNZgPMU6Z76St
 SjvpBF2v6rRrkH7sP.K2iKs4c4qCWRNZIiX6f8_f3RrbJiLDAicE9Ta48TdcoCCO4Sa3CkKx.LWw
 et9nSrkVpjTsypeeir0UqGFKWMzhQ.whO_.5dopMgf_k0DYY0FkQA0c2MGiQsT_irjJx4Fg_jO0I
 YynhG4GMQKuO2hIDvdI5aZviKHcoiCokWTMQThB9eBOtNZeeDX3uGBnLnHw05dxnYy7I2jXi7F_a
 tfaV6I3wny0xKeydacQYHKa1zW0Tg1rQjXNkrSOzLQSeuhBB4hhusxrqDw7OL5BgGRZeR8_CU_9p
 sYyZokKdQW9XtEWIh6CsLO74_I9qvDCBnpVce2PWJPyoiyv_gR5DUZAm5zluBJjUMYYTcaPwOyEu
 1Sfgl9PSCd_pJQE_2OlVdiT4PTHKl60lAiHcf2ScXwO_qa5JSfrnl64CrbsvYiJOf1ol4kCnl_Rj
 ctQ4CzwSuAxN2HeJ61Q0IIVfGyvOLmQ.cYT5Wp_voVPUAUZ99ccuUE3Y2t3PJOOPiLpt0k7neHg6
 yQZBVrWngwF.TYwGpu5a8E44U5OUcOyMBRV2bJ1rJt.0TYfDBobkTJwYrkSH9LRJPrE5Mt4pG3fo
 Fa8QXM3bs6Dkefuo4hXmeLabEfAp8c3.HlDKiDct_D05v5SbsGCFThdjSNlCvjykY4fBV0QV7QrE
 WP5xbFBM5lE.eF8l5qiW0m2N4oFB2Bx8LQmZpghrOmsGewvweYwnYrnCDjuxTeM786cUdtjkRii4
 cefa6SbwYL7jDPpN7_DQUGdCYXUV5i1uvKPqQkh_t33nMiVdScBx2mpYOTkR1kNoLBK8BG6rKHsg
 5IBZ8NNh5fZ0EMcVRsoxF5jQPJw.VbB2IjPf2CXdI74hP8O.zz43OfezPOm5FIm_RfWGcTSwsPba
 lk1rFKI4WBhGmlg9pD.c3zD_ZlhQAr.5tE5DARn.7GioxfIVCL1_9UBQFhNeii2AlvtOZLM0yLm4
 RZRm6dyBBMqiIejVZLzrBzMMbbkxmFzTTUq9R3LIS935boHPPem1o4WnYSlnPzjHMkiz8OBQQNwz
 QuXgFlFYbj6WZWqD2WjrVQtT88oO4IL23hNR05KNMxVX1AhqL5wMN9Tinx72R9pyup5VTZb64XV7
 ecmM6iUH8luYqZhSkYsRTsP7X8zl.SxdsR8.S2qas_TeqSxYPbZ3gPdEeeyQfOYHU127lZmxouYU
 wgT3Pobm_aWkRmy6CFbs4jLWk6skwBVKdatwLZ77lunuJXmpLGCusm4BPSIyD_UcWv4EtkmRpaFh
 y.uW9ojBw32Wc9QPRdZv12fLoS8H2lpNjMSBNTRKAR54v7qh0QgTvo3SnQ_.8BTjEDrWqJGWLmi5
 UhofzDLX.8y3Z4YPJAdIx3DEEFUyrYUEZ_KmL79obET4i8w9N9dj4azF2nDcEFi4PkTyEPtfcfp7
 Vm.om1pRXUk0mK2HNlHxpQLzVGtsU9EjkBv6_l7kOyxHMaeNNQ_CEB.rL.T4e1JW3Q2TQmwQ9foP
 q7LViFeSWVtKetMuwOSHF3fvc92g5LTjGZVye8ZkatdJjsMWVyUYOYxnriFr15ixlHih6mz5_nxg
 eZ4mSc0mg3JbQnZ.zSI7NEyJnDxXJWpHs0I.qq9Nd7kWyprDobNuekRN1e.R2T5Zz9Vf6RkQ2sVJ
 8xt2_4DEAz2e7HSaJwc.QmC.LKxSI8b8egqFP.2EqDTS8qNqDwNH7.FV9s1j5rLx.0kBfSME_yhX
 MiYHDIuLCA8cqGfqq_lUsy0AoFUW3vGJn3BgHL940Qbj34TX_TzPDwfLuqiMIJV.Jf.VtGqr6lB8
 Yy6NB1KmPEmENLOVT0Wcej0SnHlcFk54mP4sXg4Fop0SgGgVDM7advhAeudJUs8Cfxn_DcbU32_t
 gXuFsuO6SG.4Bkm8AEPz9Cp6jAASw3HpwytX4ehbLbXmsDX3ezr0OCJXhToeL9dPV2R8dousAcQv
 8PItVbCEAnlPDc3z.ik7ibS5BSGa0GpKME_gTE5IHXlEV1joR9lCpZOK..VJoCgtu8fHNAkB1PaI
 mYXBoz1Ti2LucOydNuQvsPRippuiPdmy_D_3A_5uyvEjxBreij1BNm8fBsW5LdamKlauV.kdM2kt
 z6ozLtbnKew183IqbXwngzAQMBz3xBRnlKZrrmuUtbicNrRbW8Z5kmzkH0k92u6XK47D_n5gsJe9
 RAWb4oe6LR_JJL3WUGPJYBAmQl7nrs8oIWeqsjHuDEB8HerJc41fXl46vLTiBhJ9xdsx3JD0T2jq
 nlpNOTimAZPCr3UEnaelz.0xI2INMsxmCSd8bD0HN6V7p1CaXYN2lgw.0iFT_eJ8edg9kl26RhYQ
 AxT81Fa6BjjGH66nGvRqwc8Fv9.gSo7zfas2ps2xUKue3CTK_Ets9JaPkDU9RGVkMAPyJqj7ngc6
 Z3zK1uVZD._eYiZezqV2ikl5TPjyONNaihxmzwiL_1WwzcpH_Meyz.jAZXdnrTKlvHEekxCFGQTR
 PXfHM8N1jfTbazHFw564UICeOkQdbyQvjVphfjshQ6Wu8_oasPYUjRv7CXQCWbgj0pC7d7I3G.jA
 PMd7cDpr6L.94zgeknG0o_9wO7dY946e7MVDQFoa6GgJDfpymRTg8l0gA3DXH8FTnjkQkvBjywu.
 6TBSaMJSsUcayuCd63e5XJyP7pxmU.Jc5LvYSRmCiHBnR926XxmKFVipyHPpoai.F.a2_jn4_.yy
 F4xhmn_Co7eDpqZdhL1NLSU6DKRGFSX2GWAySVlcY2lwgUMcQ54pKrCFgBSjLN2uvP4P6p7dLygZ
 igY5e0X2KjSVuCgKvu7cBD.VBroLYrcbjTCGNAvxEpjasdU4bQzBTqICyKnyMevlqEu3XkhRE_kW
 4TpQ1j0sDlsV_MnMINCVcKkZzNuOlwYETJXwAs3D54aeByGdYCtLukuci_5zau8QHyRowU8CPmTR
 _ZLPHHNIGlhEUaAeU2ad.L6_IhRjGA8_3z3xhNufnSSTI6x6M22bM.stgqqEeyA8a78X7c0768Uu
 IQaTOgrYv5At6HBpviHZi8f8gTrDUi2x6LnXwlpCBCP9jJVOErfyxNZkZ9MVc7.uSnoh1bg3WNL3
 EZi.6A1soydGG6yymLSK8mMCrXh8kGlEyZcqWJFmGnVj.W9PaeC2FVRq8hrg.w5j0zF_N._ZvtYi
 _o.WurloS61pjq_o6vdmjO7LLY6UGzHXlwbLd25rplzdHVMATqw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:20:30 +0000
Received: by kubenode566.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 884178ba24598ea363d74a2dc49a1ae8;
          Thu, 13 May 2021 20:20:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v26 11/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Thu, 13 May 2021 13:07:53 -0700
Message-Id: <20210513200807.15910-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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
index 60f4515b9181..64f898e5e854 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -454,7 +454,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1005,9 +1005,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index dd902b68433e..6684927f12fc 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1962,13 +1962,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index a05841e1012b..5ee7629fd782 100644
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
index f3b985f76dab..54f4a4ead69f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1546,9 +1546,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

