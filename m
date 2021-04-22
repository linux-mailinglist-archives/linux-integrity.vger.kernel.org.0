Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6985A3678DD
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 06:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhDVErw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 00:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhDVEru (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 00:47:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8A9C06138C
        for <linux-integrity@vger.kernel.org>; Wed, 21 Apr 2021 21:47:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u4so50294215ljo.6
        for <linux-integrity@vger.kernel.org>; Wed, 21 Apr 2021 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8xSVHnbnPreLCUm7lSlAXXP6DIoYnAcQ4G8DoJd4po=;
        b=VtdCM6R6wqO20+uZ6bRWiuSnZJL/C81YI/D91nz6KU/GcxI5P46Udak7Pod8u/G0AN
         rUBQ4rOUoCb3bJZXZTNX72aSGAOqChTfNh+ZMKNNafbKqCyceaw6hKzX3IcLVZoT7+eH
         pR4/WGEI26z6Y6amHnm0LqCBn4vHu9UjAkGuw+dEImVUgoFM1EDhscrpFf1I/z+8DYgn
         ku2DgFfh/G82U3PruwU3KeNRw1egaE1iERchBMBjFKN18fKF21aYBCkhqmAbv/g4SmUY
         L649YW352pvHgX2DwiDn8mDPPtCoQtujbiTyifvWVWSuFxZVNhRv4ael8Ddzcidzm1Hu
         SdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8xSVHnbnPreLCUm7lSlAXXP6DIoYnAcQ4G8DoJd4po=;
        b=AO8R9GrqURr1mslKzBnsHDsUp+O9Y9Sjx3gIBokCEOe5NTh0XCOzaGc2Ps72LbEyoW
         jD+Ffn5QaXmXZFKt6wWlgHQF98y4zzbzJN5TaK/LxbjpzeHdckU7Sq6EwhGJsoz9EfeV
         K4nx2sEWr0hI8pLKYeFOi/kkmPG30qz7jovVg3+g8XXmjjsCV08Og1LFtDdwxp0Obf7/
         l9vrZvW70hdsaCnWXZ35G4OifE838cshiuxnvxJ0LTf/3d4TRtK6XjxDdOpyDqs24y4K
         zBM+GboT3Yfq8gXam+/PynlHwmfawy3SGWP6fo6TSgVPOUBSUxBTqYXeW6RvF6JuIYQb
         lAoA==
X-Gm-Message-State: AOAM532wNuogM7U55nKffF/soM/CL4HLLuoKjZrBtCYZPOc491WNMJHH
        e9PSk1cNuLhSxbxL2+/LC9Vrh1WCU75aHqFWyumxZg==
X-Google-Smtp-Source: ABdhPJyZHxpDwI0EgkJCh5/0J5fqW292ra6TnpMN3+D+M/7dCIKQxqZY4Yov2+SeYHml0Acg2lTS/DUjtX+ig/efka8=
X-Received: by 2002:a2e:9e98:: with SMTP id f24mr1134602ljk.442.1619066834900;
 Wed, 21 Apr 2021 21:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210301131127.793707-1-sumit.garg@linaro.org>
 <20210301131127.793707-2-sumit.garg@linaro.org> <65dcc9fa28833e6beb1eadf98b0ed3402404d693.camel@linux.ibm.com>
 <CAFA6WYOzD-qhHrcnzvd9P7iFvEqWwf0NCKXrgrEgvnB5i_-SxQ@mail.gmail.com> <e7a91c8c09722afe1fb1ec3aa7b6544e713183af.camel@linux.ibm.com>
In-Reply-To: <e7a91c8c09722afe1fb1ec3aa7b6544e713183af.camel@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 22 Apr 2021 10:17:02 +0530
Message-ID: <CAFA6WYOSVVhk91XxwbmqGkvpcUF5pkro4M7fay480Enocoj+=g@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] KEYS: trusted: Add generic trusted keys framework
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 21 Apr 2021 at 22:51, James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Wed, 2021-04-21 at 16:38 +0530, Sumit Garg wrote:
> > Hi James,
> >
> > On Wed, 21 Apr 2021 at 04:47, James Bottomley <jejb@linux.ibm.com>
> > wrote:
> > > On Mon, 2021-03-01 at 18:41 +0530, Sumit Garg wrote:
> > > > Current trusted keys framework is tightly coupled to use TPM
> > > > device as an underlying implementation which makes it difficult
> > > > for implementations like Trusted Execution Environment (TEE) etc.
> > > > to provide trusted keys support in case platform doesn't posses a
> > > > TPM device.
> > > >
> > > > Add a generic trusted keys framework where underlying
> > > > implementations can be easily plugged in. Create struct
> > > > trusted_key_ops to achieve this, which contains necessary
> > > > functions of a backend.
> > > >
> > > > Also, define a module parameter in order to select a particular
> > > > trust source in case a platform support multiple trust sources.
> > > > In case its not specified then implementation itetrates through
> > > > trust sources list starting with TPM and assign the first trust
> > > > source as a backend which has initiazed successfully during
> > > > iteration.
> > > >
> > > > Note that current implementation only supports a single trust
> > > > source at runtime which is either selectable at compile time or
> > > > during boot via aforementioned module parameter.
> > >
> > > You never actually tested this, did you?  I'm now getting EINVAL
> > > from all the trusted TPM key operations because of this patch.
> > >
> >
> > Unfortunately, I don't possess a development machine with a TPM
> > device. So mine testing was entirely based on TEE as a backend which
> > doesn't support any optional parameters. And that being the reason I
> > didn't catch this issue at first instance.
> >
> > Is there any TPM emulation environment available that I can use for
> > testing?
>
> Well use the same as we all use: A software TPM running in the host
> coupled with a virtual machine guest for the kernel:
>
> https://en.opensuse.org/Software_TPM_Emulator_For_QEMU
>
> It doesn't catch interface issues (like TIS timeouts) but it does catch
> TPM operations problems like this patch had.
>

Thanks for the pointer. I will use it for future testing.

-Sumit

> James
>
>
