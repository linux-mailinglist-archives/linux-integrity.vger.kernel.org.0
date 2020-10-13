Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC1328CC03
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJMKxv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 06:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgJMKxu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 06:53:50 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C3C0613D6
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 03:53:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l2so21625016lfk.0
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 03:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3qSt/yVefPSRQYiEWS9diKrWOAd37+h5epZFLrelMw=;
        b=YCb/GMyA9TZ+1dfkpQLjYelV1j6wc9qgpJOffjV8Rvg2PN0QUCKn50OpBGUPidJn5y
         wOK0GAzzSZ207end9icoCQvF8u6zU23d4R4zb/Ci+kKWOVOmQVjZeNEpWtfIOITK/yb8
         fKvQSOK40GE9PjYdm/m2MZJu+VxJqS1QF8l2B8VyiW6deFUckcomnDQQzxKwn85vdnTk
         ITNWaiSkUka+WfnKtpgVW8ZaEb0lz+t6usNyV7oRDGEZCLQtnEoaVUocVDlxFNfZzKlR
         xLHxQzixocS/FnicsAkcSS+NqNFq4ZbEPedg0JEZLrlaKYzq2N4fbDctOzevd2FaLvWH
         CXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3qSt/yVefPSRQYiEWS9diKrWOAd37+h5epZFLrelMw=;
        b=WYS3L7OQNYqUVdFI/RZqFEfJAyL7D+DgKhF7cmCANfVfFA6AES8r7KClJeKUkbBwxr
         pPJRo3/cQf341kr0aF4eLjMk5ej0yHzeapvdS11rkirj/uTYJgR4fvuur/duffLVN11e
         CK3VrRpP5pt4pJvg34CXA0iZTlE4TbC2jsLWNiMKqX3Qo7/QVjAgm0BskRiisKw7yX0w
         dvZ7l5Yp5CKlACJ9zQA/g8eAytmptIKk7lmHkFS/5cGpFISLzdOFPc7fIUe8QSVUTkRW
         A/5bpgfeiUItNUEfC5DsYuRqnEYwnayAbjYqbcb3QOxm+OFkWiCcynLNhBJ4Z1IVMJqQ
         F1LA==
X-Gm-Message-State: AOAM530SA2T8L8Gg/Lpy7e3s3M+vqFdgKn5VRz3k/uQm7SkD3UPcth8I
        zW+2kqE8N7IYkgUGhquT81CSRNAvsZn6YLs7jwOmwQ==
X-Google-Smtp-Source: ABdhPJznIwhssCxBuKaeZ81md5C4ijmQvLK928GBtED3whxbGPg/asXNqWXz8Z+eIwiB7U9qyAAhvQd4c4W8n0+Ca9M=
X-Received: by 2002:ac2:50d0:: with SMTP id h16mr995095lfm.445.1602586427139;
 Tue, 13 Oct 2020 03:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-2-git-send-email-sumit.garg@linaro.org> <20201013014304.GC41176@linux.intel.com>
In-Reply-To: <20201013014304.GC41176@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Oct 2020 16:23:36 +0530
Message-ID: <CAFA6WYN1n_x1wUefXEf-4Y+bUZybNAMeD9cirvz4WQnK2E7djw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
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
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 13 Oct 2020 at 07:13, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Oct 07, 2020 at 03:37:45PM +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device as
> > an underlying implementation which makes it difficult for implementations
> > like Trusted Execution Environment (TEE) etc. to provide trusted keys
> > support in case platform doesn't posses a TPM device.
> >
> > Add a generic trusted keys framework where underlying implementations
> > can be easily plugged in. Create struct trusted_key_ops to achieve this,
> > which contains necessary functions of a backend.
> >
> > Also, add a module parameter in order to select a particular trust source
> > in case a platform support multiple trust sources.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> This is exactly kind of place where I think static_call() should be
> taken into use, which is a v5.10 feature [1]. For background and
> context, I'd read [2].

This looks like an interesting feature. But I am not sure about the
real benefits that it will provide in case of trusted keys. If we are
looking at it performance wise then I think the gain will be
negligible when compared with slow TPM communication interface (eg.
SPI, I2C) or when compared with context switching involved in TEE.

Also, it requires arch specific support too which currently seems to
be limited to x86 only.

>
> The other thing that I see that does not make much else than additional
> complexity, is trusted_tpm.ko. We can do with one trusted.ko.
>

Current implementation only builds a single trusted.ko module. There
isn't any trusted_tpm.ko.

-Sumit

> I'd also *guess* that the static_call() mechanism does not work accross
> module boundaries.
>
> [1] https://lore.kernel.org/lkml/20201012155542.GA3557765@gmail.com/
> [2] https://lwn.net/Articles/815908/
>
> /Jarkko
