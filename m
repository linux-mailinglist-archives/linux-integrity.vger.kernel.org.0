Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1DA248A6F
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHRPtk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:49:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728269AbgHRPtL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:49:11 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 51E8BDCF110317A0CBA6;
        Tue, 18 Aug 2020 16:49:10 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:49:08 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:49:11 +0200
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
Subject: [RFC PATCH 30/30] ima: Set ML template per ima namespace
Date:   Tue, 18 Aug 2020 17:42:30 +0200
Message-ID: <20200818154230.14016-21-krzysztof.struczynski@huawei.com>
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

Set ML template based on the ima_template string. It can be defined by
the user through kcmd_for_children ima securityfs entry. Acceptable
values are the same as for the ima_template kernel boot parameter.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h                   |  1 +
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_init.c     |  1 +
 security/integrity/ima/ima_ns.c       | 30 ++++++++++++++++++++++++++-
 security/integrity/ima/ima_template.c | 29 +++++++++++++++-----------
 5 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 7db4995c66cf..f65d6424e584 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -211,6 +211,7 @@ struct ima_namespace {
 #ifdef CONFIG_KEYS
 	struct key_tag *key_domain;
 #endif
+	struct ima_template_desc *ima_template;
 } __randomize_layout;
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b55d25c2bf63..89cb050d5668 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -177,6 +177,7 @@ int template_desc_init_fields(const char *template_fmt,
 struct ima_template_desc *ima_template_desc_current(void);
 struct ima_template_desc *lookup_template_desc(const char *name);
 bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
+int ima_template_setup(char *str, struct ima_namespace *ima_ns);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 1668edf3ed32..af77d2c85964 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -49,6 +49,7 @@ struct ima_namespace init_ima_ns = {
 #ifdef CONFIG_KEYS
 	.key_domain = &init_ima_key_domain,
 #endif
+	.ima_template = NULL,
 };
 EXPORT_SYMBOL(init_ima_ns);
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 9b9c34e71cc6..05c5f0df8f8f 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -48,6 +48,28 @@ static void dec_ima_namespaces(struct ucounts *ucounts)
 	return dec_ucount(ucounts, UCOUNT_IMA_NAMESPACES);
 }
 
+static int ima_set_ns_template(struct ima_namespace *ima_ns)
+{
+	int result;
+
+	if (!ima_ns->ima_template)
+		ima_ns->ima_template =
+			lookup_template_desc(CONFIG_IMA_DEFAULT_TEMPLATE);
+
+	result = template_desc_init_fields(ima_ns->ima_template->fmt,
+					   &(ima_ns->ima_template->fields),
+					   &(ima_ns->ima_template->num_fields));
+	if (result < 0) {
+		pr_err("template %s init failed, result: %d\n",
+		       (strlen(ima_ns->ima_template->name) ?
+		       ima_ns->ima_template->name :
+		       ima_ns->ima_template->fmt), result);
+		ima_ns->ima_template = NULL;
+	}
+
+	return result;
+}
+
 static int ima_ns_add_boot_aggregate(struct ima_namespace *ima_ns)
 {
 	static const char op[] = "ns_add_boot_aggregate";
@@ -269,6 +291,7 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 	ns->policy_path_for_children = NULL;
 	ns->x509_path_for_children = NULL;
 	ns->policy_setup_for_children = NULL;
+	ns->ima_template = NULL;
 
 	INIT_LIST_HEAD(&ns->policy_data->ima_default_rules);
 	INIT_LIST_HEAD(&ns->policy_data->ima_policy_rules);
@@ -444,6 +467,10 @@ static int imans_activate(struct ima_namespace *ima_ns)
 	if (ima_ns->frozen)
 		goto out;
 
+	res = ima_set_ns_template(ima_ns);
+	if (res < 0)
+		goto out;
+
 	res = ima_set_ns_policy(ima_ns);
 	if (res < 0)
 		goto out;
@@ -580,10 +607,11 @@ struct ima_kernel_param {
 	int (*set)(char *val, struct ima_namespace *ima_ns);
 };
 
-/* TODO: add ima_template, ima_template_fmt, ima_hash, ... */
+/* TODO: add ima_template_fmt, ima_hash, ... */
 static const struct ima_kernel_param ima_kernel_params[] = {
 	{"ima_appraise", ima_default_appraise_setup},
 	{"ima_policy", ima_policy_setup},
+	{"ima_template", ima_template_setup},
 };
 static const size_t ima_kernel_params_size = ARRAY_SIZE(ima_kernel_params);
 
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 2020bd5176a4..91339a7e1134 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -57,8 +57,6 @@ static const struct ima_template_field supported_fields[] = {
  */
 #define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf|d-modisg|modsig|ns")
 
-static struct ima_template_desc *ima_template;
-
 /**
  * ima_template_has_modsig - Check whether template has modsig-related fields.
  * @ima_template: IMA template to check.
@@ -78,12 +76,12 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template)
 	return false;
 }
 
-static int __init ima_template_setup(char *str)
+int ima_template_setup(char *str, struct ima_namespace *ima_ns)
 {
 	struct ima_template_desc *template_desc;
 	int template_len = strlen(str);
 
-	if (ima_template)
+	if (ima_ns->ima_template)
 		return 1;
 
 	ima_init_template_list();
@@ -109,16 +107,21 @@ static int __init ima_template_setup(char *str)
 		return 1;
 	}
 
-	ima_template = template_desc;
+	ima_ns->ima_template = template_desc;
 	return 1;
 }
-__setup("ima_template=", ima_template_setup);
+
+static int __init template_setup(char *str)
+{
+	return ima_template_setup(str, &init_ima_ns);
+}
+__setup("ima_template=", template_setup);
 
 static int __init ima_template_fmt_setup(char *str)
 {
 	int num_templates = ARRAY_SIZE(builtin_templates);
 
-	if (ima_template)
+	if (init_ima_ns.ima_template)
 		return 1;
 
 	if (template_desc_init_fields(str, NULL, NULL) < 0) {
@@ -128,7 +131,7 @@ static int __init ima_template_fmt_setup(char *str)
 	}
 
 	builtin_templates[num_templates - 1].fmt = str;
-	ima_template = builtin_templates + num_templates - 1;
+	init_ima_ns.ima_template = builtin_templates + num_templates - 1;
 
 	return 1;
 }
@@ -247,12 +250,14 @@ void ima_init_template_list(void)
 
 struct ima_template_desc *ima_template_desc_current(void)
 {
-	if (!ima_template) {
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	if (!ima_ns->ima_template) {
 		ima_init_template_list();
-		ima_template =
-		    lookup_template_desc(CONFIG_IMA_DEFAULT_TEMPLATE);
+		ima_ns->ima_template =
+			lookup_template_desc(CONFIG_IMA_DEFAULT_TEMPLATE);
 	}
-	return ima_template;
+	return ima_ns->ima_template;
 }
 
 int __init ima_init_template(void)
-- 
2.20.1

