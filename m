Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD4446F3AA
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 20:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhLITO6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 14:14:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42156 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhLITO5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 14:14:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43783CE27EF;
        Thu,  9 Dec 2021 19:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E17AC341CA;
        Thu,  9 Dec 2021 19:11:14 +0000 (UTC)
Date:   Thu, 9 Dec 2021 20:11:09 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v5 13/16] ima: Move some IMA policy and filesystem
 related variables into ima_namespace
Message-ID: <20211209191109.o3x7nynnm52zhygz@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-14-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211208221818.1519628-14-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 08, 2021 at 05:18:15PM -0500, Stefan Berger wrote:
> Move the ima_write_mutex, ima_fs_flag, and valid_policy variables into
> ima_namespace. This way each IMA namespace can set those variables
> independently.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/ima.h                      |  5 ++++
>  security/integrity/ima/ima_fs.c          | 32 +++++++++++-------------
>  security/integrity/ima/ima_init_ima_ns.c |  4 +++
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 2ce801bfc449..3aaf6e806db4 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -261,6 +261,11 @@ struct ima_namespace {
>  	struct ima_h_table ima_htable;
>  	struct list_head ima_measurements;
>  	unsigned long binary_runtime_size;
> +
> +	/* IMA's filesystem */
> +	struct mutex ima_write_mutex;
> +	unsigned long ima_fs_flags;
> +	int valid_policy;
>  };
>  
>  extern struct ima_namespace init_ima_ns;
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 38b1c26479b3..0e582ceecc7f 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -25,8 +25,6 @@
>  
>  #include "ima.h"
>  
> -static DEFINE_MUTEX(ima_write_mutex);
> -
>  bool ima_canonical_fmt;
>  static int __init default_canonical_fmt_setup(char *str)
>  {
> @@ -37,8 +35,6 @@ static int __init default_canonical_fmt_setup(char *str)
>  }
>  __setup("ima_canonical_fmt", default_canonical_fmt_setup);
>  
> -static int valid_policy = 1;
> -
>  static ssize_t ima_show_htable_value(char __user *buf, size_t count,
>  				     loff_t *ppos, atomic_long_t *val)
>  {
> @@ -339,7 +335,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>  		goto out;
>  	}
>  
> -	result = mutex_lock_interruptible(&ima_write_mutex);
> +	result = mutex_lock_interruptible(&ns->ima_write_mutex);
>  	if (result < 0)
>  		goto out_free;
>  
> @@ -354,12 +350,12 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>  	} else {
>  		result = ima_parse_add_rule(ns, data);
>  	}
> -	mutex_unlock(&ima_write_mutex);
> +	mutex_unlock(&ns->ima_write_mutex);
>  out_free:
>  	kfree(data);
>  out:
>  	if (result < 0)
> -		valid_policy = 0;
> +		ns->valid_policy = 0;
>  
>  	return result;
>  }
> @@ -376,8 +372,6 @@ enum ima_fs_flags {
>  	IMA_FS_BUSY,
>  };
>  
> -static unsigned long ima_fs_flags;
> -
>  #ifdef	CONFIG_IMA_READ_POLICY
>  static const struct seq_operations ima_policy_seqops = {
>  		.start = ima_policy_start,
> @@ -392,6 +386,8 @@ static const struct seq_operations ima_policy_seqops = {
>   */
>  static int ima_open_policy(struct inode *inode, struct file *filp)
>  {
> +	struct ima_namespace *ns = get_current_ns();
> +

I'm a bit confused here. In all those callbacks:
	.open = ima_open_policy,
	.write = ima_write_policy,
	.release = ima_release_policy,
you're calling get_current_ns() at the top of it. What guarantees that
the same ima_namespace is returned here? What if the fd is sent to
someone who is in a different user namespace and the write to that
file?

Maybe I'm just confused but wouldn't you want something like this?

From 1f03dc427c583d5e9ebc9ebe9de77c3c535bbebe Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 9 Dec 2021 20:07:02 +0100
Subject: [PATCH] !!!! HERE BE DRAGONS - UNTESTED !!!!

---
 security/integrity/ima/ima_fs.c | 43 +++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 583462b29cb5..d5b302b925b8 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -317,10 +317,14 @@ static ssize_t ima_read_policy(char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns;
+	struct user_namespace *user_ns;
 	char *data;
 	ssize_t result;
 
+	user_ns = ima_filp_private(filp);
+	ns = user_ns->ima_ns
+
 	if (datalen >= PAGE_SIZE)
 		datalen = PAGE_SIZE - 1;
 
@@ -373,26 +377,51 @@ static const struct seq_operations ima_policy_seqops = {
 };
 #endif
 
+static struct user_namespace *ima_filp_private(struct file *filp)
+{
+	if (!(filp->f_flags & O_WRONLY)) {
+#ifdef CONFIG_IMA_READ_POLICY
+		struct seq_file *seq;
+
+		seq = filp->private_data;
+		return seq->private;
+#endif
+	}
+	return filp->private_data;
+}
+
 /*
  * ima_open_policy: sequentialize access to the policy file
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct user_namespace *user_ns = current_user_ns();
+	struct ima_namespace *ns = user_ns->ima_ns;
 
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
 		return -EACCES;
 #else
+		int err;
+		struct seq_file *seq;
+
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!mac_admin_ns_capable(ima_user_ns(ns)))
+		if (!mac_admin_ns_capable(user_ns))
 			return -EPERM;
-		return seq_open(filp, &ima_policy_seqops);
+		err = seq_open(filp, &ima_policy_seqops);
+		if (err)
+			return err;
+
+		seq = filp->private_data;
+		seq->private = user_ns;
+		return 0;
 #endif
 	}
 	if (test_and_set_bit(IMA_FS_BUSY, &ns->ima_fs_flags))
 		return -EBUSY;
+
+	filp->private_data = user_ns;
 	return 0;
 }
 
@@ -405,9 +434,13 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	struct ima_namespace *ns = get_current_ns();
+	struct ima_namespace *ns;
+	struct user_namespace *user_ns;
 	const char *cause = ns->valid_policy ? "completed" : "failed";
 
+	user_ns = ima_filp_private(filp);
+	ns = user_ns->ima_ns
+
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
-- 
2.30.2

