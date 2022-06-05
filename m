Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6942553DED3
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jun 2022 00:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbiFEW4Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Jun 2022 18:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiFEW4P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Jun 2022 18:56:15 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D154EDD8;
        Sun,  5 Jun 2022 15:56:13 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id m82so17575047oif.13;
        Sun, 05 Jun 2022 15:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UMKvzwbSRd/rxKXUR0P8o5zGehpsLdw9MafSGqZvJfc=;
        b=jnbpGnYwx3ZwtZJSuO8kr2KPQxRGZd6UOhaOXSZu8rnHaupM3rWnCpn1Fwht8D4sZ+
         lDXbdZURQ24PsI0IjxoBlLiHIP49atVLGR25MsiAjUqfD3K9MkiQivu4RCKZmnUBG+OP
         QVPU7G5iQ5jlF7032+EoEAAwv6QVRX28Ixs+OgOlQDCppqbs2BjqBw3VH+81a0W5eOs7
         0ucrgkTcKKcRY7+p5z6Fp896JtDnvR9eRXpwoYSY2htU5vspCk/cY5wuJ3lzjmWRoGJg
         VDWjfJATBlJ4ngOa6cBmwGIF306Sa2rIeKyLRtxR/J5nwmApJ46tNXNT7P+FkOYqPVl/
         Zb7w==
X-Gm-Message-State: AOAM531Q2rra1t8NRDdcPHYSqDRREzkMb7bILjujFUH0oeYdGBv0kwJ9
        xcQB3/GIVI4/yh9dDhI9yg==
X-Google-Smtp-Source: ABdhPJzIJCQ60tCHqJkUEoNcacGJSr/mA7PifTVKaaxmt4fCRG0dXXuznS0bPqDG5Fo/G+UqVWVb0w==
X-Received: by 2002:a05:6808:140f:b0:32b:ce0f:2002 with SMTP id w15-20020a056808140f00b0032bce0f2002mr25942550oiv.288.1654469772993;
        Sun, 05 Jun 2022 15:56:12 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id l14-20020a056870d3ce00b000f333ac991fsm6038058oag.27.2022.06.05.15.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:56:12 -0700 (PDT)
Received: (nullmailer pid 3683501 invoked by uid 1000);
        Sun, 05 Jun 2022 22:56:10 -0000
Date:   Sun, 5 Jun 2022 17:56:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: trivial-devices: Add two I2C TPM
 devices
Message-ID: <20220605225610.GA3682221-robh@kernel.org>
References: <20220603143532.8202-1-Alexander.Steffen@infineon.com>
 <20220603143532.8202-2-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603143532.8202-2-Alexander.Steffen@infineon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 03, 2022 at 04:35:30PM +0200, Alexander Steffen wrote:
> Both are supported by the upcoming tpm_tis_i2c driver.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Change-Id: I4750e39274038715d568d711cde1dc3d8595ba1b
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6aafa71806a3..92aae2a805f7 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -139,6 +139,8 @@ properties:
>            - infineon,slb9635tt
>              # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
>            - infineon,slb9645tt
> +            # Infineon SLB9673 I2C TPM 2.0
> +          - infineon,slb9673
>              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>            - infineon,tlv493d-a1b6
>              # Infineon Multi-phase Digital VR Controller xdpe11280
> @@ -333,6 +335,8 @@ properties:
>            - st,24c256
>              # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
>            - taos,tsl2550
> +            # TCG TIS-compliant TPM with I2C interface
> +          - tcg,tpm-tis-i2c

Again, not a trivial device.

>              # Temperature Monitoring and Fan Control
>            - ti,amc6821
>              # Temperature and humidity sensor with i2c interface
> -- 
> 2.25.1
> 
> 
