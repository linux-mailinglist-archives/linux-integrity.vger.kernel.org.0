Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6CC32DA46
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Mar 2021 20:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhCDTVX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 14:21:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40276 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhCDTVJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 14:21:09 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 609E520B83EA;
        Thu,  4 Mar 2021 11:20:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 609E520B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614885628;
        bh=WE/MH9d3tOO+W5gxFbytmnbQMgefyJG0bPMyC3ufH9Q=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=p9bX9RtNIuF06hN//hknaNnwcs9bpUi1fLCCGT0YyuIJNL46CebL0Go6fyvhdwZHp
         P9vQgtLOyY7XoDMHReJ2An9MyCFf/p6Xmvyk9trbqtBbsZ1ktA6aryKmk1aXzLOfPC
         UAXI0zmXiEph8XRKHylJL+v+MRrGpSU80gWhGjUA=
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com
Cc:     tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210212163709.3139-1-nramas@linux.microsoft.com>
Message-ID: <87273030-2303-e791-4e5d-25373faf0880@linux.microsoft.com>
Date:   Thu, 4 Mar 2021 11:20:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210212163709.3139-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/12/21 8:37 AM, Lakshmi Ramasubramanian wrote:

Hi Paul,

> SELinux stores the configuration state and the policy capabilities
> in kernel memory.  Changes to this data at runtime would have an impact
> on the security guarantees provided by SELinux.  Measuring this data
> through IMA subsystem provides a tamper-resistant way for
> an attestation service to remotely validate it at runtime.
> 
> Measure the configuration state and policy capabilities by calling
> the IMA hook ima_measure_critical_data().
> 

I have addressed your comments on the v2 patch for selinux measurement 
using IMA. Could you please let me know if there are any other comments 
that I need to address in this patch?

Thanks for your review and help so far.

  -lakshmi

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> ---
>   security/selinux/ima.c         | 87 ++++++++++++++++++++++++++++++++--
>   security/selinux/include/ima.h |  6 +++
>   security/selinux/selinuxfs.c   |  6 +++
>   security/selinux/ss/services.c |  2 +-
>   4 files changed, 96 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index 03715893ff97..34d421861bfc 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -13,18 +13,83 @@
>   #include "ima.h"
>   
>   /*
> - * selinux_ima_measure_state - Measure hash of the SELinux policy
> + * selinux_ima_collect_state - Read selinux configuration settings
>    *
> - * @state: selinux state struct
> + * @state: selinux_state
>    *
> - * NOTE: This function must be called with policy_mutex held.
> + * On success returns the configuration settings string.
> + * On error, returns NULL.
>    */
> -void selinux_ima_measure_state(struct selinux_state *state)
> +static char *selinux_ima_collect_state(struct selinux_state *state)
>   {
> +	const char *on = "=1;", *off = "=0;";
> +	char *buf;
> +	int buf_len, len, i, rc;
> +
> +	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
> +
> +	len = strlen(on);
> +	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++)
> +		buf_len += strlen(selinux_policycap_names[i]) + len;
> +
> +	buf = kzalloc(buf_len, GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
> +
> +	rc = strscpy(buf, "initialized", buf_len);
> +	WARN_ON(rc < 0);
> +
> +	rc = strlcat(buf, selinux_initialized(state) ? on : off, buf_len);
> +	WARN_ON(rc >= buf_len);
> +
> +	rc = strlcat(buf, "enforcing", buf_len);
> +	WARN_ON(rc >= buf_len);
> +
> +	rc = strlcat(buf, enforcing_enabled(state) ? on : off, buf_len);
> +	WARN_ON(rc >= buf_len);
> +
> +	rc = strlcat(buf, "checkreqprot", buf_len);
> +	WARN_ON(rc >= buf_len);
> +
> +	rc = strlcat(buf, checkreqprot_get(state) ? on : off, buf_len);
> +	WARN_ON(rc >= buf_len);
> +
> +	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> +		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
> +		WARN_ON(rc >= buf_len);
> +
> +		rc = strlcat(buf, state->policycap[i] ? on : off, buf_len);
> +		WARN_ON(rc >= buf_len);
> +	}
> +
> +	return buf;
> +}
> +
> +/*
> + * selinux_ima_measure_state_locked - Measure SELinux state and hash of policy
> + *
> + * @state: selinux state struct
> + */
> +void selinux_ima_measure_state_locked(struct selinux_state *state)
> +{
> +	char *state_str = NULL;
>   	void *policy = NULL;
>   	size_t policy_len;
>   	int rc = 0;
>   
> +	WARN_ON(!mutex_is_locked(&state->policy_mutex));
> +
> +	state_str = selinux_ima_collect_state(state);
> +	if (!state_str) {
> +		pr_err("SELinux: %s: failed to read state.\n", __func__);
> +		return;
> +	}
> +
> +	ima_measure_critical_data("selinux", "selinux-state",
> +				  state_str, strlen(state_str), false);
> +
> +	kfree(state_str);
> +
>   	/*
>   	 * Measure SELinux policy only after initialization is completed.
>   	 */
> @@ -42,3 +107,17 @@ void selinux_ima_measure_state(struct selinux_state *state)
>   
>   	vfree(policy);
>   }
> +
> +/*
> + * selinux_ima_measure_state - Measure SELinux state and hash of policy
> + *
> + * @state: selinux state struct
> + */
> +void selinux_ima_measure_state(struct selinux_state *state)
> +{
> +	WARN_ON(mutex_is_locked(&state->policy_mutex));
> +
> +	mutex_lock(&state->policy_mutex);
> +	selinux_ima_measure_state_locked(state);
> +	mutex_unlock(&state->policy_mutex);
> +}
> diff --git a/security/selinux/include/ima.h b/security/selinux/include/ima.h
> index d69c36611423..75ca92b4a462 100644
> --- a/security/selinux/include/ima.h
> +++ b/security/selinux/include/ima.h
> @@ -15,10 +15,16 @@
>   
>   #ifdef CONFIG_IMA
>   extern void selinux_ima_measure_state(struct selinux_state *selinux_state);
> +extern void selinux_ima_measure_state_locked(
> +			struct selinux_state *selinux_state);
>   #else
>   static inline void selinux_ima_measure_state(struct selinux_state *selinux_state)
>   {
>   }
> +static inline void selinux_ima_measure_state_locked(
> +			struct selinux_state *selinux_state)
> +{
> +}
>   #endif
>   
>   #endif	/* _SELINUX_IMA_H_ */
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 4bde570d56a2..26ec58593ba1 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -41,6 +41,7 @@
>   #include "security.h"
>   #include "objsec.h"
>   #include "conditional.h"
> +#include "ima.h"
>   
>   enum sel_inos {
>   	SEL_ROOT_INO = 2,
> @@ -182,6 +183,8 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>   		selinux_status_update_setenforce(state, new_value);
>   		if (!new_value)
>   			call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
> +
> +		selinux_ima_measure_state(state);
>   	}
>   	length = count;
>   out:
> @@ -762,6 +765,9 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>   
>   	checkreqprot_set(fsi->state, (new_value ? 1 : 0));
>   	length = count;
> +
> +	selinux_ima_measure_state(fsi->state);
> +
>   out:
>   	kfree(page);
>   	return length;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 2106b5d383e7..cb2866489363 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2179,7 +2179,7 @@ static void selinux_notify_policy_change(struct selinux_state *state,
>   	selinux_status_update_policyload(state, seqno);
>   	selinux_netlbl_cache_invalidate();
>   	selinux_xfrm_notify_policyload();
> -	selinux_ima_measure_state(state);
> +	selinux_ima_measure_state_locked(state);
>   }
>   
>   void selinux_policy_commit(struct selinux_state *state,
> 

