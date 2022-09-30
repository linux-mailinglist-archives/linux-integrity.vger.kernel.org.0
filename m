Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8085F1604
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Oct 2022 00:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiI3WUn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 18:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiI3WUj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 18:20:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6067EDE0E6;
        Fri, 30 Sep 2022 15:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F9BFB82A75;
        Fri, 30 Sep 2022 22:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0058C4347C;
        Fri, 30 Sep 2022 22:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664576435;
        bh=qT36EX6plFqF5Dp1cywmOZEh3p78L3P14nLf6Hv8za4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pk//MLBPF1I1bXlxlD2KQovY1EdDdZ3jnbAvKyHLnVOhrBM0HOj+HPZq/YNou9kmo
         Oy92llsvp/cOIZLL4iHFTNr8KMvit/zxHf31K4WEdBoNp8GU3qyczs5mmSaoE41J9O
         a07ZQrmPJmJdWazmJAhtGlTte/Hn1BToLfo1depOxoYRpB3i3utvcDwqKaUMGrHTgw
         9KQ/sttSqaNcaY4Xb6l9ptZrf6IPKmcGAUtSe3wMB7iSU7WwNTbTG9fdAqrOlu4Z+B
         nc7ZEU5QEJwkTQW1cgslw6nVa5EfMqcqjN1UTDr/grriwId864Yv+EXZURnLI6F8sz
         OPEEo8FVanD3Q==
Received: by mail-vs1-f53.google.com with SMTP id 126so6203314vsi.10;
        Fri, 30 Sep 2022 15:20:35 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ahcYq/wJlNH+ntLqaA5+Xgdbf19rT79v3xPna3cK+co4tTCfv
        vGUX2XU+sRrMa/0qgN4oXEsuiXZm3+BjegAZbQ==
X-Google-Smtp-Source: AMsMyM6EtfadS9EDbw63AXTLcxQyOx5tRPRr7P3P1LWdGkdT+AroH8GXcleFyqCuhSOve8JuzpOPAnjNgSYzVxxxLGI=
X-Received: by 2002:a05:6102:3211:b0:398:87ba:a1a6 with SMTP id
 r17-20020a056102321100b0039887baa1a6mr5773044vsf.0.1664576434778; Fri, 30 Sep
 2022 15:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com> <20220930165116.13329-4-Alexander.Steffen@infineon.com>
In-Reply-To: <20220930165116.13329-4-Alexander.Steffen@infineon.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Sep 2022 17:20:23 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+W=GdjdUhL4cxm6q7+YZ_Q0mizY5WLQvY3NHZVY+mFmA@mail.gmail.com>
Message-ID: <CAL_Jsq+W=GdjdUhL4cxm6q7+YZ_Q0mizY5WLQvY3NHZVY+mFmA@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: tpm: Add previously undocumented properties
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     devicetree@vger.kernel.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, Johannes.Holland@infineon.com,
        benoit.houyere@st.com, amirmizi6@gmail.com, peter@pjd.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 30, 2022 at 12:02 PM Alexander Steffen
<Alexander.Steffen@infineon.com> wrote:
>
> TPM devices may use some more properties than previously allowed by
> trivial-devices.yaml. Document those in trivial-tpms.yaml.
>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  .../bindings/security/tpm/trivial-tpms.yaml      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Adding these here means we would need to duplicate them for any device
with its own schema file. You need a common TPM property schema which
the specific TPM device schemas can reference.

>
> diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
> index 2092341c6491..a9e2dd17b1ca 100644
> --- a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
> +++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
> @@ -25,6 +25,22 @@ properties:
>
>    spi-max-frequency: true
>
> +  linux,sml-base:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description: |
> +      64-bit base address of the reserved memory allocated for the firmware
> +      event log
> +
> +  linux,sml-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: size of the memory allocated for the firmware event log
> +
> +  powered-while-suspended:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Present when the TPM is left powered on between suspend and resume
> +      (makes the suspend/resume callbacks do nothing).
> +
>    compatible:
>      contains:
>        enum:
> --
> 2.25.1
>
