Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E66A88F2
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCBTFR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 14:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCBTFQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 14:05:16 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26057D02
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 11:04:54 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i5so323951pla.2
        for <linux-integrity@vger.kernel.org>; Thu, 02 Mar 2023 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677783893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRVimYCKhvDiUDPfm5kwf3o6VQDi4G7m6HXxXYMXUFM=;
        b=ft/viqzCkTLwW6EhkDpC3VazoKVAkUJYltQAAdCTwnd9bafcpSMDaQPKSVafTdr0WW
         hnhUPhxUelD0fxHuGH3j9xRL8OQBTgTg8OTQaBDbqxqZpMqWtW8NEuCYFSGQirO02J63
         h0Pq0R1AnqVBRt19s3QVGSiWWXQFKWPD1MmrDXV/KH6wIBUNFVAWd8GO4F1s3esSSJ97
         tjlnWdZmE45usWwpu86183HKv10lKSOdXVYU07Dpovrnld5ZrlsQI1q6wK3U2HtZhNtO
         B8sj/nGKL2Kdp+mFWaFq7Z6Po3kHhxKlyNaDlJO4Q3raImBfrjgsOCDZR0mTnjsGUIBm
         oSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677783893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRVimYCKhvDiUDPfm5kwf3o6VQDi4G7m6HXxXYMXUFM=;
        b=eVT5LO5m1Qa4/EEXqY6UCQ4bcgcBKGG1sXKcrHh0DF5O948JXNvYDcmO6OMrOzIpCB
         Bl5XHMlVl+TRfeSfA9zZP0IF2MIUt8poYshI7xzKMFtxt5VV1oZtZvy8m88a/tJ9YIIz
         j4KCO17n2q+bSSNik64jrRIvjN60bb6sEeFPq7rYSIb8ZFa3nFUcKeiQ3ogGkZoJ4sUH
         Efh2RtDirScYuOQyOi6XtPQNst3drGy1lXBxDkr3RNuWmka1B7NrSV3mDqxoowNANe/X
         fk6269zSu5OdKVlXPpzMBWIa283wuVGQZJQlJWKc/o3pg0d9nEtVYUyAKA63UD1ZfL3x
         JxcA==
X-Gm-Message-State: AO0yUKVlia4Ll+1ZTy/KorJQzLQG+eCf+oUhGeaVcxwpi5vtJg1pPCq7
        peigYZT3eNxhzJ5wSTLfGXFSW/GGg3EUlhOBLvKy
X-Google-Smtp-Source: AK7set8jr8w++GEdWwicBErVrQxXYcvRZv+4pkR2mJOP8drvGUq4551NSSMlqb/wqBBEjbF+WJsHq3GFxyqHmReivT0=
X-Received: by 2002:a17:902:f7d1:b0:19a:f9d9:28d4 with SMTP id
 h17-20020a170902f7d100b0019af9d928d4mr4094339plw.3.1677783893526; Thu, 02 Mar
 2023 11:04:53 -0800 (PST)
MIME-Version: 1.0
References: <1675119451-23180-1-git-send-email-wufan@linux.microsoft.com> <1675119451-23180-6-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1675119451-23180-6-git-send-email-wufan@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Mar 2023 14:04:42 -0500
Message-ID: <CAHC9VhRa+NwKzLfQBmHfMgUp6_d5soQG7JBq-Vn=MUeUAt4tuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 05/16] ipe: add userspace interface
To:     Fan Wu <wufan@linux.microsoft.com>
Cc:     corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
        axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        eparis@redhat.com, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-audit@redhat.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 30, 2023 at 5:58=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
>
> From: Deven Bowers <deven.desai@linux.microsoft.com>
>
> As is typical with LSMs, IPE uses securityfs as its interface with
> userspace. for a complete list of the interfaces and the respective
> inputs/outputs, please see the documentation under
> admin-guide/LSM/ipe.rst
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

...

> ---
>  security/ipe/Makefile    |   2 +
>  security/ipe/fs.c        | 101 +++++++++
>  security/ipe/fs.h        |  17 ++
>  security/ipe/ipe.c       |   3 +
>  security/ipe/ipe.h       |   2 +
>  security/ipe/policy.c    | 135 ++++++++++++
>  security/ipe/policy.h    |   7 +
>  security/ipe/policy_fs.c | 459 +++++++++++++++++++++++++++++++++++++++
>  8 files changed, 726 insertions(+)
>  create mode 100644 security/ipe/fs.c
>  create mode 100644 security/ipe/fs.h
>  create mode 100644 security/ipe/policy_fs.c

...

> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index 772d876b1087..a5e9c6e5691b 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -4,12 +4,39 @@
>   */
>
>  #include "ipe.h"
> +#include "eval.h"
> +#include "fs.h"
>  #include "policy.h"
>  #include "policy_parser.h"
>  #include "digest.h"
>
>  #include <linux/verification.h>
>
> +/* lock for synchronizing writers across ipe policy */
> +DEFINE_SPINLOCK(ipe_policy_lock);
> +
> +/**
> + * ver_to_u64 - Convert an internal ipe_policy_version to a u64.
> + * @p: Policy to extract the version from.
> + *
> + * Bits (LSB is index 0):
> + *     [48,32] -> Major
> + *     [32,16] -> Minor
> + *     [16, 0] -> Revision
> + *
> + * Return: u64 version of the embedded version structure.
> + */
> +static inline u64 ver_to_u64(const struct ipe_policy *const p)
> +{
> +       u64 r =3D 0;

No need to set @r to 0 since you set it to the version immediately below.

> +       r =3D (((u64)p->parsed->version.major) << 32)
> +         | (((u64)p->parsed->version.minor) << 16)
> +         | ((u64)(p->parsed->version.rev));
> +
> +       return r;
> +}
> +
>  /**
>   * ipe_free_policy - Deallocate a given IPE policy.
>   * @p: Supplies the policy to free.
> @@ -21,6 +48,7 @@ void ipe_free_policy(struct ipe_policy *p)
>         if (IS_ERR_OR_NULL(p))
>                 return;
>
> +       ipe_del_policyfs_node(p);
>         free_parsed_policy(p->parsed);
>         if (!p->pkcs7)
>                 kfree(p->text);
> @@ -39,6 +67,70 @@ static int set_pkcs7_data(void *ctx, const void *data,=
 size_t len,
>         return 0;
>  }
>
> +/**
> + * ipe_update_policy - parse a new policy and replace @old with it.
> + * @addr: Supplies a pointer to the i_private for saving policy.
> + * @text: Supplies a pointer to the plain text policy.
> + * @textlen: Supplies the length of @text.
> + * @pkcs7: Supplies a pointer to a buffer containing a pkcs7 message.
> + * @pkcs7len: Supplies the length of @pkcs7len.
> + *
> + * @text/@textlen is mutually exclusive with @pkcs7/@pkcs7len - see
> + * ipe_new_policy.
> + *
> + * Return:
> + * * !IS_ERR   - OK
> + * * -ENOENT   - Policy doesn't exist
> + * * -EINVAL   - New policy is invalid
> + */
> +struct ipe_policy *ipe_update_policy(struct ipe_policy __rcu **addr,
> +                                    const char *text, size_t textlen,
> +                                    const char *pkcs7, size_t pkcs7len)
> +{
> +       int rc =3D 0;
> +       struct ipe_policy *old, *new;
> +
> +       old =3D ipe_get_policy_rcu(*addr);
> +       if (!old) {
> +               rc =3D -ENOENT;
> +               goto err;
> +       }
> +
> +       new =3D ipe_new_policy(text, textlen, pkcs7, pkcs7len);
> +       if (IS_ERR(new)) {
> +               rc =3D PTR_ERR(new);
> +               goto err;
> +       }
> +
> +       if (strcmp(new->parsed->name, old->parsed->name)) {
> +               rc =3D -EINVAL;
> +               goto err;
> +       }
> +
> +       if (ver_to_u64(old) > ver_to_u64(new)) {
> +               rc =3D -EINVAL;
> +               goto err;
> +       }
> +
> +       if (ipe_is_policy_active(old)) {

I don't understand the is-active check, you want to make @new the new
active policy regardless, right?  Could this is-active check ever be
false?

> +               spin_lock(&ipe_policy_lock);
> +               rcu_assign_pointer(ipe_active_policy, new);
> +               spin_unlock(&ipe_policy_lock);
> +               synchronize_rcu();
> +       }
> +
> +       rcu_assign_pointer(*addr, new);
> +
> +       swap(new->policyfs, old->policyfs);
> +       ipe_free_policy(old);
> +
> +       goto out;
> +err:
> +       ipe_free_policy(new);
> +out:
> +       return (rc < 0) ? ERR_PTR(rc) : new;
> +}
> +
>  /**
>   * ipe_new_policy - Allocate and parse an ipe_policy structure.
>   *
> @@ -117,3 +209,46 @@ struct ipe_policy *ipe_get_policy_rcu(struct ipe_pol=
icy __rcu *p)
>
>         return rv;
>  }
> +
> +/**
> + * ipe_set_active_pol - Make @p the active policy.
> + * @p: Supplies a pointer to the policy to make active.
> + */
> +int ipe_set_active_pol(const struct ipe_policy *p)
> +{
> +       int rc =3D 0;
> +       struct ipe_policy *ap =3D NULL;
> +
> +       ap =3D ipe_get_policy_rcu(ipe_active_policy);
> +       if (ap && ver_to_u64(ap) > ver_to_u64(p)) {
> +               rc =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       spin_lock(&ipe_policy_lock);
> +       rcu_assign_pointer(ipe_active_policy, p);
> +       spin_unlock(&ipe_policy_lock);
> +       synchronize_rcu();
> +
> +out:
> +       return rc;
> +}
> +
> +/**
> + * ipe_is_policy_active - Determine wehther @p is the active policy.
> + * @p: Supplies a pointer to the policy to check.
> + *
> + * Return:
> + * * true      - @p is the active policy
> + * * false     - @p is not the active policy
> + */
> +bool ipe_is_policy_active(const struct ipe_policy *p)
> +{
> +       bool rv;
> +
> +       rcu_read_lock();
> +       rv =3D rcu_access_pointer(ipe_active_policy) =3D=3D p;
> +       rcu_read_unlock();
> +
> +       return rv;
> +}

--
paul-moore.com
