Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86603248A57
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgHRPpw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:45:52 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgHRPpj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:45:39 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 8C3E2B9656467A8B2B83;
        Tue, 18 Aug 2020 16:45:37 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:45:35 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:45:38 +0200
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
Subject: [RFC PATCH 16/30] ima: Extend permissions to the ima securityfs entries
Date:   Tue, 18 Aug 2020 17:42:16 +0200
Message-ID: <20200818154230.14016-7-krzysztof.struczynski@huawei.com>
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

Add "others" permissions to the namespaced ima securityfs entries. It
is necessary so that the root in the user namespace that is the parent
of the given ima namespace has access to the ima related data.

Loosened DAC restrictrions are compensated by an extra check for
SYS_ADMIN capabilities in the ima code. The access is given
only to the namespaced data, e.g. root user in the new ima namespace
will see measurement list entries collected for that namespace and not
for the other existing namespaces. The only exception is made for the
admin in the initial user namespace, who has access to all the data.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima.h    |  4 ++--
 security/integrity/ima/ima_fs.c | 31 +++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e08f88aab0b5..7318fff3ccaa 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -523,9 +523,9 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #endif /* CONFIG_IMA_LSM_RULES */
 
 #ifdef	CONFIG_IMA_READ_POLICY
-#define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
+#define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR | S_IROTH | S_IWOTH)
 #else
-#define	POLICY_FILE_FLAGS	S_IWUSR
+#define	POLICY_FILE_FLAGS	(S_IWUSR | I_WOTH)
 #endif /* CONFIG_IMA_READ_POLICY */
 
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e2893f0b0f31..6d370874d80f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -59,6 +59,16 @@ static const struct file_operations ima_htable_violations_ops = {
 	.llseek = generic_file_llseek,
 };
 
+static int ima_open_measurements_count(struct inode *inode, struct file *file)
+{
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	if (!ns_capable(ima_ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return 0;
+}
+
 static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
@@ -70,6 +80,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 }
 
 static const struct file_operations ima_measurements_count_ops = {
+	.open = ima_open_measurements_count,
 	.read = ima_show_measurements_count,
 	.llseek = generic_file_llseek,
 };
@@ -242,6 +253,11 @@ static const struct seq_operations ima_measurments_seqops = {
 
 static int ima_measurements_open(struct inode *inode, struct file *file)
 {
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	if (!ns_capable(ima_ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
 	return seq_open(file, &ima_measurments_seqops);
 }
 
@@ -308,6 +324,11 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
 
 static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 {
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	if (!ns_capable(ima_ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
 	return seq_open(file, &ima_ascii_measurements_seqops);
 }
 
@@ -429,13 +450,15 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
+	struct ima_namespace *ima_ns = get_current_ns();
+
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
 		return -EACCES;
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!capable(CAP_SYS_ADMIN))
+		if (!ns_capable(ima_ns->user_ns, CAP_SYS_ADMIN))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
@@ -509,21 +532,21 @@ int __init ima_fs_init(void)
 
 	binary_runtime_measurements =
 	    securityfs_create_file("binary_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
+				   S_IRUSR | S_IRGRP | S_IROTH, ima_dir, NULL,
 				   &ima_measurements_ops);
 	if (IS_ERR(binary_runtime_measurements))
 		goto out;
 
 	ascii_runtime_measurements =
 	    securityfs_create_file("ascii_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
+				   S_IRUSR | S_IRGRP | S_IROTH, ima_dir, NULL,
 				   &ima_ascii_measurements_ops);
 	if (IS_ERR(ascii_runtime_measurements))
 		goto out;
 
 	runtime_measurements_count =
 	    securityfs_create_file("runtime_measurements_count",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
+				   S_IRUSR | S_IRGRP | S_IROTH, ima_dir, NULL,
 				   &ima_measurements_count_ops);
 	if (IS_ERR(runtime_measurements_count))
 		goto out;
-- 
2.20.1

