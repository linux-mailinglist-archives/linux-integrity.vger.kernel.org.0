Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C96954BC52
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jun 2022 22:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbiFNU6P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jun 2022 16:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiFNU6P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jun 2022 16:58:15 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690384FC49;
        Tue, 14 Jun 2022 13:58:14 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id h8so10687125iof.11;
        Tue, 14 Jun 2022 13:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7iMjdZBJ4KMw63aFHTKRe1N4L60iJ+6XfVwG5ZwbGng=;
        b=sXdsKkp9lAHFN3EkCoj374ZvZ3mvKZu/eewmPqSzISPoQc0+pUDt86jAd2Zs07t5hA
         kEZ1x56iivspspbYIkdMkJ73Tx87QRUt/O6359mO7rY5aTobFQwsp/E5/8UVVXHGc62V
         yQ/3WUPXwdq1yYchICb+l8/JFEsT8eo5rWFJJrM0gsWIyBtf55bWogB8O0LmUN72yMRk
         RB1+9+pX/O5zMj9e4zynf649xeiTgy60QJEH2b9kMd5/0XAYUaiG70Ades407ME9ZHeF
         J+SS5GsZzbfNNIBB25Jm8DLtAsM2zAPD5LI3d2bR55hsjnmRMaM1a3ylaUtb3wczB0iQ
         wc+w==
X-Gm-Message-State: AOAM530W6lsQ+hgrsr8J67urH76oYIHrW2+xIRlyZPDVHUCMDPhTwNL5
        nre62456N5sXhmrkPvWnZaxxzV1Y+A==
X-Google-Smtp-Source: ABdhPJzaPjeU08pGK0MfSUVKPEZ9N1AbAOfvFkcbi6Q+ONd4MUogkiyMtEdcQTGGoAmBarcytqPQ4g==
X-Received: by 2002:a05:6638:1509:b0:331:baca:d2bc with SMTP id b9-20020a056638150900b00331bacad2bcmr3901729jat.299.1655240293668;
        Tue, 14 Jun 2022 13:58:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id x24-20020a026f18000000b00331f48289easm5307203jab.136.2022.06.14.13.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:58:13 -0700 (PDT)
Received: (nullmailer pid 2547452 invoked by uid 1000);
        Tue, 14 Jun 2022 20:58:11 -0000
Date:   Tue, 14 Jun 2022 14:58:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: trivial-devices: Add Infineon
 SLB9673 TPM
Message-ID: <20220614205811.GA2528404-robh@kernel.org>
References: <20220608173113.9232-1-Alexander.Steffen@infineon.com>
 <20220608173113.9232-2-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608173113.9232-2-Alexander.Steffen@infineon.com>
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

On Wed, Jun 08, 2022 at 07:31:11PM +0200, Alexander Steffen wrote:
> Initial device to be supported by the upcoming tpm_tis_i2c driver. More
> to be added later.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6aafa71806a3..47a88e891a06 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -139,6 +139,8 @@ properties:
>            - infineon,slb9635tt
>              # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
>            - infineon,slb9645tt
> +            # Infineon SLB9673 I2C TPM 2.0
> +          - infineon,slb9673

I suspect these will need to move to here (don't you need to support 
linux,sml-base?):
 
Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt

But for now,

Acked-by: Rob Herring <robh@kernel.org>

>              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>            - infineon,tlv493d-a1b6
>              # Infineon Multi-phase Digital VR Controller xdpe11280
> -- 
> 2.25.1
> 
> 
