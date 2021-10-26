Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1E43B67C
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhJZQKs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Oct 2021 12:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234225AbhJZQKq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Oct 2021 12:10:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 785186108B;
        Tue, 26 Oct 2021 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635264502;
        bh=I9GJJIJ1ciVkNplFB72u5b2bVUSDmxGPxemQZuOwPfQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kMbVo3kamYq1rArekSB0qLarlRl5J8pWp326TEGhbWDPRk+JpqeP/0hnb94AMUtD9
         8NevxyVmtsgsdfZKzigqTQoiOgMQrQTXuqobBNpUVF1vPULfvgS5Z45wH0UtUeVmel
         0FdBL23rXE2Z2WJ8M5SGl1i0zaJmlpBQRZO20/9go6MX47mSvVjr0BgSW8lnHnr7+W
         pL1qVOxXPA4yJ/kJeZsgvMsW8+UbYeDgU/cWwF/Nj+vLOvnMBbWMxYwWUsUq6hih39
         FohZnAbzpakkBUaOcYieESjA4scj+s8sOYZ9YG4u1BHxWEhePXH/aWOSSDW4c4XOMR
         G0EdeoJwdNi7A==
Received: by mail-oi1-f175.google.com with SMTP id o83so21317425oif.4;
        Tue, 26 Oct 2021 09:08:22 -0700 (PDT)
X-Gm-Message-State: AOAM532myRnhy41hUaP0BNuWhKhmHGZ/fB24mHNsljoAFSeKoI2v0DUq
        IY7auFV4A/Fjvl2n6TsHpJ/bUQ6SMrdC28Baej8=
X-Google-Smtp-Source: ABdhPJyKuzF2435HA4gQPovRQk2F3CCNzD/7cMKyLJZAXO0i4XInSWHhpsWgmvIwbw0BF3MFRGD5FXz1Eu294qSF3yI=
X-Received: by 2002:a54:448e:: with SMTP id v14mr3036920oiv.174.1635264501675;
 Tue, 26 Oct 2021 09:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211026075626.61975-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20211026075626.61975-1-tianjia.zhang@linux.alibaba.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 26 Oct 2021 18:08:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGiC-LCc-50cfddJxJ-mezO=fcLqhJHiK110CgxKusy9w@mail.gmail.com>
Message-ID: <CAMj1kXGiC-LCc-50cfddJxJ-mezO=fcLqhJHiK110CgxKusy9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] use SM3 instead of SM3_256
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        keyrings@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 26 Oct 2021 at 09:56, Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
> SM3 always produces a 256-bit hash value and there are no plans for
> other length development, so there is no ambiguity in the name of sm3.
>

What is the point of these changes? Having '256' in the identifiers is
merely redundant and not factually incorrect, so why can't we just
leave these as they are?




> ---
> v3 changes:
>  - The fix of document trusted-encrypted.rst is put in patch 2
>
> v2 changes:
>  - an additional macro with the same value is defined for uapi instead
>    of renaming directly
>
> Tianjia Zhang (2):
>   crypto: use SM3 instead of SM3_256
>   tpm: use SM3 instead of SM3_256
>
>  Documentation/security/keys/trusted-encrypted.rst | 2 +-
>  crypto/hash_info.c                                | 4 ++--
>  drivers/char/tpm/tpm-sysfs.c                      | 4 ++--
>  drivers/char/tpm/tpm2-cmd.c                       | 2 +-
>  include/crypto/hash_info.h                        | 2 +-
>  include/linux/tpm.h                               | 2 +-
>  include/uapi/linux/hash_info.h                    | 3 ++-
>  security/keys/trusted-keys/trusted_tpm2.c         | 2 +-
>  8 files changed, 11 insertions(+), 10 deletions(-)
>
> --
> 2.19.1.3.ge56e4f7
>
