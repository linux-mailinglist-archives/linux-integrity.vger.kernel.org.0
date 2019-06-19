Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE34C01B
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2019 19:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfFSRqr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 13:46:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35256 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSRqr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 13:46:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so20203531otq.2;
        Wed, 19 Jun 2019 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZevpDDlCAGLTfjr+h0ZLFMxekqlpPh9j8cV6hobNH4=;
        b=N6ABCsSck+i6soE736QGPnpvFL3Ru1HyAmA3jqvUbZmQx62A/ErE0+apKJqxwfQLAm
         9jvUXbGMu7grIMvuq604dAAg5Kt4mA9Og+b4e1j0pQ/I9lrLwBoPHA0vG3UDyshK8I5y
         +/RciXPu46OfUXcP7QTeH8XrAyGMrXth6Ja24B6DdNIr1D1YRAGUJPF0boIjn0VYu4F6
         BWsnjPpQAKfz2ma/k72NDfxGHGtBqu5jjyWV9mneY/rYqIQTqvmkVckUlxz8SB5gr7j5
         5cI1j6viwdA+g/hmc0LVY7C3Nd/6D554ZpfW20DaDRNaH6XyWmdj2aNmcSVvMvdWhFA7
         VV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZevpDDlCAGLTfjr+h0ZLFMxekqlpPh9j8cV6hobNH4=;
        b=j2RYyUIlJBV6Sl/2dLcGQyZ0WY2gxHqcWodCqfzi8nMA1iVIAfFV8dIFc+QiuxuHPh
         gF4I4X8Pz6JDkHjfKZDu4PlcvGEvsynfvZKLqf5utGrKuKEZ3rSBjUOtgU4NII1ux4Z8
         RzdpZUAu8N+SJWZE5c3ROMMsGfpPAHjsjar9cw51bR8XEFszEAw2BhiUjvFQSSOMjYEE
         BahtznvxdhPQrnJi6cCoIsnhxeOKJJIkMB0b8VqlSCGHdZ+rJkpeL2WlO5rmkDzp4Zog
         ndB4gQ1rm02Rw0PjjyhkDF2b1KBhq1qAfqlv/UJ5YznzK+dpFnANJ/Gklnpd+lTfYYLF
         yJ0w==
X-Gm-Message-State: APjAAAX46qnza3mjrrz/CyzT3DwMJtru9/bNvXYJaI6/7RXzK+qNKH0M
        y0Qd7UnfOOsRvrrQqMi/d7nqL/zy5wfcmvSAz2ZmASEq
X-Google-Smtp-Source: APXvYqxTaAoweepz0ZK6vEig/7ZKT3Duj0Ntx4NE8PlxuoumHORSCZLMvPiqYYMF1bw1mOOyaGQhQJMvZkp1GKhHnkg=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr20913774oth.159.1560966405949;
 Wed, 19 Jun 2019 10:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190617183738.14484-1-prsriva02@gmail.com> <20190617183738.14484-2-prsriva02@gmail.com>
In-Reply-To: <20190617183738.14484-2-prsriva02@gmail.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Wed, 19 Jun 2019 10:46:34 -0700
Message-ID: <CAEFn8q+BU9aQxwHQZECZ2Kpn5Gb9qDAm8m7fkEHCq7wo7+9fpQ@mail.gmail.com>
Subject: Re: [PATCH V9 1/3] IMA:Define a new hook to measure the kexec boot
 command line arguments
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 17, 2019 at 11:37 AM Prakhar Srivastava <prsriva02@gmail.com> wrote:
>
> Currently during soft reboot(kexec_file_load) boot command line
> arguments are not measured. Define hooks needed to measure kexec
> command line arguments during soft reboot(kexec_file_load).
>
> - A new ima hook ima_kexec_cmdline is defined to be called by the
> kexec code.
> - A new function process_buffer_measurement is defined to measure
> the buffer hash into the IMA measurement list.
> - A new func policy KEXEC_CMDLINE is defined to control the
>  measurement.[Suggested by Mimi]
>
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> ---
>  Documentation/ABI/testing/ima_policy |  1 +
>  include/linux/ima.h                  |  2 +
>  security/integrity/ima/ima.h         |  1 +
>  security/integrity/ima/ima_api.c     |  1 +
>  security/integrity/ima/ima_main.c    | 74 ++++++++++++++++++++++++++++
>  security/integrity/ima/ima_policy.c  |  7 +++
>  6 files changed, 86 insertions(+)
>
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index b383c1763610..fc376a323908 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -28,6 +28,7 @@ Description:
>                 base:   func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>                                 [FIRMWARE_CHECK]
>                                 [KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> +                               [KEXEC_CMDLINE]
>                         mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>                                [[^]MAY_EXEC]
>                         fsmagic:= hex value
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index fd9f7cf4cdf5..b42f5a006042 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -26,6 +26,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
>  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>                               enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
> +extern void ima_kexec_cmdline(const void *buf, int size);
>
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> @@ -92,6 +93,7 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
>         return;
>  }
>
> +static inline void ima_kexec_cmdline(const void *buf, int size) {}
>  #endif /* CONFIG_IMA */
>
>  #ifndef CONFIG_IMA_KEXEC
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 18b48a6d0b80..a4ad1270bffa 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -185,6 +185,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
>         hook(KEXEC_KERNEL_CHECK)        \
>         hook(KEXEC_INITRAMFS_CHECK)     \
>         hook(POLICY_CHECK)              \
> +       hook(KEXEC_CMDLINE)             \
>         hook(MAX_CHECK)
>  #define __ima_hook_enumify(ENUM)       ENUM,
>
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 78eb11c7ac07..ea7d8cbf712f 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -176,6 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   *             subj=, obj=, type=, func=, mask=, fsmagic=
>   *     subj,obj, and type: are LSM specific.
>   *     func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
> + *     | KEXEC_CMDLINE
>   *     mask: contains the permission mask
>   *     fsmagic: hex value
>   *
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index af341a80118f..1e233417a7af 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -605,6 +605,80 @@ int ima_load_data(enum kernel_load_data_id id)
>         return 0;
>  }
>
> +/*
> + * process_buffer_measurement - Measure the buffer to ima log.
> + * @buf: pointer to the buffer that needs to be added to the log.
> + * @size: size of buffer(in bytes).
> + * @eventname: event name to be used for the buffer entry.
> + * @cred: a pointer to a credentials structure for user validation.
> + * @secid: the secid of the task to be validated.
> + *
> + * Based on policy, the buffer is measured into the ima log.
> + */
> +static void process_buffer_measurement(const void *buf, int size,
> +                                      const char *eventname,
> +                                      const struct cred *cred, u32 secid)
> +{
> +       int ret = 0;
> +       struct ima_template_entry *entry = NULL;
> +       struct integrity_iint_cache iint = {};
> +       struct ima_event_data event_data = {.iint = &iint };
> +       struct ima_template_desc *template_desc = NULL;
> +       struct {
> +               struct ima_digest_data hdr;
> +               char digest[IMA_MAX_DIGEST_SIZE];
> +       } hash = {};
> +       int violation = 0;
> +       int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +       int action = 0;
> +
> +       action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
> +                               &template_desc);
> +       if (!(action & IMA_MEASURE))
> +               goto out;
> +
> +       event_data.filename = eventname;
> +
> +       iint.ima_hash = &hash.hdr;
> +       iint.ima_hash->algo = ima_hash_algo;
> +       iint.ima_hash->length = hash_digest_size[ima_hash_algo];
> +
> +       ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
> +       if (ret < 0)
> +               goto out;
> +
> +       ret = ima_alloc_init_template(&event_data, &entry, template_desc);
> +       if (ret < 0)
> +               goto out;
> +
> +       if (action & IMA_MEASURE)
> +               ret = ima_store_template(entry, violation, NULL, buf, pcr);
> +
> +       if (ret < 0)
> +               ima_free_template_entry(entry);
> +
> +out:
> +       return;
> +}
> +
> +/**
> + * ima_kexec_cmdline - measure kexec cmdline boot args
> + * @buf: pointer to buffer
> + * @size: size of buffer
> + *
> + * Buffers can only be measured, not appraised.
> + */
> +void ima_kexec_cmdline(const void *buf, int size)
> +{
> +       u32 secid;
> +
> +       if (buf && size != 0) {
> +               security_task_getsecid(current, &secid);
> +               process_buffer_measurement(buf, size, "kexec-cmdline",
> +                                          current_cred(), secid);
> +       }
> +}
> +
>  static int __init init_ima(void)
>  {
>         int error;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fd9b01881d17..4e8bb7eecd08 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -292,6 +292,11 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>         int i;
>
> +       if (func == KEXEC_CMDLINE) {
> +               if ((rule->flags & IMA_FUNC) && (rule->func == func))
> +                       return true;
> +               return false;
> +       }
>         if ((rule->flags & IMA_FUNC) &&
>             (rule->func != func && func != POST_SETATTR))
>                 return false;
> @@ -880,6 +885,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>                                 entry->func = KEXEC_INITRAMFS_CHECK;
>                         else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
>                                 entry->func = POLICY_CHECK;
> +                       else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
> +                               entry->func = KEXEC_CMDLINE;
>                         else
>                                 result = -EINVAL;
>                         if (!result)
> --
> 2.19.1
>

Hi Mimi,
Can you Ack this patch?
I want to make sure this looks okay to you.

Thanks,
Prakhar Srivastava
