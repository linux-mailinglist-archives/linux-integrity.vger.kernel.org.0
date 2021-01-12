Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D142F35BA
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jan 2021 17:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406727AbhALQ2I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 11:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406715AbhALQ2I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 11:28:08 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4747EC0617A4
        for <linux-integrity@vger.kernel.org>; Tue, 12 Jan 2021 08:27:21 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f4so3273303ejx.7
        for <linux-integrity@vger.kernel.org>; Tue, 12 Jan 2021 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9XY+SrL1C8QH90qcJqPmDFWdeEzWfdgu1cbhdh73k4=;
        b=EQ/fT5KTR3MtbCTetUzVn/GWwkD8fDJdMXji5OfxzkRmMlIP58JNlysqqO5iAZ51ta
         M/v76BBkKQph3OPmuxOLrE56u6UcmQuufbKg0rIHzmYaU9LkndR/x9/rjLDCxLnTDHvK
         eWFzzz8GVOIFJCCUTh6eMeTaAf6iTx5mqsbkiei8l4Mf1PvTmgPWwwr/4xN1CFMzNgYv
         Gpk/8WU51A8ksp/8MoHqeJ9c6RmMMVzP1qIxXha4OxZngMLZoQX1Jo1fuC5SZdP5XS9m
         la+BdHJWU6mKMitROBWVmWqFRKu6fzu0I0CgeXEvwSlZKtn9X0vblx8adBoyLIah5xj9
         j+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9XY+SrL1C8QH90qcJqPmDFWdeEzWfdgu1cbhdh73k4=;
        b=D9WsRV15wynC5NYYR0aKe9V0oWTD4jrJxnffd4tgBNp+xkX1KZ8DK8C7CPuvaKrklx
         /U6T82AAmF8Kwm/BpSp6wTVShF+skOdUGxnOaFKQcE3xeZKGquywj/PNxXA1HQp/Vq3T
         nJda/eyHec7V+808fd7WjPumKXrPqyegOTNijDMmYPOolORD8zdfbVSQb/stdcLdnc7L
         ryY0URHR5R21/2Zlq2nJbXBXWyqoFdWfSvbP31Ra7NW4o/VbVAFNnO8XiFOkPxC89kxR
         ZQ0VipbvN/bKUpdF+2uhP9V1HQYx2xqrbzS8agfhNuNzArS0dMVj4oX5o6sHRvgOnd/o
         S2Eg==
X-Gm-Message-State: AOAM5335cB1fxbq6Oj7MKL4uNNLtS7TGtgoWEmGKp6IGpqC2WHJtLzLd
        VAwyAcjgIVJRPATSJL71NxRcRAI+5ePEsg8CbJuN
X-Google-Smtp-Source: ABdhPJzaWEEScvWK9P+Ko5jvJwHXBeyvblFzNT50Hx0stb2MQkmev4pVT/wKA4109kJJ3/oW0KUZbO6cXUICkrswLbM=
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr3920253ejc.178.1610468839776;
 Tue, 12 Jan 2021 08:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com> <20210108040708.8389-9-tusharsu@linux.microsoft.com>
In-Reply-To: <20210108040708.8389-9-tusharsu@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 11:27:08 -0500
Message-ID: <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 7, 2021 at 11:07 PM Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>
> SELinux stores the active policy in memory, so the changes to this data
> at runtime would have an impact on the security guarantees provided
> by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
> provides a secure way for the attestation service to remotely validate
> the policy contents at runtime.
>
> Measure the hash of the loaded policy by calling the IMA hook
> ima_measure_critical_data().  Since the size of the loaded policy
> can be large (several MB), measure the hash of the policy instead of
> the entire policy to avoid bloating the IMA log entry.
>
> To enable SELinux data measurement, the following steps are required:
>
> 1, Add "ima_policy=critical_data" to the kernel command line arguments
>    to enable measuring SELinux data at boot time.
> For example,
>   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
>
> 2, Add the following rule to /etc/ima/ima-policy
>    measure func=CRITICAL_DATA label=selinux
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
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy |  3 +-
>  security/selinux/Makefile            |  2 +
>  security/selinux/ima.c               | 64 ++++++++++++++++++++++++++++
>  security/selinux/include/ima.h       | 24 +++++++++++
>  security/selinux/include/security.h  |  3 +-
>  security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
>  6 files changed, 149 insertions(+), 11 deletions(-)
>  create mode 100644 security/selinux/ima.c
>  create mode 100644 security/selinux/include/ima.h

I remain concerned about the possibility of bypassing a measurement by
tampering with the time, but I appear to be the only one who is
worried about this so I'm not going to block this patch on those
grounds.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 54fe1c15ed50..8365596cb42b 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -52,8 +52,9 @@ Description:
>                         template:= name of a defined IMA template type
>                         (eg, ima-ng). Only valid when action is "measure".
>                         pcr:= decimal value
> -                       label:= [data_label]
> +                       label:= [selinux]|[data_label]
>                         data_label:= a unique string used for grouping and limiting critical data.
> +                       For example, "selinux" to measure critical data for SELinux.
>
>                   default policy:
>                         # PROC_SUPER_MAGIC
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index 4d8e0e8adf0b..776162444882 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -16,6 +16,8 @@ selinux-$(CONFIG_NETLABEL) += netlabel.o
>
>  selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
>
> +selinux-$(CONFIG_IMA) += ima.o
> +
>  ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
>
>  $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> new file mode 100644
> index 000000000000..0b835bdc3aa9
> --- /dev/null
> +++ b/security/selinux/ima.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Microsoft Corporation
> + *
> + * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
> + *
> + * Measure critical data structures maintainted by SELinux
> + * using IMA subsystem.
> + */
> +#include <linux/vmalloc.h>
> +#include <linux/ktime.h>
> +#include <linux/ima.h>
> +#include "security.h"
> +#include "ima.h"
> +
> +/*
> + * selinux_ima_measure_state - Measure hash of the SELinux policy
> + *
> + * @state: selinux state struct
> + *
> + * NOTE: This function must be called with policy_mutex held.
> + */
> +void selinux_ima_measure_state(struct selinux_state *state)
> +{
> +       struct timespec64 cur_time;
> +       void *policy = NULL;
> +       char *policy_event_name = NULL;
> +       size_t policy_len;
> +       int rc = 0;
> +
> +       /*
> +        * Measure SELinux policy only after initialization is completed.
> +        */
> +       if (!selinux_initialized(state))
> +               return;
> +
> +       /*
> +        * Pass a unique "event_name" to the IMA hook so that IMA subsystem
> +        * will always measure the given data.
> +        */
> +       ktime_get_real_ts64(&cur_time);
> +       policy_event_name = kasprintf(GFP_KERNEL, "%s-%lld:%09ld",
> +                                     "selinux-policy-hash",
> +                                     cur_time.tv_sec, cur_time.tv_nsec);
> +       if (!policy_event_name) {
> +               pr_err("SELinux: %s: event name for policy not allocated.\n",
> +                      __func__);
> +               goto out;
> +       }
> +
> +       rc = security_read_state_kernel(state, &policy, &policy_len);
> +       if (rc) {
> +               pr_err("SELinux: %s: failed to read policy %d.\n", __func__, rc);
> +               goto out;
> +       }
> +
> +       ima_measure_critical_data("selinux", policy_event_name,
> +                                 policy, policy_len, true);
> +
> +       vfree(policy);
> +
> +out:
> +       kfree(policy_event_name);
> +}
> diff --git a/security/selinux/include/ima.h b/security/selinux/include/ima.h
> new file mode 100644
> index 000000000000..d69c36611423
> --- /dev/null
> +++ b/security/selinux/include/ima.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2021 Microsoft Corporation
> + *
> + * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
> + *
> + * Measure critical data structures maintainted by SELinux
> + * using IMA subsystem.
> + */
> +
> +#ifndef _SELINUX_IMA_H_
> +#define _SELINUX_IMA_H_
> +
> +#include "security.h"
> +
> +#ifdef CONFIG_IMA
> +extern void selinux_ima_measure_state(struct selinux_state *selinux_state);
> +#else
> +static inline void selinux_ima_measure_state(struct selinux_state *selinux_state)
> +{
> +}
> +#endif
> +
> +#endif /* _SELINUX_IMA_H_ */
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 3cc8bab31ea8..29cae32d3fc5 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -229,7 +229,8 @@ void selinux_policy_cancel(struct selinux_state *state,
>                         struct selinux_policy *policy);
>  int security_read_policy(struct selinux_state *state,
>                          void **data, size_t *len);
> -
> +int security_read_state_kernel(struct selinux_state *state,
> +                              void **data, size_t *len);
>  int security_policycap_supported(struct selinux_state *state,
>                                  unsigned int req_cap);
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 9704c8a32303..cc8dbc4ed8db 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -65,6 +65,7 @@
>  #include "ebitmap.h"
>  #include "audit.h"
>  #include "policycap_names.h"
> +#include "ima.h"
>
>  /* Forward declaration. */
>  static int context_struct_to_string(struct policydb *policydb,
> @@ -2180,6 +2181,7 @@ static void selinux_notify_policy_change(struct selinux_state *state,
>         selinux_status_update_policyload(state, seqno);
>         selinux_netlbl_cache_invalidate();
>         selinux_xfrm_notify_policyload();
> +       selinux_ima_measure_state(state);
>  }
>
>  void selinux_policy_commit(struct selinux_state *state,
> @@ -3875,8 +3877,33 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>  }
>  #endif /* CONFIG_NETLABEL */
>
> +/**
> + * __security_read_policy - read the policy.
> + * @policy: SELinux policy
> + * @data: binary policy data
> + * @len: length of data in bytes
> + *
> + */
> +static int __security_read_policy(struct selinux_policy *policy,
> +                                 void *data, size_t *len)
> +{
> +       int rc;
> +       struct policy_file fp;
> +
> +       fp.data = data;
> +       fp.len = *len;
> +
> +       rc = policydb_write(&policy->policydb, &fp);
> +       if (rc)
> +               return rc;
> +
> +       *len = (unsigned long)fp.data - (unsigned long)data;
> +       return 0;
> +}
> +
>  /**
>   * security_read_policy - read the policy.
> + * @state: selinux_state
>   * @data: binary policy data
>   * @len: length of data in bytes
>   *
> @@ -3885,8 +3912,6 @@ int security_read_policy(struct selinux_state *state,
>                          void **data, size_t *len)
>  {
>         struct selinux_policy *policy;
> -       int rc;
> -       struct policy_file fp;
>
>         policy = rcu_dereference_protected(
>                         state->policy, lockdep_is_held(&state->policy_mutex));
> @@ -3898,14 +3923,35 @@ int security_read_policy(struct selinux_state *state,
>         if (!*data)
>                 return -ENOMEM;
>
> -       fp.data = *data;
> -       fp.len = *len;
> +       return __security_read_policy(policy, *data, len);
> +}
>
> -       rc = policydb_write(&policy->policydb, &fp);
> -       if (rc)
> -               return rc;
> +/**
> + * security_read_state_kernel - read the policy.
> + * @state: selinux_state
> + * @data: binary policy data
> + * @len: length of data in bytes
> + *
> + * Allocates kernel memory for reading SELinux policy.
> + * This function is for internal use only and should not
> + * be used for returning data to user space.
> + *
> + * This function must be called with policy_mutex held.
> + */
> +int security_read_state_kernel(struct selinux_state *state,
> +                              void **data, size_t *len)
> +{
> +       struct selinux_policy *policy;
>
> -       *len = (unsigned long)fp.data - (unsigned long)*data;
> -       return 0;
> +       policy = rcu_dereference_protected(
> +                       state->policy, lockdep_is_held(&state->policy_mutex));
> +       if (!policy)
> +               return -EINVAL;
> +
> +       *len = policy->policydb.len;
> +       *data = vmalloc(*len);
> +       if (!*data)
> +               return -ENOMEM;
>
> +       return __security_read_policy(policy, *data, len);
>  }
> --
> 2.17.1
>


-- 
paul moore
www.paul-moore.com
