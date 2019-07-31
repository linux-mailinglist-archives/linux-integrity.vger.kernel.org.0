Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8ED7BE43
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2019 12:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfGaKV5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Jul 2019 06:21:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45208 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfGaKV4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Jul 2019 06:21:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so64975624lje.12;
        Wed, 31 Jul 2019 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTjYYJ5w8JGFiCV+fisqsMFDW4bJ2CE5EvIC9ToOEts=;
        b=kQgLwbxGzgHNMyuTAkxNFzi2aRlyhVO9V24U6HoPMgsf73FeO4NNRkfbI9sA1/VeCi
         L+vRPE0C3z1l0UJxCQYGpmkdJfvC3jC+J18p407ueMt6c80hF66r4PMCidNSlV2pZVYh
         hJj99MZl7trjLsU28smtLW55AiDdl4TlXelTS2YuejV4BUW5JhJjShGEm9mKW27TPeLa
         QRy6yGgoBgplQLbP/GvoGKhajbKfSwsOTs1uvbYFnYX4n44Oji+j0MrTdbv21yJP43Hk
         wtu9Mqomps2+RbIuua4UWVObpyjn07ZnC5xX0mzc18psE6MD0ZT5nvbZ4EMRfD/pR7+n
         JDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTjYYJ5w8JGFiCV+fisqsMFDW4bJ2CE5EvIC9ToOEts=;
        b=rV6YVU6zl1m6pEuFume43G0K2Svgx0KPsUdevHvbSkcLcl8o1p585QyNbENSKw1TdS
         4VARvT3Bvie+WdhVM38oCRxIma8dfon13e2MlxET9kCSIAEo3W2IszAvMXLrxOqEzGOf
         OKVAZj7e/FTK973SYlb0B+JxyJ0cw57wchGh+W402llrNKvFVRRb7xY9MlffRJ88Xgvs
         sSMUqEW3zC6hRkjVqoTwlZI7schTT8uoN9OeVa/mz2EO3OQr7WW9EyOooPGN5ySimrp7
         mPpIsEASOjVfRtM9L/5In5OFtghehxdDyGtVLmeg89ZxOGwF6A75uAw9A4cMlQk3Xb94
         2HmQ==
X-Gm-Message-State: APjAAAUuUi9olv+nhVz0AvJkq46c1y5IwN4qWMzI6HX08vbQcRCTPqR3
        P43tw22FRHiPlYNUqoM0204G/xEftLYp+uZPUjI=
X-Google-Smtp-Source: APXvYqx/9SP/mdIA/VveogDuSBQVAooZmV3FTt0pb7Z8M4ZHoddgQssQP7MNd2vdOvgkZ7HmpBbZgYsmAHs3KDhjdKE=
X-Received: by 2002:a2e:9857:: with SMTP id e23mr62898681ljj.217.1564568513273;
 Wed, 31 Jul 2019 03:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org> <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
In-Reply-To: <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 31 Jul 2019 13:21:41 +0300
Message-ID: <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, jens.wiklander@linaro.org,
        corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

To clarify a bit further - my thought was to support any type of trust
source. Remote, local or both. Just having one particular type of
locally bound 'TEE' sounded very limited, especially when nothing from
the TEE execution side is really needed for supporting the kernel
crypto. What you really need is the seal/unseal transaction going
somewhere and where that somewhere is does not matter much. With the
user mode helper in between anyone can easily add their own thing in
there.


--
Janne

On Wed, Jul 31, 2019 at 10:11 AM Janne Karhunen
<janne.karhunen@gmail.com> wrote:
>
> Hi,
>
> Interesting, I wrote something similar and posted it to the lists a while back:
> https://github.com/jkrh/linux/commit/d77ea03afedcb5fd42234cd834da8f8a0809f6a6
>
> Since there are no generic 'TEEs' available, I implemented the same
> thing as a generic protocol translator. The shared memory binding for
> instance already assumes fair amount about the TEE and how that is
> physically present in the system. Besides, the help from usage of shm
> is pretty limited due to the size of the keydata.
>
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
