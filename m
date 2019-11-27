Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E671B10BEA3
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfK0Vhl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:37:41 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:33177
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbfK0Vhk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890658; bh=x9eL3pWHrjhYXfPb3Pu4M3dmL7qJPVG+F1FszCwYhZw=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=kGh+Y/Jhrfz7ulfurWkJMQwhIxUvXxEbdVrMqAZWh1ooq8plV8LPcMfoYZsuOgAaHoEtTMps482m/l5oTnm4Df7KLQT48SU3Op3baghf262reQR2XgOsALBV1TL/aUq2/OMoPlD+doIaUCidhtZntMs7leQhbdOIZDQ1rNlZu15eUX9Wv925U0SAk1DtO5oNsTPWuF/7TSjrwXLwBHG/gzGC+zhQUZGO+RKAwKp0V6rlnfA7SlQwEVkhtLdesQsKi9YAUArPSqI7fHo9/N9ZJicrbaVsHfcvGHwAVgDedtY/IDw/fCM+Kf0Tvs/ZOV6VuQWr9M6IFV7NFFiRyaZXsw==
X-YMail-OSG: K4dwuHIVM1m_TnFTSFmHGGYTUY.tbzhAEVUhjwVquIURcu1jCBrd74zSrVLdUbB
 sai71KflOTd_cyIv7.qC1JJqUZW2V33u9JXpU6O3frPi2RPfVtpT7P0nl87cNu5asqmb9bAo_fx6
 Pboepye13eJxatxk1rW.wdKp55CUemj_4DbAnPt1b14po0VHXC7aGWR.76ucwLZnemVO6FFIiI0x
 ssfLtNIZhZedVpAYWq9khfTxLVULcOydBd03ejG2ZOD7r45L7ahPBnAm1gGxLSMtCQbaMUpTuqq9
 TSqb0jYMzjzcGmdzF144EhVLuI4O5mTr6h_uSVLXko8p_VqjNUc8FAg4yQ3EszeE7yWkdBOj9ORh
 XAQJ.hwg2vzh3BRBm58kuv7cFkFAEeYpyH_F.8wdQ37EhLF73FB6ADJPDDge9kBt1gO2GD1VYtHt
 Xv1Lgb.zbVY7TKaTEXK.E7w2G9yZrP.c74tmwicKGHRFjmIqwI8wsAICWFSfKBevIvl7OQO3RrNV
 zCwsn6IPg840.Trg6BjRPe15CUa9fFVKsCJwAdnT3.wcsxjz5PPgHEGwbRfi8upvW4x4bT20_Qi0
 oia2Ap1jVqWosAKb5LZ9EqAQNEdo8zLumz20XzMlexWK30aXLKomEawFS8nOTQiOnrfFQLSxsCyL
 SrY9E9vQA5NebwyRLimvCmMwg.lrXYfwMKIDt2d8jiY5z8UY6pVXk8BYaUcox4kk_mfo.vlF7ygy
 IN0PS.g0WhBTzBmNFCGgTyghO3NaNGdoT6ZK4elZB.WAzUsKXNwaWzwVdTORQjSdrz3Nb1fSbKSN
 mFFT2CH.wN7UXdadIxQEqBUereoI67BttlkyNtdtic.HLhC5bU57oK6GvfytU9hcWGZzaPf_lsfo
 .KdiczO_7WBbVkQx9OEeLTX2XRhTOEvf1_uuwaHV..2u_XqseXo8UgD5YqK3voVToG6ai5c1lFBI
 DkWSq0bfEazpDereADGzfVi97Jqk2VHVgZc7CQzVdNI_RdgOu8cCwOSwJSsWcoqo2JoXmBnnvkSk
 xp8mUrk9tdsUZgvpJrv1PMB5QH8BMnOa1ooOLEDNShU8nX0OaHmCwnqHwFvUx.X1NEuL1oWX3wxc
 FyO_hcO93C2QC426dwnrkq29Hk0ioGsBIE7XkWQLc6d4ecFm_C2Qnvb0yvpQhyXQArTBdapllHPo
 0y_vSx7EnjSh.CiS5gnEnkPpyaW.o7HAxsBYmqd4sxodcfQte2f9bO7e9ZkCpsbPFioNzniU1jGo
 b_dRG738e7H9RXMTc0dxtCAB78tqBBgogrJo6aypKrt5JQ3_fWmsJSvmF89QRlYrt9oenYqZOx5z
 70NLmwuunsiO7xq.73da7DtT2.DCfGMIVcmzLm2VnNezUMPwQBL0r.o5tFXbNm0fFDJOqpsR_7gK
 mWxfRTclDd3jGCvt9YQ2yKzNFWT7xgdLWF8r2E8fSS1rXcw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:37:38 +0000
Received: by smtp418.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7ae6d5325a27611baf4cae658f88f94c;
          Wed, 27 Nov 2019 21:37:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 05/25] net: Prepare UDS for security module stacking
Date:   Wed, 27 Nov 2019 13:36:58 -0800
Message-Id: <20191127213718.18267-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the data used in UDS SO_PEERSEC processing from a
secid to a more general struct lsmblob. Update the
security_socket_getpeersec_dgram() interface to use the
lsmblob. There is a small amount of scaffolding code
that will come out when the security_secid_to_secctx()
code is brought in line with the lsmblob.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: netdev@vger.kernel.org
---
 include/linux/security.h |  7 +++++--
 include/net/af_unix.h    |  2 +-
 include/net/scm.h        |  8 +++++---
 net/ipv4/ip_sockglue.c   |  8 +++++---
 net/unix/af_unix.c       |  6 +++---
 security/security.c      | 18 +++++++++++++++---
 6 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 503058f1de8b..3ce417be4da7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1353,7 +1353,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1491,7 +1492,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
 	return -ENOPROTOOPT;
 }
 
-static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static inline int security_socket_getpeersec_dgram(struct socket *sock,
+						   struct sk_buff *skb,
+						   struct lsmblob *blob)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 3426d6dacc45..933492c08b8c 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -36,7 +36,7 @@ struct unix_skb_parms {
 	kgid_t			gid;
 	struct scm_fp_list	*fp;		/* Passed files		*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Security ID		*/
+	struct lsmblob		lsmblob;	/* Security LSM data	*/
 #endif
 	u32			consumed;
 } __randomize_layout;
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..e2e71c4bf9d0 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -33,7 +33,7 @@ struct scm_cookie {
 	struct scm_fp_list	*fp;		/* Passed files		*/
 	struct scm_creds	creds;		/* Skb credentials	*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Passed security ID 	*/
+	struct lsmblob		lsmblob;	/* Passed LSM data	*/
 #endif
 };
 
@@ -46,7 +46,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
 #ifdef CONFIG_SECURITY_NETWORK
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
 {
-	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
+	security_socket_getpeersec_dgram(sock, NULL, &scm->lsmblob);
 }
 #else
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
@@ -97,7 +97,9 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
+		/* Scaffolding - it has to be element 0 for now */
+		err = security_secid_to_secctx(scm->lsmblob.secid[0],
+					       &secdata, &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index aa3fd61818c4..6cf57d5ac899 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -130,15 +130,17 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
 
 static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
+	struct lsmblob lb;
 	char *secdata;
-	u32 seclen, secid;
+	u32 seclen;
 	int err;
 
-	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
+	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(secid, &secdata, &seclen);
+	/* Scaffolding - it has to be element 0 */
+	err = security_secid_to_secctx(lb.secid[0], &secdata, &seclen);
 	if (err)
 		return;
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 67e87db5877f..45e0d6a02073 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -138,17 +138,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	UNIXCB(skb).secid = scm->secid;
+	UNIXCB(skb).lsmblob = scm->lsmblob;
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	scm->secid = UNIXCB(skb).secid;
+	scm->lsmblob = UNIXCB(skb).lsmblob;
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	return (scm->secid == UNIXCB(skb).secid);
+	return lsmblob_equal(&scm->lsmblob, &(UNIXCB(skb).lsmblob));
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/security/security.c b/security/security.c
index dd6f212e11af..55837706e3ef 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2108,10 +2108,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc = -ENOPROTOOPT;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
+						&blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.20.1

