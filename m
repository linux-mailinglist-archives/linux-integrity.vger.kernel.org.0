Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37DC3A386D
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Jun 2021 02:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhFKAS4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 20:18:56 -0400
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:35213
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230482AbhFKAS4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 20:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370619; bh=aE67GTy+CXATARYAx3N/UHATRCEpQghw5DPhm/u2kl8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uWWsDKdhxF3OT0EJAJ/YF5ryd286wH+GpCqVDEGMuGzLcpll6PXHxSs1A6Il7lmmoL+8bX55F2QY6klyAAY6yObYRSZ1iTIbKgSWhKGfJmYYKzk9mRgQCOey/huj91JCCcPztegCm245DJ7cWJYGBjHtBrle6CA9RVvBToYvtCWqYyHS3bwWPwlXY/E9COm7du0B4ZHoEyE1aaGBa2dfl/jffbFsHM+aY4ls5+vEhhD8Bt9nnRBg+QK3wVvZUfUGSuZvzN5hKvE3iF0JSVXHWIcs/yhuM9qaAKK2M+LoZDmc7QmVmGz7MajXFTpi8L8/4In/VH/GgvgNFu7G4sbzSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370619; bh=1RqtYUyY2vEQ06kPiAedaAgOxH90dBEgfdiP57Wo/ug=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=A9bLTw2APY4G9YOkzFmfE0hT6Wqcz0WYAw/zIq4ZBmPPv3b0TWV/XSWhmj7HuFrL9sEhngGJCp3EyM8usbTQUMWT4biqKfNY0coaLaeojo4wXPaUuQYYkNu+/lBlcOxxa/oGTA+KhQy/F0JVuW5n36yQAahznLglFb59S//VCaOBqSJUIk0vk5F9I6BWh36FwdAgXffT9h+0+RIL6FZOoXsOu28Q7y7EGUxg9ZjHpiDBZYfHhi4uFtcGWuRThcjwXVDeIDTitbUTjQT/BcCmgViue7cyYxjeAKEraS6Cgu93WRVOk9RmGiIsCtho2NmIL+E42CJ3pXotYUKAVMk+iA==
X-YMail-OSG: Lwsrww0VM1kJGSxJUmrmdWjAyq2onfoUVTDKCdOQO.LH_rnIc4E8BZYHNr8HFJN
 Bf_kqkzxkqTAxRpNNqf6HE5Awb56ERRkyd7zwwuZBAWu7EVmN1A9jEBXpj4z4cjBL0aDtWVZOqAN
 mpdfgEUJpMAJqkAB369JwYKsTQJ_V_JnIYB8IbFSp8z3wZ6PvKnSJA2Z35b1nHT1rQJIB0IQqc8G
 c3_6lr7vGT8_iUjhZtjgKKc1VTDv4SVXVR2Y0m8tq559Tnk6EUL8AAtMroFLxtnuy3zZYHur7qP3
 CkRW1EOXcl7bHNqD_OEoMKA12C06YB3d5Wusz9sMD52lv_2EENB9Bc_04Z.PRx514fRxv871NMXK
 O3eNWKcw5b7YG0eg_4QNQhcKGo_HJKNU1UBLt4hsXHkFcMLxon4nTZRGpl9y2IXrnh099V8R3oSf
 a6YAjlXmyCoNRRmKpYdjGTgeqPXe6OH0E2O59F7TGwo2PbqJEtuaj8NEy3YCjHXDHWgVOeRgcjqT
 J21ETv4hiVbQQPia.MG7Ie1j1KZpgsRBXpqVxQ3f4z7YQPRleGRPLxwMvGbsgyHhx_1vfn_dVvtO
 GwKg4Q1CygPzGQvcyivFEkxdCLAuaeO_p.1Of8iqby8b1yurm1mJxBnU.6KgnBuShuGoFG8BNu92
 6yd.rmxRo.D3KWdi0gTTZALgI4N0TUhYFGrHUJ5wDhTRVm.R_RaRK5tARlr3el81lnTPuus4Ay2P
 SOE_AHnMyCaaM5kUm1Fxx4yiMazXPbZx88JNo5hM6Yb8d_5gQoEteIG7idB8mixADJsn9xXaRn.6
 vE03wJ_pfe6uA89S2liSKUypWBIvSi3AgH1lycXMzuFJgbF3kJlzso6qqpJNBVM35nqMBlV..JXr
 0eGCwozPRononPACNS1YGxyfTx418GoyjewWfCHzK_IGpcsEU64op.3h_aHTn1xDIhDKmjb6yAO5
 BuiHGKZjJFWZR5J7aRRrRpnOWZZ7CLhVZM3ooIJbAiQGZqWHKa_KzwLnRPE6G.fX2I0YyvaldoOi
 arobM6tWhaDP58p4hneFA0w85zZBnWTnWs0ExUw7aAvRdKyJgganX8dj_exKzn5YbhiDFW6keZFx
 8kBqmDyJN2ksteXVAMbz0OO3DQI1oYQCuyvFujcRR762cVcnVqq_MJosl3KF_UsPuUgZ9BrPxuEI
 cx5NxRNpbPFvz2lZQI_TlrH9hv6fCdn4_Vqo.gcs5M5e8GwgyqOQIyVRQJuOA49sxQutIIHheOv6
 deygtD1UxwIgJgPE1aS.WxmweXoyNCQEMoPNbILzeBy1HQIV7YX4cH43EOEK8LtrcFb1la8FHhXu
 yDpF8FagYfOwzjiknTblq7QCR3F3Dgyb8wtCxIJfw5G7SMOGnftCnVa84_Uy3CQxnt7TwO2iRLgg
 7Qe0Tu6UrPfbUHukQnE5oH8jt2z5RYLwTA_4UjncZAkreChk71A1LqvDRwG6G0fgLwoJ0_IXj6Bn
 xe05WIav7vfT_vZT8fu5TMwl5xsKXfQ2AUOmQwVoAekUK_hPfJ8HJrPWfYr3JvIiOIoNd7msahuT
 JO7LZUeOQXuC_HKqpBimutviJOMt8ooVpRMavuErcB3clSnmyU_OKhOGui420ofPCmscL0SP83CS
 6fJcUqFB2t0twvUkuFmNADRvViNW6GEwSdf.qfJHTfKsAvjAw_zJgVXrj0uHb9H1mPssIfb_mT5f
 G7zKfS.OPybbqlTR9Z9PHgz2tWq1whWmL.dYNcQ7uYUqpMtmVsK72viSNoAiIJ8BQcuS4mtHIskp
 xfq72_s7ubr_YAbKd_MSSuQpkKDJ.yyQzrgroB5Vb0iN0IRc.H90cUPPlNhTxmFOqvpgFTHun56A
 CP4yiEKWWEzrycixLJ0Vy8EF5GeyHo7BrKr.y7kcCGyMc_pfQMqNswVmVXzuf0iYHo6_BcOcI4gA
 u4pxdKmBLWNhBaa1MfjNVbD5bAXLSW7QTQ3CbQiZ7btPWimtlaSDC.FBCv81IEJrTvpxbV6jv8jN
 IXJt5_3EGoI1PydoGXNix9qUNVfsRxZFopM7e.xO0SBHv8ryknbUdEvcaEEaUwT45IKzRwXIFF4c
 vAWXNUGdjihJX.i.qKllEiTmmMlJSRFSYZZUIoyZD8NabFOpXB_OI336jN9i_WBYbwHbo72rMzVf
 eg.0XMxBNn2WwZsyxU.nf6DjCy6Dbzyq391hrie02TjR5bY_z35.fkSMBO3CV2NbyQ9pvxfIgbvk
 VHbWYRr89B_QsinDrKCyf.p8domV7BGrMubfGMdgA.n2jfiWdp7iaGSVMpTr4l3Rl7n3W4teRZTW
 hNx53lO0ljOh7n.wNeEuioTnsGLCvrwVQW5amPFGEXu.8slzkQJUxYGfbKgOh6B0EljeI5aW91m6
 sX2R.nwsvxAT8faarosbfbVJqPJ1jYj0R9neJCcVGQ0k1KVjy5kPYOkoIjuFgSSqMfjX1NFTVq7K
 XKJhOB.oU8ZLXxmfQNYfgwG2Pc.U0x97ckJUwptMQNXXjgjcuZHAEGy6kTUff_yCfxJpgtLPMwdd
 i60h9.0dyEjRnw7CatdAtH10Bp1uBuMs2IBNfZyYGXpvPRGFEojf7HUAtFx7Ia0oYGefF_enFDdz
 kr4KDKA8bznau8Q538YrbhG_oGyeTOgi99nmHP454Jg5wOiRkkgRzBFIaO3CTNzWbX7ji2UcxWWU
 .cXe7CER081yGDji57q7JaF5kNw8qKZ6ga5kpq_gMm6amcvdcr5eBKCSzZay_4TVh9V.a4KACDX8
 st_tk8rlLfstGi4cDjDtUsy8hL1fFfuvyPKnwYKu.1cpLrlKa_zOIOUpBBXTKdigUbgP6ybKIFC8
 JeXqgpnouyo4Ank8Q_4EMYM.EvpTW7rDkhGLypP1qkL3WbxBiyE8Pt3RB89CYhkb.6byKAsOuNgx
 xV67pgizetjxGUcB_LslVFrLsy43RkVXZaJDIXMHaV62lgfgInCPzqgFQfjeT9I.Z6fNENYpx0oa
 EvHwINnSVXjlim0JRoiYOYzwltBK6k3miJod8n7DJ0tAxTxe.N3ezOYWe.z68mH389Ej50olnsUE
 BhUEZaqvNngaEPpTGWoGQCEAIWds8q12sQSxN6wCL47I6kMJunXkohWVv9k.KeBo5OdJiCxgqp_e
 uCnMsG0vgLjATOWqgXk3RqseHMyUuzxszbHeGrNDNDOWgHRknJPkj5BEaSSMdch8pLJSwgOsGkYD
 FfdG6uVKfLMbIh8HoZ_39IdHAI5aZyPgnMgMn6OW16vAcbGJE
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:16:59 +0000
Received: by kubenode557.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b8cca2b9bf814e639aeab6157732b1f7;
          Fri, 11 Jun 2021 00:16:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v27 11/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Thu, 10 Jun 2021 17:04:21 -0700
Message-Id: <20210611000435.36398-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
index ce22903ccce2..c6de5200c467 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1548,9 +1548,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

