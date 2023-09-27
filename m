Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0065A7AFB3A
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Sep 2023 08:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjI0GlT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Sep 2023 02:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjI0GlK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2023 02:41:10 -0400
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 23:41:08 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81EEFC;
        Tue, 26 Sep 2023 23:41:08 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2957A100FBD1B;
        Wed, 27 Sep 2023 08:31:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CBB53A3DDA; Wed, 27 Sep 2023 08:31:16 +0200 (CEST)
Date:   Wed, 27 Sep 2023 08:31:16 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add Infineon SLB9670 TPM reset
 driver
Message-ID: <20230927063116.GA6252@wunner.de>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
 <169576062741.534473.12201606598910537660.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169576062741.534473.12201606598910537660.robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 26, 2023 at 03:37:07PM -0500, Rob Herring wrote:
> On Tue, 26 Sep 2023 21:09:35 +0200, Lukas Wunner wrote:
> > A new reset driver is about to be added to perform the reset sequence of
> > the Infineon SLB9670 Trusted Platform Module.
> > 
> > Document its device tree bindings.
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml:29:111: [warning] line too long (124 > 110 characters) (line-length)

That's the following line:

  [1] https://www.infineon.com/dgdl/Infineon-SLB%209670VQ2.0-DataSheet-v01_04-EN.pdf?fileId=5546d4626fc1ce0b016fc78270350cd6

I'm not sure what to do about it.  Use an URL shortener?

I did see the warning when running static checks before submission,
but it seemed like a false positive to me.


> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/reset/infineon,slb9670-reset.example.dtb: /example-0/spi/tpm@0: failed to match any schema with compatible: ['infineon,slb9670']

The TPM DT bindings in Documentation/devicetree/bindings/security/tpm/
haven't been converted to YAML yet, hence the warning/error.

Is it a prerequisite that I consolidate and convert them before
this patch is acceptable?

Thanks,

Lukas
