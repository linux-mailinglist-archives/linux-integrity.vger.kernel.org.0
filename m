Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4512213A0
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 19:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgGORo3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 13:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGORo3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 13:44:29 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1887DC061755;
        Wed, 15 Jul 2020 10:44:29 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x2so632602oog.5;
        Wed, 15 Jul 2020 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GFlWCMXT1McclKUDiU9FJWNsfLXEuQwJM+Zc8tDAILE=;
        b=A1R8OVVC9vVfiBTU8FBD4g/7FAbDqOTl5RcE40gueHg0iu1oi6Z+QI63vMrc60ccEg
         g4fbcm9RdmVBHISRj5nrInNkpM0neIAUHOhCxUobMwfLt/WnJRzj1fZCx2heNrdLQdXf
         lO3VJTS4O9MH5MRIKrlVs7XTGVHSOrdsiKl22C56iYC74V5wSb2fts2Y27u8p8awc9YH
         eGGxWmBCh8aKNm8ND87Ix1zGKAjdr8wwhe9YeKPPF64GZS5aiFisu5XF8ik2zFTF6J4b
         4KWSzGSToha8gQ9Hr3qzr8F1fZrTuXl4D3uvEromBp/ibpUrt5jSzfSuWoStb76eHmpe
         Wc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GFlWCMXT1McclKUDiU9FJWNsfLXEuQwJM+Zc8tDAILE=;
        b=OxKMMe0DYgdqGYlcQ6soJ5pa+XHEfBL21gY7wUgr/BdG/w3N7PSpcvMCdy5Ty/YoHg
         cwkq+2bUB3WQiPdp2n/MENWKkZsGpS9w2RcvQwdBE+4Sb+nA412+gaxUCA0OTtrnoKaD
         aoAOI0lPNkM4PQZSMPHHrzkrjwc7xCC3OAwLbuWEuKtlMnLjCV9F61+2L4QdOSolK8Fq
         /xiB2O1+lOGeeZYv1lLrhcL0rwbZkCLiFJDUy1/XpvCJIEiokploNF9ScYGUtutudXos
         +f0U1orRJLBQJNzABHJNQ+JWKvKBDYF6lWZfWB9ngeARJljRxEQQmaZRbIJ+CRWF5m/y
         k2gw==
X-Gm-Message-State: AOAM532bGYmiyph+A82GYVa8flkbiQMkg3ypgYpawUimY+NeIrujE04W
        vOPn2WH1YDJBuIJ2HPtoK/0sNm3eSb+ecTy3XnM=
X-Google-Smtp-Source: ABdhPJwLe3zpc1iO8/plW7H06lE30/eXcr+XQ0aXN5z8ePAZR0S2zFdXre5n68MuXktaZx4+4nkPOXL84ctbz5uMfUY=
X-Received: by 2002:a4a:b006:: with SMTP id f6mr304583oon.13.1594835068421;
 Wed, 15 Jul 2020 10:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200715154853.23374-1-nramas@linux.microsoft.com> <20200715154853.23374-5-nramas@linux.microsoft.com>
In-Reply-To: <20200715154853.23374-5-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 15 Jul 2020 14:04:52 -0400
Message-ID: <CAEjxPJ6UsK9QqFTpMKjgSin2Q6D-5NCNDS0enuRNuixVP9H2wQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] LSM: Define SELinux function to measure security state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 15, 2020 at 11:48 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> SELinux configuration and policy are some of the critical data for this
> security module that needs to be measured. To enable this measurement
> SELinux needs to implement the interface function, security_state(), that
> the LSM can call.
>
> Define the security_state() function in SELinux to measure SELinux
> configuration and policy. Call this function to measure SELinux data
> when there is a change in the security module's state.
>
> Sample measurement of SELinux state and hash of the policy:
>
> 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state 656e61626c65643d3=
13b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574706565723d31=
3b6f70656e7065726d3d313b657874736f636b636c6173733d313b616c776179736e6574776=
f726b3d303b6367726f75707365636c6162656c3d313b6e6e706e6f737569647472616e7369=
74696f6e3d313b67656e66737365636c6162656c73796d6c696e6b3d303b
> 10 f4a7...9408 ima-buf sha256:4941...68fc selinux-policy-hash 8d1d...1834
>
> The data for selinux-state in the above measurement is:
> enabled=3D1;enforcing=3D0;checkreqprot=3D1;netpeer=3D1;openperm=3D1;extso=
ckclass=3D1;alwaysnetwork=3D0;cgroupseclabel=3D1;nnpnosuidtransition=3D1;ge=
nfsseclabelsymlink=3D0;
>
> The data for selinux-policy-hash in the above measurement is
> the SHA256 hash of the SELinux policy.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index b0e02cfe3ce1..691c7e35f82a 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -222,16 +222,35 @@ static inline bool selinux_policycap_genfs_seclabel=
_symlinks(void)
>         return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLIN=
KS];
>  }
>
> +static inline bool selinux_checkreqprot(void)
> +{
> +       struct selinux_state *state =3D &selinux_state;
> +
> +       return state->checkreqprot;
> +}

Probably should use READ_ONCE().

> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> new file mode 100644
> index 000000000000..b909e8e61542
> --- /dev/null
> +++ b/security/selinux/measure.c
> @@ -0,0 +1,122 @@
> +int selinux_security_state(void)

Let's call this selinux_measure_state() or similar.  Needs a verb. And
pass it a struct selinux_state * pointer argument to be measured, even
though initially it will always be passed &selinux_state.  The
encapsulation of selinux state within selinux_state was to support
multiple selinux namespaces in the future, each with their own state.

> +{
> +       int rc =3D 0;
> +       int count;
> +       size_t buflen;
> +       int policy_hash_len;
> +       char *state =3D NULL;
> +       void *policy =3D NULL;
> +       void *policy_hash =3D NULL;
> +       static char *security_state_string =3D
> +                       "enabled=3D%d;enforcing=3D%d;checkreqprot=3D%d;" =
       \
> +                       "netpeer=3D%d;openperm=3D%d;extsockclass=3D%d;"  =
       \
> +                       "alwaysnetwork=3D%d;cgroupseclabel=3D%d;"        =
     \
> +                       "nnpnosuidtransition=3D%d;genfsseclabelsymlink=3D=
%d;";

Rather than hardcoding policy capability names here, I would recommend
using the selinux_policycap_names[] array for the names and the
selinux_state.policycap[] array for the values.  Also recommend
passing in a struct selinux_state * here to allow for future case
where there are multiple selinux states, one per selinux namespace.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index ef0afd878bfc..0c289d13ef6a 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3724,10 +3724,11 @@ int security_netlbl_sid_to_secattr(struct selinux=
_state *state,
>   * security_read_policy - read the policy.
>   * @data: binary policy data
>   * @len: length of data in bytes
> - *
> + * @alloc_kernel_memory: flag to indicate memory allocation
>   */
> -int security_read_policy(struct selinux_state *state,
> -                        void **data, size_t *len)
> +int security_read_selinux_policy(struct selinux_state *state,
> +                                void **data, size_t *len,
> +                                bool alloc_kernel_memory)

Instead of passing in a boolean to control how the memory is
allocated, split this into a helper function that takes an
already-allocated buffer and two
different front-end wrappers, one for kernel-internal use and one for
userspace use.

> @@ -3738,7 +3739,10 @@ int security_read_policy(struct selinux_state *sta=
te,
>
>         *len =3D security_policydb_len(state);
>
> -       *data =3D vmalloc_user(*len);
> +       if (alloc_kernel_memory)
> +               *data =3D kzalloc(*len, GFP_KERNEL);

You need vmalloc() since policy image size may exceed kmalloc max (or
at least that used to be the case).
