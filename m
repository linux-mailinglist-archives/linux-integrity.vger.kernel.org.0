Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3072F6AF1
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbhANTaE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 14:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbhANTaE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 14:30:04 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED5C061757
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jan 2021 11:29:23 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id q22so9906678eja.2
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jan 2021 11:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qq2aH+y0EILMZ/V0Gi3bdV3PAv+48DWJFv7xdmZhjgc=;
        b=y/5nukRm+oNUragIwq6lG7rl8pxbQgh0UV++xzU/zBKJxlYVTJ5CfSjT9yYLcM1z05
         dlgQaCh0ees3xDzH4AIgN2DemRT5TeGVaI27/FtJmX1xQHlngcQFtr1s9VJ0qlYPNVn0
         bZeRyG+gJsIYT584mbjyN16hynpmUmM8TrUWsFW3N4EDFuprzzZyw1uPOtBquCKdIBH6
         ZxQjaKJLvHeBi4NwI81wNBOU+plGtHvs5faTpQ1zUn3XuHZhXgjQijbmzEeDovEjxH7h
         AqJslAChpaA9cZekLp12iZJXsj4pj6QuN9UzjuRanazSIexbg/fD798cQ5Z33yZWfxKd
         te6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qq2aH+y0EILMZ/V0Gi3bdV3PAv+48DWJFv7xdmZhjgc=;
        b=mH7ukWOMEdQTLVa0tPGoC5dAET8NTZfNIbGL7h6vTYNyJkMaeOJcu56El/VqzWYR3l
         Nthsorbv0eSfp7iyqqIwyShZpIVvf00ePKwtmvtrfotGqyHr0HXB06FEeRSBtzMBoC6x
         GD96s9pnb911KgIm8TXqvFbnLcc8yY0SsPUJWR9IghL7KwqiAq7EVkXQX8jdzO6Mepmq
         wq2iUTAEm2LVuz87pAv9F4ZYvFYoeJ1WzqVfkpsg9i843I5ThPuwsaTwY5gD6h6bQzYy
         C2v7mcMgnSsY6F7CYBct5XtJE/ksCtjL/w/022dd7AxH0CqqxrSiJ2oe/RJxUktcfH/5
         3gvQ==
X-Gm-Message-State: AOAM533BZXwkGT/70SuBadZo3tnpd34YYe5T++fdj4PfOLKK3zrreAx1
        l7jjqRXa/H/jdP7fQrKlMTxZ8/PMgzEFbrjlQGhTbyGnwQ==
X-Google-Smtp-Source: ABdhPJxDc/UaA4f8UImz0e6lNsThTu6OP11c2qSlnbnd6zIksuO5zm94PRI1p8KUzlCjmJLpa4f0ULttsLXk50dxlnk=
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr6240578ejb.542.1610652562293;
 Thu, 14 Jan 2021 11:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20210114191522.4001-1-nramas@linux.microsoft.com>
In-Reply-To: <20210114191522.4001-1-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Jan 2021 14:29:09 -0500
Message-ID: <CAHC9VhQ5PEvZggtijta3EbWY5HEmfs6phmBWdQXk451yBRXQpA@mail.gmail.com>
Subject: Re: [PATCH] selinux: include a consumer of the new IMA critical data hook
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 2:15 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
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
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy |  3 +-
>  security/selinux/Makefile            |  2 +
>  security/selinux/ima.c               | 44 +++++++++++++++++++
>  security/selinux/include/ima.h       | 24 +++++++++++
>  security/selinux/include/security.h  |  3 +-
>  security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
>  6 files changed, 129 insertions(+), 11 deletions(-)
>  create mode 100644 security/selinux/ima.c
>  create mode 100644 security/selinux/include/ima.h

I think this has changed enough that keeping the "Acked-by" and
"Reviewed-by" tags is probably not a good choice.  I took a quick look
and this still looks okay from a SELinux perspective, I'll leave Mimi
to comment on it from a IMA perspective.

Unless Tyler has reviewed this version prior to your posting, it might
be a good idea to remove his "Reviewed-by" unless he has a chance to
look this over again before it is merged.

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
> index 000000000000..03715893ff97
> --- /dev/null
> +++ b/security/selinux/ima.c
> @@ -0,0 +1,44 @@
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
> +       void *policy = NULL;
> +       size_t policy_len;
> +       int rc = 0;
> +
> +       /*
> +        * Measure SELinux policy only after initialization is completed.
> +        */
> +       if (!selinux_initialized(state))
> +               return;
> +
> +       rc = security_read_state_kernel(state, &policy, &policy_len);
> +       if (rc) {
> +               pr_err("SELinux: %s: failed to read policy %d.\n", __func__, rc);
> +               return;
> +       }
> +
> +       ima_measure_critical_data("selinux", "selinux-policy-hash",
> +                                 policy, policy_len, true);
> +
> +       vfree(policy);
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
> 2.30.0
>


-- 
paul moore
www.paul-moore.com
