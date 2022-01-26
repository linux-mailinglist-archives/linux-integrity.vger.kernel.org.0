Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1204E49CC5D
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbiAZOcA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242164AbiAZObt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:31:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A0C06161C;
        Wed, 26 Jan 2022 06:31:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 018BB6177F;
        Wed, 26 Jan 2022 14:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FA1C340E6;
        Wed, 26 Jan 2022 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643207508;
        bh=3rjfrXEQI/WMd7z+IpGMnkqZQh7poK0zECzrGhslMLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmO/BYaiA0n0/TF2kn5cdLSgGwBx5ELgMeuj0J8iVkS9CHIDIkGDYpvqbf+Y/VDgN
         /b1+cFSebZU6rDtivfkFj2HgR8UQwt8Lrgl/hwM0zCEcN+eXe9ulXcdNqcWU8VRGPG
         jo80uWln3xaQLPFgOKLGtrb7VeD6TnzDMVtpghpds6Zo9/ybfLvZA5Q+1E+jW8VF1X
         HzoZIn2CjDhSn7g/Zbnjy5GugpGrtJmPX0f2iVzdg+zKHMDI0b4m3Spakd2Fj0VDxw
         IVMbr8xJbz9KWYD24p2dRwgcJJTJl+JNNYpkNGm3rKjy8KzO6t9MUO6yS8as9m8lZj
         mEaCJCfyqVw7w==
Date:   Wed, 26 Jan 2022 15:31:40 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 21/23] ima: Introduce securityfs file to activate an
 IMA namespace
Message-ID: <20220126143140.awwlv3h2jqotng2n@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-22-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-22-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:43PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Introduce securityfs file 'active' that allows a user to activate an IMA
> namespace by writing a "1" (precisely a '1\0' or '1\n') to it. When
> reading from the file, it shows either '0' or '1'.
> 
> Also, introduce ns_is_active() to be used in those places where the
> ima_namespace pointer may either be NULL or where the active field may not
> have been set to '1', yet. An inactive IMA namespace should never be
> accessed since it has not been initialized, yet.
> 
> Set the init_ima_ns's active field to '1' since it is considered active
> right from the beginning.
> 
> The rationale for introducing a file to activate an IMA namespace is that
> subsequent support for IMA-measurement and IMA-appraisal will add
> configuration files for selecting for example the template that an IMA
> namespace is supposed to use for logging measurements, which will add
> an IMA namespace configuration stage (using securityfs files) before its
> activation.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/ima/ima.h             |  7 +++
>  security/integrity/ima/ima_fs.c          | 59 ++++++++++++++++++++++++
>  security/integrity/ima/ima_init_ima_ns.c |  1 +
>  security/integrity/ima/ima_main.c        |  2 +-
>  4 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a52b388b4157..cf2f63bb5bdf 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -123,6 +123,8 @@ struct ima_h_table {
>  };
>  
>  struct ima_namespace {
> +	atomic_t active;		/* whether namespace is active */
> +
>  	struct rb_root ns_status_tree;
>  	rwlock_t ns_tree_lock;
>  	struct kmem_cache *ns_status_cache;
> @@ -154,6 +156,11 @@ struct ima_namespace {
>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;
>  
> +static inline bool ns_is_active(struct ima_namespace *ns)
> +{
> +	return (ns && atomic_read(&ns->active));
> +}
> +
>  extern const int read_idmap[];
>  
>  #ifdef CONFIG_HAVE_IMA_KEXEC
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 5dd0e759a470..79a786db79db 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -451,6 +451,62 @@ static const struct file_operations ima_measure_policy_ops = {
>  	.llseek = generic_file_llseek,
>  };
>  
> +static ssize_t ima_show_active(struct file *filp,
> +			       char __user *buf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct ima_namespace *ns = &init_ima_ns;
> +	char tmpbuf[2];
> +	ssize_t len;
> +
> +	len = scnprintf(tmpbuf, sizeof(tmpbuf),
> +			"%d\n", atomic_read(&ns->active));
> +	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
> +}
> +
> +static ssize_t ima_write_active(struct file *filp,
> +				const char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct ima_namespace *ns = &init_ima_ns;
> +	unsigned int active;
> +	char tmpbuf[3];
> +	ssize_t ret;
> +
> +	if (ns_is_active(ns))
> +		return -EBUSY;
> +
> +	ret = simple_write_to_buffer(tmpbuf, sizeof(tmpbuf) - 1, ppos,
> +				     buf, count);
> +	if (ret < 0)
> +		return ret;
> +	tmpbuf[ret] = 0;
> +
> +	if (!kstrtouint(tmpbuf, 10, &active) && active == 1)
> +		atomic_set(&ns->active, 1);
> +
> +	return count;
> +}

Hm, I'd rather do something like (uncompiled, untested):

+static ssize_t ima_write_active(struct file *filp,
				const char __user *buf,
				size_t count, loff_t *ppos)
{
	struct ima_namespace *ns = &init_ima_ns;
	int err;
	unsigned int active;
	char *kbuf = NULL;
	ssize_t length;

	if (count >= 3)
		return -EINVAL;

	/* No partial writes. */
	if (*ppos != 0)
		return -EINVAL;

	if (ns_active(ns))
		return -EBUSY;

	kbuf = memdup_user_nul(buf, count);
	if (IS_ERR(kbuf))
		return PTR_ERR(kbuf);

	err = kstrtouint(kbuf, 10, &active);
	kfree(kbuf);
	if (err)
		return err;

	if (active != 1)
		return -EINVAL;

	atomic_set(&ns->active, 1);
	return count;
}

> +
> +static const struct file_operations ima_active_ops = {
> +	.read = ima_show_active,
> +	.write = ima_write_active,
> +};
> +
> +static int ima_fs_add_ns_files(struct dentry *ima_dir)
> +{
> +	struct dentry *active;
> +
> +	active =
> +	    securityfs_create_file("active",
> +				   S_IRUSR | S_IWUSR | S_IRGRP, ima_dir, NULL,
> +				   &ima_active_ops);
> +	if (IS_ERR(active))
> +		return PTR_ERR(active);
> +
> +	return 0;
> +}
> +
>  int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>  {
>  	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
> @@ -516,6 +572,9 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>  			goto out;
>  	}
>  
> +	if (ns != &init_ima_ns && ima_fs_add_ns_files(ima_dir))

Wouldn't you want to catch the specific error from
ima_fs_add_ns_files() and surface that?

> +		goto out;
> +
>  	return 0;
>  out:
>  	securityfs_remove(ns->ima_policy);
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index d4ddfd1de60b..39ee0c2477a6 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -58,5 +58,6 @@ struct ima_namespace init_ima_ns = {
>  	.ima_lsm_policy_notifier = {
>  		.notifier_call = ima_lsm_policy_change,
>  	},
> +	.active = ATOMIC_INIT(1),
>  };
>  EXPORT_SYMBOL(init_ima_ns);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8018e9aaad32..059917182960 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -441,7 +441,7 @@ static int process_measurement(struct user_namespace *user_ns,
>  
>  	while (user_ns) {
>  		ns = ima_ns_from_user_ns(user_ns);
> -		if (ns) {
> +		if (ns_is_active(ns)) {
>  			int rc;
>  
>  			rc = __process_measurement(ns, file, cred, secid, buf,
> -- 
> 2.31.1
> 
> 
