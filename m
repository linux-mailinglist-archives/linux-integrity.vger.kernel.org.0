Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0149DA4E
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 06:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiA0FnA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 00:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiA0Fm7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 00:42:59 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FE3C06161C
        for <linux-integrity@vger.kernel.org>; Wed, 26 Jan 2022 21:42:59 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t7so2625628ljc.10
        for <linux-integrity@vger.kernel.org>; Wed, 26 Jan 2022 21:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dTkxGYUlNJhi8u43pDWWFCeIctkqPXxzUpp/O4S0VA=;
        b=nU20B3sS+LfpIOekeMws0AVgBv3fCRJS76MRe4s0LAuZQVhhAvtfAV5olP2ivrN59l
         5zeRsgnktL6Gh4MkXAVpb6Bp23tNdq/1tLPjsvfLRwI3OMfBwNGsB0Jc3RvHLlPfBfnL
         HKo9in79rxbzyxK8JtvmKzXpBgAV9ugJJTxOVzXwP7Q8+62WUgzkuWniGrg2gYPDMoBF
         c7p1VpqVy6TN2X8A3kTEI9fSO9lZvhhZUlq7TOQeUiAolULuL+SdRceM15KyO5pjO0cH
         7dDaCp1y9OQHXifcOULncCnTUu3T7HLzB3+F3W8CoQ+nfl+G+vpgHa76c8ugsypfL8JO
         JlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dTkxGYUlNJhi8u43pDWWFCeIctkqPXxzUpp/O4S0VA=;
        b=0Tpz2sRCmkLan+ljwKaWqDoMqe75uSKiQvO0SKhUmvBvyecLDdoa4X0WJIt0nNFMSQ
         FmQscFFMlXb0AlqZ3k3UGN/+r2Cd248wORJTJK+LR1Ph+ktuQ9F98ygnnD9skczB6yLe
         nDTimhY4j/nuwrWbb/k4lF19VZKqgniNppWaCeZTeE2pyaqefM45ZbNk6FfQl+6YMhDE
         1hgdJR16UlE5T4OkY8Y1zlGvJkH+fK70ZyRlr6/MobXHCk+XZaroZoyDIKJPRiYJ/GWc
         SIzOKwp9az1iCH6eoIbuK2WdpcNglXLJJuGsCSHZLegI/nS+fy41c+eHX7ISioo4wfH3
         /Gbg==
X-Gm-Message-State: AOAM53286eST63zzOT6xvywBYBvRRsIWcnodGscRTM8c0xYeLxYiwnaX
        V7830Saa/79ROK84zcWVqGkb65u2b/ZiilHL9QJJ0w==
X-Google-Smtp-Source: ABdhPJyjFKH1eFW8c9iG7GHHeCKkvytQDNzjWI5d62tvhNQl3Ul3xJNWa6SY4dzAjSPxwo3VLvCGUsvgjdEPz7BsWPQ=
X-Received: by 2002:a2e:8754:: with SMTP id q20mr1764155ljj.71.1643262177779;
 Wed, 26 Jan 2022 21:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20220126203243.231822-1-dave.kleikamp@oracle.com>
In-Reply-To: <20220126203243.231822-1-dave.kleikamp@oracle.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 27 Jan 2022 11:12:46 +0530
Message-ID: <CAFA6WYNiWo+wrKp_=jC+g5DcXrg-JzwSqND+8wL9FFeZwGH+Kg@mail.gmail.com>
Subject: Re: [PATCH v2] KEYS: trusted: Avoid calling null function trusted_key_exit
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     linux-kernel@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 27 Jan 2022 at 02:02, Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> If one loads and unloads the trusted module, trusted_key_exit can be
> NULL. Call it through static_call_cond() to avoid a kernel trap.
>
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
> v2 changes:
> Header cleanup - removed empty line and cc:stable
>  security/keys/trusted-keys/trusted_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks for the fix.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index d5c891d8d353..8c14e04e2112 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -351,7 +351,7 @@ static int __init init_trusted(void)
>
>  static void __exit cleanup_trusted(void)
>  {
> -       static_call(trusted_key_exit)();
> +       static_call_cond(trusted_key_exit)();
>  }
>
>  late_initcall(init_trusted);
> --
> 2.35.0
>
