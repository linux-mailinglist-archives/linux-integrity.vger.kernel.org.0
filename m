Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45895F4DAF
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Oct 2022 04:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJEC23 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 22:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJEC22 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 22:28:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4F7170B;
        Tue,  4 Oct 2022 19:28:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso288665wmq.2;
        Tue, 04 Oct 2022 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NWFS/JTo3j6cmgEDLzBh1Aucit9LLMrOrbqTf1du6A8=;
        b=kQRsHNX6uyvYJTzdOn8wnH4DC8E0NqDwyFznYUr5PZxHya0fME0DCet3e0uRcJ+x3Z
         aCSxARWHbzNCDjVb9TSqxLWYGC3LIvOhXvsq7k4eqnMdMizDU/CtV5YoIzzXzkDQxoef
         rpVA20E5CbQNBamPfLudQb84x6lU8cn773ZiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NWFS/JTo3j6cmgEDLzBh1Aucit9LLMrOrbqTf1du6A8=;
        b=y9G4zq59GZtmchsT6KfPH1hHE4+B6dWADbhfomA4lE7Fk6eQpgUoBMkgjZMGQFBv+T
         0lHe5hOXATc1+/vMhEzMXjWAMshT1UCUASaSBDdEGhVHNhUIJiIWHCJv2+/mOuwlMAdx
         hNoGYBT8AsLLa0PI0hz2qE6XHnIlXENzqPaxnD1ZQq8SlbuKuq++7fcef7CYBC3T/eBf
         /BYhfUkGb8irehg4ps0JsYhhQ1N+5LA4N7tPSEh/1fB9Q+wHCi8eUjXepAfOXWEAMk88
         w3fgt2AYxpxRw0yG+pllq9ahApY79Ab8tQPw9o8muxf9c+z7XFPyDEzr0Ep2ofKo7Ezr
         HY4A==
X-Gm-Message-State: ACrzQf1eVDRAnnYZw6M6W0LCe+/VtlfcwqktwqmV3+lx1dmyL/YWdNwy
        ZS0oDeP8dkVTNRYxc/vczf6097DPoqA7Hv/THoy/Dmrs
X-Google-Smtp-Source: AMsMyM5vU9C5sAu6dSajn9ys61RzOD1MB+Yfu7zKZWsel9VFTBylk/kyWqQmb6Yc30NRvrvOEdr3u868Ng0u60dK1x8=
X-Received: by 2002:a05:600c:1906:b0:3b4:c979:e639 with SMTP id
 j6-20020a05600c190600b003b4c979e639mr1681781wmq.10.1664936905460; Tue, 04 Oct
 2022 19:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220928043957.2636877-1-joel@jms.id.au> <20220928043957.2636877-4-joel@jms.id.au>
 <20220930144438.GA287295-robh@kernel.org>
In-Reply-To: <20220930144438.GA287295-robh@kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 5 Oct 2022 02:28:13 +0000
Message-ID: <CACPK8Xf3CBf=TPBb=KXCNSmCJmYC2T_=W0=dLzpYCxj0qrxkPw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: tis-i2c: Add more compatible strings
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 30 Sept 2022 at 14:44, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 28, 2022 at 02:09:57PM +0930, Joel Stanley wrote:
> > The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> >
> > https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
> >
> > Add a compatible string for it, and the generic compatible.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> > index 0692510dfcab..4af27b7ec5b1 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c.c
> > @@ -368,6 +368,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> >  #ifdef CONFIG_OF
> >  static const struct of_device_id of_tis_i2c_match[] = {
> >       { .compatible = "infineon,slb9673", },
> > +     { .compatible = "nuvoton,npct75x", },
> > +     { .compatible = "tcg,tpm-tis-i2c", },
>
> If there is not currently any distinction that the kernel makes, you
> only need to add "tcg,tpm-tis-i2c".

There are device trees that just have one or the other, so it makes
sense to list both.

>
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> > --
> > 2.35.1
> >
> >
