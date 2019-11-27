Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B084E10BEC0
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfK0ViW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:38:22 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:33785
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728698AbfK0ViV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890700; bh=jx6SBqD3iFh7Ov9qmHnd1D9nd07iILpEnAa1txjocoA=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=djqJXEBGKJANvh4A1meDCxeyB/PTrltMdGgODPDtKWi7yWhswfETWSDEut1N28JC6D2Fd/8s/qQjZdfIkYzzsQ9fBqyJ4k+XQklsWR4ok477UwVwkIzk1xaSERZTNVq2YUV3WAx2dxjjzJkNxj2c/ENlaASu84ew1i5Ajz2+jRlqwvLAyukF1ERtceyIgJM94tBo/4j9XGo2BcBbz8tt/Apvg7Hrior9r4oJj4RxXutFXznDTZ49ao4+657nppItTQvJv6TKFk590/V0wCV5+JPxxaeyqj434h8sRNERb/BCiu0dUAeyTMqK+yJAtnLqRX7QfGNUN+G3KNaZqu5y3w==
X-YMail-OSG: aEcA9M4VM1lNbky_ZOTOKquoDle_aM2A4LrFsU6Tgz8gThU8NKvyBaW3s.59iIt
 jQoPrK0EY379G7bb41fOHTJyE6MrLUhvp8UXJYMQymaGDeK37HKs3atso0iGlK_0OzCaKT3YkOVK
 6Avegc8uWx6sNG0Fwt5Lx_nPZg42uOK3zYdCvOMxFD1AnZxE3NBPks7EcPpLNEC_bPYYE8NfAsCR
 v7kT6cPnSWNsi_ZAa4Qx2Jv1dpPq5.R.UiL0VRhvWgKI8xly_RkglUE.78qBjtJ3K5BlxZd8cS7O
 fwzYiwV8R0qk.XQXVFVt8mdPTZ_Dr_jTL_zPZDZ7I.Qgizlbgz6LTQrhxyDZ.TbjvhQ_oc.6r7LT
 cn6r7ox34B45.jy0WNAG_engswEdKTNJFpf5nQI5txjB2M7aGFrZQeLY57D5xHT0p0Z_h2_PWvnK
 UvlG9cc29uVrhwjR_wWo0Cr1XL4sOjWPfGaEFtEVzwV4YdfARWDYeAj7.PL7X_6op2hJ6O5Rv0ky
 0a9PchL7txGzoflFRVzO6hMPmaLBPbzYcpsUDPIltBrlv5E33GYrc5c6E.wZM.TVlvqGWtvIh2ht
 PRCwwr.UBWmCiP5aoXMm0fDjg0yDySyf424lx44mLw2hPyPi4iiwFZGaD44xa2LIPW8dUP_9uwyU
 LhGL801ytsKSsCy2hjpP_nkaNCON9DddkpnfflMfEIGhKQI9pkGNLBI7eYNaKJ6DqRtocP894VtY
 fuFqmieht4yi75RAZmaXbLaNXjhDOyqemSAAu_.yHhMJoJzmaMUFMM4LktJqlIgfgwO0RpJkioSX
 3A192CTEBDeUL5ZubmjYt_6M2MJ124GtI1qFzhbIpjwH0wxVzPls9pjejIPWbAvyUXs8SmQd4Yio
 80xkhD8OhQ.wLKpICdL1HUZtjHWimXWLBURcLZVN37wQQ1nUKjXe1iuDnsCGzJ9gYI6LQF7LQjNN
 WqNZ5xtuy9vqUnMtPng7NURXlZXVNBvUlOYG6HTaZ857Fi.K.1kbIHWvY_npkxT89Cm95FTUL4Fp
 pKtLSYGt5LbtDMVVbQLvTh.xtJ_w_xz6uhLK5T89s7TGFam0A2b0PQPyIIgLMtRy3BcskMx3Z5q_
 WXpjyLJySgxMyA0rE56M9OSBCge7wCAp380.H7Yi7zq7J0lqL052sGb9.D8lZhm8Toa3YSUfv7MA
 06yj_S6t0YCF_yuBF80uNubdT.8qOKd0Gr53HXBxv2Ry.ljTrU5FiP6x394DoeUzzUvyhcW4uzJJ
 q9CIBNyiIdxvq82MWHG6Ahe5I9oQ_1YyNZWrApwxjY0P0natilsZQkiK068kSMlgz2UTM1AMqoRJ
 fyUbW0Qh15arqb4MDC.g3Rw4mrpsVUs0z4QPKc1OU.Ik5Eb.unILPtQaV_NqYPID3q5DWwIfzfMs
 O9hc0.NvjUUjBeYZslYzDqmPzoeXGPBaSH5H3X_bwHsT15euLrUTYAQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:38:20 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 850c88567681b8abbaba4b57aaf8e962;
          Wed, 27 Nov 2019 21:38:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 18/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Wed, 27 Nov 2019 13:37:11 -0800
Message-Id: <20191127213718.18267-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change netlink netfilter interfaces to use lsmcontext
pointers, and remove scaffolding.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: netdev@vger.kernel.org
---
 net/netfilter/nfnetlink_queue.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 2d6668fd026c..a1296453d8f2 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -301,12 +301,10 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 	return -1;
 }
 
-static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
+static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
 {
-	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
 	struct lsmblob blob;
-	struct lsmcontext context = { };
 
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
@@ -314,15 +312,16 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
 	if (skb->secmark) {
+		/* Any LSM might be looking for the secmark */
 		lsmblob_init(&blob, skb->secmark);
-		security_secid_to_secctx(&blob, &context);
-		*secdata = context.context;
+		security_secid_to_secctx(&blob, context);
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
-	seclen = context.len;
+	return context->len;
+#else
+	return 0;
 #endif
-	return seclen;
 }
 
 static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
@@ -398,8 +397,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	enum ip_conntrack_info uninitialized_var(ctinfo);
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
-	struct lsmcontext scaff; /* scaffolding */
-	char *secdata = NULL;
+	struct lsmcontext context = { };
 	u32 seclen = 0;
 
 	size = nlmsg_total_size(sizeof(struct nfgenmsg))
@@ -466,7 +464,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
-		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
+		seclen = nfqnl_get_sk_secctx(entskb, &context);
 		if (seclen)
 			size += nla_total_size(seclen);
 	}
@@ -601,7 +599,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
 		goto nla_put_failure;
 
-	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
+	if (seclen && nla_put(skb, NFQA_SECCTX, context.len, context.context))
 		goto nla_put_failure;
 
 	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
@@ -629,10 +627,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	nlh->nlmsg_len = skb->len;
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (seclen)
+		security_release_secctx(&context);
 	return skb;
 
 nla_put_failure:
@@ -640,10 +636,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	kfree_skb(skb);
 	net_err_ratelimited("nf_queue: error creating packet message\n");
 nlmsg_failure:
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (seclen)
+		security_release_secctx(&context);
 	return NULL;
 }
 
-- 
2.20.1

