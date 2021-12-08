Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7ED46D372
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 13:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhLHMoQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 07:44:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42406 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhLHMoO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 07:44:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B08BDCE214F;
        Wed,  8 Dec 2021 12:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32915C00446;
        Wed,  8 Dec 2021 12:40:34 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:40:31 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
Subject: Re: [PATCH v4 14/16] ima: Use mac_admin_ns_capable() to check
 corresponding capability
Message-ID: <20211208124031.lbutcvt3ns73vgsw@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-15-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207202127.1508689-15-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 07, 2021 at 03:21:25PM -0500, Stefan Berger wrote:
> Use mac_admin_ns_capable() to check corresponding capability to allow
> read/write IMA policy without CAP_SYS_ADMIN but with CAP_MAC_ADMIN.
> 
> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/capability.h      | 6 ++++++
>  security/integrity/ima/ima_fs.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
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
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 0e582ceecc7f..a749a3e79304 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -394,7 +394,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>  #else
>  		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>  			return -EACCES;
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!mac_admin_ns_capable(ns->user_ns))
>  			return -EPERM;

Hm, couldn't this rather just be:

		if (ns_capable(ns, CAP_MAC_ADMIN) || capable(CAP_SYS_ADMIN))

so we don't carry CAP_SYS_ADMIN as an alternative way for ima into user
namespaces as well? This way containers don't need to drop CAP_SYS_ADMIN
just to prevent mac policy from being altered. But that's more on the
LSM side of questions.
