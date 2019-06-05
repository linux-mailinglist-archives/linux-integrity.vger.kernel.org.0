Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D877736472
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 21:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFETQF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 15:16:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42087 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFETQF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 15:16:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so13062234lje.9
        for <linux-integrity@vger.kernel.org>; Wed, 05 Jun 2019 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5gCap6cvNBSPEAIzOt2bO96t9rWvciwXUye4o9D03k=;
        b=IBsNr2pTPqpb15MKtmctTQEybXfKnOz88q6JcU58yYUvkTOG+is2ABSdCvR7ujkp5J
         wlmadsutiiN/Fmga8NNLbJKg1nW+nGpbMmd50TeynYuxiWmPXhXOlDYFl2UTqn5apmiM
         qSrya/tTKrHp7KQk7l58NGUIGy7kYEinvqrBbZzHW+AP82XxgbrHIMzmWp230gMMh+4y
         zJ17eBxXDjHMWygjFMilb3Ep3Uxzh5NPYvDG3W5UAdjtqUtVQ3+c63RU59rXL8R464C2
         jpTlVk24vzq7PfFfHh2qmHxQTRkRP6iW0VomraSXVEky0rzSDxXb8Rbf8gam/jn3ZjKF
         amZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5gCap6cvNBSPEAIzOt2bO96t9rWvciwXUye4o9D03k=;
        b=XdFz3N5iXF+6Ebd6z3zy9UxuzIhhgKJKo2YRWM5KRXnmt65RwbkxeYHPt/pDz3AP9K
         zAjMu7xiL2qi5pcv4rX27NogvWiRPwUKzPbsqPSzDcWGsSPtPk/LtUOnj4cJWc3EJrNN
         HbjhHcK30cwGpy0fsrMUh9O8jxzXg9RF5zXK3rba1QfvtoaxgknjtLm5kcWrgj9Ot/dG
         rtlsJ8nYJvsQuOPfK5Vk7Av6ArxyrrJVI5PJha+byWJtTqzKj9LDCMsobwvOLPLo26DN
         MckYVMnXdKjhQBPqfI+gAb4NQX75m1ElXvMDJzZF9lciuaU1u94goMid3/jTRd0GhjHB
         mvnw==
X-Gm-Message-State: APjAAAXGK9SOMz6yhzpuEyh/r/MwZWBN28n4zYjsJjltjfuxfEtsQ6sT
        IFQqgOvk3yttieYqrLNDLf2GfLr2ipWNaQz1PZn1
X-Google-Smtp-Source: APXvYqzY1c1xTWbVXcNXwoQb7xOiIrytND3ntvsa8td3QEp+gtia/TrlfuuXCIMmWEwLIn8jd+PjocUAjuw+SWHXlZc=
X-Received: by 2002:a2e:3e14:: with SMTP id l20mr22411482lja.40.1559762162428;
 Wed, 05 Jun 2019 12:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
In-Reply-To: <20190605083606.4209-1-janne.karhunen@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Jun 2019 15:15:51 -0400
Message-ID: <CAHC9VhT6ws9WaodE2n+-LPmyZXVs=2qZSUDccUDyb_1Lc2MMjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 5, 2019 at 4:36 AM Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> Atomic policy updaters are not very useful as they cannot
> usually perform the policy updates on their own. Since it
> seems that there is no strict need for the atomicity,
> switch to the blocking variant. While doing so, rename
> the functions accordingly.
>
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> ---
>  drivers/infiniband/core/device.c |  6 +++---
>  include/linux/security.h         |  6 +++---
>  security/security.c              | 23 +++++++++++++----------
>  security/selinux/hooks.c         |  2 +-
>  security/selinux/selinuxfs.c     |  2 +-
>  5 files changed, 21 insertions(+), 18 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 78dc07c6ac4b..61c0c93a2e73 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2499,7 +2499,7 @@ static int __init ib_core_init(void)
>                 goto err_mad;
>         }
>
> -       ret = register_lsm_notifier(&ibdev_lsm_nb);
> +       ret = register_blocking_lsm_notifier(&ibdev_lsm_nb);
>         if (ret) {
>                 pr_warn("Couldn't register LSM notifier. ret %d\n", ret);
>                 goto err_sa;
> @@ -2518,7 +2518,7 @@ static int __init ib_core_init(void)
>         return 0;
>
>  err_compat:
> -       unregister_lsm_notifier(&ibdev_lsm_nb);
> +       unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
>  err_sa:
>         ib_sa_cleanup();
>  err_mad:
> @@ -2544,7 +2544,7 @@ static void __exit ib_core_cleanup(void)
>         nldev_exit();
>         rdma_nl_unregister(RDMA_NL_LS);
>         unregister_pernet_device(&rdma_dev_net_ops);
> -       unregister_lsm_notifier(&ibdev_lsm_nb);
> +       unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
>         ib_sa_cleanup();
>         ib_mad_cleanup();
>         addr_cleanup();
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 659071c2e57c..fc655fbe44ad 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -189,9 +189,9 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
>
>  #ifdef CONFIG_SECURITY
>
> -int call_lsm_notifier(enum lsm_event event, void *data);
> -int register_lsm_notifier(struct notifier_block *nb);
> -int unregister_lsm_notifier(struct notifier_block *nb);
> +int call_blocking_lsm_notifier(enum lsm_event event, void *data);
> +int register_blocking_lsm_notifier(struct notifier_block *nb);
> +int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>
>  /* prototypes */
>  extern int security_init(void);
> diff --git a/security/security.c b/security/security.c
> index c01a88f65ad8..6bfc7636ddb7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -39,7 +39,7 @@
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> -static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> +static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>
>  static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
> @@ -430,23 +430,26 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>                 panic("%s - Cannot get early memory.\n", __func__);
>  }
>
> -int call_lsm_notifier(enum lsm_event event, void *data)
> +int call_blocking_lsm_notifier(enum lsm_event event, void *data)
>  {
> -       return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
> +       return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
> +                                           event, data);
>  }
> -EXPORT_SYMBOL(call_lsm_notifier);
> +EXPORT_SYMBOL(call_blocking_lsm_notifier);
>
> -int register_lsm_notifier(struct notifier_block *nb)
> +int register_blocking_lsm_notifier(struct notifier_block *nb)
>  {
> -       return atomic_notifier_chain_register(&lsm_notifier_chain, nb);
> +       return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
> +                                               nb);
>  }
> -EXPORT_SYMBOL(register_lsm_notifier);
> +EXPORT_SYMBOL(register_blocking_lsm_notifier);
>
> -int unregister_lsm_notifier(struct notifier_block *nb)
> +int unregister_blocking_lsm_notifier(struct notifier_block *nb)
>  {
> -       return atomic_notifier_chain_unregister(&lsm_notifier_chain, nb);
> +       return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
> +                                                 nb);
>  }
> -EXPORT_SYMBOL(unregister_lsm_notifier);
> +EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
>
>  /**
>   * lsm_cred_alloc - allocate a composite cred blob
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c61787b15f27..c1e37018c8eb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -197,7 +197,7 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
>  {
>         if (event == AVC_CALLBACK_RESET) {
>                 sel_ib_pkey_flush();
> -               call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
> +               call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
>         }
>
>         return 0;
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 145ee62f205a..1e2e3e4b5fdb 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -180,7 +180,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>                 selnl_notify_setenforce(new_value);
>                 selinux_status_update_setenforce(state, new_value);
>                 if (!new_value)
> -                       call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
> +                       call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
>         }
>         length = count;
>  out:
> --
> 2.17.1
>

-- 
paul moore
www.paul-moore.com
