Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F4B4AA706
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Feb 2022 07:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbiBEGEb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Feb 2022 01:04:31 -0500
Received: from mail.hallyn.com ([178.63.66.53]:39068 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344783AbiBEGEa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Feb 2022 01:04:30 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 136E47E4; Fri,  4 Feb 2022 23:58:27 -0600 (CST)
Date:   Fri, 4 Feb 2022 23:58:27 -0600
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
        Denis Semakin <denis.semakin@huawei.com>
Subject: Re: [PATCH v10 12/27] ima: Define mac_admin_ns_capable() as a
 wrapper for ns_capable()
Message-ID: <20220205055826.GA15072@mail.hallyn.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-13-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201203735.164593-13-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 01, 2022 at 03:37:20PM -0500, Stefan Berger wrote:
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

Do you care about audit warnings?  If the task has CAP_SYS_ADMIN but
not CAP_MAC_ADMIN, is it desirable that selinux_capable() will audit the
CAP_MAC_ADMIN failure?

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
> index 89d3113ceda1..c41aa61b7393 100644
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
