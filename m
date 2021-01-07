Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2F82ED35C
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 16:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbhAGPOl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 10:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAGPOl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 10:14:41 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C60C0612F4
        for <linux-integrity@vger.kernel.org>; Thu,  7 Jan 2021 07:14:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u19so8128761edx.2
        for <linux-integrity@vger.kernel.org>; Thu, 07 Jan 2021 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puiterwijk.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFGonR2aZoMBmk7HnCBDgn1XxArRm2sUbQ50E3+txGc=;
        b=R/wWaPkXApi1gVL/p0k2WnsfkaVFDrliXZXBZSX/04wWlCddzo7S41nVga9VCJ64D8
         Th1tl0RAwPCNcg+8YZbJ639J6iJt/M8mMypxcCHjZR+najk+XmCf3dvN14UA28zMDI6h
         piJsHE8fXQ66nwz3sj5TqPk2Z2FMjkZG3EwEUcLWTGiUgy6/DdJcpYI1e4NtfCDEaoXQ
         kJKh3Ync66zDtNHuh29JlHUR/lTsC+rI3JCmQ5Kj1eLt+MLR4L26ecP+Egj+TnRTF6tW
         pCkBcYGK/M2hlLEHLchZBrzPkg4kxqh7gCqgQpcJqOZagDNry6L7Mk1C+zP7ImNOa+jr
         7gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFGonR2aZoMBmk7HnCBDgn1XxArRm2sUbQ50E3+txGc=;
        b=m4xEn7zBQAemkXXuTQ5txzcL+AoQQmXzjUUq7tQs9zMvWUnp7ksqxLYqoKGdBMqXTq
         nJIUDRKBzaAH/1PJZeOhPBVP6LTyDLG8qPkmgm8X2XDwjRtbhVkGsr3RTLXfb5h1g+uL
         vXDFajSYqOkYIsFJIVej6FDG6NlumuTVCRPHA4Jgcv8/bySFc0C5EXuWfrc0t03Q4v9H
         M8PKlrCqpSScpHQT13Ka2a2WRppHco4nWzcARc2DJz9UQmP3hZAtEJ2odttsXsZE+2dh
         rpcDY/lD6Famfq6jxn/67jhMW67ZZBzchYDWzYhyYgAjLdGpp9T8zY+sAn9N3JOARQD8
         IvFQ==
X-Gm-Message-State: AOAM530sj79xD1SYft2Mg0RZ4NaRKZjmTTyK6sBN0ZkgukPLfP6GBcsT
        Mo3VttUU9oHiN3f8Q64foGcWj6FCEJDio7Qtpt/7EA==
X-Google-Smtp-Source: ABdhPJxODlE63qV2qz+1I7B3YVqbHK2j3hmppFPfEl47DZ/CMddqP2Dd2fIIVQ3a9G8C94JHvbcJUZHKoW/SV490heU=
X-Received: by 2002:aa7:df0f:: with SMTP id c15mr2055676edy.354.1610032439376;
 Thu, 07 Jan 2021 07:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
 <20210106094335.3178261-2-patrick@puiterwijk.org> <ed6980130453e529d5bc8a089a0d0082d2f471cd.camel@linux.ibm.com>
 <20210107130816.wmzrcx5il4hdmah6@altlinux.org> <20210107131555.t7k4r2kytftj2nip@altlinux.org>
In-Reply-To: <20210107131555.t7k4r2kytftj2nip@altlinux.org>
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Thu, 7 Jan 2021 16:13:48 +0100
Message-ID: <CAJweMdbAeuVMmqdcUohZKWY7GC0oiU7-TL+nTi7282Yrip7Tsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix sign_hash not observing the hashalgo argument
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        pbrobinson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 7, 2021 at 2:15 PM Vitaly Chikunov <vt@altlinux.org> wrote:
>
> On Thu, Jan 07, 2021 at 04:08:16PM +0300, Vitaly Chikunov wrote:
> > Patrick, Mimi,
> >
> > On Thu, Jan 07, 2021 at 07:24:43AM -0500, Mimi Zohar wrote:
> > > On Wed, 2021-01-06 at 10:43 +0100, Patrick Uiterwijk wrote:
> > > > This fixes sign_hash not using the correct algorithm for creating the
> > > > signature, by ensuring it uses the passed in variable value.
> > > >
> > > > Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> > >
> > > Thank you.  This is a regression first introduced in commit
> > > 07e623b60848 ("ima-evm-utils: Convert sign_hash_v2 to EVP_PKEY API").
> >
> > Ah, when sign_hash() is used not via evmctl, but as a library
> > imaevm_params may be not set.
>
> Thinking about imaevm_params -- it's still belong to a library and
> extensively used in libimaevm.c, so I wonder if the fix is perfect.
> Since, now there is hash_algo and algo duplication which one to prefer
> and why?
>
> Maybe, it should be [also] set like keypass in sign_hash?

I had this exact diff as an initial version of this patch, but then
personally thought that because "hashalgo" is passed to sign_hash_v2
anyway, and sign_hash_v1 already prefers the argument (and ignores
imaevm_params.hash_algo), keeping this behaviour in sync is more
consistent.
With my patch, imaevm_params.hash_algo is only used in verify_hash_v2
and ima_calc_hash, both of which are primarily called by
ima_verify_signature which sets it, as a way to pass the argument
without having it explicit everywhere.

>
>   int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
>   {
>           if (keypass)
>                   imaevm_params.keypass = keypass;
>
> +         if (hashalgo)
> +                 imaevm_params.hash_algo = hashalgo;
>
>           return imaevm_params.x509 ?
>                   sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
>                   sign_hash_v1(hashalgo, hash, size, keyfile, sig);
>   }
>
>
