Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA9E1A2E08
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Apr 2020 05:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDIDjQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Apr 2020 23:39:16 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49769 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbgDIDjQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Apr 2020 23:39:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tv0dk.r_1586403548;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Tv0dk.r_1586403548)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Apr 2020 11:39:09 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ima: support to read appraise mode
Date:   Thu,  9 Apr 2020 11:39:06 +0800
Message-Id: <20200409033907.102833-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409033907.102833-1-tianjia.zhang@linux.alibaba.com>
References: <20200409033907.102833-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Support to read appraise mode in runtime through securityfs file
'integrity/ima/appraise_mode'.

Signed-off-by: luanshi <zhangliguang@linux.alibaba.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/integrity/ima/ima_fs.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index a71e822a6e92..65384f6ac0d9 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -360,6 +360,7 @@ static struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
 static struct dentry *violations;
 static struct dentry *ima_policy;
+static struct dentry *appraise_mode;
 
 enum ima_fs_flags {
 	IMA_FS_BUSY,
@@ -447,6 +448,29 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
+static ssize_t ima_appraise_mode_read(struct file *filp,
+					char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	const char *mode;
+
+	if (ima_appraise & IMA_APPRAISE_ENFORCE)
+		mode = "enforce";
+	else if (ima_appraise & IMA_APPRAISE_FIX)
+		mode = "fix";
+	else if (ima_appraise & IMA_APPRAISE_LOG)
+		mode = "log";
+	else
+		mode = "off";
+
+	return simple_read_from_buffer(buf, count, ppos, mode, strlen(mode));
+}
+
+static const struct file_operations ima_appraise_mode_ops = {
+	.read = ima_appraise_mode_read,
+	.llseek = generic_file_llseek,
+};
+
 int __init ima_fs_init(void)
 {
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
@@ -491,14 +515,20 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_policy))
 		goto out;
 
+	appraise_mode =
+	    securityfs_create_file("appraise_mode", S_IRUSR | S_IRGRP,
+				   ima_dir, NULL, &ima_appraise_mode_ops);
+	if (IS_ERR(appraise_mode))
+		goto out;
+
 	return 0;
 out:
+	securityfs_remove(ima_policy);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
 	securityfs_remove(binary_runtime_measurements);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
-	securityfs_remove(ima_policy);
 	return -1;
 }
-- 
2.17.1

