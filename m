Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1AB7B0357
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Sep 2023 13:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjI0LxF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Sep 2023 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjI0LxE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2023 07:53:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91755BE
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2023 04:53:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B393C433C7;
        Wed, 27 Sep 2023 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695815583;
        bh=w7NOYvDlz9WwO8/lZ+B4+xWRuFiX5D0MM18h/+ZIoV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKJam3pBL23Re2oidE3bSNRNlZF5e8ZSoDSs7Cw1pLhO4rHGwsqd+KKBrKauUl14s
         SquphGJCtaUq2UKoqefo8+fRC8PafFUGr8g9cWJ7yI01YMLpLqGzhjzhqil2Cg7AZB
         Bse98S5TCJjHTmvujAYQXDWrwDr4VmLV3eRgBMS4vleoBf+E2Ehr1eFxJMVRFIG+Ol
         ycpU2Lr8e9bDPN627R9ym6FkXBRyh2X5rH1Sf4BVo8uv8AzS4wUFlMZyQOEp17PIQF
         PAbW5N853xcJynP0pn9/Lqi5lf+mgW57OPuHiH6/Qjd4TtGXYRqVxfNqq/k602tNpR
         QD6JQ+HtS7gog==
Received: (nullmailer pid 1595187 invoked by uid 1000);
        Wed, 27 Sep 2023 11:53:00 -0000
Date:   Wed, 27 Sep 2023 06:53:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add Infineon SLB9670 TPM reset
 driver
Message-ID: <20230927115300.GA1587935-robh@kernel.org>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
 <169576062741.534473.12201606598910537660.robh@kernel.org>
 <20230927063116.GA6252@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927063116.GA6252@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 27, 2023 at 08:31:16AM +0200, Lukas Wunner wrote:
> On Tue, Sep 26, 2023 at 03:37:07PM -0500, Rob Herring wrote:
> > On Tue, 26 Sep 2023 21:09:35 +0200, Lukas Wunner wrote:
> > > A new reset driver is about to be added to perform the reset sequence of
> > > the Infineon SLB9670 Trusted Platform Module.
> > > 
> > > Document its device tree bindings.
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml:29:111: [warning] line too long (124 > 110 characters) (line-length)
> 
> That's the following line:
> 
>   [1] https://www.infineon.com/dgdl/Infineon-SLB%209670VQ2.0-DataSheet-v01_04-EN.pdf?fileId=5546d4626fc1ce0b016fc78270350cd6
> 
> I'm not sure what to do about it.  Use an URL shortener?

The link doesn't even work for me.

> I did see the warning when running static checks before submission,
> but it seemed like a false positive to me.

I suppose we could bump the limit by 1 as I think it is set to 110.

> 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/reset/infineon,slb9670-reset.example.dtb: /example-0/spi/tpm@0: failed to match any schema with compatible: ['infineon,slb9670']
> 
> The TPM DT bindings in Documentation/devicetree/bindings/security/tpm/
> haven't been converted to YAML yet, hence the warning/error.

Yes, there's been multiple attempts. Everyone disappears when I say work 
together and consolidate the efforts.

> Is it a prerequisite that I consolidate and convert them before
> this patch is acceptable?

Yes. Can't have warnings.

Rob
