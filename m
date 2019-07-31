Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA0D7BE5D
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2019 12:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfGaK01 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Jul 2019 06:26:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44933 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfGaK00 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Jul 2019 06:26:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so65026379ljc.11
        for <linux-integrity@vger.kernel.org>; Wed, 31 Jul 2019 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUZSHlOC2NsvHH+oiYgXd/P9aGC7hBdS8UD65AtoMp4=;
        b=MQiLGOAWAeeOz7OvhR0Srak34dyDFzwv68hLoy3nUVLq1Ok4QKDOGspGoCLiCYmrsl
         X53gwv/rai5eej0QK73mKUVb9t737/JnqyNFTDy3ud2eorwscZF/qVEhn/BI0oZfsUMX
         NoICCfPOb5jeWu0aA1R5XdP93vlkhILcxoIL6Bf+Pme7yWed9VVKTeOxvaXLm3EViblG
         bGCBElPhzYPNZVjOgapbV1/DZKl2AMMCaspfmKtCBYkTr7liVQ4IXthOr4B74aJynBUX
         0mIzuX+PD1vORUscdCQ8kS1BDpsmqzR8d5B0vqB5KEyhGRuDcTR+C0CId8saWMKP4v4l
         0GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUZSHlOC2NsvHH+oiYgXd/P9aGC7hBdS8UD65AtoMp4=;
        b=Mh3SMp5+SKlkfdRG04VeRLZzj+zqSfKsOmxNioV9qrErr5jNOUuLzfVNQ8gWemu/q6
         b2ZJVpuGiAfu/wzjbb0MkOyy5NWmHM9GNqqs3VnMmwGmUkPlAoNN7t5GxiFpIVuJ92uS
         cEDV5cW9KASgctPQWf9iXI+l7q5hU10RTaWuhoBGtAAKHeNDDq3OY+I86KBxVGrnPE+G
         RojoQvNGDTYYijpJruSjHWjZcuhOnnrNbGC3U8K1f9LoMBnH/+qZbyCn+yC6ACtrmj2U
         h8uWJD1wtAkm9Rf2NCgIRr8WwdhajCFTKnXEuBq27vi7xYPwwGL870jXdNTowOcFd5w9
         ShMQ==
X-Gm-Message-State: APjAAAVH0WtRWPfEo8Md+GH4QZmQsB4mR43hjZhgqQEnFNtrwNYHRHSq
        puf2KY4aoYxedrDe2uefcjEvm0iAinOSrzPNEc1T0g==
X-Google-Smtp-Source: APXvYqzK9w7NfgMq23mlEeHWtRc1vd+SdbVRqgKv0YbwMlIYSzawLj8RuR4WbpJLpxKS9HshxfPzK8im8DJXEMjL6UY=
X-Received: by 2002:a2e:85d4:: with SMTP id h20mr6120835ljj.142.1564568783805;
 Wed, 31 Jul 2019 03:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org> <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
In-Reply-To: <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 31 Jul 2019 15:56:12 +0530
Message-ID: <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, dhowells@redhat.com,
        jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Janne,

On Wed, 31 Jul 2019 at 12:41, Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> Hi,
>
> Interesting, I wrote something similar and posted it to the lists a while back:
> https://github.com/jkrh/linux/commit/d77ea03afedcb5fd42234cd834da8f8a0809f6a6
>
> Since there are no generic 'TEEs' available,

There is already a generic TEE interface driver available in kernel.
Have a look here: "Documentation/tee.txt".

> I implemented the same
> thing as a generic protocol translator. The shared memory binding for
> instance already assumes fair amount about the TEE and how that is
> physically present in the system. Besides, the help from usage of shm
> is pretty limited due to the size of the keydata.
>

If you look at patch #1 and #2, they add support to register kernel
memory buffer (keydata buffer in this case) with TEE to operate on. So
there isn't any limitation due to the size of the keydata.

-Sumit

>
> --
> Janne
>
>
>
>
> On Tue, Jul 30, 2019 at 3:26 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key. Also, this is
> > an alternative in case platform doesn't possess a TPM device.
> >
> > This series also adds some TEE features like:
> >
> > Patch #1, #2 enables support for registered kernel shared memory with TEE.
> >
> > Patch #3 enables support for private kernel login method required for
> > cases like trusted keys where we don't wan't user-space to directly access
> > TEE service to retrieve trusted key contents.
> >
> > Rest of the patches from #4 to #6 adds support for TEE based trusted keys.
> >
> > This patch-set has been tested with OP-TEE based pseudo TA which can be
> > found here [1].
> >
> > Also, this patch-set is dependent on generic Trusted Keys framework
> > patch-set [2].
> >
> > [1] https://github.com/OP-TEE/optee_os/pull/3082
> > [2] https://lkml.org/lkml/2019/7/18/284
> >
> > Changes in v2:
> > 1. Add reviewed-by tags for patch #1 and #2.
> > 2. Incorporate comments from Jens for patch #3.
> > 3. Switch to use generic trusted keys framework.
> >
> > Sumit Garg (6):
> >   tee: optee: allow kernel pages to register as shm
> >   tee: enable support to register kernel memory
> >   tee: add private login method for kernel clients
> >   KEYS: trusted: Introduce TEE based Trusted Keys
> >   doc: keys: Document usage of TEE based Trusted Keys
> >   MAINTAINERS: Add entry for TEE based Trusted Keys
> >
> >  Documentation/security/keys/index.rst       |   1 +
> >  Documentation/security/keys/tee-trusted.rst |  93 +++++++++
> >  MAINTAINERS                                 |   9 +
> >  drivers/tee/optee/call.c                    |   7 +
> >  drivers/tee/tee_core.c                      |   6 +
> >  drivers/tee/tee_shm.c                       |  16 +-
> >  include/keys/trusted-type.h                 |   3 +
> >  include/keys/trusted_tee.h                  |  66 +++++++
> >  include/linux/tee_drv.h                     |   1 +
> >  include/uapi/linux/tee.h                    |   8 +
> >  security/keys/Kconfig                       |   3 +
> >  security/keys/trusted-keys/Makefile         |   3 +-
> >  security/keys/trusted-keys/trusted-tee.c    | 282 ++++++++++++++++++++++++++++
> >  security/keys/trusted-keys/trusted.c        |   3 +
> >  14 files changed, 498 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/security/keys/tee-trusted.rst
> >  create mode 100644 include/keys/trusted_tee.h
> >  create mode 100644 security/keys/trusted-keys/trusted-tee.c
> >
> > --
> > 2.7.4
> >
