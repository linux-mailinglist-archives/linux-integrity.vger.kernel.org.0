Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626D36A8918
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 20:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCBTI1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 14:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCBTIU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 14:08:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEE23609E
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 11:08:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bo22so141372pjb.4
        for <linux-integrity@vger.kernel.org>; Thu, 02 Mar 2023 11:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677784095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdu6kOAJ1Ups+aUuKMhdxW9mbKAGnc9mpfEPZtQ5oYc=;
        b=QCBxot5UEe92USFtl63SUB/c1YdLVxScPQJ1P4QKkUVllAOjkExvExOlk22Y+cAPLp
         7weEoPvxZ0D+WDb8BBKIVp9dG4Qk6OQkdh8kKA3dGVcxvksE7MJCCR2RE4qhTXvYfGvU
         jgj/tDTwkb4LQQic+6FFlgFTo6sCZEIGs5slvhlNdP2IW3PkjwzxqzAKtaNvhqrh1ARk
         Fk945S48pTjqSBexPAR6DDMtcXU3MwN4FBw5DjJSxESA4tj2RXONXJlXtInGbuPs/1lK
         6Em3Vjg2pr05lfKVnhLnuoPez7jPU4XUgCaO4BKItyg6p/BwZcZW+iA8dgGN98E+y8bW
         DE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677784095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vdu6kOAJ1Ups+aUuKMhdxW9mbKAGnc9mpfEPZtQ5oYc=;
        b=3OUgi4KGZCuQYQV4wz2Y8CLNH5uALUfunvbHvaCz9YFHEc8Ay9Buq4j6pxwFMyEnDy
         jjaPMQrSYgX9WZUzBbdeD+d1LPSlLqreX/cZzOiuejrFHasWHKpTlPOnFp08q7exZ52y
         uHOgyqDi23vrYLC93mv6CUMgbx9/LKXVR34wg5B2/TvcOYOLylemN/w+Bsxr8T2fhriQ
         xusyXpg5U1tUNQ2TY5bTP4PGT18kGMj/EZ63R291StlNiSIAhfhO3XyRJNMmLTCChhjx
         1blhn4hLgBnZqgzX3cwi+n7im7AAbcL2FzonJsrsMgABd+d0yfHpksehafZPIQgI9uLL
         04/g==
X-Gm-Message-State: AO0yUKXTG/u9yphUYBsxc4lqHfC7ZIv25J/Wn/F7A1fNaV5+3N9ixKMS
        +BAV+AlHzOpg1J0AsGT7hyR07CGJaCjoFYHS80z9
X-Google-Smtp-Source: AK7set9s3MxX+z1dx88uX1Fs1h5mTCDHnH5bToYcnqr8ZticQMwTWq2upjnKLw2DFG5CIW3NG3MUdlWUtltns+RDwxc=
X-Received: by 2002:a17:903:1d1:b0:19c:cb32:bfef with SMTP id
 e17-20020a17090301d100b0019ccb32bfefmr4510758plh.3.1677784095231; Thu, 02 Mar
 2023 11:08:15 -0800 (PST)
MIME-Version: 1.0
References: <1675119451-23180-1-git-send-email-wufan@linux.microsoft.com> <1675119451-23180-12-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1675119451-23180-12-git-send-email-wufan@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Mar 2023 14:08:04 -0500
Message-ID: <CAHC9VhRdm_xpXNQvSVO2hkx2js=_zzo2DiQ6PvEjAEet4OjxNw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 11/16] ipe: add support for dm-verity as a trust provider
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
> Allows author of IPE policy to indicate trust for a singular dm-verity
> volume, identified by roothash, through "dmverity_roothash" and all
> signed dm-verity volumes, through "dmverity_signature".
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

...

> ---
>  security/ipe/Kconfig         |  20 +++++
>  security/ipe/Makefile        |   2 +
>  security/ipe/audit.c         |  24 ++++++
>  security/ipe/digest.c        | 144 +++++++++++++++++++++++++++++++++++
>  security/ipe/digest.h        |  26 +++++++
>  security/ipe/eval.c          | 103 +++++++++++++++++++++++++
>  security/ipe/eval.h          |  13 ++++
>  security/ipe/hooks.c         |  51 +++++++++++++
>  security/ipe/hooks.h         |   8 ++
>  security/ipe/ipe.c           |  15 ++++
>  security/ipe/ipe.h           |   4 +
>  security/ipe/policy.h        |   3 +
>  security/ipe/policy_parser.c |  16 ++++
>  13 files changed, 429 insertions(+)
>  create mode 100644 security/ipe/digest.c
>  create mode 100644 security/ipe/digest.h
>
> diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
> index ac4d558e69d5..16e835ce61b0 100644
> --- a/security/ipe/Kconfig
> +++ b/security/ipe/Kconfig
> @@ -15,3 +15,23 @@ menuconfig SECURITY_IPE
>           admins to reconfigure trust requirements on the fly.
>
>           If unsure, answer N.
> +
> +if SECURITY_IPE
> +menu "IPE Trust Providers"
> +
> +config IPE_PROP_DM_VERITY
> +       bool "Enable support for dm-verity volumes"
> +       depends on DM_VERITY && DM_VERITY_VERIFY_ROOTHASH_SIG
> +       default Y
> +       help
> +         This option enables the properties 'dmverity_signature' and
> +         'dmverity_roothash' in IPE policy. These properties evaluates
> +         to TRUE when a file is evaluated against a dm-verity volume
> +         that was mounted with a signed root-hash or the volume's
> +         root hash matches the supplied value in the policy.
> +
> +         If unsure, answer Y.

If you had both IPE and dm-verity enabled in your kernel build, is
there ever a case where you wouldn't want IPE_PROP_DM_VERITY?  I
suspect you can just have IPE and dm-verity select IPE_PROP_DM_VERITY
and not bother the user/admin with the additional Kconfig knob.

> +endmenu
> +
> +endif

--
paul-moore.com
