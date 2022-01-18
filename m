Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65AA492E7E
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 20:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbiARTdN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 14:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiARTdN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 14:33:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD89EC06161C
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 11:33:12 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x22so74939492lfd.10
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 11:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bBy3CYfuqFnCx19HkSiY69nlsVaIO8zSqvCrUbGJzY=;
        b=RjAQS+KyvgKkaoHdBY2N3PbAm/v/bKvuVFQNdVRXI7Kp3tlMojLprMh/stW/djIQh0
         0KV4Wa79IPFP0qCWrUtcEO5xJ+8faGi1s7dGhhI2SmUg77bhyLBTRrsYjOtx8UTi0nXn
         F3YBlrbedzBkw2Nyg2T2cnBzoyfhRbdfGya8luZjl+xej0SA9VD4XZ3Q0WhE6mim0k52
         gc/lTJBG1bNpyWhgxP3ucWqs3x26JW7F89dYKtzJ93mPVInp8VtPkd7v3oxun/wj4x68
         FwldQs1jy6Kgh6dl5Uhhsmz1MmGUu6uiWwvuvx0pxTF5ak/S3e2LWK6ZTL0WhPFkiz76
         F0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bBy3CYfuqFnCx19HkSiY69nlsVaIO8zSqvCrUbGJzY=;
        b=nFLUHtvMBy/DM+RCSwykm/59/hy6Jj2cHtAq+41GCXW58KudQ40/+OhpVWG+5OylZP
         s99bjTHVEhgPDDsEy7YXn0Fh1TRRZ36tm4+AIPvS+0gXF7bsbRVZ7PZek0OeLP60XXV8
         y/eW0Fly/DvmnjAANPMfDYFfCXvRqkZletKC5TxPMisuAAgKIYezxngmsrW8cmuKIrsl
         sUg/9CEKPxuW4aYe+aadtOQQszA+rq6h9mnJiGhIHw/3h5++0gxfZWN9aTadaCSX/BKP
         QKT5s8f0pLh7KNKTlbj0b5r6qwjP+BttqZN4CoD0PjWmHuxSlRbFMD6SBc4/T4KXt3ju
         bmkg==
X-Gm-Message-State: AOAM5318FW0puJNvw9GY4XHzO6rxmCGYm6wuPzMiTNRSDHHyCdh7AZLQ
        AlwAPv+heU4ZXPIBMkoaFDi+kPQs5Or0tP+SZlwYWQ==
X-Google-Smtp-Source: ABdhPJx/1UJf3FwrXqsd++NEyd+vbL+s17UyRGF3V/2G6UNi5FHvEJ4oqMuue0/l/pMgKjeZHcKeZClk+PFpp4wYCQ8=
X-Received: by 2002:a2e:964e:: with SMTP id z14mr14936557ljh.375.1642534390901;
 Tue, 18 Jan 2022 11:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20220118183650.3386989-1-keescook@chromium.org>
In-Reply-To: <20220118183650.3386989-1-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 18 Jan 2022 20:32:43 +0100
Message-ID: <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: vtpm_proxy: Double-check to avoid buffer overflow
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 18, 2022 at 7:37 PM Kees Cook <keescook@chromium.org> wrote:
> When building with -Warray-bounds, this warning was emitted:
>
> In function 'memset',
>     inlined from 'vtpm_proxy_fops_read' at drivers/char/tpm/tpm_vtpm_proxy.c:102:2:
> ./include/linux/fortify-string.h:43:33: warning: '__builtin_memset' pointer overflow between offset 164 and size [2147483648, 4294967295]
> [-Warray-bounds]
>    43 | #define __underlying_memset     __builtin_memset
>       |                                 ^

Can you explain what that compiler warning actually means, and which
compiler it is from? Is this from a 32-bit or a 64-bit architecture?

It sounds like the compiler (GCC?) is hallucinating a codepath on
which "len" is guaranteed to be >=2147483648, right? Why is it doing
that? Is this some kinda side effect from the fortify code?
