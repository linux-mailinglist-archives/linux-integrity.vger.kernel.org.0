Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F35248A50
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgHRPpy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:45:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2641 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbgHRPpo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:45:44 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A69F3321DE040DAE081E;
        Tue, 18 Aug 2020 16:45:42 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:45:41 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:45:43 +0200
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
Subject: [RFC PATCH 18/30] ima: Change the owning user namespace of the ima namespace if necessary
Date:   Tue, 18 Aug 2020 17:42:18 +0200
Message-ID: <20200818154230.14016-9-krzysztof.struczynski@huawei.com>
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

It's possible that the user first unshares the ima namespace and then
creates a new user namespace using clone3(). In that case the owning
user namespace is the newly created one, because it is associated with
the first process in the new ima namespace.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h             |  6 +++--
 kernel/nsproxy.c                |  2 +-
 security/integrity/ima/ima_ns.c | 42 +++++++++++++++++++++++++++------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 7eb7a008c5fe..4b5b832417b0 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -216,7 +216,8 @@ struct ima_namespace *copy_ima_ns(unsigned long flags,
 
 void free_ima_ns(struct kref *kref);
 
-int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
+int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk,
+		  struct user_namespace *user_ns);
 
 static inline struct ima_namespace *get_ima_ns(struct ima_namespace *ns)
 {
@@ -239,7 +240,8 @@ static inline struct ima_namespace *copy_ima_ns(unsigned long flags,
 }
 
 static inline int imans_on_fork(struct nsproxy *nsproxy,
-				struct task_struct *tsk)
+				struct task_struct *tsk,
+				struct user_namespace *user_ns)
 {
 	return 0;
 }
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 791efffd7a03..4b1ecf405f11 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -204,7 +204,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 		return ret;
 	}
 
-	ret = imans_on_fork(new_ns, tsk);
+	ret = imans_on_fork(new_ns, tsk, user_ns);
 	if (ret) {
 		free_nsproxy(new_ns);
 		return ret;
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 3012287b22d2..b8bfab39b55b 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -92,6 +92,24 @@ static void ima_set_ns_policy(struct ima_namespace *ima_ns,
 	ima_init_ns_policy(ima_ns, &setup_data);
 }
 
+static int ima_swap_user_ns(struct ima_namespace *ima_ns,
+			    struct user_namespace *user_ns)
+{
+	struct ucounts *ucounts;
+
+	dec_ima_namespaces(ima_ns->ucounts);
+	put_user_ns(ima_ns->user_ns);
+
+	ucounts = inc_ima_namespaces(user_ns);
+	if (!ucounts)
+		return -ENOSPC;
+
+	ima_ns->user_ns = get_user_ns(user_ns);
+	ima_ns->ucounts = ucounts;
+
+	return 0;
+}
+
 /**
  * Clone a new ns copying an original ima namespace, setting refcount to 1
  *
@@ -337,23 +355,33 @@ static int imans_install(struct nsset *nsset, struct ns_common *new)
 	return res;
 }
 
-int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
+int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk,
+		  struct user_namespace *user_ns)
 {
 	int res;
-	struct ns_common *nsc = &nsproxy->ima_ns_for_children->ns;
-	struct ima_namespace *ns = to_ima_ns(nsc);
+	struct ima_namespace *ima_ns = nsproxy->ima_ns_for_children;
 
 	/* create_new_namespaces() already incremented the ref counter */
-	if (nsproxy->ima_ns == nsproxy->ima_ns_for_children)
+	if (nsproxy->ima_ns == ima_ns)
 		return 0;
 
-	res = imans_activate(ns);
+	/* It's possible that the user first unshares the IMA namespace and
+	 * then creates a new user namespace on clone3(). In that case swap
+	 * user namespace for the "current" one.
+	 */
+	if (ima_ns->user_ns != user_ns) {
+		res = ima_swap_user_ns(ima_ns, user_ns);
+		if (res)
+			return res;
+	}
+
+	res = imans_activate(ima_ns);
 	if (res)
 		return res;
 
-	get_ima_ns(ns);
+	get_ima_ns(ima_ns);
 	put_ima_ns(nsproxy->ima_ns);
-	nsproxy->ima_ns = ns;
+	nsproxy->ima_ns = ima_ns;
 
 	return res;
 }
-- 
2.20.1

