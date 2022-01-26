Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAC49CB16
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 14:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbiAZNnq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 08:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbiAZNnp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 08:43:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8923C06161C;
        Wed, 26 Jan 2022 05:43:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49DA56152F;
        Wed, 26 Jan 2022 13:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E67C340E3;
        Wed, 26 Jan 2022 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643204624;
        bh=yMFvQqxwqDIuVp2GIpZdDIZGBM7hvQhOlI6IOZPBOgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qx9WNWys+iiLYrvUd4CWOuHHnhQvnpVRXmVi2MI/CITSzaAzGOTRze+m6CfEoShf/
         hTbDRkepUg2XL2mpNrXu8iXnjqxB2Du40xy1r1uuVa+jaP51K0tVTyokxsgneACiqw
         jxQ7IwM42MhvSrlogC2ZOYBAM7BZhdWNWHZ8PDWvPVDCfGXwJcry7+rzTUqnr5wCe+
         txrT1d0XTdYlduALq9rE0litfBoLodTHICmuSo8uzuoMLzLV03qMcXZNNEvBYmTo2/
         uUxXuuQP0BE+/aQLrgS9KokhlCf9rbYUKHQcjuV8yB/8Spm88i5Juw3HmOk9hArGSl
         e62YCoQC2oZsQ==
Date:   Wed, 26 Jan 2022 14:43:36 +0100
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
        Stefan Berger <stefanb@linux.ibm.com>,
        Denis Semakin <denis.semakin@huawei.com>
Subject: Re: [PATCH v9 12/23] ima: Define mac_admin_ns_capable() as a wrapper
 for ns_capable()
Message-ID: <20220126134336.fqaqwzed3cpaz2vi@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-13-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-13-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:34PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Define mac_admin_ns_capable() as a wrapper for the combined ns_capable()
> checks on CAP_MAC_ADMIN and CAP_SYS_ADMIN in a user namespace. Return
> true on the check if either capability or both are available.
> 
> Use mac_admin_ns_capable() in place of capable(SYS_ADMIN). This will allow
> an IMA namespace to read the policy with only CAP_MAC_ADMIN, which has
> less privileges than CAP_SYS_ADMIN.
> 
> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

It's unfortunate that the securityfs namespacing patch with
FS_USERNS_MOUNT set comes before this patch. The check below with
ima_open_policy() operates on an unprivileged userns if securityfs is
mounted in there. But the ima namespace is the hardcoded as the initial
ima namespace.

I'd rather have the securityfs namespacing patch moved very late in the
series. Even if might not yet possible to open an ima policy in a
non-init userns at this point in the patch series, it still is confusing
in terms of ordering. Especially when considering this were to land in
an upstream tree and one would later in a few years have to read through
the history of this code again.

>  static int ima_open_policy(struct inode *inode, struct file *filp)
>  {
> +#ifdef CONFIG_IMA_READ_POLICY
> +	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
> +#endif

>  include/linux/capability.h      | 6 ++++++
>  security/integrity/ima/ima.h    | 6 ++++++
>  security/integrity/ima/ima_fs.c | 5 ++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 65efb74c3585..991579178f32 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>  		ns_capable(ns, CAP_SYS_ADMIN);
>  }
>  
> +static inline bool mac_admin_ns_capable(struct user_namespace *ns)
> +{
> +	return ns_capable(ns, CAP_MAC_ADMIN) ||
> +		ns_capable(ns, CAP_SYS_ADMIN);
> +}
> +
>  /* audit system wants to get cap info from files as well */
>  int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>  			   const struct dentry *dentry,
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index fb6bd054d899..0057b1fd6c18 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -487,4 +487,10 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
>  #define	POLICY_FILE_FLAGS	S_IWUSR
>  #endif /* CONFIG_IMA_READ_POLICY */
>  
> +static inline
> +struct user_namespace *ima_user_ns_from_file(const struct file *filp)
> +{
> +	return file_inode(filp)->i_sb->s_user_ns;
> +}
> +
>  #endif /* __LINUX_IMA_H */
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 3afb7a74d2cf..9162f06d182f 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -377,6 +377,9 @@ static const struct seq_operations ima_policy_seqops = {
>   */
>  static int ima_open_policy(struct inode *inode, struct file *filp)
>  {
> +#ifdef CONFIG_IMA_READ_POLICY
> +	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
> +#endif
>  	struct ima_namespace *ns = &init_ima_ns;
>  
>  	if (!(filp->f_flags & O_WRONLY)) {
> @@ -385,7 +388,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>  #else
>  		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>  			return -EACCES;
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!mac_admin_ns_capable(user_ns))
>  			return -EPERM;
>  		return seq_open(filp, &ima_policy_seqops);
>  #endif
> -- 
> 2.31.1
> 
> 
