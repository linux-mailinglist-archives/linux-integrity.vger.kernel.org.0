Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8355304EB
	for <lists+linux-integrity@lfdr.de>; Sun, 22 May 2022 19:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbiEVRbK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 May 2022 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiEVRbH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 May 2022 13:31:07 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED5B492;
        Sun, 22 May 2022 10:31:01 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 476603F4; Sun, 22 May 2022 12:31:00 -0500 (CDT)
Date:   Sun, 22 May 2022 12:31:00 -0500
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
        jpenumak@redhat.com, Denis Semakin <denis.semakin@huawei.com>
Subject: Re: [PATCH v12 11/26] ima: Define mac_admin_ns_capable() as a
 wrapper for ns_capable()
Message-ID: <20220522173100.GB24041@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-12-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-12-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:18AM -0400, Stefan Berger wrote:
> Define mac_admin_ns_capable() as a wrapper for the combined ns_capable()
> checks on CAP_MAC_ADMIN and CAP_SYS_ADMIN in a user namespace. Return
> true on the check if either capability or both are available.
> 
> Use mac_admin_ns_capable() in place of capable(SYS_ADMIN). This will allow
> an IMA namespace to read the policy with only CAP_MAC_ADMIN, which has
> less privileges than CAP_SYS_ADMIN.
> 
> Since CAP_MAC_ADMIN is an additional capability added to an existing gate
> avoid auditing in case it is not set.

It would probably be best to become a user of
https://lore.kernel.org/all/20220217145003.78982-2-cgzones@googlemail.com/

when that lands.

> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> v11:
>   - use ns_capable_noaudit for CAP_MAC_ADMIN to avoid auditing in this case
> ---
>  include/linux/capability.h      | 6 ++++++
>  security/integrity/ima/ima.h    | 6 ++++++
>  security/integrity/ima/ima_fs.c | 5 ++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 65efb74c3585..dc3e1230b365 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>  		ns_capable(ns, CAP_SYS_ADMIN);
>  }
>  
> +static inline bool mac_admin_ns_capable(struct user_namespace *ns)
> +{
> +	return ns_capable_noaudit(ns, CAP_MAC_ADMIN) ||
> +		ns_capable(ns, CAP_SYS_ADMIN);
> +}
> +
>  /* audit system wants to get cap info from files as well */
>  int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>  			   const struct dentry *dentry,
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 5bf7f080c2be..626a6ce2453c 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -491,4 +491,10 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
>  #define	POLICY_FILE_FLAGS	S_IWUSR
>  #endif /* CONFIG_IMA_READ_POLICY */
>  
> +static inline
> +struct user_namespace *ima_user_ns_from_file(const struct file *filp)
> +{
> +	return file_inode(filp)->i_sb->s_user_ns;
> +}

include/linux/fs.h has file_mnt_user_ns().  Maybe you should add a
file_sb_user_ns() next to that?

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
> 2.34.1
