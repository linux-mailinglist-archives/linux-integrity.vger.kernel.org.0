Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8029251E859
	for <lists+linux-integrity@lfdr.de>; Sat,  7 May 2022 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446615AbiEGQCd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 May 2022 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446610AbiEGQCc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 May 2022 12:02:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BCE1EAF1
        for <linux-integrity@vger.kernel.org>; Sat,  7 May 2022 08:58:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so19441877ejd.9
        for <linux-integrity@vger.kernel.org>; Sat, 07 May 2022 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F4eg3zMRdpKPCGlpzvcFzu7becBtGl7sPy8Sb1qKlmI=;
        b=PjDkBDm1zFIqM02o+qAceGgf+oG1KkBJ1T5lAaRVXihm94rQqYsfUrzoCiL2cuc7R6
         jR5tcI7LG+uwqrjEupVKuZ36MYNrghJQyqUno6n8AZi5vTOyDRA2HksqtRqfpqZxPLwe
         wiamYMcwg250+hguO6aQiSyeNC92aBLYXddXdfEgCcgJLHL6xAQY1Eb2GjQ0LH13kOGd
         Ql+KqpabkrmXL6OPYY8uTTffb308pclxUmHIkNvec9lXlEOLZFhbyPXLzmided3Wf1u3
         u/MdhNpd3THj6rlJM/vjo2PULJio5S69mUSKZLxTePCJbjD2oUY13g/75Txyszd9mwvg
         KlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F4eg3zMRdpKPCGlpzvcFzu7becBtGl7sPy8Sb1qKlmI=;
        b=JWpRVuVJ1CD750zF6pMS6AHgn62SsnW1GoHaDvWQf0J9zwqmbiQT5XMW/5Cr6dRA+u
         Bg1CAs8DJriLG7NJSEXldXg3yzc2eOaZiT1jCFQfr72wpMqldTfP6+/CBxas+L6ccM9L
         vl+bZu1KrNVNOjKM0MBCKBIJSyLLgp3wONMdwEwW7TIC69n/BPFj3qeVBsDsPwNIsLjJ
         HiUhBq3u+skLs73BERQUvdFw11NJ4EXxkPZ6caq1gO3xWCBo+y8VJhIbz1nXMTV8He74
         oX5FlDfYrs8lpObr+bKI4xurG9pQZHUrA8ua0qgULsJMlwgNpuYxiVvQPIsoRL6dEYmi
         kGUQ==
X-Gm-Message-State: AOAM530J/BfZ3lYtBPQCS9+zou/z9G9hydboekptaESntMg7fXTA5flF
        EdFlzJms+SaxqLQp/reH7c0H6Q==
X-Google-Smtp-Source: ABdhPJxvE6qr6UTyhd8YDsJjT6zrySc6pcTArns0DCeI6aPzPq4IY7FXPd6kYkL+Dez0qO9/jeu9Pw==
X-Received: by 2002:a17:906:1845:b0:6f4:346f:f767 with SMTP id w5-20020a170906184500b006f4346ff767mr7511895eje.214.1651939123480;
        Sat, 07 May 2022 08:58:43 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zg12-20020a170907248c00b006f3ef214e36sm3162897ejb.156.2022.05.07.08.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 08:58:42 -0700 (PDT)
Message-ID: <e49ea1aa-0711-c75a-3694-f8cdc8d56489@linaro.org>
Date:   Sat, 7 May 2022 17:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] dt-bindings: doc/devicetree/bindings/security/tpm:
 Move tpm-i2c.txt to YAML
Content-Language: en-US
To:     Johannes Holland <johannes.holland@infineon.com>,
        jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org
References: <20220506170013.22598-1-johannes.holland@infineon.com>
 <20220506170013.22598-4-johannes.holland@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220506170013.22598-4-johannes.holland@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 06/05/2022 19:00, Johannes Holland wrote:
> Migrate the existing plain text I2c driver schema to YAML and extend by
> the options of the generic TIS driver for I2C TPMs which comply to the
> TCG PC Client Platform TPM Profile (PTP) specification for TPM 2.0 v1.04
> Revision 14.
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---

Please use subject prefix consistent with subsystem:
git log --oneline -- Documentation/devicetree/bindings/


so for example: "dt-bindings: tpm: tpm-i2c: Convert to YAML"

> Changelog:
>  * v2:
>    * move existing device tree instead of just adding a new one
>    * do not use wildcard compatibles
>    * make properties "label", "linux,sml-base" and "linux,sml-size"
>      optional, as they should be

Why they should be? Please explain all changes deviating from conversion
in the commit msg. Adding new features should be in new commits, because
this is supposed to be only conversion + minor adjustments for the
conversion needs.

> 
> All properties are listed, even if some drivers do not implement them.
> 
> As mentioned, I kept the generic compatible in there because the TPM
> is a standardized device. For vendor-specific features and bugs, the
> specific compatibles can be used. Please let me know if you need it
> removed.

I think it should be a separate patch because it is not mentioned in
original bindings at all.

> 
>  .../bindings/security/tpm/tpm-i2c.txt         | 26 --------
>  .../bindings/security/tpm/tpm-i2c.yaml        | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt b/Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
> deleted file mode 100644
> index a65d7b71e81a..000000000000
> --- a/Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -* Device Tree Bindings for I2C based Trusted Platform Module(TPM)
> -
> -Required properties:
> -
> -- compatible     : 'manufacturer,model', eg. nuvoton,npct650
> -- label          : human readable string describing the device, eg. "tpm"
> -- linux,sml-base : 64-bit base address of the reserved memory allocated for
> -                   the firmware event log
> -- linux,sml-size : size of the memory allocated for the firmware event log
> -
> -Optional properties:
> -
> -- powered-while-suspended: present when the TPM is left powered on between
> -                           suspend and resume (makes the suspend/resume
> -                           callbacks do nothing).
> -
> -Example (for OpenPower Systems with Nuvoton TPM 2.0 on I2C)
> -----------------------------------------------------------
> -
> -tpm@57 {
> -	reg = <0x57>;
> -	label = "tpm";
> -	compatible = "nuvoton,npct650", "nuvoton,npct601";
> -	linux,sml-base = <0x7f 0xfd450000>;
> -	linux,sml-size = <0x10000>;
> -};
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-i2c.yaml
> new file mode 100644
> index 000000000000..952605ab8611
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-i2c.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/tpm-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C PTP based TPM Device Tree Bindings

s/Device Tree Bindings//

> +
> +maintainers:
> +  - Johannes Holland <johannes.holland@infineon.com>
> +
> +description:
> +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).

s/Device Tree Bindings//

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          # Infineon's Trusted Platform Module (TPM) (SLB9673)
> +          - infineon,slb9673

This was not documented before, so separate commit please.

> +          - nuvoton,npct601

Please remove it from trivial-devices (in this commit).

> +          - nuvoton,npct650
> +      - const: tcg,tpm-tis-i2c
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt:
> +    maxItems: 1
> +
> +  label:
> +    description: |

No need for "|". Also in other cases below.

> +      Human readable string describing the device, eg. "tpm".
> +
> +  linux,sml-base:
> +    description: |
> +      64-bit base address of the reserved memory allocated
> +      for the firmware event log.

This does not look like standard type, so it needs a $ref.

> +
> +  linux,sml-size:
> +    description: |
> +      Size of the memory allocated for the firmware event log.

Ditto.

> +
> +  powered-while-suspended:
> +    description: |
> +      Present when the TPM is left powered on between suspend and
> +      resume (makes the suspend/resume callbacks do nothing).

Missing type, so:
type:boolean


> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      tpm@2e {
> +        compatible = "infineon,slb9673", "tcg,tpm-tis-i2c";
> +        reg = <0x2e>;

Why changing example? Use the original one, unless it has issues but
this was not mentioned anywhere.

> +      };
> +    };
> +...


Best regards,
Krzysztof
