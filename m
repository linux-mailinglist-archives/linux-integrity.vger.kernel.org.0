Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2555F0DD8
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiI3OpQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiI3OpM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 10:45:12 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110732ED4C;
        Fri, 30 Sep 2022 07:45:12 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id o64so4906484oib.12;
        Fri, 30 Sep 2022 07:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pc2DgYZTOFOp2GGJfV5I+GdUrAwPYjF8VqL/R6M+Uss=;
        b=SIPVxZdpnoMNRtLxtzq7uCaGBi8xrz/TGdxv63htS6h1fG6HHmbG6iEobMz9rsP3ke
         XcIZ4rkJtQcHEmzxZ4UAlhCLZYYXbOPey/Er2q143kz+D12F/KO43wku6xefdtdIfYlO
         V9jzsYc/5Eji7se+UaWtIbk48tJiVLWxPNeUnpcv6aQ+axV58YffElNFxEOKWTLW1nJS
         EhhjTf/upk4TsUrNkKDRfvGv0f0bdht8FG0Xh5tackg+xutjtk0Q1xWTFxkuxSACn4Uh
         D3rQ1yXGzdXHbEdQcZDxyg/lLDUcgwiga9C6N6/vITybk1c4z5gQZ3Z9do+Vp0LgdNes
         ul9A==
X-Gm-Message-State: ACrzQf1mSf9T2jpBLDU8sYqmeZNQotZx2k7HxJNisr+FfJfQBFiVCa8C
        e/+n+F0jagv2zA2gfVt40w==
X-Google-Smtp-Source: AMsMyM5mkfk1Oz8S6nmEp6CE/yaDq8Vl9VqiORj4nCy50Pae0FB5XuLNAkBvy5TfTLw2Y1ITkpEjGw==
X-Received: by 2002:a05:6808:2384:b0:351:29cc:64d5 with SMTP id bp4-20020a056808238400b0035129cc64d5mr4165294oib.136.1664549111301;
        Fri, 30 Sep 2022 07:45:11 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a10-20020a05687073ca00b00127ebb410a4sm751532oan.11.2022.09.30.07.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:45:11 -0700 (PDT)
Received: (nullmailer pid 290299 invoked by uid 1000);
        Fri, 30 Sep 2022 14:45:10 -0000
Date:   Fri, 30 Sep 2022 09:45:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Johannes Holland <johannes.holland@infineon.com>,
        linux-integrity@vger.kernel.org, eajames@linux.ibm.com,
        Peter Huewe <peterhuewe@gmx.de>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 2/3] dt-bindings: tpm: Add schema for TIS I2C devices
Message-ID: <166454910936.290223.3190321287654108789.robh@kernel.org>
References: <20220928043957.2636877-1-joel@jms.id.au>
 <20220928043957.2636877-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928043957.2636877-3-joel@jms.id.au>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 28 Sep 2022 14:09:56 +0930, Joel Stanley wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
> 
> Add a dt schema to support device tree bindings for the generic I2C
> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.
> 
> This includes descriptions for the Nuvoton and Infineon devices.
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: String changes
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
