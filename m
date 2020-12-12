Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5703F2D8370
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 01:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgLLAdF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 19:33:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59158 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407321AbgLLAc7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 19:32:59 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id ED6B620B7187;
        Fri, 11 Dec 2020 16:32:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED6B620B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607733138;
        bh=IxyofULMIwKRiSil7XNF3s6H7NOefNAaufmv/Xws5tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evSx/T/FD+zPGKk6Ni88SIASdF11MzdBzZVBv/pPF4VG9+hfaG4KZb2a1roL44JuX
         8jwlItXgd+a3WoubA20nzi47Bt1pAOu511uFxcmDFsz0gkRpygUNFpUw3wd5i/fiIP
         pDLDue3PJfW+lxShmJ9kX9Q2pGE/iagx2CPRHwkM=
Date:   Fri, 11 Dec 2020 18:32:15 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v8 8/8] selinux: include a consumer of the new IMA
 critical data hook
Message-ID: <20201212003215.GG4951@sequoia>
References: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
 <20201211235807.30815-9-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211235807.30815-9-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-12-11 15:58:07, Tushar Sugandhi wrote:
> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> SELinux stores the active policy in memory, so the changes to this data
> at runtime would have an impact on the security guarantees provided
> by SELinux. Measuring in-memory SELinux policy through IMA subsystem
> provides a secure way for the attestation service to remotely validate
> the policy contents at runtime.
> 
> Measure the hash of the loaded policy by calling the IMA hook
> ima_measure_critical_data(). Since the size of the loaded policy can
> be large (several MB), measure the hash of the policy instead of
> the entire policy to avoid bloating the IMA log entry.
> 
> Add "selinux" to the list of supported data sources maintained by IMA
> to enable measuring SELinux data.
> 
> To enable SELinux data measurement, the following steps are required:
> 
> 1, Add "ima_policy=critical_data" to the kernel command line arguments
>    to enable measuring SELinux data at boot time.
> For example,
>   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
> 
> 2, Add the following rule to /etc/ima/ima-policy
>    measure func=CRITICAL_DATA data_source=selinux
> 
> Sample measurement of the hash of SELinux policy:
> 
> To verify the measured data with the current SELinux policy run
> the following commands and verify the output hash values match.
> 
>   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> 
>   grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
> 
> Note that the actual verification of SELinux policy would require loading
> the expected policy into an identical kernel on a pristine/known-safe
> system and run the sha256sum /sys/kernel/selinux/policy there to get
> the expected hash.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This looks good but I've got one small suggestion below if you roll a
v9. Feel free to add:

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> new file mode 100644
> index 000000000000..a070d8dae403
> --- /dev/null
> +++ b/security/selinux/measure.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Measure SELinux state using IMA subsystem.
> + */
> +#include <linux/vmalloc.h>
> +#include <linux/ktime.h>
> +#include <linux/ima.h>
> +#include "security.h"
> +
> +/*
> + * This function creates a unique name by appending the timestamp to
> + * the given string. This string is passed as "event_name" to the IMA
> + * hook to measure the given SELinux data.
> + *
> + * The data provided by SELinux to the IMA subsystem for measuring may have
> + * already been measured (for instance the same state existed earlier).
> + * But for SELinux the current data represents a state change and hence
> + * needs to be measured again. To enable this, pass a unique "event_name"
> + * to the IMA hook so that IMA subsystem will always measure the given data.
> + *
> + * For example,
> + * At time T0 SELinux data to be measured is "foo". IMA measures it.
> + * At time T1 the data is changed to "bar". IMA measures it.
> + * At time T2 the data is changed to "foo" again. IMA will not measure it
> + * (since it was already measured) unless the event_name, for instance,
> + * is different in this call.
> + */
> +static char *selinux_event_name(const char *name_prefix)
> +{
> +	char *event_name = NULL;
> +	struct timespec64 cur_time;
> +
> +	ktime_get_real_ts64(&cur_time);
> +	event_name = kasprintf(GFP_KERNEL, "%s-%lld:%09ld", name_prefix,
> +			       cur_time.tv_sec, cur_time.tv_nsec);
> +	return event_name;

There's no longer a need to store the return of kasprintf() in a
variable. Just 'return kasprint(...);' and get rid of the event_name
variable.

Tyler
