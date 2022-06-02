Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E558D53BA15
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jun 2022 15:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiFBNsz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jun 2022 09:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiFBNsx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jun 2022 09:48:53 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B05F59E;
        Thu,  2 Jun 2022 06:48:50 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-f2cbceefb8so6761831fac.11;
        Thu, 02 Jun 2022 06:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZLsZQGwsALXGpwwgGurYj2bunkoe3IvjuaCpAsGQqs4=;
        b=HTe3YuHHkCtxWIakuZcKtzI+RhTjyni3GnKA3R7AyvjdbxFhYq14eVdAiGO957JvfU
         X5Rd/esaw91RhYCZsMsCj0ChnppAIumO+aEg8xWMF5ItG+X0+9KDSxutA2uvW0JPKcA5
         X0tT+fuMaCQU9B+Tj+zkC75eD0HhKz1CM35ON/WJYMYRck1TQwnBJsU64zyd2nKY/o3y
         eUcIDEJqtHoIlj4HnQP3TqNAaR8v3nBPlWKSjuCzuGO2F7S1EVWS01ZiOyNPLvWW0D4h
         tAyRb67hKOfxYRNd8FFhXMlquA5qAdZka+PiY7UjxQFcZW+778VDf9KOLBL5hhFaZAV4
         5cnw==
X-Gm-Message-State: AOAM533sUOfNwtU3cp/EP5WZC3EDfv1qnnYI9PffEmiRGZPiMH2ItKA9
        4KQ2DUBEo1HgG/A6H7nQ4g==
X-Google-Smtp-Source: ABdhPJzhAExoUF+3ohnZR4GGm+CAP7YlqdUPcNsT0zhxsWf8ebeYkbeyF4YzJF+4BWW7gB+1NtJAfA==
X-Received: by 2002:a05:6870:61cd:b0:e9:8de7:9c51 with SMTP id b13-20020a05687061cd00b000e98de79c51mr2791058oah.50.1654177729893;
        Thu, 02 Jun 2022 06:48:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bh35-20020a056808182300b00325cda1ff95sm2566851oib.20.2022.06.02.06.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:48:49 -0700 (PDT)
Received: (nullmailer pid 2184180 invoked by uid 1000);
        Thu, 02 Jun 2022 13:48:48 -0000
Date:   Thu, 2 Jun 2022 08:48:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: trivial-devices: Add two I2C TPM
 devices
Message-ID: <20220602134848.GA2178372-robh@kernel.org>
References: <20220525165849.7789-1-Alexander.Steffen@infineon.com>
 <20220525165849.7789-2-Alexander.Steffen@infineon.com>
 <8c4941a1-e047-1352-32ba-8595cd0143f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c4941a1-e047-1352-32ba-8595cd0143f0@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 26, 2022 at 02:29:56PM +0200, Krzysztof Kozlowski wrote:
> On 25/05/2022 18:58, Alexander Steffen wrote:
> > Both are supported by the upcoming tpm_tis_i2c driver.
> > 
> > Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index 550a2e5c9e05..dc52822331dd 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -135,6 +135,8 @@ properties:
> >            - infineon,slb9635tt
> >              # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> >            - infineon,slb9645tt
> > +            # Infineon SLB9673 I2C TPM 2.0
> > +          - infineon,slb9673
> >              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
> >            - infineon,tlv493d-a1b6
> >              # Infineon Multi-phase Digital VR Controller xdpe11280
> > @@ -323,6 +325,8 @@ properties:
> >            - st,24c256
> >              # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> >            - taos,tsl2550
> > +            # TCG TIS-compliant TPM with I2C interface
> > +          - tcg,tpm_tis-i2c
> 
> One flavor uses tpm-tis, another tpm_tis... I guess it is too late to
> make it consistent, but let's stick to the one more reasonable, so:
> "tpm-tis-i2c".

Neither should be used except perhaps as a fallback. Does 'TCG 
TIS-compliant TPM' encompass every property of a device? Power supplies, 
resets, interrupts, quirks, etc.?

Rob
