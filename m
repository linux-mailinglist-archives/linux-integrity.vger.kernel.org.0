Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16172214F4
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 21:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGOTRE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 15:17:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44234 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGOTQq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 15:16:46 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 57B7F20B4908;
        Wed, 15 Jul 2020 12:16:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57B7F20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594840580;
        bh=UWGs7/duiBxGsOajSPhznATeEZNTIvIT7z0CfurjKPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtQ4ANyqaj6Uj0YRg8qc9b5pYtQCaff87NoEQAxW5c0zBREGYQuchjVgHQdDCj8oM
         /GvJb8FSUQuvO/e1TwLqtK8//i2IhlFHexBR2+P58o2riBIsAF4Gvi6F/j2S118bl7
         +6zBiYPodt/qIGlByb78XSsNS1/Ui3BltYWOBlnY=
Date:   Wed, 15 Jul 2020 14:16:17 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     deven.desai@linux.microsoft.com
Cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com,
        pasha.tatashin@soleen.com, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [RFC PATCH v3 03/12] security: add ipe lsm policy parser and
 policy loading
Message-ID: <20200715191617.GD3673@sequoia>
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
 <20200415162550.2324-4-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415162550.2324-4-deven.desai@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-04-15 09:25:41, deven.desai@linux.microsoft.com wrote:
> From: Deven Bowers <deven.desai@linux.microsoft.com>
> 
> Adds the policy parser and the policy loading to IPE, along with the
> related sysfs, securityfs entries, and audit events.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> ---

...

> diff --git a/security/ipe/ipe-sysfs.c b/security/ipe/ipe-sysfs.c
> index 1c65185c531d..a250da29c3b5 100644
> --- a/security/ipe/ipe-sysfs.c
> +++ b/security/ipe/ipe-sysfs.c
> @@ -5,6 +5,7 @@
>  
>  #include "ipe.h"
>  #include "ipe-audit.h"
> +#include "ipe-secfs.h"
>  
>  #include <linux/sysctl.h>
>  #include <linux/fs.h>
> @@ -45,6 +46,79 @@ static int ipe_switch_mode(struct ctl_table *table, int write,
>  
>  #endif /* CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH */
>  
> +#ifdef CONFIG_SECURITYFS
> +
> +/**
> + * ipe_switch_active_policy: Handler to switch the policy IPE is enforcing.
> + * @table: Sysctl table entry from the variable, sysctl_table.
> + * @write: Integer indicating whether this is a write or a read.
> + * @buffer: Data passed to sysctl. This is the policy id to activate,
> + *	    for this function.
> + * @lenp: Pointer to the size of @buffer.
> + * @ppos: Offset into @buffer.
> + *
> + * This wraps proc_dointvec_minmax, and if there's a change, emits an
> + * audit event.
> + *
> + * Return:
> + * 0 - OK
> + * -ENOMEM - Out of memory
> + * -ENOENT - Policy identified by @id does not exist
> + * Other - See proc_dostring and retrieve_backed_dentry
> + */
> +static int ipe_switch_active_policy(struct ctl_table *table, int write,
> +				    void __user *buffer, size_t *lenp,
> +				    loff_t *ppos)
> +{
> +	int rc = 0;
> +	char *id = NULL;
> +	size_t size = 0;
> +
> +	if (write) {

I see that the policy files in securityfs, such as new_policy, are
checking for CAP_MAC_ADMIN but there's no check here for CAP_MAC_ADMIN
when switching the active policy. I think we should enforce that cap
here, too.

Thinking about it some more, I find it a little odd that we're spreading
the files necessary to update a policy across both procfs (sysctl) and
securityfs. It looks like procfs will have different semantics than
securityfs after looking at proc_sys_permission(). I suggest moving
strict_parse and active_policy under securityfs for a unified experience
and common location when updating policy.

Tyler

> +		id = kzalloc((*lenp) + 1, GFP_KERNEL);
> +		if (!id)
> +			return -ENOMEM;
> +
> +		table->data = id;
> +		table->maxlen = (*lenp) + 1;
> +
> +		rc = proc_dostring(table, write, buffer, lenp, ppos);
> +		if (rc != 0)
> +			goto out;
> +
> +		rc = ipe_set_active_policy(id, strlen(id));
> +	} else {
> +		if (!rcu_access_pointer(ipe_active_policy)) {
> +			table->data = "";
> +			table->maxlen = 1;
> +			return proc_dostring(table, write, buffer, lenp, ppos);
> +		}
> +
> +		rcu_read_lock();
> +		size = strlen(rcu_dereference(ipe_active_policy)->policy_name);
> +		rcu_read_unlock();
> +
> +		id = kzalloc(size + 1, GFP_KERNEL);
> +		if (!id)
> +			return -ENOMEM;
> +
> +		rcu_read_lock();
> +		strncpy(id, rcu_dereference(ipe_active_policy)->policy_name,
> +			size);
> +		rcu_read_unlock();
> +
> +		table->data = id;
> +		table->maxlen = size;
> +
> +		rc = proc_dostring(table, write, buffer, lenp, ppos);
> +	}
> +out:
> +	kfree(id);
> +	return rc;
> +}
> +
> +#endif /* CONFIG_SECURITYFS */
> +
>  static struct ctl_table_header *sysctl_header;
>  
>  static const struct ctl_path sysctl_path[] = {
> @@ -75,6 +149,24 @@ static struct ctl_table sysctl_table[] = {
>  		.extra1 = SYSCTL_ZERO,
>  		.extra2 = SYSCTL_ONE,
>  	},
> +#ifdef CONFIG_SECURITYFS
> +	{
> +		.procname = "strict_parse",
> +		.data = &ipe_strict_parse,
> +		.maxlen = sizeof(int),
> +		.mode = 0644,
> +		.proc_handler = proc_dointvec_minmax,
> +		.extra1 = SYSCTL_ZERO,
> +		.extra2 = SYSCTL_ONE,
> +	},
> +	{
> +		.procname = "active_policy",
> +		.data = NULL,
> +		.maxlen = 0,
> +		.mode = 0644,
> +		.proc_handler = ipe_switch_active_policy,
> +	},
> +#endif /* CONFIG_SECURITYFS */
>  	{}
>  };
>  
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index b6553e370f98..07f855ffb79a 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -6,6 +6,7 @@
>  #include "ipe.h"
>  #include "ipe-policy.h"
>  #include "ipe-hooks.h"
> +#include "ipe-secfs.h"
>  #include "ipe-sysfs.h"
>  
>  #include <linux/module.h>
> @@ -60,3 +61,4 @@ DEFINE_LSM(ipe) = {
>  
>  int ipe_enforce = 1;
>  int ipe_success_audit;
> +int ipe_strict_parse;
> diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
> index 6a47f55b05d9..bf6cf7744b0e 100644
> --- a/security/ipe/ipe.h
> +++ b/security/ipe/ipe.h
> @@ -16,5 +16,6 @@
>  
>  extern int ipe_enforce;
>  extern int ipe_success_audit;
> +extern int ipe_strict_parse;
>  
>  #endif /* IPE_H */
> -- 
> 2.26.0
