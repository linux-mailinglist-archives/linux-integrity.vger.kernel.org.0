Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF7D612F2E
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Oct 2022 04:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJaDAR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 30 Oct 2022 23:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJaDAO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 30 Oct 2022 23:00:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F170657D
        for <linux-integrity@vger.kernel.org>; Sun, 30 Oct 2022 20:00:13 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N0yXB2gmrz67wM8;
        Mon, 31 Oct 2022 10:58:34 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 31 Oct 2022 04:00:11 +0100
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 03:00:10 +0000
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>,
        <yusongping@huawei.com>, <hukeping@huawei.com>,
        <roberto.sassu@huawei.com>, <krzysztof.struczynski@huawei.com>,
        <stefanb@linux.ibm.com>, <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v2 3/4] ima: Create vpcr file on securityfs.
Date:   Mon, 31 Oct 2022 11:00:00 +0800
Message-ID: <20221031030000.298779-1-denis.semakin@huawei.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221031025507.298323-1-denis.semakin@huawei.com>
References: <20221031025507.298323-1-denis.semakin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.70.102]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This file contains information of all virtual PCR registers
that is extended by kernel when the real PCR extension operation
is occurred.

It provides the values of cPCRs and PCR12 register.
During reading operation it calculates the final value of
of cPCRs, store it in temp_vpcr_hash structure.

Then this tempPCR value is used to extend the real PCR12 register.

E.g.:
$ sudo cat /sys/kernel/security/ima/vpcr
cPCR:  ab3c1c3ae0581168284738f01470d7be64b9a220bb4b7030b879ffc669a2e4b6
PCR12: 73b7267c1e9b74c573a6e243af1d574bf6141be162a51e6aef4cfc15c7550963

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
---
 security/integrity/ima/ima_fs.c | 72 +++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index bb4c3d4493e2..d9e91b9f1564 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -25,6 +25,8 @@
 
 #include "ima.h"
 
+extern struct list_head vpcr_list;
+
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -538,6 +540,65 @@ static const struct file_operations ima_active_ops = {
 	.write = ima_write_active,
 };
 
+static void *vpcr_start(struct seq_file *m, loff_t *pos)
+{
+	int err;
+
+	err = mutex_lock_interruptible(&vpcr_list_mutex);
+	if (err)
+		return ERR_PTR(err);
+
+	return seq_list_start(&vpcr_list, *pos);
+}
+
+static void *vpcr_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &vpcr_list, pos);
+}
+
+static void vpcr_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&vpcr_list_mutex);
+}
+
+static int vpcr_show(struct seq_file *m, void *v)
+{
+	struct vpcr_entry *vpcr = list_entry(v, struct vpcr_entry, list);
+
+	ima_putc(m, "cPCR: ", strlen("cPCR: "));
+	ima_putc(m, vpcr->vpcr_tmp, SHA256_DIGEST_SIZE);
+
+	return 0;
+}
+
+const struct seq_operations vpcr_seq_ops = {
+	.start = vpcr_start,
+	.next  = vpcr_next,
+	.stop  = vpcr_stop,
+	.show  = vpcr_show,
+};
+
+static int ima_vpcr_open(struct inode *inode, struct file *filp)
+{
+	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
+	struct ima_namespace *ns = ima_ns_from_file(filp);
+
+	if (!ns->ima_tpm_chip)
+		return -ENODEV;
+
+	if (!ns_is_active(ns) || !mac_admin_ns_capable(user_ns))
+		return -EACCES;
+
+	return seq_open(filp, &vpcr_seq_ops);
+}
+
+static const struct file_operations ima_vpcr_fops = {
+	.open = ima_vpcr_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
 int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
 	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
@@ -549,6 +610,7 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
 	struct dentry *active = NULL;
+	struct dentry *vpcr = NULL;
 	int ret;
 
 	/*
@@ -625,6 +687,15 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 		goto out;
 	}
 
+	if (ns == &init_ima_ns) {
+		vpcr = securityfs_create_file("vpcr", S_IRUSR | S_IRGRP,
+					      ima_dir, NULL, &ima_vpcr_fops);
+		if (IS_ERR(vpcr)) {
+			ret = PTR_ERR(vpcr);
+			goto out;
+		}
+	}
+
 	if (!ns->ima_policy_removed) {
 		ns->ima_policy =
 		    securityfs_create_file("policy", POLICY_FILE_FLAGS,
@@ -652,6 +723,7 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 
 	return 0;
 out:
+	securityfs_remove(vpcr);
 	securityfs_remove(active);
 	securityfs_remove(ns->ima_policy);
 	securityfs_remove(violations);
-- 
2.38.GIT

