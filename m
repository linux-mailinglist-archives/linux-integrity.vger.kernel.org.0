Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65927AFD07
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Sep 2023 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjI0Hsu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Sep 2023 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjI0Hsm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2023 03:48:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C901E1AB
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2023 00:48:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-532c3b4b55eso12495325a12.0
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2023 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695800918; x=1696405718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DDN8CaUWyyaMzzng4BvgyrNM8oRA8ZCWD7UDepNEACQ=;
        b=QEOMM4QIOAey5MCgE0qCsWB7p1P/qc5op7NC7K8Seha1miqErZpFNH1of123vYg7Ng
         Gyk+OOe0fcweliGoqCHfb7xvvjJNYU5Gz3U+oPMLbfrlW17OzlQ2INzNgF5XAeXQxUQQ
         YgIIKtVs71dao4w8p9FmGDDqRdOzN+qIV6HL2Sk9mOCu6HNGH7lmyUiy/R4CxkG7ef9I
         qwe5DWVZGgrsqAU8GaNzeSSCEOxgCwNpr36lB3n2k5zb6StK+BGm0CedM6FZV4aYgVZF
         wrzT5yOAN9M3HEiGvibBvzjYYFAMWDwS2wnU0oTZSD9aSZxb/3kdvTbSDRkplbDlMQIk
         Ao1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695800918; x=1696405718;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDN8CaUWyyaMzzng4BvgyrNM8oRA8ZCWD7UDepNEACQ=;
        b=r4j+IgpJFpidUy2ThJ54bW3/4+GVEnx8VF2akb+zd827RRcbwtIG5c4gjjvGrfNkEf
         SDcQmk4bShF3a8Sp0R+A80qRUiZG2YXtnOH637UY3RoB1MZVigC+LMw0yqHHGVRUNhTX
         hQVj85IGL1e87yYzV5UD4zUGmQOkYxTeiA/W9TiYt+VZYOabUUZ6GPSZzqR70RB7rt+m
         gtf6W6SnNgquzmFbo+MsKNTNt8UPMTCK6yn4H0oo5yvgsLEKq5nHeoLpUeEVvTUISWFq
         1RlP17Xi2iO8OxT3tnbXXxI6a2DkB4uma5X6hpZf1uXhd4Nqt6u6A69Jjyg3f+3qXI5b
         1Riw==
X-Gm-Message-State: AOJu0Ywbdx8YCHVhuEUh8sO2wtQnA9Fx8IE0lrx+uG4kh99FLqeWn0za
        vsd/vL77nkjUhgVHQrxcqFKgaw==
X-Google-Smtp-Source: AGHT+IF/IKoQsRHW2/VOL3l42j/c3hARsN9XDT0ZghxoPnXf39fZNhCOMv8E5Mh5DvSOiC3lAUMu6Q==
X-Received: by 2002:a17:906:291:b0:9ae:5ba3:9d8f with SMTP id 17-20020a170906029100b009ae5ba39d8fmr960815ejf.17.1695800918270;
        Wed, 27 Sep 2023 00:48:38 -0700 (PDT)
Received: from [192.168.1.160] (host-87-4-82-94.retail.telecomitalia.it. [87.4.82.94])
        by smtp.gmail.com with ESMTPSA id v5-20020a1709064e8500b00993470682e5sm8792520eju.32.2023.09.27.00.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 00:48:37 -0700 (PDT)
Message-ID: <fe7a5807-92ad-4669-ab76-be24d20832f5@linaro.org>
Date:   Wed, 27 Sep 2023 09:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add Infineon SLB9670 TPM reset
 driver
To:     Lukas Wunner <lukas@wunner.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 26/09/2023 21:09, Lukas Wunner wrote:
> A new reset driver is about to be added to perform the reset sequence of
> the Infineon SLB9670 Trusted Platform Module.
> 
> Document its device tree bindings.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  .../bindings/reset/infineon,slb9670-reset.yaml     | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml b/Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml
> new file mode 100644
> index 00000000..b1e23d47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/infineon,slb9670-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon SLB9670 TPM Reset Driver

Sorry, bindings are for hardware, not for drivers.

> +
> +maintainers:
> +  - Lukas Wunner <lukas@wunner.de>
> +
> +description: |
> +  The Infineon SLB9670 Trusted Platform Module requires a specific reset
> +  sequence on its RST# pin which is documented in sections 5.4 and 5.5 of
> +  the datasheet [1]. This driver performs the reset sequence using a GPIO.

Sorry, bindings are for hardware, not for drivers. I don't see the point
for this binding, especially that you refer to drivers. Why it cannot be
just part of other device?


> +
> +  The sequence with minimum wait intervals is as follows:
> +  deassert RST#
> +  wait at least 60 ms
> +  assert RST#
> +  wait at least 2 usecs
> +  deassert RST#
> +  wait at least 60 ms
> +  assert RST#
> +  wait at least 2 usecs
> +  deassert RST#
> +  wait at least 60 ms before issuing the first TPM command
> +
> +  [1] https://www.infineon.com/dgdl/Infineon-SLB%209670VQ2.0-DataSheet-v01_04-EN.pdf?fileId=5546d4626fc1ce0b016fc78270350cd6
> +
> +properties:
> +  compatible:
> +    enum:
> +      - infineon,slb9670-reset
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Reference to the GPIO connected to the RST# pin.
> +
> +  "#reset-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    tpm_reset: reset-controller {

No need for label.

> +        compatible = "infineon,slb9670-reset";
> +        #reset-cells = <0>;
> +        reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
> +    };
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tpm@0 {
> +            compatible = "infineon,slb9670";

Drop node, not related to the binding. We never keep consumers in
binding providers.

> +            reg = <0>;
> +            resets = <&tpm_reset>;
> +        };
> +    };

Best regards,
Krzysztof

