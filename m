Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED31A1DC9
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2020 11:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDHJD0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Apr 2020 05:03:26 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59365 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726996AbgDHJD0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Apr 2020 05:03:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TuyXpqc_1586336574;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TuyXpqc_1586336574)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Apr 2020 17:02:55 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: Simplify the implementation of ima_fs_init function
Date:   Wed,  8 Apr 2020 17:02:54 +0800
Message-Id: <20200408090254.99525-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_fs_init() has more redundant code, a lot of repetitive code
makes this function ugly, it is inconvenient to add additional
functions, this patch optimizes the implementation of this function,
uses an array and loop to simplify the function process.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/integrity/ima/ima_fs.c | 72 ++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index a71e822a6e92..6763d6cee78d 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -355,10 +355,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 
 static struct dentry *ima_dir;
 static struct dentry *ima_symlink;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
-static struct dentry *runtime_measurements_count;
-static struct dentry *violations;
 static struct dentry *ima_policy;
 
 enum ima_fs_flags {
@@ -447,8 +443,24 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
+static struct ima_fs_file {
+	const char *name;
+	const struct file_operations *fops;
+	struct dentry *dentry;
+} ima_fs_entries[] = {
+	{ "binary_runtime_measurements", &ima_measurements_ops },
+	{ "ascii_runtime_measurements", &ima_ascii_measurements_ops },
+	{ "runtime_measurements_count", &ima_measurements_count_ops },
+	{ "violations", &ima_htable_violations_ops },
+	{ NULL }
+};
+
 int __init ima_fs_init(void)
 {
+	struct dentry *dentry;
+	struct ima_fs_file *iff;
+	int i;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return -1;
@@ -458,47 +470,33 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_symlink))
 		goto out;
 
-	binary_runtime_measurements =
-	    securityfs_create_file("binary_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_measurements_ops);
-	if (IS_ERR(binary_runtime_measurements))
+	ima_policy = securityfs_create_file("ima_policy", POLICY_FILE_FLAGS,
+					ima_dir, NULL,
+					&ima_measure_policy_ops);
+	if (IS_ERR(ima_policy))
 		goto out;
 
-	ascii_runtime_measurements =
-	    securityfs_create_file("ascii_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_ascii_measurements_ops);
-	if (IS_ERR(ascii_runtime_measurements))
-		goto out;
+	for (i = 0; ; i++) {
+		iff = &ima_fs_entries[i];
+		if (!iff->name)
+			return 0;
 
-	runtime_measurements_count =
-	    securityfs_create_file("runtime_measurements_count",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_measurements_count_ops);
-	if (IS_ERR(runtime_measurements_count))
-		goto out;
+		dentry = securityfs_create_file(iff->name, S_IRUSR | S_IRGRP,
+						ima_dir, NULL, iff->fops);
+		if (IS_ERR(dentry))
+			break;
 
-	violations =
-	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
-				   ima_dir, NULL, &ima_htable_violations_ops);
-	if (IS_ERR(violations))
-		goto out;
+		iff->dentry = dentry;
+	}
 
-	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
-					    ima_dir, NULL,
-					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy))
-		goto out;
+	for (i--; i >= 0; i--) {
+		iff = &ima_fs_entries[i];
+		securityfs_remove(iff->dentry);
+		iff->dentry = NULL;
+	}
 
-	return 0;
 out:
-	securityfs_remove(violations);
-	securityfs_remove(runtime_measurements_count);
-	securityfs_remove(ascii_runtime_measurements);
-	securityfs_remove(binary_runtime_measurements);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
-	securityfs_remove(ima_policy);
 	return -1;
 }
-- 
2.17.1

