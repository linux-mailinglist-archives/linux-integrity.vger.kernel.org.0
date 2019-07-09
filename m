Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544D26303A
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2019 07:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfGIF6y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jul 2019 01:58:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39267 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIF6y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jul 2019 01:58:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id v85so9580539lfa.6
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jul 2019 22:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkH82jEVCc2YvBDQT3QhNyCJ4U0glGemvghHKQeB0QY=;
        b=cNb/XsZZMssiXnqsdsYslGZZnpEl+wF7SO6km6xBmQ9FrCo6pXwKlIBoQQ23cHkgkE
         Vya6eho3ITk4fQeXF0IjryWNuzDi3ruR7OAFGUujEhs5E3AAYxWCaqi3aMTUGCNb5h90
         aDZ3DLdJ9IDzhrnmiohsrcPr8jiwlDuJldbIDdqPqQ0YkJP4KDnGVHBpds4JDKxWHX+u
         CMXbxUILRJaIoz49mwulwBwgXABcUp18u/YllLuEwq225M/hoMOD0EPXivSpyWx31Flj
         vQEk6t3rpgumzW/o7x3htGjjIXSId18CYEQGh38yMMzTYO4nGeDRGNN3uiVxy7e+Wuw0
         TlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkH82jEVCc2YvBDQT3QhNyCJ4U0glGemvghHKQeB0QY=;
        b=b303LO52PXjbmMIDm2FMNC7ia5I8uI02ePS7SCKsFGo0q2oHIiCIRh4XZZjs+Wrt9J
         LCl3OlIsYZ8MTnjtIoxGgBNdN9gta1R123pZbkSrgvoCaq6Le7KimjR92miSuex7kCpw
         kCEWyJIvJizxYuXnn3TSx6uqWUvsPszbBwBIyyrbk4M/h/aRSkHDgctZlqG5N7TMpJwD
         /k1KbGkAeS4ogwWsFNIRr97FMR5vuu6f+gbQLG67cRzL8jiAAE12BNRkrYaVtL/ECCQ7
         IaztTcTEOAA7QMulC64LWyjJykzhYDvGvq/IXmhtXvjB/rWL+Rko1HQztLD6yz1nu4Kg
         5OBQ==
X-Gm-Message-State: APjAAAXFaBW42uJ3QKKJZmv5geP9EpZ70JNZ/gh9I5mcchdc4IAPfaXz
        DAO2fG6aaG3I/To8OuuetNFCiVchgw7w1D8k9R+tFg==
X-Google-Smtp-Source: APXvYqx39kKCkmeiwsnYwL4Q6V2zqXobDhEMh1U3Qo1MZfJGNYbLOD7APTlz9j9E0uKTM/cQCPkVL3vExCIu1uSwzS4=
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr10800149lfm.134.1562651931884;
 Mon, 08 Jul 2019 22:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYPn3HB6BRocKmKTR+ZPE=Fav5w1TUdRgmLp-NkYobp3rw@mail.gmail.com> <20190708163140.GB28253@jax>
In-Reply-To: <20190708163140.GB28253@jax>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 9 Jul 2019 11:28:40 +0530
Message-ID: <CAFA6WYO0QmCVup6kEhodrf2+WS8p_iaLsb-CLPMaMbnPjapa2Q@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce TEE based Trusted Keys support
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        serge@hallyn.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 8 Jul 2019 at 22:01, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Mon, Jul 08, 2019 at 06:11:39PM +0530, Sumit Garg wrote:
> > Hi Jens,
> >
> > On Thu, 13 Jun 2019 at 16:01, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Add support for TEE based trusted keys where TEE provides the functionality
> > > to seal and unseal trusted keys using hardware unique key. Also, this is
> > > an alternative in case platform doesn't possess a TPM device.
> > >
> > > This series also adds some TEE features like:
> > >
> > > Patch #1, #2 enables support for registered kernel shared memory with TEE.
> > >
> >
> > Would you like to pick up Patch #1, #2 separately? I think both these
> > patches add independent functionality and also got reviewed-by tags
> > too.
>
> I think it makes more sense to keep them together in the same patch
> series or could end up with dependencies between trees.
>

I understand your point. Let me keep this patch-set together to avoid
any dependencies.

-Sumit

> If you don't think dependencies will be an issue then I don't mind
> picking them up, in that case they'd likely sit in an arm-soc branch
> until next merge window. However, I think that #3 (support for private
> kernel login method) should be included too and that one isn't ready
> yet.
>
> Thanks,
> Jens
>
> >
> >
> > -Sumit
> >
> > > Patch #3 enables support for private kernel login method required for
> > > cases like trusted keys where we don't wan't user-space to directly access
> > > TEE service to retrieve trusted key contents.
> > >
> > > Rest of the patches from #4 to #7 adds support for TEE based trusted keys.
> > >
> > > This patch-set has been tested with OP-TEE based pseudo TA which can be
> > > found here [1].
> > >
> > > Looking forward to your valuable feedback/suggestions.
> > >
> > > [1] https://github.com/OP-TEE/optee_os/pull/3082
> > >
> > > Sumit Garg (7):
> > >   tee: optee: allow kernel pages to register as shm
> > >   tee: enable support to register kernel memory
> > >   tee: add private login method for kernel clients
> > >   KEYS: trusted: Introduce TEE based Trusted Keys
> > >   KEYS: encrypted: Allow TEE based trusted master keys
> > >   doc: keys: Document usage of TEE based Trusted Keys
> > >   MAINTAINERS: Add entry for TEE based Trusted Keys
> > >
> > >  Documentation/security/keys/tee-trusted.rst      |  93 +++++
> > >  MAINTAINERS                                      |   9 +
> > >  drivers/tee/optee/call.c                         |   7 +
> > >  drivers/tee/tee_core.c                           |   6 +
> > >  drivers/tee/tee_shm.c                            |  16 +-
> > >  include/keys/tee_trusted.h                       |  84 ++++
> > >  include/keys/trusted-type.h                      |   1 +
> > >  include/linux/tee_drv.h                          |   1 +
> > >  include/uapi/linux/tee.h                         |   2 +
> > >  security/keys/Kconfig                            |   3 +
> > >  security/keys/Makefile                           |   3 +
> > >  security/keys/encrypted-keys/masterkey_trusted.c |  10 +-
> > >  security/keys/tee_trusted.c                      | 506 +++++++++++++++++++++++
> > >  13 files changed, 737 insertions(+), 4 deletions(-)
> > >  create mode 100644 Documentation/security/keys/tee-trusted.rst
> > >  create mode 100644 include/keys/tee_trusted.h
> > >  create mode 100644 security/keys/tee_trusted.c
> > >
> > > --
> > > 2.7.4
> > >
