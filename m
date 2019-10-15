Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E4D7112
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2019 10:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfJOIca (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 04:32:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44948 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfJOIca (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 04:32:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so19259327ljj.11
        for <linux-integrity@vger.kernel.org>; Tue, 15 Oct 2019 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqc7TL4ZCr8iG1KRxAEVdDujqelnE0lYSvI39NYB58s=;
        b=ORou6M+VQm37RcWZSBf+3eRqxFtkcZeczsKeNWcAWPwbiqHzYP3Ur9KiB9UMEd3Lto
         EoEQpQ3RKxucy9m96KaqlT52jWOyIdtxMJg9nvXjEG0bWLtxNYS5vIyzfQQyBASKjoJO
         qupfVGIPm1FO80oJCZxaNFclo8qLzzM9dW8Sx96n3kT/eFuwFB9OceQV6omhjxyMkFGz
         a6Ufa4iTgdyC+zlKaESyzDnFop4NnLupEVuRofGYvRYCidXxRBamHowRUOIXXRndk+Hk
         Wc/siRy083KIQubV8OoCGsZK1dkvjTQ7eKGU+nF0pFCJblZJTUSG5AspIUsuQeE0fZgE
         UiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqc7TL4ZCr8iG1KRxAEVdDujqelnE0lYSvI39NYB58s=;
        b=kfjfG9HrJ+2G2gr5TsL6Zit34i7EQrwWLK7U//+nc4wikub7Nh0EdMzQde0KkXqThi
         s0F4Q3F1TphYhyqCB+Kh09ovHrtNcj4xlYoeOmxBJZmaoiFLJ7sF0FXU9MBTOyqRPCER
         FJPPQqM+Kt/f5MvsLjixWOoyhh5hMKydl4XqPShW9yhtP0sJsWb9DA97VDj6Wcwc61Z+
         mDrvNgL4N6Wu1U711DtjVwLcPE/gBQ4u1kLKfTFCYMIjlVysfv9rU97LbOMhNhWG7zap
         i2fVlHR/qUsb4knBcFpgrw5jEG84f5Po/bWNwho+LRPlBvf7++jvHdLnC1eAW/sfdDVd
         i00Q==
X-Gm-Message-State: APjAAAVGfxzsTbpFRkX63kqiUT1Bg+6VVd0cHdgJRPuCyEpz4GFwyLML
        /QgvI4c7/9pQ/p74bS/zhQpxhilMPcZC3pdZCGhgBg==
X-Google-Smtp-Source: APXvYqxazDgrooIQclEs7kygQ2crMsb2qqnTnpLdD1E5sie5oddglXjpLaPSJSrZAAYLQpj1tBFHnzGFpI/tNX842Mc=
X-Received: by 2002:a2e:1214:: with SMTP id t20mr21151298lje.191.1571128347374;
 Tue, 15 Oct 2019 01:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
 <20191011123757.GD3129@linux.intel.com> <20191011210517.qxjemugqczsvscu6@cantor>
 <20191014201604.GN15552@linux.intel.com>
In-Reply-To: <20191014201604.GN15552@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 15 Oct 2019 14:02:15 +0530
Message-ID: <CAFA6WYM1AfYfk1+eJeDJeaRddF7kQ8mi+-DKbcND1gkOzkF6=Q@mail.gmail.com>
Subject: Re: [Patch v7 0/4] Create and consolidate trusted keys subsystem
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 15 Oct 2019 at 01:46, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Oct 11, 2019 at 02:05:17PM -0700, Jerry Snitselaar wrote:
> > On Fri Oct 11 19, Jarkko Sakkinen wrote:
> > > On Mon, Oct 07, 2019 at 10:55:31AM +0530, Sumit Garg wrote:
> > > > This patch-set does restructuring of trusted keys code to create and
> > > > consolidate trusted keys subsystem.
> > > >
> > > > Also, patch #2 replaces tpm1_buf code used in security/keys/trusted.c and
> > > > crypto/asymmertic_keys/asym_tpm.c files to use the common tpm_buf code.
> > > >
> > > > Changes in v7:
> > > > 1. Rebased to top of tpmdd/master
> > > > 2. Patch #4: update tpm2 trusted keys code to use tpm_send() instead of
> > > >    tpm_transmit_cmd() which is an internal function.
> > > >
> > > > Changes in v6:
> > > > 1. Switch TPM asymmetric code also to use common tpm_buf code. These
> > > >    changes required patches #1 and #2 update, so I have dropped review
> > > >    tags from those patches.
> > > > 2. Incorporated miscellaneous comments from Jarkko.
> > > >
> > > > Changes in v5:
> > > > 1. Drop 5/5 patch as its more relavant along with TEE patch-set.
> > > > 2. Add Reviewed-by tag for patch #2.
> > > > 3. Fix build failure when "CONFIG_HEADER_TEST" and
> > > >    "CONFIG_KERNEL_HEADER_TEST" config options are enabled.
> > > > 4. Misc changes to rename files.
> > > >
> > > > Changes in v4:
> > > > 1. Separate patch for export of tpm_buf code to include/linux/tpm.h
> > > > 2. Change TPM1.x trusted keys code to use common tpm_buf
> > > > 3. Keep module name as trusted.ko only
> > > >
> > > > Changes in v3:
> > > >
> > > > Move TPM2 trusted keys code to trusted keys subsystem.
> > > >
> > > > Changes in v2:
> > > >
> > > > Split trusted keys abstraction patch for ease of review.
> > > >
> > > > Sumit Garg (4):
> > > >   tpm: Move tpm_buf code to include/linux/
> > > >   KEYS: Use common tpm_buf for trusted and asymmetric keys
> > > >   KEYS: trusted: Create trusted keys subsystem
> > > >   KEYS: trusted: Move TPM2 trusted keys code
> > > >
> > > >  crypto/asymmetric_keys/asym_tpm.c                  | 101 +++----
> > > >  drivers/char/tpm/tpm-interface.c                   |  56 ----
> > > >  drivers/char/tpm/tpm.h                             | 226 ---------------
> > > >  drivers/char/tpm/tpm2-cmd.c                        | 307 --------------------
> > > >  include/Kbuild                                     |   1 -
> > > >  include/keys/{trusted.h => trusted_tpm.h}          |  49 +---
> > > >  include/linux/tpm.h                                | 251 ++++++++++++++--
> > > >  security/keys/Makefile                             |   2 +-
> > > >  security/keys/trusted-keys/Makefile                |   8 +
> > > >  .../{trusted.c => trusted-keys/trusted_tpm1.c}     |  96 +++----
> > > >  security/keys/trusted-keys/trusted_tpm2.c          | 314 +++++++++++++++++++++
> > > >  11 files changed, 652 insertions(+), 759 deletions(-)
> > > >  rename include/keys/{trusted.h => trusted_tpm.h} (77%)
> > > >  create mode 100644 security/keys/trusted-keys/Makefile
> > > >  rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (94%)
> > > >  create mode 100644 security/keys/trusted-keys/trusted_tpm2.c
> > > >
> > > > --
> > > > 2.7.4
> > > >
> > >
> > > I fixed a merge conflict caused by James' commit. Already pushed.
> > > Compiling test kernel ATM i.e. tested-by's will follow later.
> > >
> > > /Jarkko
> >
> > Are you missing patch 4 on master?
>
> Already removed the patch set given the sparse issues.

The sparse issues weren't due to this patch-set but they already
existed in "security/keys/trusted.c" and this patch-set only did a
rename for that file. So I think we should have a separate patch to
fix sparse issues.

-Sumit

> Read this email
> after doing that. Thanks anyway for pointing that out.
>
> /Jarkko
