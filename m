Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14FF492E8A
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 20:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348287AbiARTje (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 14:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244586AbiARTje (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 14:39:34 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34FFC061574
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 11:39:33 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id t66so225576qkb.4
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tLdog0n5L37y3MRWMAFNB4F/ux6HarIU0b+GSL5AL8I=;
        b=JxuUbd1edEtbcMjCPSHSeTD/CMYEQdKqj/JLXxnkn+Bkc6GbozsOmUxwYRcTFsY47V
         WslujJVSY9vZtdXObppzaJQ0XtxjM0/O6BcKQE/zLqUnX0H8LSFwCeWeCMv6fVoWagiZ
         UtOtlLdGXjCLwzJlFu1FXI8C5OfuzJPVSSbieu+2VLq4ZVapGXxYrJTLJFqeMIFy9d2Z
         k0/ON6VVV5+yE9VVVEWmaWQlbwRu5BN60dy3Gg3kukxXeKDIhZdFxFaEc4FoJa1LtbHS
         Uv158qvrSco6aI/Rx+lCeqczh5qvcETHy05zvS+uAImu/AEx1laINzofgC3XGJBKWFzn
         RXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tLdog0n5L37y3MRWMAFNB4F/ux6HarIU0b+GSL5AL8I=;
        b=ftysk1ZBnPoZ1XnOtenQyinvzvlUUPvS6/qP0O1+rsqde4eDxh/GjuRmCnOGvFkN7r
         a8Y6u0nBmrdGlU1xiwSdR43EMkDILLy9N1yoKkCut8RdxIz1M2boZCHJ7l5Q+DB8Mszc
         e7U602QEmENkS1C1gYJMB2VOB+zZJL7sRv0lW3tdvYIse5Sq1H58nX5KiI3p32juemIC
         hpQ7/7LBFoosV2p3bIHw3pYLq+1gmNdYeOM3+G+NfoBvKojh2xA+EctRFJRHOVVl6dFW
         kbo4uIXb5J5xig8iwinPv6WTf1FGoJwUk+wMrf11hSwCOUaX5X6SuLlKMzZVcU1PpjCr
         HD/g==
X-Gm-Message-State: AOAM531XoEWFur2fx8AnEv4slhUEHMi86b0Dqmu197yrXCNsiWRWjKH7
        IC0Npzo3qVvc+dyIeJfy1vF8TQ==
X-Google-Smtp-Source: ABdhPJyv+GW0Uxig4OgnmrE0B7ffqMZTGZmT4aK6Hb5mU/4+tpZB5vTRrUzdANLkG2L924vH1W5P2A==
X-Received: by 2002:a37:de09:: with SMTP id h9mr18417793qkj.764.1642534772953;
        Tue, 18 Jan 2022 11:39:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a19sm431977qtx.7.2022.01.18.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:39:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9uKJ-0012sn-OS; Tue, 18 Jan 2022 15:39:31 -0400
Date:   Tue, 18 Jan 2022 15:39:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tpm: vtpm_proxy: Double-check to avoid buffer overflow
Message-ID: <20220118193931.GH8034@ziepe.ca>
References: <20220118183650.3386989-1-keescook@chromium.org>
 <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 18, 2022 at 08:32:43PM +0100, Jann Horn wrote:
> On Tue, Jan 18, 2022 at 7:37 PM Kees Cook <keescook@chromium.org> wrote:
> > When building with -Warray-bounds, this warning was emitted:
> >
> > In function 'memset',
> >     inlined from 'vtpm_proxy_fops_read' at drivers/char/tpm/tpm_vtpm_proxy.c:102:2:
> > ./include/linux/fortify-string.h:43:33: warning: '__builtin_memset' pointer overflow between offset 164 and size [2147483648, 4294967295]
> > [-Warray-bounds]
> >    43 | #define __underlying_memset     __builtin_memset
> >       |                                 ^
> 
> Can you explain what that compiler warning actually means, and which
> compiler it is from? Is this from a 32-bit or a 64-bit architecture?
> 
> It sounds like the compiler (GCC?) is hallucinating a codepath on
> which "len" is guaranteed to be >=2147483648, right? Why is it doing
> that? Is this some kinda side effect from the fortify code?

I agree, this looks bogus, or at least the commit message neeeds alot
more explaining.

static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)

        if (count > sizeof(proxy_dev->buffer))
            [...]
        proxy_dev->req_len = count;

Not clear how req_len can be larger than sizeof(buffer)?

Jason
