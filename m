Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5659610BEB9
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfK0ViT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:38:19 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:37060
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729349AbfK0ViN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890693; bh=TnXvlNY6VoB9fEnUTntEpcYHoQQ6ZD8wsgUlVRl2Wr0=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=k/R9+ktqxZq+ALUzEUycsajJhtYubMbnVzyLFqeipsl91z/SAm+QpoxFokqCU+8vRRf1wl4682c9b9/3MgYQxAncYE9+MxAcat5WgX91bOx6nddqBgsDyXY8bPxooSi9LGf2wvOmWFsDXDM0wP23BcOTBVG0pW7TnRzqFvWOP0KSRwq6NlN3xApMicTJfXA28WC4tFm6sAC90OZAUZbMUudCAceyCgny1xM65ENeXsT5UaFV3EOMsZD7r0y9t/sypq2KNzFHFbYnTOwbW6I4ISS/OxW/w/wJsoQ0yF8LziqZoG2/Ee/xjmeciLrdlasXdcpk1hqThMclDYCfPOH96A==
X-YMail-OSG: 3wH8e5oVM1l2inu.GKBDIA6wHbMT34akfbtwwZ_SSBztJ71JpOmT4Pfp7w5Qvho
 O.yN7wo9UdZzBGf4IfvkeT5yQglhZCEn8KnFNgitCMakFuYzljKezUOCm7IA3aIJ1MixpXOtiomV
 tFkm56HAXu54IfWTlOi700dqnsv7AZdSGvgN5eouJu1qTzTsdgTSznZxlDWhjjzjI5IubWNCeB.z
 BWpizwnW5aGnW56Mrr.yDP9Wl.7Uxye1HRBHBttRrrwxy5yMm8by..RU.mQbtw5vzMdsAc9yk8CS
 m8T0yd2xQIi2WGH9EtOF0qaRd7HnskznKq4vQAA9NaQo5ThvszuSPFP9vDF._AddEnqGMah_dNVS
 prASmtyq5_oZ54B70edQPSU2hAzH9gyITMOXG57ngaf5xx9ERwm0jsVX0WaQQNDKF3cRWZLSc8fq
 tO9T6vPTOQK17C_moPGHCVq8BD4lgkWlxj7HjUvi7nUccrtse2S3z0PShWUcsegbICC7j4gvgGXx
 6_ozho2mZHUdvsk0V9nlpV.WVeIEKzLRqUxYeGuBhC59oMyuayhOt_2IkbSPJnQlBxMYgQ2jnNAW
 7IVJTpFjXcLyig4YqgKc5gJ6_MBEC_HIpKOzD4j.HOvGLYPmhHxM9_grj5I0gd4WDlvLv8vd1gby
 pXB1xPWrW4vs7ZhDl1PNzxPe0SiuL2oxsGOtkRod5FVaZUwZDQxArDFEnOrc.nsCU4NrvLfmm53O
 Qdggr8TRz180ke_mwJQc8kq4KazvNn4Zc8wXzrvMBOlV1vWX6YQX6QNPE8Ml7tlSpRC4wOTErwFF
 yYzZUGnhYYp9.yPxl2Szo2Rwc2AWc1SlpWYu3ZrFu5YHDhK7DmpvAiYQ78AOS11tAnFiSmaM5qR0
 F9inodERMARiU4OsOGi779fyNm6jSSMdCWOck0RGdaTR93tYr4qvdSBi7HAro8KsL4BwkItEFO5Z
 2MlIpEC8FjN2IY6HOstM9yGz09R0RFIeuFPO77rDw.XevU8InpJHvKNiCQ_RAnfxNTspNUWIds7I
 g9rX3VhOUBr62oSsid1u.2AEYDHsc3Uvf1Udci1rpsx1v_ZE1GBItZZmnAEa7jFdKlV_S5VOjYle
 QTDI8rIEudrJYQJeDFOWH_sHZqweYJz08ncCWvFr.NKXBsSclNrVbNZsDUxEdHXSLWzOY1rUYgvX
 fF9phlJuzxGZvv8a6MznO7Qm9UNhqVHiV4Y7uuPts7sVPJA0B9HorHBTvTIfFmX25F0R4j6PSEAo
 kviYIYCCsStcCP_.FUi9EslnSm5qJzw66o1GjoYehm.axtHDFiXhSapdyEvYni4o.bmu_UxYrOc1
 QdpI7b8RMkZG7YiBOkmn3T94_DeC1wXKtVP6kF5PgsqEP3jGoPLqBC2Mw2yJEAElDWvEuqVCOEhd
 7cJGDxTMFNSXBoYs7yjFBekqDM4pVoYTZOt0v5s2eWX7Q5j8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:38:13 +0000
Received: by smtp410.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9bd56037893eb98ac7e975d63de82f18;
          Wed, 27 Nov 2019 21:38:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Wed, 27 Nov 2019 13:37:10 -0800
Message-Id: <20191127213718.18267-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_inode_getsecctx() interface to fill
a lsmcontext structure instead of data and length pointers.
This provides the information about which LSM created the
context so that security_release_secctx() can use the
correct hook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
 include/linux/security.h |  5 +++--
 security/security.c      | 13 +++++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b17aad082bde..3e90d7c55c74 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2304,11 +2304,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    struct lsmcontext *context)
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, len + 4 + 4 + 4);
+	p = xdr_reserve_space(xdr, context->len + 4 + 4 + 4);
 	if (!p)
 		return nfserr_resource;
 
@@ -2318,13 +2318,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
 	 */
 	*p++ = cpu_to_be32(0); /* lfs */
 	*p++ = cpu_to_be32(0); /* pi */
-	p = xdr_encode_opaque(p, context, len);
+	p = xdr_encode_opaque(p, context->context, context->len);
 	return 0;
 }
 #else
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    struct lsmcontext *context)
 { return 0; }
 #endif
 
@@ -2421,9 +2421,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	int err;
 	struct nfs4_acl *acl = NULL;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	struct lsmcontext scaff; /* scaffolding */
-	void *context = NULL;
-	int contextlen;
+	struct lsmcontext context = { };
 #endif
 	bool contextsupport = false;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
@@ -2481,7 +2479,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -2911,8 +2909,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -2924,10 +2921,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (context) {
-		lsmcontext_init(&scaff, context, contextlen, 0); /*scaffolding*/
-		security_release_secctx(&scaff);
-	}
+	if (context.context)
+		security_release_secctx(&context);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(acl);
 	if (tempfh) {
diff --git a/include/linux/security.h b/include/linux/security.h
index 31d663a9f7ab..e10c22bafab8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -534,7 +534,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1359,7 +1359,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static inline int security_inode_getsecctx(struct inode *inode,
+					   struct lsmcontext *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 6f43dafe1249..101063b00aeb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2207,9 +2207,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct security_hook_list *hp;
+
+	memset(cp, 0, sizeof(*cp));
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		cp->slot = hp->lsmid->slot;
+		return hp->hook.inode_getsecctx(inode, (void **)&cp->context,
+						&cp->len);
+	}
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
-- 
2.20.1

