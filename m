Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF8248ACA
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHRPrG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:47:06 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbgHRPqx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:46:53 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 72D5DD3BE118E0003501;
        Tue, 18 Aug 2020 16:46:49 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:46:47 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:46:50 +0200
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
Subject: [RFC PATCH 21/30] user namespace: Add function that checks if the UID map is defined
Date:   Tue, 18 Aug 2020 17:42:21 +0200
Message-ID: <20200818154230.14016-12-krzysztof.struczynski@huawei.com>
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

Add function that checks if the UID map is defined. It will be used by
ima to check if ID remapping in subject-based rules is necessary.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/user_namespace.h |  6 ++++++
 kernel/user_namespace.c        | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index d9759c54fead..bcb21c41c910 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -138,6 +138,7 @@ extern bool in_userns(const struct user_namespace *ancestor,
 		       const struct user_namespace *child);
 extern bool current_in_userns(const struct user_namespace *target_ns);
 struct ns_common *ns_get_owner(struct ns_common *ns);
+extern bool userns_set_uidmap(const struct user_namespace *ns);
 #else
 
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
@@ -182,6 +183,11 @@ static inline struct ns_common *ns_get_owner(struct ns_common *ns)
 {
 	return ERR_PTR(-EPERM);
 }
+
+static inline bool userns_set_uidmap(const struct user_namespace *ns)
+{
+	return true;
+}
 #endif
 
 #endif /* _LINUX_USER_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 87804e0371fe..e38f9f11a589 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1232,6 +1232,17 @@ bool current_in_userns(const struct user_namespace *target_ns)
 }
 EXPORT_SYMBOL(current_in_userns);
 
+bool userns_set_uidmap(const struct user_namespace *ns)
+{
+	bool mapping_defined;
+
+	mutex_lock(&userns_state_mutex);
+	mapping_defined = ns->uid_map.nr_extents != 0;
+	mutex_unlock(&userns_state_mutex);
+
+	return mapping_defined;
+}
+
 static inline struct user_namespace *to_user_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct user_namespace, ns);
-- 
2.20.1

