Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 627EA10BEA4
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK0Vho (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:37:44 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:33655
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729296AbfK0Vhn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890663; bh=chVVSuzeO3yprU97pKE3628zC+yHEJiCci/1ddEIsNI=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=OhyKRz8/KI1LQdjKYF7mocBML6avlPNTyUvJtPE6fl3zePAqhIXOBqZqQouou/aVXrOp85tFcDguYQJRKzny15duYfFJmTi3OzYxIXlsLI8gfn8p6Pxjdq/ACDS4y54Mz1NW6HJ22/s3IGqmoA7LG+9r/fJx2VsDaH0/bbZHDPipfb7bwxwCfDVs7ARpG802z8actTcjXAdzQuDv/TK+nRSccAPnQgCpbWg3hRGqBy3FIfxOPvoABLmTuCtBSbSlja3Auzwd9uvLvylkQ1MicXrDUumuXeZVvp6UWnyBxgzYkt07DEYU+JlOsaxYJtPpkVXv9QXei+R9GTYt8uGHjA==
X-YMail-OSG: u9dqDLgVM1lOju64G3NvSB8AD.gVMSY7o0e1y.2r3VM3S4iNk.cXQCIAQU6o_Ox
 5.I0nE5rz5g84W1UtLktuf_qwk67baHDkqqWqMomX8NdWTE0OCG_N5QuSSitNOL8sAbpSYbyd94Z
 qEvF.v3zsWKOx.gELk4dQN024PZWICGRhSuGTHJR5EFbrZyduMKcSj2Myz5rYmOm6nHquMuozxYt
 aF7OK.FOoIuGfZm1O7wYnJUu6X9MQMt8qpq1YVJ9idR9Uw60QNDj_V9CLD9Odyczt9YhOMh.yYkO
 qi41NMNF0bIfkFD8ui6tDkEve60_ZKwbcL3KIxfyaSSRFBZQpPiIigeY4czZDPH8Wo695cGrhcE6
 PSlbhOxlH3MTqFuEZDLzOFER3Poa0Rbs5wDgXG1KSmxoxOtos6iM7y2SWDBhwQ.2vclhUDK82gTH
 rO4WtxcFkR.rJRJkLsn7WuVLkyXigXNkthjAq7coVCHwtpWumuAltCFbrYFrWSR9v9Uh58TEa7Jg
 mACTUIWXlpjF1DF5BRpeWbp4oz8R4rEnSwuHhz3.OqVDEL85.ShAWZPdi8U6f9QgdlW9UjkNn1Hh
 2aa23REwdgmFE6fibZjFZwMxNWCMB1IzVAWcdNG8llFUkukisUT7d5SiJqIDjPOdxqSBGF5ZCXtN
 bdzwuEw8aBtRaj698iV44L99QepVt1bripO7lbB1jqe4iOCHPHodqHpJ2YBHcuMPORxo2AxYH._d
 .8YN5mxFrLV5E5dqHSyUBx40i.3TBW6R7VEw9L_U7xDnxlB9s5MRVCnA6ozkPscBnEXNyEhEMawZ
 ZTDPkORQ7QQbp9yyW3OSmnCQxolTDxWPs8_5csTa4WS0BMkw6dwQaiZHyLRWb3zDPMHlrF707Eih
 Isv6DekwdiH5zh6rP._y7vVhF_Jv6vRKIsvGUGtkgBDSEk.eM0T_gMJseZIeQc1Q_04ELFSq8fJX
 SAqnNpEwRbKTW7CSUijYb_OLvWO5SwBxp_Vpj67Xv.HQQfJ.YhfPRY0X5x7L9Af8lZqcEQCvNOou
 jQKT3Gvq._GzGR9gjkm6KtzWMpC5P1JAFEe5wrzXzLZj9kKuo.m3CuOutZSCdZRVzHqJd9jz4usZ
 UqpwqTdvCfhMy61ItRj25EfhlWaIlhKpwe3pM42MMNp1X3teXqDEjtvXzgqgVjARiITNK_79.267
 mvrlth4AE9RclkyyQogL4ju8Lx5SNTaUDA1NJtIzvJdijQtOa9ouywnaBdU7KiwzHCNbspLq4nlm
 eQSB.lzsE4mYyAXidJtyqfQYsSTdJMh90dE71cDI8QNpIw0Y9wjk_yipEtVDlvvOQ.4EuCnBZuPk
 HSnzfpAnE5_2ti2I8Mj3VppCbqedRvF5el.8LsdtXf97HKHVJZGKksp5IuOrIM9TKeDLoPOb30bz
 m3ETd7zquIjCc97lvkvI6nwapGrQC6IL0dlH2E3CDGG8NPl8J
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:37:43 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1acf01b6929c230fae5ce1ab34c8a381;
          Wed, 27 Nov 2019 21:37:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 06/25] LSM: Use lsmblob in security_secctx_to_secid
Date:   Wed, 27 Nov 2019 13:36:59 -0800
Message-Id: <20191127213718.18267-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change security_secctx_to_secid() to fill in a lsmblob instead
of a u32 secid. Multiple LSMs may be able to interpret the
string, and this allows for setting whichever secid is
appropriate. In some cases there is scaffolding where other
interfaces have yet to be converted.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          |  5 +++--
 kernel/cred.c                     |  4 +---
 net/netfilter/nft_meta.c          | 13 ++++++-------
 net/netfilter/xt_SECMARK.c        |  5 ++++-
 net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
 security/security.c               | 18 +++++++++++++++---
 6 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 3ce417be4da7..7d62721cc18a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -493,7 +493,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
@@ -1299,7 +1300,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct lsmblob *blob)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 846ac4b23c16..7fef90f3f10b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -756,14 +756,12 @@ EXPORT_SYMBOL(set_security_override);
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
 	struct lsmblob blob;
-	u32 secid;
 	int ret;
 
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
+	ret = security_secctx_to_secid(secctx, strlen(secctx), &blob);
 	if (ret < 0)
 		return ret;
 
-	lsmblob_init(&blob, secid);
 	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 317e3a9e8c5b..7c49397c33fd 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -617,21 +617,20 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
 static int nft_secmark_compute_secid(struct nft_secmark *priv)
 {
-	u32 tmp_secid = 0;
+	struct lsmblob blob;
 	int err;
 
-	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
+	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &blob);
 	if (err)
 		return err;
 
-	if (!tmp_secid)
-		return -ENOENT;
-
-	err = security_secmark_relabel_packet(tmp_secid);
+	/* Using le[0] is scaffolding */
+	err = security_secmark_relabel_packet(blob.secid[0]);
 	if (err)
 		return err;
 
-	priv->secid = tmp_secid;
+	/* Using le[0] is scaffolding */
+	priv->secid = blob.secid[0];
 	return 0;
 }
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 2317721f3ecb..2d68416b4552 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -45,13 +45,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 
 static int checkentry_lsm(struct xt_secmark_target_info *info)
 {
+	struct lsmblob blob;
 	int err;
 
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
-				       &info->secid);
+				       &blob);
 	if (err) {
 		if (err == -EINVAL)
 			pr_info_ratelimited("invalid security context \'%s\'\n",
@@ -59,6 +60,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
+	/* scaffolding during the transition */
+	info->secid = blob.secid[0];
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index d2e4ab8d1cb1..7a5a87f15736 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -881,7 +881,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -905,12 +905,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &blob);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* scaffolding with the [0] */
 	return netlbl_unlhsh_add(&init_net,
-				 dev_name, addr, mask, addr_len, secid,
+				 dev_name, addr, mask, addr_len, blob.secid[0],
 				 &audit_info);
 }
 
@@ -932,7 +933,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -954,12 +955,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &blob);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* scaffolding with the [0] */
 	return netlbl_unlhsh_add(&init_net,
-				 NULL, addr, mask, addr_len, secid,
+				 NULL, addr, mask, addr_len, blob.secid[0],
 				 &audit_info);
 }
 
diff --git a/security/security.c b/security/security.c
index 55837706e3ef..32bb5383de9b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1970,10 +1970,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob)
 {
-	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.secctx_to_secid(secdata, seclen,
+					      &blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.20.1

