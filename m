Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A847667DEFE
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jan 2023 09:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjA0IUq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Jan 2023 03:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjA0IUp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Jan 2023 03:20:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6860738B6D
        for <linux-integrity@vger.kernel.org>; Fri, 27 Jan 2023 00:20:36 -0800 (PST)
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P39R95vyqz6J6Bv
        for <linux-integrity@vger.kernel.org>; Fri, 27 Jan 2023 16:17:09 +0800 (CST)
Received: from localhost.localdomain (10.123.66.33) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 27 Jan 2023 08:20:33 +0000
From:   Ilya Hanov <ilya.hanov@huawei-partners.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <yusongping@huawei.com>, <hukeping@huawei.com>,
        <denis.semakin@huawei-partners.com>, <artem.kuzin@huawei.com>,
        <konstantin.meskhidze@huawei.com>, <ilya.hanov@huawei-partners.com>
Subject: [RFC PATCH v1 2/3] ima: ascii_vpcr pseudo-file for sysadmins
Date:   Fri, 27 Jan 2023 16:19:52 +0800
Message-ID: <20230127081953.7534-3-ilya.hanov@huawei-partners.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
References: <20221031025507.298323-1-denis.semakin@huawei.com>
 <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.123.66.33]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dump cPCR values in human-readable format. This may add some flexibility for
debugging. ima/vpcr also was renamed to ima/binary_vpcr. When something went wrong
System Administrator is able to see cPCR values without
doing PCR_Extend operations (for PCR12), this invokes only PCR_Read. ascii_vpcr
has the same format as binary_vpcr, but can be read by humans:

$ sudo cat /sys/kernel/security/ima/ascii_vpcr
cPCR: c57f9efc-7149-4df5-a1b3-66fb03db4006 8780724757d796e21b242f9bc8912c0905d24dfb2011a74fd1e91134b247bf80
(output truncated)

Signed-off-by: Ilya Hanov <ilya.hanov@huawei-partners.com>
---
 security/integrity/ima/ima_fs.c | 129 ++++++++++++++++++++++++++++----
 1 file changed, 113 insertions(+), 16 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cf9164d31599..2ebbdfa708df 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -572,7 +572,7 @@ static void *vpcr_next(struct seq_file *m, void *v, loff_t *pos)
 	return seq_list_next(v, &vpcr_list, pos);
 }
 
-static void vpcr_stop(struct seq_file *m, void *v)
+static void binary_vpcr_stop(struct seq_file *m, void *v)
 {
 	int j;
 	int ret;
@@ -585,8 +585,10 @@ static void vpcr_stop(struct seq_file *m, void *v)
 		return;
 
 	tpm_chip = curr_ns->ima_tpm_chip;
-	pcr12_digest.alg_id = TPM_ALG_SHA256;
+	if (!tpm_chip)
+		goto ex;
 
+	pcr12_digest.alg_id = TPM_ALG_SHA256;
 	temp_tpm = kcalloc(tpm_chip->nr_allocated_banks,
 			   sizeof(*curr_ns->digests), GFP_NOFS);
 	if (!temp_tpm)
@@ -626,7 +628,7 @@ static void vpcr_stop(struct seq_file *m, void *v)
 	mutex_unlock(&vpcr_list_mutex);
 }
 
-static int vpcr_show(struct seq_file *m, void *v)
+static int binary_vpcr_show(struct seq_file *m, void *v)
 {
 	int ret = 0;
 	u8 buf[IMA_MAX_DIGEST_SIZE * 2] = {0};
@@ -647,14 +649,96 @@ static int vpcr_show(struct seq_file *m, void *v)
 	return ret;
 }
 
-const struct seq_operations vpcr_seq_ops = {
+const struct seq_operations binary_vpcr_seq_ops = {
+	.start = vpcr_start,
+	.next  = vpcr_next,
+	.stop  = binary_vpcr_stop,
+	.show  = binary_vpcr_show,
+};
+
+static int ima_binary_vpcr_open(struct inode *inode, struct file *filp)
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
+	return seq_open(filp, &binary_vpcr_seq_ops);
+}
+
+static const struct file_operations ima_binary_vpcr_fops = {
+	.open = ima_binary_vpcr_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void ascii_vpcr_stop(struct seq_file *m, void *v)
+{
+	int ret;
+	struct tpm_chip *tpm_chip;
+	struct tpm_digest pcr12_digest;
+	struct ima_namespace *curr_ns = ima_ns_from_file(m->file);
+
+	if (!vpcr_mutex_acquired)
+		return;
+
+	tpm_chip = curr_ns->ima_tpm_chip;
+	if (!tpm_chip)
+		goto ex;
+
+	pcr12_digest.alg_id = TPM_ALG_SHA256;
+	ret = tpm_pcr_read(tpm_chip, TPM_PCR12, &pcr12_digest);
+	if (ret != 0) {
+		seq_puts(m, "TPM read error\n");
+		goto ex;
+	}
+
+	/* 1st: PCR12 Prefix */
+	seq_printf(m, "\nPCR12: ");
+
+	/* 2nd: PCR12 Hash */
+	seq_printf(m, "%*phN", SHA256_DIGEST_SIZE, pcr12_digest.digest);
+	seq_printf(m, "\n");
+ex:
+	WRITE_ONCE(vpcr_mutex_acquired, false);
+	mutex_unlock(&vpcr_list_mutex);
+}
+
+static int ascii_vpcr_show(struct seq_file *m, void *v)
+{
+	struct vpcr_entry *vpcr = list_entry(v, struct vpcr_entry, list);
+	struct ima_namespace *curr_ns = container_of(vpcr, struct ima_namespace,
+						     vpcr);
+
+	if (!vpcr)
+		return -ENOENT;
+
+	/* 1st: cPCR Prefix */
+	seq_printf(m, "cPCR: ");
+
+	/* 2nd: cPCR UUID Value */
+	seq_printf(m, "%pUb ", &curr_ns->uuid);
+
+	/* 3rd: cPCR.Value XOR cPCR.Secret */
+	seq_printf(m, "%*phN", SHA256_DIGEST_SIZE, vpcr->vpcr_tmp);
+	seq_printf(m, "\n");
+
+	return 0;
+}
+
+const struct seq_operations ascii_vpcr_seq_ops = {
 	.start = vpcr_start,
 	.next  = vpcr_next,
-	.stop  = vpcr_stop,
-	.show  = vpcr_show,
+	.stop  = ascii_vpcr_stop,
+	.show  = ascii_vpcr_show,
 };
 
-static int ima_vpcr_open(struct inode *inode, struct file *filp)
+static int ima_ascii_vpcr_open(struct inode *inode, struct file *filp)
 {
 	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
 	struct ima_namespace *ns = ima_ns_from_file(filp);
@@ -665,11 +749,11 @@ static int ima_vpcr_open(struct inode *inode, struct file *filp)
 	if (!ns_is_active(ns) || !mac_admin_ns_capable(user_ns))
 		return -EACCES;
 
-	return seq_open(filp, &vpcr_seq_ops);
+	return seq_open(filp, &ascii_vpcr_seq_ops);
 }
 
-static const struct file_operations ima_vpcr_fops = {
-	.open = ima_vpcr_open,
+static const struct file_operations ima_ascii_vpcr_fops = {
+	.open = ima_ascii_vpcr_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = seq_release,
@@ -686,7 +770,8 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
 	struct dentry *active = NULL;
-	struct dentry *vpcr = NULL;
+	struct dentry *binary_vpcr = NULL;
+	struct dentry *ascii_vpcr = NULL;
 	int ret;
 
 	/*
@@ -764,10 +849,21 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	}
 
 	if (ns == &init_ima_ns) {
-		vpcr = securityfs_create_file("vpcr", S_IRUSR | S_IRGRP,
-					      ima_dir, NULL, &ima_vpcr_fops);
-		if (IS_ERR(vpcr)) {
-			ret = PTR_ERR(vpcr);
+		binary_vpcr =
+		    securityfs_create_file("binary_vpcr",
+					    S_IRUSR | S_IRGRP, ima_dir, NULL,
+					    &ima_binary_vpcr_fops);
+		if (IS_ERR(binary_vpcr)) {
+			ret = PTR_ERR(binary_vpcr);
+			goto out;
+		}
+
+		ascii_vpcr =
+		    securityfs_create_file("ascii_vpcr",
+					    S_IRUSR | S_IRGRP, ima_dir, NULL,
+					    &ima_ascii_vpcr_fops);
+		if (IS_ERR(ascii_vpcr)) {
+			ret = PTR_ERR(ascii_vpcr);
 			goto out;
 		}
 	}
@@ -799,7 +895,8 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 
 	return 0;
 out:
-	securityfs_remove(vpcr);
+	securityfs_remove(ascii_vpcr);
+	securityfs_remove(binary_vpcr);
 	securityfs_remove(active);
 	securityfs_remove(ns->ima_policy);
 	securityfs_remove(violations);
-- 
2.17.1

