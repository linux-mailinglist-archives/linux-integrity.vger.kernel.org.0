Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F006BD81E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Mar 2023 19:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjCPSZj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Mar 2023 14:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCPSZh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Mar 2023 14:25:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4213B857;
        Thu, 16 Mar 2023 11:25:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ix20so2727587plb.3;
        Thu, 16 Mar 2023 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678991135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL5zaI1dmdmkqbj+v3hTo4gZP5FUUEqQBzD5eDr0c7Y=;
        b=nwWAViIJ2NwX+4bd9YDQ+rhdKBTmqshzW98fiCNPuu3Jev4KAz/F2MBtHL5nwSt46c
         hFcS8eL867tR2avWoa+KNcwBZ7og1LyMQJihQTlmuj1Iyda9aaGESPVGI5889TR5pfMn
         bf0MyiOYp21vTN/MK8dWfJe+kuBVrUKWxukCZyBvBAskpitYvpubgNd0R4yxjj3uBiqC
         hmTU49EZ0xe5/aRJ8V1pEMXZRRvrcX/YmuHnOA0Y4yiS/9aS0yXpZFVnFHS+QNd4LM8E
         3ZrfuhK7KuU/BBiKyl1jpKKhAhQ/9Jn/Zc1CldajwfotPmAAa1JaGJhU/JBoVWok41tZ
         vBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL5zaI1dmdmkqbj+v3hTo4gZP5FUUEqQBzD5eDr0c7Y=;
        b=uqgXVliumxLFj9Y4+FqTbpsJb0VtFX1cKI5Z6ENeWOMim2sZLC7xg/OWE3C3z5EAhA
         NLQwg2QAi6xk+H2KiT3U+agEpFhFwTY4M9BDkaq3P8aSTa5jMFEhvIrsaWn5RM9NNSx2
         VwxO6eMDgsz89LziDnmiv9eu9sUPrDM3exNkxHvUxKNAJrzzjjdu19Sln5BArN1bnwmj
         kBG91vbmucIFBspzefoHyXSL/7IYxiIE4kTQ2EzYtUpXrLBGauaLbI+PO/Kuu7gey+pU
         tPFO9eO5wuH6ppBCtlBPlCNV3SuMxbLt61uQp4JTBhgdKup1aBprclN906mFrzhxBlG5
         pFew==
X-Gm-Message-State: AO0yUKXgzm6IoCAQGiWHStvfJG9xoBqR+0gj4y3y7VO3kwuWU+re8n+l
        uhi3d1u7wy7mLUkDsiG4DDjlD9slE1ozdN+Racw=
X-Google-Smtp-Source: AK7set+FMx6p2HK7HTpie3oKAnwtOlZofjNqE1f8kMjS/2TINozJNjM4S04218HZiLAbCfiK2UvfW+1Vp22JKbxa8bk=
X-Received: by 2002:a17:90b:1952:b0:237:1fe0:b151 with SMTP id
 nk18-20020a17090b195200b002371fe0b151mr1395345pjb.8.1678991134894; Thu, 16
 Mar 2023 11:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230316175749.233373-1-paul@paul-moore.com>
In-Reply-To: <20230316175749.233373-1-paul@paul-moore.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 16 Mar 2023 14:25:23 -0400
Message-ID: <CAEjxPJ4v3KWoBidGpbrU9ibiQeuwUh34uEZg3E8tc7vPJ9dH0w@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the 'checkreqprot' functionality
To:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     selinux@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 16, 2023 at 2:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> We originally promised that the SELinux 'checkreqprot' functionality
> would be removed no sooner than June 2021, and now that it is March
> 2023 it seems like it is a good time to do the final removal.  The
> deprecation notice in the kernel provides plenty of detail on why
> 'checkreqprot' is not desirable, with the key point repeated below:
>
>   This was a compatibility mechanism for legacy userspace and
>   for the READ_IMPLIES_EXEC personality flag.  However, if set to
>   1, it weakens security by allowing mappings to be made executable
>   without authorization by policy.  The default value of checkreqprot
>   at boot was changed starting in Linux v4.4 to 0 (i.e. check the
>   actual protection), and Android and Linux distributions have been
>   explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
>   initialization for some time.
>
> Along with the official deprecation notice, we have been discussing
> this on-list and directly with several of the larger SELinux-based
> distros and everyone is happy to see this feature finally removed.
> In an attempt to catch all of the smaller, and DIY, Linux systems
> we have been writing a deprecation notice URL into the kernel log,
> along with a growing ssleep() penalty, when admins enabled
> checkreqprot at runtime or via the kernel command line.  We have
> yet to have anyone come to us and raise an objection to the
> deprecation or planned removal.
>
> It is worth noting that while this patch removes the checkreqprot
> functionality, it leaves the user visible interfaces (kernel command
> line and selinuxfs file) intact, just inert.  This should help
> prevent breakages with existing userspace tools that correctly, but
> unnecessarily, disable checkreqprot at boot or runtime.  Admins
> that attempt to enable checkreqprot will be met with a removal
> message in the kernel log.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I was wondering if we could remove the reqprot parameter altogether from th=
e
mmap/mprotect hooks but looks like IMA is using it.

> ---
>  .../sysfs-selinux-checkreqprot                |  3 +++
>  security/selinux/Kconfig                      | 23 -------------------
>  security/selinux/hooks.c                      | 20 ++++------------
>  security/selinux/include/security.h           |  9 ++++----
>  security/selinux/selinuxfs.c                  | 13 ++++-------
>  5 files changed, 17 insertions(+), 51 deletions(-)
>  rename Documentation/ABI/{obsolete =3D> removed}/sysfs-selinux-checkreqp=
rot (90%)
>
> diff --git a/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot b/Docu=
mentation/ABI/removed/sysfs-selinux-checkreqprot
> similarity index 90%
> rename from Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
> rename to Documentation/ABI/removed/sysfs-selinux-checkreqprot
> index ed6b52ca210f..f599a0a87e8b 100644
> --- a/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
> +++ b/Documentation/ABI/removed/sysfs-selinux-checkreqprot
> @@ -4,6 +4,9 @@ KernelVersion:  2.6.12-rc2 (predates git)
>  Contact:       selinux@vger.kernel.org
>  Description:
>
> +       REMOVAL UPDATE: The SELinux checkreqprot functionality was remove=
d in
> +       March 2023, the original deprecation notice is shown below.
> +
>         The selinuxfs "checkreqprot" node allows SELinux to be configured
>         to check the protection requested by userspace for mmap/mprotect
>         calls instead of the actual protection applied by the kernel.
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 9e921fc72538..4ea946123255 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -70,29 +70,6 @@ config SECURITY_SELINUX_AVC_STATS
>           /sys/fs/selinux/avc/cache_stats, which may be monitored via
>           tools such as avcstat.
>
> -config SECURITY_SELINUX_CHECKREQPROT_VALUE
> -       int "NSA SELinux checkreqprot default value"
> -       depends on SECURITY_SELINUX
> -       range 0 1
> -       default 0
> -       help
> -         This option sets the default value for the 'checkreqprot' flag
> -         that determines whether SELinux checks the protection requested
> -         by the application or the protection that will be applied by th=
e
> -         kernel (including any implied execute for read-implies-exec) fo=
r
> -         mmap and mprotect calls.  If this option is set to 0 (zero),
> -         SELinux will default to checking the protection that will be ap=
plied
> -         by the kernel.  If this option is set to 1 (one), SELinux will
> -         default to checking the protection requested by the application=
.
> -         The checkreqprot flag may be changed from the default via the
> -         'checkreqprot=3D' boot parameter.  It may also be changed at ru=
ntime
> -         via /sys/fs/selinux/checkreqprot if authorized by policy.
> -
> -         WARNING: this option is deprecated and will be removed in a fut=
ure
> -         kernel release.
> -
> -         If you are unsure how to answer this question, answer 0.
> -
>  config SECURITY_SELINUX_SIDTAB_HASH_BITS
>         int "NSA SELinux sidtab hashtable size"
>         depends on SECURITY_SELINUX
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index db6d8b68b543..9a58971f9a16 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -136,17 +136,13 @@ static int __init selinux_enabled_setup(char *str)
>  __setup("selinux=3D", selinux_enabled_setup);
>  #endif
>
> -static unsigned int selinux_checkreqprot_boot =3D
> -       CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
> -
>  static int __init checkreqprot_setup(char *str)
>  {
>         unsigned long checkreqprot;
>
>         if (!kstrtoul(str, 0, &checkreqprot)) {
> -               selinux_checkreqprot_boot =3D checkreqprot ? 1 : 0;
>                 if (checkreqprot)
> -                       pr_err("SELinux: checkreqprot set to 1 via kernel=
 parameter.  This is deprecated and will be rejected in a future kernel rel=
ease.\n");
> +                       pr_err("SELinux: checkreqprot set to 1 via kernel=
 parameter.  This is no longer supported.\n");
>         }
>         return 1;
>  }
> @@ -3712,7 +3708,8 @@ static int selinux_mmap_addr(unsigned long addr)
>         return rc;
>  }
>
> -static int selinux_mmap_file(struct file *file, unsigned long reqprot,
> +static int selinux_mmap_file(struct file *file,
> +                            unsigned long reqprot __always_unused,
>                              unsigned long prot, unsigned long flags)
>  {
>         struct common_audit_data ad;
> @@ -3727,23 +3724,17 @@ static int selinux_mmap_file(struct file *file, u=
nsigned long reqprot,
>                         return rc;
>         }
>
> -       if (checkreqprot_get())
> -               prot =3D reqprot;
> -
>         return file_map_prot_check(file, prot,
>                                    (flags & MAP_TYPE) =3D=3D MAP_SHARED);
>  }
>
>  static int selinux_file_mprotect(struct vm_area_struct *vma,
> -                                unsigned long reqprot,
> +                                unsigned long reqprot __always_unused,
>                                  unsigned long prot)
>  {
>         const struct cred *cred =3D current_cred();
>         u32 sid =3D cred_sid(cred);
>
> -       if (checkreqprot_get())
> -               prot =3D reqprot;
> -
>         if (default_noexec &&
>             (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
>                 int rc =3D 0;
> @@ -7202,9 +7193,6 @@ static __init int selinux_init(void)
>
>         memset(&selinux_state, 0, sizeof(selinux_state));
>         enforcing_set(selinux_enforcing_boot);
> -       if (CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE)
> -               pr_err("SELinux: CONFIG_SECURITY_SELINUX_CHECKREQPROT_VAL=
UE is non-zero.  This is deprecated and will be rejected in a future kernel=
 release.\n");
> -       checkreqprot_set(selinux_checkreqprot_boot);
>         selinux_avc_init();
>         mutex_init(&selinux_state.status_lock);
>         mutex_init(&selinux_state.policy_mutex);
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index cb38d1894cfc..7e9511841134 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -95,7 +95,6 @@ struct selinux_state {
>  #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>         bool enforcing;
>  #endif
> -       bool checkreqprot;
>         bool initialized;
>         bool policycap[__POLICYDB_CAP_MAX];
>
> @@ -145,14 +144,16 @@ static inline void enforcing_set(bool value)
>
>  static inline bool checkreqprot_get(void)
>  {
> -       return READ_ONCE(selinux_state.checkreqprot);
> +       /* setting checkreqprot to a non-zero value is no longer supporte=
d */
> +       return 0;
>  }
>
>  static inline void checkreqprot_set(bool value)
>  {
> -       if (value)
> +       if (value) {
>                 pr_err("SELinux: https://github.com/SELinuxProject/selinu=
x-kernel/wiki/DEPRECATE-checkreqprot\n");
> -       WRITE_ONCE(selinux_state.checkreqprot, value);
> +               pr_err("SELinux: setting checkreqprot to '1' is no longer=
 supported\n");
> +       }
>  }
>
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 08164d074e56..68688bc84912 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -728,23 +728,20 @@ static ssize_t sel_write_checkreqprot(struct file *=
file, const char __user *buf,
>         if (IS_ERR(page))
>                 return PTR_ERR(page);
>
> -       length =3D -EINVAL;
> -       if (sscanf(page, "%u", &new_value) !=3D 1)
> +       if (sscanf(page, "%u", &new_value) !=3D 1) {
> +               length =3D -EINVAL;
>                 goto out;
> +       }
> +       length =3D count;
>
>         if (new_value) {
>                 char comm[sizeof(current->comm)];
>
>                 memcpy(comm, current->comm, sizeof(comm));
> -               pr_err("SELinux: %s (%d) set checkreqprot to 1. This is d=
eprecated and will be rejected in a future kernel release.\n",
> +               pr_err("SELinux: %s (%d) set checkreqprot to 1. This is n=
o longer supported.\n",
>                        comm, current->pid);
>         }
>
> -       checkreqprot_set((new_value ? 1 : 0));
> -       if (new_value)
> -               ssleep(15);
> -       length =3D count;
> -
>         selinux_ima_measure_state();
>
>  out:
> --
> 2.40.0
>
