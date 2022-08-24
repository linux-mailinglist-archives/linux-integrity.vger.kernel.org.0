Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB78E59FDF0
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiHXPLj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Aug 2022 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbiHXPLi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Aug 2022 11:11:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D690185
        for <linux-integrity@vger.kernel.org>; Wed, 24 Aug 2022 08:11:36 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCTxP5ty8z67xQL;
        Wed, 24 Aug 2022 23:08:09 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 24 Aug 2022 17:11:34 +0200
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 16:11:33 +0100
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <anton.sirazetdinov@huawei.com>, <artem.kuzin@huawei.com>,
        <konstantin.meskhidze@huawei.com>, <yusongping@huawei.com>,
        <hukeping@huawei.com>, <roberto.sassu@huawei.com>,
        <krzysztof.struczynski@huawei.com>, <stefanb@linux.ibm.com>,
        <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v1 3/4] ima: Create vpcr file on securityfs.
Date:   Wed, 24 Aug 2022 23:11:25 +0800
Message-ID: <20220824151125.234590-1-denis.semakin@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.70.102]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
$ sudo cat /sys/kernel/security/ima/vpcr | hexdump -C
00000000  63 50 43 52 3a 20 00 00  00 00 01 00 00 00 00 00  |cPCR: ..........|
00000010  00 00 00 00 00 00 40 71  8e 03 45 9e ff ff 00 00  |......@q..E.....|
00000020  00 00 00 00 00 00 d1 50  43 52 31 32 3a 43 7b a2  |.......PCR12:C{.|
00000030  89 11 5b b8 b4 30 c3 4d  f7 cd e4 f7 19 1e b2 10  |..[..0.M........|
00000040  38 a4 5e 23 61 aa 15 4e  8d ca 38 7d b2 00        |8.^#a..N..8}..|
0000004e

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
---
 security/integrity/ima/ima_fs.c | 122 ++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2eb11d0fb3c7..aaa65ee0d9d5 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -25,6 +25,14 @@
 
 #include "ima.h"
 
+extern struct list_head vpcr_list;
+
+#define CPCR_PFX	"cPCR: "
+#define CPCR_PFX_LEN	6
+
+#define PCR12_PFX	"PCR12:"
+#define PCR12_PFX_LEN	6
+
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -533,6 +541,109 @@ static const struct file_operations ima_active_ops = {
 	.write = ima_write_active,
 };
 
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
+	return 0;
+}
+
+static ssize_t ima_vpcr_read(struct file *filp, char __user *buf, size_t count,
+			     loff_t *ppos)
+{
+	struct vpcr_entry *vpcr;
+	struct {
+		struct ima_digest_data hdr;
+		char digest[SHA256_DIGEST_SIZE];
+	} temp_vpcr_hash = {};
+
+	struct {
+		u8 dig[CPCR_PFX_LEN + SHA256_DIGEST_SIZE + 1];
+	} *vpcr_buff = NULL;
+
+	int ret, i = 0;
+	size_t vpcr_buff_size = 0;
+	loff_t size = SHA256_DIGEST_SIZE * 2;
+	struct ima_namespace *init_ns = &init_ima_ns;
+	struct ima_namespace *curr_ns = ima_ns_from_file(filp);
+
+	if (*ppos != 0)
+		return 0;
+
+	temp_vpcr_hash.hdr.algo = HASH_ALGO_SHA256;
+	temp_vpcr_hash.hdr.length = SHA256_DIGEST_SIZE;
+
+	if (mutex_lock_interruptible(&vpcr_list_mutex))
+		return -EINTR;
+
+	list_for_each_entry(vpcr, &init_ns->vpcr.list, list) {
+		size_t buff_len;
+		u8 buf[IMA_MAX_DIGEST_SIZE * 2] = {0};
+
+		memcpy(buf, &temp_vpcr_hash.digest, SHA256_DIGEST_SIZE);
+		memcpy(buf + SHA256_DIGEST_SIZE, vpcr->vpcr_tmp,
+		       SHA256_DIGEST_SIZE);
+		ret = ima_calc_buffer_hash(curr_ns, buf, size,
+					   &temp_vpcr_hash.hdr);
+		if (ret) {
+			ret = -EINTR;
+			goto free_mem;
+		}
+
+		buff_len = (CPCR_PFX_LEN + SHA256_DIGEST_SIZE + 1) * (i + 1);
+		vpcr_buff_size += buff_len;
+
+		/**
+		 * Using krealloc() here probably looks buggy,
+		 * maybe it's better to use kvmalloc() or vmalloc() instead.
+		 */
+		vpcr_buff = krealloc(vpcr_buff, buff_len, GFP_NOFS);
+		if (!vpcr_buff) {
+			ret = -ENOMEM;
+			goto free_mem;
+		}
+
+		memcpy(&vpcr_buff[i].dig, CPCR_PFX, CPCR_PFX_LEN);
+		memcpy(&vpcr_buff[i].dig[CPCR_PFX_LEN], vpcr->vpcr_tmp,
+		       SHA256_DIGEST_SIZE);
+		i++;
+	}
+
+	vpcr_buff_size += PCR12_PFX_LEN + SHA256_DIGEST_SIZE + 1;
+	vpcr_buff = krealloc(vpcr_buff, vpcr_buff_size, GFP_NOFS);
+	if (!vpcr_buff) {
+		ret = -ENOMEM;
+		goto free_mem;
+	}
+
+	memcpy(&vpcr_buff[i].dig, PCR12_PFX, PCR12_PFX_LEN);
+	mutex_unlock(&vpcr_list_mutex);
+	ret = simple_read_from_buffer(buf, count, ppos, vpcr_buff,
+				      vpcr_buff_size);
+	kfree(vpcr_buff);
+
+	return ret;
+
+free_mem:
+	mutex_unlock(&vpcr_list_mutex);
+	if (vpcr_buff)
+		kfree(vpcr_buff);
+
+	return ret;
+}
+
+static const struct file_operations ima_vpcr_ops = {
+	.open = ima_vpcr_open,
+	.read = ima_vpcr_read,
+};
+
 int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
 	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
@@ -544,6 +655,7 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
 	struct dentry *active = NULL;
+	struct dentry *vpcr = NULL;
 	int ret;
 
 	/*
@@ -620,6 +732,15 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 		goto out;
 	}
 
+	if (ns == &init_ima_ns) {
+		vpcr = securityfs_create_file("vpcr", S_IRUSR | S_IRGRP,
+					      ima_dir, NULL, &ima_vpcr_ops);
+		if (IS_ERR(vpcr)) {
+			ret = PTR_ERR(vpcr);
+			goto out;
+		}
+	}
+
 	if (!ns->ima_policy_removed) {
 		ns->ima_policy =
 		    securityfs_create_file("policy", POLICY_FILE_FLAGS,
@@ -647,6 +768,7 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 
 	return 0;
 out:
+	securityfs_remove(vpcr);
 	securityfs_remove(active);
 	securityfs_remove(ns->ima_policy);
 	securityfs_remove(violations);
-- 
2.25.1

