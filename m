Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB9368A25B
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Feb 2023 19:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjBCS5o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Feb 2023 13:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjBCS5e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Feb 2023 13:57:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8ECAA25A;
        Fri,  3 Feb 2023 10:57:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA20C61FCB;
        Fri,  3 Feb 2023 18:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F6EC4339E;
        Fri,  3 Feb 2023 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675450642;
        bh=xPHez8jgrQEIrINfac2nxZSidld4VJx0LyaPtkG+laE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cXfcivfqU8U+vJ+dCd53pK87It7Zzx0W/NRXTciVyxTFINVoPGnwhgdUTYpUMBOwi
         JfpuOJy98Rak4STk6vQNMzrVVYqCCsp13wH0QNCp9ElGJ3gK4UzSXKqB0BCBqZAlNU
         RvVauAuqlJIeaPQYDlJDzXyUUVaTVoocHBVJaksRy+XJK7+7X+w0Z8nWUYjQkgCUHA
         gykynLgqveGgz6M50Mt9HXZ1bjUaQodb6+Os42wnhjfCW5BBaiQoDO93nh3lU3HUlK
         fbAqpT+pRrL8NoLw8CVZKrKwHseSKgyteo/01gWupICSstgtkeLz3Xv2GV/nzEu04F
         07Z6GFHbbzXJg==
Received: by mail-ua1-f52.google.com with SMTP id h9so1129483uag.9;
        Fri, 03 Feb 2023 10:57:22 -0800 (PST)
X-Gm-Message-State: AO0yUKVFvPHTwhbGHFywYBclpYpQkaagmXYxw/gA/AJElUbnc0NSWpUp
        R0vk/D4/qJCYZsvEfVminx8wySzkLAutvjW7BQ==
X-Google-Smtp-Source: AK7set+3/1t+yXug05T1BjleQ8O1DFYFiinTTWfgTa1FCabNmZGf3MifYZALAEdGTKKn0pVJM2F/9ERU7v8yRBMMd7Y=
X-Received: by 2002:ab0:3418:0:b0:66c:f3bf:fc86 with SMTP id
 z24-20020ab03418000000b0066cf3bffc86mr1824865uap.24.1675450641056; Fri, 03
 Feb 2023 10:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20230203130133.32901-1-kyarlagadda@nvidia.com> <20230203130133.32901-2-kyarlagadda@nvidia.com>
In-Reply-To: <20230203130133.32901-2-kyarlagadda@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 3 Feb 2023 12:57:09 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+SbgdN3gbb2M2DszEk3F7wfYrrDYeBFm6165mBetdPgw@mail.gmail.com>
Message-ID: <CAL_Jsq+SbgdN3gbb2M2DszEk3F7wfYrrDYeBFm6165mBetdPgw@mail.gmail.com>
Subject: Re: [Patch V2 1/4] dt-bindings: tpm: Add compatible for Tegra TPM
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     broonie@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 3, 2023 at 7:02 AM Krishna Yarlagadda
<kyarlagadda@nvidia.com> wrote:
>

Please use get_maintainers.pl. In particular, resend to DT list so
automated checks work.

> Tegra234 and Tegra241 devices have QSPI controller that supports TPM
> devices. Since the controller only supports half duplex, sw wait polling
> method implemented in tpm_tis_spi does not suffice. Wait polling as per
> protocol is a hardware feature.
>
> Add compatible for Tegra TPM driver with hardware flow control.
>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  .../security/tpm/nvidia,tegra-tpm-spi.yaml    | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.yaml
>
> diff --git a/Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.yaml b/Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.yaml
> new file mode 100644
> index 000000000000..dcb78db7355c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/nvidia,tegra-tpm-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra QSPI TPM driver

Bindings are for h/w, not drivers.

> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra-tpm-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    qspi1@3250000 {

spi@...

> +      tpm@0 {
> +        compatible = "nvidia,tegra-tpm-spi";

Tegra has a TPM chip/block? This doesn't seem right.

> +        reg = <0>;
> +      };
> +    };
> --
> 2.17.1
>
