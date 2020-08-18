Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB4248A88
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHRPve (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:51:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728239AbgHRPsH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:48:07 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id C18A762DD92823577DEB;
        Tue, 18 Aug 2020 16:48:05 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:48:04 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:48:06 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Subject: [RFC PATCH 28/30] ima: Load per ima namespace x509 certificate
Date:   Tue, 18 Aug 2020 17:42:28 +0200
Message-ID: <20200818154230.14016-19-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
References: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

If configured, load the x509 certificate when the first process is
born into the new ima namespace. User can set the path to the
certificate by writing to the x509_for_children entry in the ima
securityfs.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/digsig.c     |  6 +--
 security/integrity/ima/ima_ns.c | 69 ++++++++++++++++++++++++++++-----
 security/integrity/integrity.h  |  2 +-
 3 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 523fc786c4d7..8cd54bc83892 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -170,8 +170,8 @@ int __init integrity_init_keyring(const unsigned int id)
 	return __integrity_init_keyring(id, perm, restriction);
 }
 
-int __init integrity_add_key(const unsigned int id, const void *data,
-			     off_t size, key_perm_t perm)
+int integrity_add_key(const unsigned int id, const void *data,
+		      off_t size, key_perm_t perm)
 {
 	key_ref_t key;
 	int rc = 0;
@@ -195,7 +195,7 @@ int __init integrity_add_key(const unsigned int id, const void *data,
 
 }
 
-int __init integrity_load_x509(const unsigned int id, const char *path)
+int integrity_load_x509(const unsigned int id, const char *path)
 {
 	void *data;
 	loff_t size;
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 872dc6a96a96..11e1d896f603 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -48,6 +48,30 @@ static void dec_ima_namespaces(struct ucounts *ucounts)
 	return dec_ucount(ucounts, UCOUNT_IMA_NAMESPACES);
 }
 
+#ifdef CONFIG_IMA_LOAD_X509
+static int ima_ns_load_x509(struct ima_namespace *ima_ns)
+{
+	int res = 0;
+	int unset_flags =
+		ima_ns->policy_data->ima_policy_flag & IMA_APPRAISE;
+
+	if (!ima_ns->x509_path_for_children)
+		return res;
+
+	ima_ns->policy_data->ima_policy_flag &= ~unset_flags;
+	res = integrity_load_x509(INTEGRITY_KEYRING_IMA,
+				  ima_ns->x509_path_for_children);
+	ima_ns->policy_data->ima_policy_flag |= unset_flags;
+
+	return res;
+}
+#else
+static inline int ima_ns_load_x509(struct ima_namespace *ima_ns)
+{
+	return 0;
+}
+#endif
+
 static struct ima_namespace *ima_ns_alloc(void)
 {
 	struct ima_namespace *ima_ns;
@@ -365,6 +389,10 @@ static int imans_activate(struct ima_namespace *ima_ns)
 	if (res < 0)
 		goto out;
 
+	res = ima_ns_load_x509(ima_ns);
+	if (res < 0)
+		goto out;
+
 	ima_ns->frozen = true;
 
 	/* Set current last element as list's head */
@@ -388,6 +416,7 @@ static int imans_install(struct nsset *nsset, struct ns_common *new)
 	int res;
 	struct nsproxy *nsproxy = nsset->nsproxy;
 	struct ima_namespace *ns = to_ima_ns(new);
+	struct ima_namespace *old_ns = nsproxy->ima_ns;
 
 	if (!current_is_single_threaded())
 		return -EUSERS;
@@ -396,14 +425,24 @@ static int imans_install(struct nsset *nsset, struct ns_common *new)
 	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	res = imans_activate(ns);
-	if (res)
-		return res;
-
 	get_ima_ns(ns);
-	put_ima_ns(nsproxy->ima_ns);
+	put_ima_ns(old_ns);
 	nsproxy->ima_ns = ns;
 
+	/* The activation has to take place, after attaching the new namespace
+	 * to the nsproxy. This is because one part of the activation process,
+	 * is loading the appraisal keys, which temporary disables appraisal in
+	 * the current ima namespace, and it must not happen for the "old" ima
+	 * namespace.
+	 */
+	res = imans_activate(ns);
+	if (res) {
+		get_ima_ns(old_ns);
+		put_ima_ns(ns);
+		nsproxy->ima_ns = old_ns;
+		return res;
+	}
+
 	get_ima_ns(ns);
 	put_ima_ns(nsproxy->ima_ns_for_children);
 	nsproxy->ima_ns_for_children = ns;
@@ -416,6 +455,7 @@ int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk,
 {
 	int res;
 	struct ima_namespace *ima_ns = nsproxy->ima_ns_for_children;
+	struct ima_namespace *old_ima_ns = nsproxy->ima_ns;
 
 	/* create_new_namespaces() already incremented the ref counter */
 	if (nsproxy->ima_ns == ima_ns)
@@ -431,14 +471,23 @@ int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk,
 			return res;
 	}
 
-	res = imans_activate(ima_ns);
-	if (res)
-		return res;
-
 	get_ima_ns(ima_ns);
-	put_ima_ns(nsproxy->ima_ns);
+	put_ima_ns(old_ima_ns);
 	nsproxy->ima_ns = ima_ns;
 
+	/* The activation has to take place, after attaching the new namespace
+	 * to the nsproxy. This is because one part of the activation process,
+	 * is loading the appraisal keys, which temporary disables appraisal in
+	 * the current ima namespace, and it must not happen for the "old" ima
+	 * namespace.
+	 */
+	res = imans_activate(ima_ns);
+	if (res) {
+		get_ima_ns(old_ima_ns);
+		put_ima_ns(ima_ns);
+		nsproxy->ima_ns = old_ima_ns;
+	}
+
 	return res;
 }
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 207a1aef28e4..9b080b9fe242 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -179,7 +179,7 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 int integrity_modsig_verify(unsigned int id, const struct modsig *modsig);
 
 int __init integrity_init_keyring(const unsigned int id);
-int __init integrity_load_x509(const unsigned int id, const char *path);
+int integrity_load_x509(const unsigned int id, const char *path);
 int __init integrity_load_cert(const unsigned int id, const char *source,
 			       const void *data, size_t len, key_perm_t perm);
 #else
-- 
2.20.1

