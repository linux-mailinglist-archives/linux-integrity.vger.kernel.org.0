Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA52248A49
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHRPoh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:44:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbgHRPo1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:44:27 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9BB6028283C12E031ACF;
        Tue, 18 Aug 2020 16:44:25 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:44:23 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:44:26 +0200
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
Subject: [RFC PATCH 11/30] ima: Keep track of the measurment list per ima namespace
Date:   Tue, 18 Aug 2020 17:42:11 +0200
Message-ID: <20200818154230.14016-2-krzysztof.struczynski@huawei.com>
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

Add a pointer to the tail of the measurement list to the ima namespace
when the namespace is created. This will allow to skip the irrelevant
measurement list entries while iterating the measurement list in that
ima namespace. Only entries with the matching ima namespace ID will be
displayed.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h               | 1 +
 security/integrity/ima/ima_init.c | 1 +
 security/integrity/ima/ima_ns.c   | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 1d0439d86ade..df22143ffe30 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -202,6 +202,7 @@ struct ima_namespace {
 	bool frozen;
 	struct ima_policy_data *policy_data;
 	struct integrity_iint_tree *iint_tree;
+	struct list_head *measurements;
 } __randomize_layout;
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index d63ecb02b032..aece357286b8 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -35,6 +35,7 @@ struct ima_namespace init_ima_ns = {
 	.frozen = true,
 	.policy_data = &init_policy_data,
 	.iint_tree = &init_iint_tree,
+	.measurements = &ima_measurements,
 };
 EXPORT_SYMBOL(init_ima_ns);
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 04aa50473971..f331187a4d3c 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -293,6 +293,11 @@ static int imans_activate(struct ima_namespace *ima_ns)
 
 	ima_ns->frozen = true;
 
+	/* Set current last element as list's head */
+	rcu_read_lock();
+	ima_ns->measurements = list_tail_rcu(&ima_measurements);
+	rcu_read_unlock();
+
 	down_write(&ima_ns_list_lock);
 	list_add_tail(&ima_ns->list, &ima_ns_list);
 	up_write(&ima_ns_list_lock);
-- 
2.20.1

