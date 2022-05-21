Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A9152F7D5
	for <lists+linux-integrity@lfdr.de>; Sat, 21 May 2022 05:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354411AbiEUDDX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 23:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347956AbiEUDDS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 23:03:18 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6F6195BC0;
        Fri, 20 May 2022 20:03:16 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 7FD571286; Fri, 20 May 2022 22:03:14 -0500 (CDT)
Date:   Fri, 20 May 2022 22:03:14 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v12 07/26] ima: Move some IMA policy and filesystem
 related variables into ima_namespace
Message-ID: <20220521030314.GE9107@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-8-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-8-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:14AM -0400, Stefan Berger wrote:
> Move the variables ima_write_mutex, ima_fs_flag, and valid_policy, which
> are related to updating the IMA policy, into the ima_namespace. This way
> each IMA namespace can set these variables independently in its instance
> of securityfs.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/integrity/ima/ima.h             |  5 ++++
>  security/integrity/ima/ima_fs.c          | 32 +++++++++++-------------
>  security/integrity/ima/ima_init_ima_ns.c |  4 +++
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 82e8af2bf698..a144edfdb9a1 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -137,6 +137,11 @@ struct ima_namespace {
>  	struct ima_h_table ima_htable;
>  	struct list_head ima_measurements;	/* list of all measurements */
>  	unsigned long binary_runtime_size;	/* used by init_ima_ns */
> +
> +	/* securityfs support related variables */
> +	struct mutex ima_write_mutex;
> +	unsigned long ima_fs_flags;
> +	int valid_policy;
>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;
>  
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 5ef0e2b2cf64..4cf786f0bba8 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -24,8 +24,6 @@
>  
>  #include "ima.h"
>  
> -static DEFINE_MUTEX(ima_write_mutex);
> -
>  bool ima_canonical_fmt;
>  static int __init default_canonical_fmt_setup(char *str)
>  {
> @@ -36,8 +34,6 @@ static int __init default_canonical_fmt_setup(char *str)
>  }
>  __setup("ima_canonical_fmt", default_canonical_fmt_setup);
>  
> -static int valid_policy = 1;
> -
>  static ssize_t ima_show_htable_value(char __user *buf, size_t count,
>  				     loff_t *ppos, atomic_long_t *val)
>  {
> @@ -338,7 +334,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>  		goto out;
>  	}
>  
> -	result = mutex_lock_interruptible(&ima_write_mutex);
> +	result = mutex_lock_interruptible(&ns->ima_write_mutex);
>  	if (result < 0)
>  		goto out_free;
>  
> @@ -353,12 +349,12 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
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
> @@ -375,8 +371,6 @@ enum ima_fs_flags {
>  	IMA_FS_BUSY,
>  };
>  
> -static unsigned long ima_fs_flags;
> -
>  #ifdef	CONFIG_IMA_READ_POLICY
>  static const struct seq_operations ima_policy_seqops = {
>  		.start = ima_policy_start,
> @@ -391,6 +385,8 @@ static const struct seq_operations ima_policy_seqops = {
>   */
>  static int ima_open_policy(struct inode *inode, struct file *filp)
>  {
> +	struct ima_namespace *ns = &init_ima_ns;
> +
>  	if (!(filp->f_flags & O_WRONLY)) {
>  #ifndef	CONFIG_IMA_READ_POLICY
>  		return -EACCES;
> @@ -402,7 +398,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>  		return seq_open(filp, &ima_policy_seqops);
>  #endif
>  	}
> -	if (test_and_set_bit(IMA_FS_BUSY, &ima_fs_flags))
> +	if (test_and_set_bit(IMA_FS_BUSY, &ns->ima_fs_flags))
>  		return -EBUSY;
>  	return 0;
>  }
> @@ -416,25 +412,25 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>   */
>  static int ima_release_policy(struct inode *inode, struct file *file)
>  {
> -	const char *cause = valid_policy ? "completed" : "failed";
>  	struct ima_namespace *ns = &init_ima_ns;
> +	const char *cause = ns->valid_policy ? "completed" : "failed";
>  
>  	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
>  		return seq_release(inode, file);
>  
> -	if (valid_policy && ima_check_policy(ns) < 0) {
> +	if (ns->valid_policy && ima_check_policy(ns) < 0) {
>  		cause = "failed";
> -		valid_policy = 0;
> +		ns->valid_policy = 0;
>  	}
>  
>  	pr_info("policy update %s\n", cause);
>  	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> -			    "policy_update", cause, !valid_policy, 0);
> +			    "policy_update", cause, !ns->valid_policy, 0);
>  
> -	if (!valid_policy) {
> +	if (!ns->valid_policy) {
>  		ima_delete_rules(ns);
> -		valid_policy = 1;
> -		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
> +		ns->valid_policy = 1;
> +		clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
>  		return 0;
>  	}
>  
> @@ -443,7 +439,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>  	securityfs_remove(ima_policy);
>  	ima_policy = NULL;
>  #elif defined(CONFIG_IMA_WRITE_POLICY)
> -	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
> +	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
>  #elif defined(CONFIG_IMA_READ_POLICY)
>  	inode->i_mode &= ~S_IWUSR;
>  #endif
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index a7477072c587..425eed1c6838 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -26,6 +26,10 @@ static int ima_init_namespace(struct ima_namespace *ns)
>  	else
>  		ns->binary_runtime_size = ULONG_MAX;
>  
> +	mutex_init(&ns->ima_write_mutex);
> +	ns->valid_policy = 1;
> +	ns->ima_fs_flags = 0;
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1
