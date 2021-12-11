Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C9747145D
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhLKPCt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 10:02:49 -0500
Received: from mail.hallyn.com ([178.63.66.53]:51816 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230180AbhLKPCt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 10:02:49 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 7F1DB67D; Sat, 11 Dec 2021 09:02:46 -0600 (CST)
Date:   Sat, 11 Dec 2021 09:02:46 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Denis Semakin <denis.semakin@huawei.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "mpeters@redhat.com" <mpeters@redhat.com>,
        "lhinds@redhat.com" <lhinds@redhat.com>,
        "lsturman@redhat.com" <lsturman@redhat.com>,
        "puiterwi@redhat.com" <puiterwi@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "jamjoom@us.ibm.com" <jamjoom@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "rgb@redhat.com" <rgb@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>
Subject: Re: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check
 corresponding capability
Message-ID: <20211211150246.GA24925@mail.hallyn.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-15-stefanb@linux.ibm.com>
 <cde301002f884f43bcb7fa244b1c6b84@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde301002f884f43bcb7fa244b1c6b84@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMO yes it is unsafe, however I concede that I am not sufficiently familiar
with the policy language.  At least Stefan and Mimi (IIUC) want the host
policy language to be able to specify cases where an IMA ns can be
configured.  What's not clear to me is what sorts of triggers the host
IMA policy could specify that would safely identify a IMA ns generation
trigger.

Stefan, would you mind showing what such a policy statement would look like?
Does it amount to "/usr/bin/runc may create an IMA ns which escapes current
policy" ?  Or is it by UID, or any file which has a certain xattr on it?

-serge

On Thu, Dec 09, 2021 at 08:09:20AM +0000, Denis Semakin wrote:
> Following that thoughts...
> Will it be so incorrectly to unbound IMA-ns from USER-ns?
> I realize that it could lead a lot of problems but it is still unclear will current IMA-ns will be useful for Kuber...
> How userland supposed to use current IMA-ns implementation?
> 
> Br,
> Denis
> 
> -----Original Message-----
> From: Denis Semakin 
> Sent: Thursday, December 9, 2021 10:22 AM
> To: 'Stefan Berger' <stefanb@linux.ibm.com>; linux-integrity@vger.kernel.org
> Cc: zohar@linux.ibm.com; serge@hallyn.com; christian.brauner@ubuntu.com; containers@lists.linux.dev; dmitry.kasatkin@gmail.com; ebiederm@xmission.com; Krzysztof Struczynski <krzysztof.struczynski@huawei.com>; Roberto Sassu <roberto.sassu@huawei.com>; mpeters@redhat.com; lhinds@redhat.com; lsturman@redhat.com; puiterwi@redhat.com; jejb@linux.ibm.com; jamjoom@us.ibm.com; linux-kernel@vger.kernel.org; paul@paul-moore.com; rgb@redhat.com; linux-security-module@vger.kernel.org; jmorris@namei.org
> Subject: RE: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check corresponding capability
> 
> Hi. 
> My question won't be about capabilities. I'm wondering how IMA-ns which is associated with USER-ns and is created during USER-ns creation would be used by some namespaces orchestration systems, e.g. Kubernetes?.. It seems that it can be run without any user namespaces... 
> Their community just discuss this opportunity to support User namespaces. (see https://github.com/kubernetes/enhancements/pull/2101)
> Looks like currently IMA-ns will not be applicable for Kubernetes.
> 
> Br,
> Denis
> 
> -----Original Message-----
> From: Stefan Berger [mailto:stefanb@linux.ibm.com]
> Sent: Thursday, December 9, 2021 1:18 AM
> To: linux-integrity@vger.kernel.org
> Cc: zohar@linux.ibm.com; serge@hallyn.com; christian.brauner@ubuntu.com; containers@lists.linux.dev; dmitry.kasatkin@gmail.com; ebiederm@xmission.com; Krzysztof Struczynski <krzysztof.struczynski@huawei.com>; Roberto Sassu <roberto.sassu@huawei.com>; mpeters@redhat.com; lhinds@redhat.com; lsturman@redhat.com; puiterwi@redhat.com; jejb@linux.ibm.com; jamjoom@us.ibm.com; linux-kernel@vger.kernel.org; paul@paul-moore.com; rgb@redhat.com; linux-security-module@vger.kernel.org; jmorris@namei.org; Stefan Berger <stefanb@linux.ibm.com>; Denis Semakin <denis.semakin@huawei.com>
> Subject: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check corresponding capability
> 
> Use mac_admin_ns_capable() to check corresponding capability to allow read/write IMA policy without CAP_SYS_ADMIN but with CAP_MAC_ADMIN.
> 
> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/capability.h      | 6 ++++++
>  security/integrity/ima/ima_fs.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h index 65efb74c3585..991579178f32 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>  		ns_capable(ns, CAP_SYS_ADMIN);
>  }
>  
> +static inline bool mac_admin_ns_capable(struct user_namespace *ns) {
> +	return ns_capable(ns, CAP_MAC_ADMIN) ||
> +		ns_capable(ns, CAP_SYS_ADMIN);
> +}
> +
>  /* audit system wants to get cap info from files as well */  int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>  			   const struct dentry *dentry,
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c index 0e582ceecc7f..a749a3e79304 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -394,7 +394,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)  #else
>  		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>  			return -EACCES;
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!mac_admin_ns_capable(ns->user_ns))
>  			return -EPERM;
>  		return seq_open(filp, &ima_policy_seqops);  #endif
> --
> 2.31.1
