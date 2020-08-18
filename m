Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5786C2489CD
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHRP0z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:26:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728060AbgHRP0T (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:26:19 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7D6AA7FAC173646AF9E4;
        Tue, 18 Aug 2020 16:26:17 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:26:15 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:26:18 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>
Subject: [RFC PATCH 05/30] ima: Add methods for parsing ima policy configuration string
Date:   Tue, 18 Aug 2020 17:20:12 +0200
Message-ID: <20200818152037.11869-6-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
References: <N>
 <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
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

IMA subsystem is configured at boot time using kernel command-line
parameters, e.g.: ima_policy=tcb|appraise_tcb|secure_boot. The same
configuration options should be available for the new ima namespace.
Add new functions to parse configuration string and store parsed data
in the new policy data structures. Don't implement it yet, just add the
dummy interface.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima.h          | 10 ++++++++
 security/integrity/ima/ima_appraise.c |  9 +++++++
 security/integrity/ima/ima_policy.c   | 37 +++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0d88222e3500..4872f193f7a3 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -306,6 +306,16 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
 
+int ima_policy_setup(char *str,
+		     struct ima_policy_setup_data *policy_setup_data,
+		     bool *fail_unverifiable_sigs);
+int ima_default_measure_policy_setup(const char *str,
+				     struct ima_policy_setup_data *setup_data);
+int ima_default_appraise_policy_setup(const char *str,
+				      struct ima_policy_setup_data *setup_data);
+int ima_default_appraise_setup(const char *str,
+			       struct ima_policy_setup_data *setup_data);
+
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
 #define IMA_APPRAISE_FIX	0x02
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 372d16382960..0632d3881611 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -16,6 +16,15 @@
 
 #include "ima.h"
 
+int ima_default_appraise_setup(const char *str,
+			       struct ima_policy_setup_data *setup_data)
+{
+	/* Currently unused. It will be implemented after namespacing ima
+	 * policy, when global variables are removed.
+	 */
+	return 1;
+}
+
 static int __init default_appraise_setup(char *str)
 {
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6b56741ec1c9..403854b18ef2 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -223,6 +223,15 @@ struct ima_policy_data init_policy_data = {
 	.ima_temp_rules = LIST_HEAD_INIT(init_policy_data.ima_temp_rules),
 };
 
+int ima_default_measure_policy_setup(const char *str,
+				     struct ima_policy_setup_data *setup_data)
+{
+	/* Currently unused. It will be implemented after namespacing ima
+	 * policy, when global variables are removed.
+	 */
+	return 1;
+}
+
 static int __init default_measure_policy_setup(char *str)
 {
 	if (ima_policy)
@@ -236,6 +245,25 @@ __setup("ima_tcb", default_measure_policy_setup);
 static bool ima_use_appraise_tcb __initdata;
 static bool ima_use_secure_boot __initdata;
 static bool ima_fail_unverifiable_sigs __ro_after_init;
+
+/**
+ * ima_policy_setup - parse policy configuration string "ima_policy="
+ * @str: string to be parsed
+ * @setup_data: pointer to a structure where parsed data is stored
+ * @fail_unverifiable_sigs: boolean flag treated separately to preserve
+ * __ro_after_init
+ */
+int ima_policy_setup(char *str,
+		     struct ima_policy_setup_data *setup_data,
+		     bool *fail_unverifiable_sigs)
+{
+
+	/* Currently unused. It will be implemented after namespacing ima
+	 * policy, when global variables are removed.
+	 */
+	return 1;
+}
+
 static int __init policy_setup(char *str)
 {
 	char *p;
@@ -257,6 +285,15 @@ static int __init policy_setup(char *str)
 }
 __setup("ima_policy=", policy_setup);
 
+int ima_default_appraise_policy_setup(const char *str,
+				      struct ima_policy_setup_data *setup_data)
+{
+	/* Currently unused. It will be implemented after namespacing ima
+	 * policy, when global variables are removed.
+	 */
+	return 1;
+}
+
 static int __init default_appraise_policy_setup(char *str)
 {
 	ima_use_appraise_tcb = true;
-- 
2.20.1

