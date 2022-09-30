Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB95F0DD5
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 16:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiI3OpJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 10:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiI3OpH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 10:45:07 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA121057C;
        Fri, 30 Sep 2022 07:44:59 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-12803ac8113so5670815fac.8;
        Fri, 30 Sep 2022 07:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5Ow92xkovoU2hWfiGMb/PJRm/nVqbNEnjNmHflvbLoc=;
        b=CeDPgSHUr+Nz1D/N+VnVZ9xX7HupNfPuml+9P0WN7zXyp1qO1IC893RFv/OblrJxYv
         8nrTRWnuc1yvKeADZsYHsg1isaK0wr3l31PqNSgyPExCjQ23iLZpt3qwkRyntmLgBPSd
         I+k84FdwfkI94jWSoD9wtXAk8B+Mg9deccYdnim8cAkX5jbxSIxseYdnTxcvueGIwn1H
         uBHKJcvWlwGxIOqu1MdCye2Oi9FAX6RPLli3AHO8MUaXUzcH9ibKdA4zqxsgdzfxV+7g
         MwdoWaKG3z66oVZqeoiuAdxpcULzKUipplRhyT5sXk1JDbY0wx9GPyypF2oOnpsBWYCI
         KTEg==
X-Gm-Message-State: ACrzQf2u0ZX0Wir7CJGGovBaSJUhH+Z/6yVSGiopK5RJwcEuIe2XLNRr
        qLFMuk83gawGU0Bz4S7P/UDIN9Eohg==
X-Google-Smtp-Source: AMsMyM7aj8kfJ7HL1vnKVNBCvcH73MwmkuRzPLzp8uiQ1N1H9Fw2I9niRFEyv1e83PNToAIHLsQjQA==
X-Received: by 2002:a05:6870:2394:b0:130:de3a:dd99 with SMTP id e20-20020a056870239400b00130de3add99mr5035431oap.54.1664549098816;
        Fri, 30 Sep 2022 07:44:58 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w92-20020a9d3665000000b0061c9ccb051bsm604906otb.37.2022.09.30.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:44:58 -0700 (PDT)
Received: (nullmailer pid 289943 invoked by uid 1000);
        Fri, 30 Sep 2022 14:44:57 -0000
Date:   Fri, 30 Sep 2022 09:44:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Peter Huewe <peterhuewe@gmx.de>, eajames@linux.ibm.com,
        Johannes Holland <johannes.holland@infineon.com>,
        linux-integrity@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: trivial-devices: Remove Infineon
 SLB9673 TPM
Message-ID: <166454909730.289887.15559616733241930652.robh@kernel.org>
References: <20220928043957.2636877-1-joel@jms.id.au>
 <20220928043957.2636877-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928043957.2636877-2-joel@jms.id.au>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 28 Sep 2022 14:09:55 +0930, Joel Stanley wrote:
> This reverts commit 2353673d8a025a6ba3b3aa3917a3a98944e64702.
> 
> It will be added to its own bindings document.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
