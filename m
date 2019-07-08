Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C505162637
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 18:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbfGHQbq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 12:31:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41763 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbfGHQbq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 12:31:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so11372262lfa.8
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jul 2019 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3muSErcKEFndhXfaKY3ATCVtuVvwHasHWrKAnKptt3A=;
        b=jy8Ff5Nekqo/UDsSM6LPdZ1/vxXRxHPPtCQNmrMM9JBSzKLh/D5A49NUn+QH8yxpsN
         ZcneME9bQ5PEkkfjrJ5FFDXn51FOriVckEKMGfCX2C3b3tapU4Zog43RMlaoakymFFVr
         8v2hEmD0TJZAZo2mtG7DNytqbW2S69YhcO4m+up5YxpC1iCRYbyIQ5rNjx0uOSmoxkvX
         JAn9KqrTnU2fCfxIxP3Js5Muakzs0ucaDQ+dNOqm7KGl0mMoAvZd8PteWG2J87NJ6y5T
         ApLhbzQONg2+flpPM4Evj/KZ0VrvDrl48NOSfNPbN7psuTAsrlP8nOA5fMCMQtkl1YMH
         J2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3muSErcKEFndhXfaKY3ATCVtuVvwHasHWrKAnKptt3A=;
        b=koat+bZQXA3p/80tS3U6d0K6eiqGkKhnb+I2rbPZt+37Bs/XprJboGIGkrS92rQv13
         J7JtyA3zwExcJ72UCLcP6BadlxU6qhNxjONojmwHpYsTsScOkzCka52EHFuVmnlZ7uu/
         m+Sdgg7AFv9SmGucL/pM6FFGifx/FM60D03wxjei2NR73qEgyej09UEZ+sVavzZ2MnUE
         h6OHzvdrYc1QfSfMhCNRQsvx3e1zUqaU05ApYOO7jYoOPKn36HSCpxL8kW8cQQLV/A8e
         ts8gt4TmSnMUyIR6WC/IraEoXEMWC3xKAI80e/CA4E16/I8BmENd0qZYXY8FjSnBbN+O
         N0Ew==
X-Gm-Message-State: APjAAAVsvceQJWJAhK63BfsEdnz4PgdCSSEmSBMOOMhVppid3amddgsH
        f/WkZjZMOC/7o8gO/cDkiZ3lKQ==
X-Google-Smtp-Source: APXvYqxUVvYjuVf39gxQ380dX6pWA86hhvJUjir+HrNiY0cZ5linR0Mbx8/ENcW/g4VOsocx8t9j7Q==
X-Received: by 2002:a19:5f46:: with SMTP id a6mr9474420lfj.142.1562603504069;
        Mon, 08 Jul 2019 09:31:44 -0700 (PDT)
Received: from jax (h-84-105.A175.priv.bahnhof.se. [79.136.84.105])
        by smtp.gmail.com with ESMTPSA id y5sm3724894ljj.5.2019.07.08.09.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 09:31:43 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:31:41 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
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
Subject: Re: [RFC 0/7] Introduce TEE based Trusted Keys support
Message-ID: <20190708163140.GB28253@jax>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYPn3HB6BRocKmKTR+ZPE=Fav5w1TUdRgmLp-NkYobp3rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYPn3HB6BRocKmKTR+ZPE=Fav5w1TUdRgmLp-NkYobp3rw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sumit,

On Mon, Jul 08, 2019 at 06:11:39PM +0530, Sumit Garg wrote:
> Hi Jens,
> 
> On Thu, 13 Jun 2019 at 16:01, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key. Also, this is
> > an alternative in case platform doesn't possess a TPM device.
> >
> > This series also adds some TEE features like:
> >
> > Patch #1, #2 enables support for registered kernel shared memory with TEE.
> >
> 
> Would you like to pick up Patch #1, #2 separately? I think both these
> patches add independent functionality and also got reviewed-by tags
> too.

I think it makes more sense to keep them together in the same patch
series or could end up with dependencies between trees.

If you don't think dependencies will be an issue then I don't mind
picking them up, in that case they'd likely sit in an arm-soc branch
until next merge window. However, I think that #3 (support for private
kernel login method) should be included too and that one isn't ready
yet.

Thanks,
Jens

> 
> 
> -Sumit
> 
> > Patch #3 enables support for private kernel login method required for
> > cases like trusted keys where we don't wan't user-space to directly access
> > TEE service to retrieve trusted key contents.
> >
> > Rest of the patches from #4 to #7 adds support for TEE based trusted keys.
> >
> > This patch-set has been tested with OP-TEE based pseudo TA which can be
> > found here [1].
> >
> > Looking forward to your valuable feedback/suggestions.
> >
> > [1] https://github.com/OP-TEE/optee_os/pull/3082
> >
> > Sumit Garg (7):
> >   tee: optee: allow kernel pages to register as shm
> >   tee: enable support to register kernel memory
> >   tee: add private login method for kernel clients
> >   KEYS: trusted: Introduce TEE based Trusted Keys
> >   KEYS: encrypted: Allow TEE based trusted master keys
> >   doc: keys: Document usage of TEE based Trusted Keys
> >   MAINTAINERS: Add entry for TEE based Trusted Keys
> >
> >  Documentation/security/keys/tee-trusted.rst      |  93 +++++
> >  MAINTAINERS                                      |   9 +
> >  drivers/tee/optee/call.c                         |   7 +
> >  drivers/tee/tee_core.c                           |   6 +
> >  drivers/tee/tee_shm.c                            |  16 +-
> >  include/keys/tee_trusted.h                       |  84 ++++
> >  include/keys/trusted-type.h                      |   1 +
> >  include/linux/tee_drv.h                          |   1 +
> >  include/uapi/linux/tee.h                         |   2 +
> >  security/keys/Kconfig                            |   3 +
> >  security/keys/Makefile                           |   3 +
> >  security/keys/encrypted-keys/masterkey_trusted.c |  10 +-
> >  security/keys/tee_trusted.c                      | 506 +++++++++++++++++++++++
> >  13 files changed, 737 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/security/keys/tee-trusted.rst
> >  create mode 100644 include/keys/tee_trusted.h
> >  create mode 100644 security/keys/tee_trusted.c
> >
> > --
> > 2.7.4
> >
