Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24668A340
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Feb 2023 20:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjBCTt6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Feb 2023 14:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjBCTts (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Feb 2023 14:49:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07919A42A8;
        Fri,  3 Feb 2023 11:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE2F1B82BAF;
        Fri,  3 Feb 2023 19:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64391C433A0;
        Fri,  3 Feb 2023 19:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675453785;
        bh=oPfYZrBYvEmlb3KaTxffGGNM7p40aDeJmEl+x/z6noI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WvNnh98L1iwdg1sE2vOW5nQKK5+jpR/TY4f6yj3dpF3EuWg+WkExwqKQ0QxnvftOn
         25jsBvkXMhAY5dF5Ww7Tf3epDlNrxfIbmd/KU3l5VCy8RMtasDacQgRfDhv1cALdMG
         763ZE9n0GtDmpz6yv0tRTIHCuQAoM/Y9/DSEmmbVdLfUFjex6AYwPWCUNzVE9tS+6H
         Oi4w8O+HFenX3mlNaob3Qki4EI1hlrl+PtcDHca8FdH9eESsFiURKKgJ09JSZsCZNR
         1/UxharaNXvxgzcbdJqnfHw+ExYQ2ROroYpr1PjtD+OL5XpAqqu+zeKRo9dAUk57Gi
         +ndIDJTn/Yaww==
Received: by mail-vs1-f51.google.com with SMTP id j7so6482026vsl.11;
        Fri, 03 Feb 2023 11:49:45 -0800 (PST)
X-Gm-Message-State: AO0yUKUzZ78qKrDJYFi7RKqdiK/YdEe7AYMtbsFF19cY350UTLO5bitK
        dzRb0t9ziDrOVUwMFd1cvAXLP1jolruC101qbw==
X-Google-Smtp-Source: AK7set8H1evMmqEhnt3X1ltHPsrVkPzjU+0a5B9vfYN3Cu68Zez1RWyDk1+x3WJT/os8en2NOKdZ+3Uc9TvadrRKISY=
X-Received: by 2002:a67:eb03:0:b0:3ea:c8c:48a5 with SMTP id
 a3-20020a67eb03000000b003ea0c8c48a5mr1841138vso.53.1675453784195; Fri, 03 Feb
 2023 11:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20230203130133.32901-1-kyarlagadda@nvidia.com> <20230203130133.32901-4-kyarlagadda@nvidia.com>
In-Reply-To: <20230203130133.32901-4-kyarlagadda@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 3 Feb 2023 13:49:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKph2iK3Qb1=PFKxVScSs1f8sUcDh52py8WyhO6pu27TQ@mail.gmail.com>
Message-ID: <CAL_JsqKph2iK3Qb1=PFKxVScSs1f8sUcDh52py8WyhO6pu27TQ@mail.gmail.com>
Subject: Re: [Patch V2 3/4] spi: dt-bindings: Add Tegra TPM wait polling flag
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
> Add "nvidia,wait-polling" flag to enable TCG TIS hardware flow control.

Tell me something that the diff doesn't.

>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> index 2c3cada75339..19d2b30cadbf 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> @@ -29,4 +29,10 @@ properties:
>      minimum: 0
>      maximum: 255
>
> +  nvidia,wait-polling:
> +    description:
> +      Enable TPM wait polling feature for QSPI as specified in TCG PC Client
> +      Specific TPM Interface Specification (TIS).
> +    $ref: /schemas/types.yaml#/definitions/flag

Why do you need this flag when you have a compatible that also
indicates you have a quirk.

If this a TPM feature, why is it enabled for every single SPI slave device?

If the fundamental issue is the controller only supports half-duplex,
why can't you just check that from the driver? Can't the SPI subsystem
tell you that the host controller is half-duplex? Though sometimes
that may be board level property I suppose. If so, define the h/w
quirk, not the driver mode in DT. Half-duplex is probably something
everyone could use, not just Nvidia.

Please discuss this series internally with the folks you marked as
maintainers. It has issues I'm sure they would have also pointed out.

Rob
