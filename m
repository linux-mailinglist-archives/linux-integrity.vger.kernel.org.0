Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4131F8FA22
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2019 06:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfHPE6f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Aug 2019 00:58:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45415 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfHPE6e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Aug 2019 00:58:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id t3so4134355ljj.12
        for <linux-integrity@vger.kernel.org>; Thu, 15 Aug 2019 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IheryZV9rrbjkhsApKF0cQrN+bCYQHiVbxfyC+R8SPs=;
        b=Pkm0NUQnQb+EOlq0h2SHmWadPKkaD/lCieO0yl74TZLlE/hgCgdzeCX4S8UkDiGIJ9
         BJDXA7BSwFx1nj8YDpy96wWOePcZc7DiQoSImn5lsCMjr0P/8rXzMbFPwUkG4bIchl0M
         3TGiEBV74UlCnVimN3ovM3xBSjDWvCfWp8kQGm7FRAuRDKOdk6IpaHooO8XopSDU2/ZN
         CGR/BXMk6C3YfQofU4kHRctOCZ8a3R+PWmzsirXmXvXffLwS+ej5SnA7wcjC8AwIjYgp
         /Wa2TSaGzuCpODuxIvQMKMxXW083gzlu8L5ieGUeWoYdQ1rFSesMW+iNs8b5YFrgiGst
         CPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IheryZV9rrbjkhsApKF0cQrN+bCYQHiVbxfyC+R8SPs=;
        b=JG9FkKdr6jlBbfuGgkFqYnYIahQlzXt6Tfw0vInlyp8Q3vWDmtyYT4BP9nDGKriwFm
         c8V7hDtHKAIY66oUNGH/T5d2X0XTj5Y9wUn+AZmGXNU9upZ2wn4IaBPC8xhM8+Q7qbcN
         ljDPuXtDouKWvsMN3x8szfL42meIzkz0roI5sagvblMd0Y0N4//nrlWl9/sQMRRIgeHt
         HwxqhIvpBLz0W2Y8apXAivtXftr+mOH/gpKIzXTuDbwlfRKLSdituCKIgwuQXJzY8FAM
         I+x0NY0AfsrHrJSKGk9vw4NAq8vyX1TMTqJlcX6pdYCBe9D3dM/13v/iVh+7QlHOH5uu
         pNyg==
X-Gm-Message-State: APjAAAUYkrsa/BZfImKVKp3SiVAudCuvQzQ9t4tpuJjfru2Hh3zirJLO
        XE6JnKYgwGMsfHeQYFjD6T4l48HnMAPmo0I28ns26g==
X-Google-Smtp-Source: APXvYqxdE1bhaVDU9yTjzsEua1cP967Nm4UBkfxH/OnLVUEy/YR6cxGtDtFMt3bbGlA7IqY5OwWGuO6PaUbetFnVF7M=
X-Received: by 2002:a2e:760f:: with SMTP id r15mr4316685ljc.92.1565931512710;
 Thu, 15 Aug 2019 21:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565789078.10490.10.camel@kernel.org> <CAFA6WYPU0oREaHROhhRsEXJTijvER8G4riBk4e4=Bd5XgGFqtQ@mail.gmail.com>
 <1565881609.9424.7.camel@kernel.org>
In-Reply-To: <1565881609.9424.7.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 16 Aug 2019 10:28:20 +0530
Message-ID: <CAFA6WYOREs37p0TF4=E0=Z66DLGFJi92FfJo9VyAD67cLpALGA@mail.gmail.com>
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
To:     Mimi Zohar <zohar@kernel.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 15 Aug 2019 at 20:36, Mimi Zohar <zohar@kernel.org> wrote:
>
> On Thu, 2019-08-15 at 18:33 +0530, Sumit Garg wrote:
> > Hi Mimi,
> >
> > On Wed, 14 Aug 2019 at 18:54, Mimi Zohar <zohar@kernel.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Tue, 2019-08-13 at 13:22 +0530, Sumit Garg wrote:
> > > > This patch-set is an outcome of discussion here [1]. It has evolved very
> > > > much since v1 to create, consolidate and generalize trusted keys
> > > > subsystem.
> > > >
> > > > This framework has been tested with trusted keys support provided via TEE
> > > > but I wasn't able to test it with a TPM device as I don't possess one. It
> > > > would be really helpful if others could test this patch-set using a TPM
> > > > device.
> > >
> > > With the "CONFIG_HEADER_TEST" and "CONFIG_KERNEL_HEADER_TEST" config
> > > options enabled, which is required for linux-next, it fails to build.
> > >
> >
> > TBH, I wasn't aware about this test feature for headers.
>
> It's new to me too.
>
> > It looks like
> > the header which fails this test is "include/keys/trusted_tpm.h" which
> > is basically a rename of "include/keys/trusted.h" plus changes in this
> > patch-set.
> >
> > And "include/keys/trusted.h" header is already put under blacklist
> > here: "include/Kbuild +68" as it fails to build. So its that rename
> > due to which build failure is observed now.
> >
> > It seems to be an easy fix for this build failure via following changes:
> >
> > diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> > index 7b593447920b..ca1bec0ef65d 100644
> > --- a/include/keys/trusted_tpm.h
> > +++ b/include/keys/trusted_tpm.h
> > @@ -2,6 +2,9 @@
> >  #ifndef __TRUSTED_TPM_H
> >  #define __TRUSTED_TPM_H
> >
> > +#include <keys/trusted-type.h>
> > +#include <linux/tpm_command.h>
> > +
> >  /* implementation specific TPM constants */
> >  #define MAX_BUF_SIZE                   1024
> >  #define TPM_GETRANDOM_SIZE             14
> >
> > So I will include above changes in this patch-set and also remove
> > "include/keys/trusted.h" header from the blacklist.
>
> That works, thanks.  With this patch set, at least the EVM trusted key
> is properly being decrypted by the encrypted key with both a TPM 1.2
> and PTT TPM 2.0.  My laptop still boots properly.  Over the weekend
> I'll try to actually review the patches.
>

Thanks Mimi for testing this patch-set.

-Sumit

> Mimi
