Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8C4738F9
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Dec 2021 00:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbhLMXx7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 18:53:59 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:43688
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239532AbhLMXx7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 18:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439639; bh=ErLYnnmzVYOVC7AIqd9CYsBXa/tj927ekfaGW6T7p/4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZJk7Yj5Y25oq1OQrGOP6FI80T+r4rHkt0z1g3h8saSDTZxXH/Y1uzHFLJZvW3ii5kzntfZL64iZZSSrC8Wb/NqZTRGRZ7r1xfGx4BLCWcCsxPltfjckH4xngDfGHsl4U20FviR0WGqf11jq3f82aPd6pL6OFfuCvng8hjA2HOeipMTzVdOrY2YpyuHFpGGOL+9mzLI0pDUa6pu+J9BlFWBr/IDRC11LET1ZDTF/hb6OLiCRkS1/SQOsx/zMtcZYa06HFwU4qHmt3nqfz1i4WqqmO2Tu1tP8IFgEUKBCYgCkRZlnEyX/9fs7bmG2qGqRiOUARg8l+rRDIHrmCUUvc0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439639; bh=zVEnaR/vrf4F15VPpXkgKSfuf3wEhEEG7X1UE0Dfbj5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KkndheORgywGDOhCAD6jyhD1/aXWeKYaoDG63q0a8z8XOnkW+ZPSyXh0xzmjDkRxzdsHPffTXHRZwwbBbdrzc0tnxWUOaffxH5knMp9PsFa/2se5yfxMMh1xcfsmOnmuIla0AUSzSR3CyCrsabnfQi1caiuSQGIr0XE/K3JxcZdwNibibz0D3mNzK1nR/X8SbGmdIy3LaHNOD19Gz29su+hkETsMz5I/9F/wE7ImLoo7PuxNlkiXzZhWJRxvr5dZhfSeChcGkk2h0W1pVlfSKQAt6j4mSkg3kaW/MnuQTxznJoJqwUwvXqLTZNGi/+s78ktXCL1h0rDdchbh4L/WlQ==
X-YMail-OSG: IYR.dRoVM1ltDfbKnJXbRMCh6vwoY.bCp1Og3IUSYHgKuG8Fehg34DBcacbuQc8
 VSrDGMf2psJ7ZYP5bb5WWl8QiO9K8S7MgE6E5f3EMbz5O1JcPMq.Z9xQFBLMAxw2e1gUycgpRMR9
 Gabemq45Ujr2TruqnsQMDX5Hc_Iti1Lv3J1E0x8Mhx2vPdy4pxHdt_SJnXL_1jCN4IdDG3tItU7s
 C3PU2ZF_U8e_0Wx977FFjDmodG6CUbrQmlezQJkMcMd2Ic4mW8_d.ltyee3bbKJvnzWZY0U3AwkL
 toC6ROs9QjJTdAKJh7O0sFRxNIgCjIDvEW4rMs.pZG.ItQNGXkzDC5T4MPkVxvlG_ETs9DqOPpfj
 DmA4YTiq1w1kAUrVrq.RZ9vIYwrrflwqBsFgX.S_9.oKbCTzA79RZi11hI34ZRU3LXaqPAS6kZ1T
 75OdW5_ik1ONnI1n1shpaWO0qjlTnTsQiTMeMluUbJw6TcgRmb0aNqgEYiGwC9oCuMX8rZ7ygeaI
 k._GNFsay0bKqldPj76X3C1HhgpQVqpsRW.ucz0X0n7hxs3nQPMlTj.Ec3wCENS3QegbLe12Vb4z
 OXlti7BDHvqagZNdrBEdCL.touzAjdsHD30Jhi1AwljbCmIRG8xFTjVRVznkW62K9IZjVvQzBsJY
 8E93oS5j4SKT4Fx5NL._J3ukRIuvHefTiptErwvtoX2QJp6PegBPvtma7yQfxACgWYdAM7ZIMXXR
 pkI86LNAAYF9gItl98Pmon9cLAZi5.FUf.yZL._Ld_dkF2Zo_aDe7Ky9eyPyeiGawFswV5iqO1pi
 9QsrtpqtCvtumZJB8JHzSSafP0rsgIn3b33rhmf7NXBtq9H2JbXPpXq._yjEPhMdIb0JuNLFEQ5i
 ooYWfkPAa.qpndZLNmUHgHF9jdeMwkr9zgFIbdhQd.Z0MPZjhHMvdptglpu9Q7LUin.XCoAkZymc
 sLyjcNuoTGkyrmo4_unhSyvVqaUVtKmW42hoIMZsqpOjC9DAxwMpWdEMxPWTmulvX3Yv2xOc8Bj8
 8516p0ZRWk8GHtL8pQWGVDW5yya0jx_2LNK6Ck4hsgZ8RVaQrWllpRIMU0SFQGfPx6gCcAdNMK1u
 tBOar8KVDXwgEDYTb3vjXfDbBhTmiB8hSYfutFbWgqwgOX7fWwAjKJZV0KnWcqq7VGXKb.im6WkU
 jeHOiSztvtpMqJdqbVqaH_UxhgMjBYMgN70jAwkK.DStiyNM4i5qn3VCT3eiJj5PSKy.BNh2iWJ3
 qV44d3sDic3XcR.zDNSptee9L5UfrcMhFseTOs6MjM.w_QRl.5tVMPMp6MJv4nNVi0q0FkeCmYTU
 _QRc0n60FC6Z6J5FmtqjNL8gWQb88PKc4aR8SDql5TR6H8yg02cETMFhmZmI9dQGOkzpyqmib9t.
 4TaZ05ltDqX6aWFhq1eQED4qoIHg2jgkDgndOWC9JRP4vozxuz_m23bRsC2KrRkU5d4WWc.iJaSC
 VMiWJGwzAx5fwjW8iB6IrB2CiOSfC.ra_p5HIFyaB.vsMCdED7p0F9u1N1ZvKaiqNuGIDEs0MHoA
 .Ts6QJPNq8yiDqqx3OAMB_8CviJqRwbS7X27Omd0uA5o6uqse_D1oO5M8zF_6sO5tAI0772QF8WN
 QGD8quUT9S48dYP68jxU66iY6ONPff28UPaEAvTctvYEsrC8lFx4KvHIP4PePMVaedLLJhBwceMj
 FY3UklT2LCFJu93doyMml3wYTL9ua_R5W_YM7oOrdcrlktkucXZXy6cbef4X5jhSZ_JcoQixUDQ4
 RNMUSaaFKexXlS6UGzId1XbFGngY6WdpHOn_ciepaDridoUqoIJnldPF85mppD7L76TLji7E6gMK
 ZNrBX5L0sMqHP829atIW9xYZ3yRbmRCGVsyC2LL4u2XGFtJE9Yhf95h2c_9FYeNstpSBRHLrTG3n
 JOcyD0moCMfCbLjzuufAaFxdOx_TKxlNekfH86BA7gYu_jhd914oG5qfNTBLeO4M.s0Uh7bjkhQ5
 eMTr5cBKpDP3JOHzcaL.QU2awKJs5MI.BrjAoDNOlhwrocXsSgKqWsLDLWs5ks3vdYKqTL799qbb
 lIv5544f86KFSYt3LINVLxInrsco99KjTlDEI_UAT6_Azw5RtJKIOzBZKrRlWBMDIuiACJOTQZJl
 2PAKbWmU8MeQwikKShvwkSt6_jdJo8bmtrawwA4wsvOySZ2u.VvZHG_w1Yhl_jkp7.xZui4R48AG
 RR5AsCKyfbFSnqTGxhbPiLRvJQdl5dvMaNhBBDHiTRsbmwhsuxdNVDNai.g2lAHK.LyNuCQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:53:59 +0000
Received: by kubenode509.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 49c1f8fed2f9bb0edca267b841b22070;
          Mon, 13 Dec 2021 23:53:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v31 12/28] LSM: Use lsmblob in security_inode_getsecid
Date:   Mon, 13 Dec 2021 15:40:18 -0800
Message-Id: <20211213234034.111891-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  7 ++++---
 security/security.c                 | 11 +++++++++--
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index bf91ff071ea0..3433850a3f9e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -457,7 +457,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1009,9 +1009,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index b9a6760f55cc..34cec4cd3dbf 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2239,13 +2239,17 @@ static void audit_copy_inode(struct audit_names *name,
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
index 22952efcc0b0..34ecdd7b01f5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -625,7 +625,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!rule->lsm[i].rule) {
 			if (!rule->lsm[i].args_p)
@@ -637,8 +637,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			security_inode_getsecid(inode, &lsmdata);
+			rc = ima_filter_rule_match(lsmdata.secid[rule->which],
+						   rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule,
 						   rule->which);
diff --git a/security/security.c b/security/security.c
index ab285557a31f..57423c92589d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1550,9 +1550,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
2.31.1

