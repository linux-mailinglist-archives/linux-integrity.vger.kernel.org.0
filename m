Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBBF6CD5D2
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Mar 2023 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjC2JEE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjC2JEC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 05:04:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C740144BE
        for <linux-integrity@vger.kernel.org>; Wed, 29 Mar 2023 02:03:34 -0700 (PDT)
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PmgYP0c0Kz6J7wn
        for <linux-integrity@vger.kernel.org>; Wed, 29 Mar 2023 17:02:33 +0800 (CST)
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 10:03:09 +0100
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>,
        <ilya.hanov@huawei-partners.com>, <yusongping@huawei.com>,
        <hukeping@huawei.com>, <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v1 1/1] ima: obtain child measurement list from init namespace
Date:   Wed, 29 Mar 2023 17:03:00 +0800
Message-ID: <20230329090300.279061-1-denis.semakin@huawei.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
References: <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.70.102]
X-ClientProxiedBy: mscpeml100002.china.huawei.com (7.188.26.75) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
---
 security/integrity/ima/ima.h             |   1 +
 security/integrity/ima/ima_fs.c          | 164 ++++++++++++++++++++++-
 security/integrity/ima/ima_init_ima_ns.c |   2 +
 security/integrity/ima/ima_ns.c          |  31 +++++
 4 files changed, 193 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a717be9685ed..b46d6944f6ca 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -178,6 +178,7 @@ struct ima_namespace {
 	int ima_extra_slots;
 	struct vpcr_entry vpcr;
 	uuid_t uuid;
+	struct dentry *parent_dentry;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 570e5d00a454..78d9f967e1f4 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -24,6 +24,7 @@
 #include <linux/ima.h>
 
 #include "ima.h"
+#define INUM_BUF_SIZE	16
 
 extern struct list_head vpcr_list;
 static bool vpcr_mutex_acquired;
@@ -84,9 +85,8 @@ static const struct file_operations ima_measurements_count_ops = {
 };
 
 /* returns pointer to hlist_node */
-static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
+static void *__ima_measurements_start(struct ima_namespace *ns, loff_t *pos)
 {
-	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
@@ -102,9 +102,16 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 	return NULL;
 }
 
-static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
+static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
 	struct ima_namespace *ns = ima_ns_from_file(m->file);
+
+	return __ima_measurements_start(ns, pos);
+}
+
+static void *__ima_measurements_next(struct ima_namespace *ns, void *v,
+				     loff_t *pos)
+{
 	struct ima_queue_entry *qe = v;
 
 	/* lock protects when reading beyond last element
@@ -118,6 +125,13 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 	return (&qe->later == &ns->ima_measurements) ? NULL : qe;
 }
 
+static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
+
+	return __ima_measurements_next(ns, v, pos);
+}
+
 static void ima_measurements_stop(struct seq_file *m, void *v)
 {
 }
@@ -237,10 +251,10 @@ void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
 }
 
 /* print in ascii */
-static int ima_ascii_measurements_show(struct seq_file *m, void *v)
+static int __ima_ascii_measurements_show(struct ima_namespace *ns,
+					 struct seq_file *m, void *v)
 {
 	/* the list never shrinks, so we don't need a lock here */
-	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
@@ -276,6 +290,13 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int ima_ascii_measurements_show(struct seq_file *m, void *v)
+{
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
+
+	return __ima_ascii_measurements_show(ns, m, v);
+}
+
 static const struct seq_operations ima_ascii_measurements_seqops = {
 	.start = ima_measurements_start,
 	.next = ima_measurements_next,
@@ -706,6 +727,94 @@ static const struct file_operations ima_ascii_vpcr_fops = {
 	.release = seq_release,
 };
 
+static void *child_ns_measure_start(struct seq_file *m, loff_t *pos)
+{
+	struct ima_namespace *ns = (struct ima_namespace *)m->private;
+
+	return __ima_measurements_start(ns, pos);
+}
+
+static void *child_ns_measure_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct ima_namespace *ns = (struct ima_namespace *)m->private;
+
+	return __ima_measurements_next(ns, v, pos);
+}
+
+static void child_ns_measure_stop(struct seq_file *m, void *v)
+{
+}
+
+static int ascii_child_ns_measure_show(struct seq_file *m, void *v)
+{
+	struct ima_namespace *ns = (struct ima_namespace *)m->private;
+
+	return __ima_ascii_measurements_show(ns, m, v);
+}
+
+static int child_ns_measure_show(struct seq_file *m, void *v)
+{
+	struct ima_namespace *ns = (struct ima_namespace *)m->private;
+
+	return ima_ns_measurements_show(ns, m, v);
+}
+
+
+const struct seq_operations ascii_child_ns_measure_seqops = {
+	.start = child_ns_measure_start,
+	.next  = child_ns_measure_next,
+	.stop  = child_ns_measure_stop,
+	.show  = ascii_child_ns_measure_show,
+};
+
+const struct seq_operations child_ns_measure_seqops = {
+	.start = child_ns_measure_start,
+	.next  = child_ns_measure_next,
+	.stop  = child_ns_measure_stop,
+	.show  = child_ns_measure_show,
+};
+
+static int child_ns_measure_open(struct inode *inode, struct file *filp,
+				 struct seq_operations *seq_ops)
+{
+	int ret;
+	struct seq_file *m;
+
+	ret = seq_open(filp, seq_ops);
+	if (ret)
+		return ret;
+
+	m = filp->private_data;
+	m->private = inode->i_private;
+
+	return 0;
+}
+
+static int ascii_child_ns_measure_open(struct inode *inode, struct file *filp)
+{
+	return child_ns_measure_open(inode, filp,
+				     &ascii_child_ns_measure_seqops);
+}
+static int bin_child_ns_measure_open(struct inode *inode, struct file *filp)
+{
+	return child_ns_measure_open(inode, filp, &child_ns_measure_seqops);
+}
+
+
+static const struct file_operations ascii_ima_child_ns_measure_fops = {
+	.open = ascii_child_ns_measure_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct file_operations ima_child_ns_measure_fops = {
+	.open = bin_child_ns_measure_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
 int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
 	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
@@ -718,6 +827,9 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *violations = NULL;
 	struct dentry *binary_vpcr = NULL;
 	struct dentry *ascii_vpcr = NULL;
+	struct dentry *child_dir;
+	struct dentry *child_ascii_dentry;
+	struct dentry *child_bin_dentry;
 	int ret;
 
 	/*
@@ -821,6 +933,12 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 			ret = PTR_ERR(ascii_vpcr);
 			goto out;
 		}
+
+		ns->parent_dentry = securityfs_create_dir("children", ima_dir);
+		if (IS_ERR(ima_dir)) {
+			ret = PTR_ERR(ima_dir);
+			goto out;
+		}
 	}
 
 	if (!ns->ima_policy_removed) {
@@ -834,11 +952,47 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 		}
 	}
 
+	if (ns != &init_ima_ns) {
+		char buf[INUM_BUF_SIZE];
+		snprintf(buf, INUM_BUF_SIZE, "%u", user_ns->ns.inum);
+		child_dir =
+			securityfs_create_dir(buf, init_ima_ns.parent_dentry);
+
+		if (IS_ERR(child_dir)) {
+			ret = PTR_ERR(child_dir);
+			if (ret != -EEXIST) /* Ignore only EEXIST */
+				goto out;
+		} else {
+			child_ascii_dentry =
+				securityfs_create_file("ascii_measurement",
+						S_IRUSR | S_IWUSR | S_IRGRP,
+						child_dir, ns,
+						&ascii_ima_child_ns_measure_fops);
+			if (IS_ERR(child_ascii_dentry)) {
+				ret = PTR_ERR(child_ascii_dentry);
+				goto out;
+			}
+
+			child_bin_dentry =
+				securityfs_create_file("binary_measurement",
+						    S_IRUSR | S_IWUSR | S_IRGRP,
+						    child_dir, ns,
+						    &ima_child_ns_measure_fops);
+			if (IS_ERR(child_bin_dentry)) {
+				ret = PTR_ERR(child_bin_dentry);
+				goto out;
+			}
+		}
+	}
+
 	if (!ima_ns_from_user_ns(user_ns))
 		user_ns_set_ima_ns(user_ns, ns);
 
 	return 0;
 out:
+	securityfs_remove(child_bin_dentry);
+	securityfs_remove(child_ascii_dentry);
+	securityfs_remove(child_dir);
 	securityfs_remove(ascii_vpcr);
 	securityfs_remove(binary_vpcr);
 	securityfs_remove(ns->ima_policy);
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 53d5539f67d6..c989bbb22a97 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -86,6 +86,8 @@ int ima_init_namespace(struct ima_namespace *ns)
 		/* Also the child ns inherits the algo array from init ns */
 		ns->ima_algo_array = init_ima_ns.ima_algo_array;
 
+		ns->parent_dentry = init_ima_ns.parent_dentry;
+
 		mutex_lock(&vpcr_list_mutex);
 		list_add_tail(&ns->vpcr.list, &vpcr_list);
 		mutex_unlock(&vpcr_list_mutex);
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 3f65bfbba98d..de49abfdf9e9 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/ima.h>
+#include <linux/namei.h>
 
 #include "ima.h"
 
@@ -48,11 +49,41 @@ void ima_free_ima_ns(struct ima_namespace *ns)
 	kmem_cache_free(imans_cachep, ns);
 }
 
+#define DENTRY_BUF_SIZE 16
+
+static void remove_ima_child_dentry(struct user_namespace *user_ns)
+{
+	char inum_dir[DENTRY_BUF_SIZE];
+	char ascii_fname[DENTRY_BUF_SIZE * 2];
+	char bin_fname[DENTRY_BUF_SIZE * 2];
+	struct dentry *dentry_dir, *ascii_file, *bin_file;
+
+	snprintf(inum_dir, DENTRY_BUF_SIZE, "%u", user_ns->ns.inum);
+	snprintf(ascii_fname, DENTRY_BUF_SIZE * 2, "%u/ascii", user_ns->ns.inum);
+	snprintf(bin_fname, DENTRY_BUF_SIZE * 2, "%u/bin", user_ns->ns.inum);
+
+	inode_lock(d_inode(init_ima_ns.parent_dentry));
+
+	dentry_dir = lookup_one_len(inum_dir, init_ima_ns.parent_dentry,
+				    strlen(inum_dir));
+	ascii_file = lookup_one_len(ascii_fname, init_ima_ns.parent_dentry,
+				     strlen(ascii_fname));
+	bin_file = lookup_one_len(bin_fname, init_ima_ns.parent_dentry,
+				     strlen(bin_fname));
+
+	inode_unlock(d_inode(init_ima_ns.parent_dentry));
+
+	securityfs_remove(ascii_file);
+	securityfs_remove(bin_file);
+	securityfs_remove(dentry_dir);
+}
+
 void free_ima_ns(struct user_namespace *user_ns)
 {
 	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 
 	ima_free_ima_ns(ns);
+	remove_ima_child_dentry(user_ns);
 
 	user_ns->ima_ns = NULL;
 }
-- 
2.38.GIT

