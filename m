Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DC10BEB7
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfK0ViP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:38:15 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:43251
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729967AbfK0ViO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890693; bh=eu1JGNeamHLvkXFRTRgdev9gtxdjuD9sGn5gTg/pel4=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=BGp14Gco1EoG5gd5RmcxPAcFt/XT6hamdm+mQ/3m9eibDsgN9dzFBFXh6a+Vdu9sgiGE9idVTNpF1NxTpBZ3/1Kz2pyVJLzDDYA2h+j9EnJAtpNGpkfr3FYsGqcBXVxYb8AF1GfkgATeyOgv4GUAKVdOPJP3atuTQ2W/+nGTABYa2BjQNRBsCBsS8VkXMvbjodWQU5kVnYo3QVAfyxw0q/BnwbCEjDOiGFTA0jrv+xm3zTaaT30h2g9XY/bM3JzOb5aYjIlbkNErCvXe/Ac2ukfY4H6CpTD+dODU5UoMbOCxpWZd0YUTu6fRtssiH0DBye15mp/09QKJWOlJXSYfOQ==
X-YMail-OSG: RSMxkpgVM1k7y2Tr50LlQY.K52qoCSsFmCE17Lits5dbHfrhGqjkqiDzyuavt.S
 GNdKWGhR8beSQewCuwMWYxkF1D47E7rVcnc1.yfeUjKhBFTexnlzB4c7uGLnS8hpzZj4oM7N.Ubl
 N9qMYWJSoVDY7kNIxqhXmfbQ_d_iWIP.nqsXIo9py5J98weTO692d4hF5EBoOSL5wzjrc5lSKzcL
 OfQ3EKPELByx18JbnVMcqknBSap2xQN6e4GODOkfo7BQYkYBKWHXovpfcHsrXIKifhqOeHNFTNW3
 8KaukgBcZiqkWHVQGBR6bxtmRqh1OddOAI8DUimuVeHxOR0FkpNCF7bjeUob.DqCITAED8DWNw8e
 G..fg2mxSeGtaAy7uIf9Z1KobjUj4Kr5mhuMF6JBTocRvwGufyvlUCF6bkh5i7esq5o70RkyTDOA
 Qh5d69OpPMRRRL6wBiYnsNYVQsytWOhnaSiTiEUvilMywK1P.rfUQCMtKIDv.Cg28fl9kbWuL76E
 4O2AIGt_8B5bmWip88WvLkyOIeR.aGu3EHm2as3sG_rBzIot9xEjBsiJVg2rgR577rqqlQq6Wm1u
 UZ6IC6xTbL0Zo03u61NVSPsV5ppvsSExqqJwMJcO3yxXTx05oMlRqNXWqUt.0E1oSHLCKtDNk3Mo
 y2gkiv1jl_bcFw4tnBOCaBIRfHItqTtGEw7vbIG9rnUBveHnuLfyHavIT6E58eYRrYfKcYIOGIML
 nAflFL.cIOTqnqrymdQrvRbWDdEqPulhE6qVmOoygoeK9SY10lg_YAA2qjZb.kYkwNRC40gW5F3q
 W.fC2ycRVeJLycHGcwUQUqGyW1fq5CdmFD5tfBZtl059r02GrEgsvWJG7GgZh3U2PKluYzXn2Xrv
 oElPQzdpuT3YX9_vLnboGxhIgJczhRRDXLX6EQhGw.9GRaumspO5SU683Ds8NPfQ91eP3nnLAkXu
 A6XddxApn0kHlPRfzVrPlt0aT_jfpRFym7rgsmSBi8i9_OE68YAepYoOQ6p1PKtSkz8mJlk5SxMC
 Nb_C3joCom.JlQWOG6.D7r.EBVjQls.YyDqErTKgtGvrm6t1jy2kBejREBPCcFCz7IfFKwEDlFUr
 VWowT5FmL2KGOEIlPybx2G9NN1cc9Mjgtcc0ecM03ph9_75YotBE9SpE39_sgacH17Y8HSI2pDk4
 V_vx0SoL._zQPjrAOOjKeFMj4Zf7zywFHoCnIOT.1JSLDfhcfXy_tBH4x5S30cgWwHgYaH7wLwef
 Wc0yuuhYlUtSjWS8eqdkHlqRaqdlBBp2yZoKBxxSyBEYrQ95lSROoFvtr.Ub3P9V0QPBQAi.Ui3Y
 TzuOp6yVPsnyZQ8HhTTxSjdwV7kYgSdeFVSpLq7WlOcpINHZamer.TU_OeKSTE6meUu67sDcfIyG
 yOtDf4jbh31IXtN1kazg8f6dMmV7Gk6bGSuasE7G4CMns6TsCKoVcGswPbA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:38:13 +0000
Received: by smtp410.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9bd56037893eb98ac7e975d63de82f18;
          Wed, 27 Nov 2019 21:38:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 16/25] LSM: Use lsmcontext in security_dentry_init_security
Date:   Wed, 27 Nov 2019 13:37:09 -0800
Message-Id: <20191127213718.18267-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_dentry_init_security() interface to
fill an lsmcontext structure instead of a void * data area
and a length. The lone caller of this interface is NFS4,
which may make copies of the data using its own mechanisms.
A rework of the nfs4 code to use the lsmcontext properly
is a significant project, so the coward's way out is taken,
and the lsmcontext data from security_dentry_init_security()
is copied, then released directly.

This interface does not use the "display". There is currently
not case where that is useful or reasonable.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
 include/linux/security.h |  7 +++----
 security/security.c      | 29 +++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 67f8e29747ca..f6c96c3fd8c8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,6 +113,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsmcontext context;
 	int err;
 
 	if (label == NULL)
@@ -122,21 +123,26 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
-	if (err == 0)
-		return label;
+					    &dentry->d_name, &context);
+
+	if (err)
+		return NULL;
+
+	label->label = kmemdup(context.context, context.len, GFP_KERNEL);
+	if (label->label == NULL)
+		label = NULL;
+	else
+		label->len = context.len;
+
+	security_release_secctx(&context);
+
+	return label;
 
-	return NULL;
 }
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsmcontext scaff; /* scaffolding */
-
-	if (label) {
-		lsmcontext_init(&scaff, label->label, label->len, 0);
-		security_release_secctx(&scaff);
-	}
+	kfree(label->label);
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
diff --git a/include/linux/security.h b/include/linux/security.h
index 7d943a812237..31d663a9f7ab 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -395,8 +395,8 @@ int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsmcontext *ctx);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -787,8 +787,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsmcontext *ctx)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 618d4f90936b..6f43dafe1249 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1011,12 +1011,33 @@ void security_inode_free(struct inode *inode)
 				inode_free_by_rcu);
 }
 
+/*
+ * security_dentry_init_security - initial context for a dentry
+ * @dentry: directory entry
+ * @mode: access mode
+ * @name: path name
+ * @context: resulting security context
+ *
+ * Use at most one security module to get the initial
+ * security context. Do not use the "display".
+ *
+ * Returns -EOPNOTSUPP if not supplied by any module or the module result.
+ */
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+				  const struct qstr *name,
+				  struct lsmcontext *cp)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list) {
+		cp->slot = hp->lsmid->slot;
+		return hp->hook.dentry_init_security(dentry, mode, name,
+						     (void **)&cp->context,
+						     &cp->len);
+	}
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.20.1

