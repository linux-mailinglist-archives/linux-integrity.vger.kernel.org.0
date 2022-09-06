Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899D05AE0DC
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiIFHU4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbiIFHUy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 03:20:54 -0400
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 00:20:52 PDT
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB826567E;
        Tue,  6 Sep 2022 00:20:52 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id EBDF820E7;
        Tue,  6 Sep 2022 09:12:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662448354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=myPv8B55ZEW05OB+S9pWiPrxR+s0aF+7aFKm/XD78HY=;
        b=h7cs+Br+GYOgEzdUyybaY6Litl/DVXOqlyaCC3x+VljpHK2U+n5HWxh9W+DjpzwfEyOQ1w
        wK6epONrj1e71rI1GKxBbvpi1G0xKi0jaEJAw8nCLpTqgB5sGjYZJtLDA4H4K6XQrk7B62
        M+o9vZ7xwYQ7tt9O8PScxqHiEIt71/mBRahS0uQ1dkzry5ykx6Dv38eo7kYoudflXbUr9p
        GIUY/pW4HmfLdLrMwmEMaKSim1sZYuqwcR4l5Y26xgeOti7tDLbeLOyufl3nxVf4L95LbH
        XGpQp0o9H9YALg+3bYjQSjKapyqC3nEpudOGQXC65xwynwAp8vU17wovHEzDkg==
MIME-Version: 1.0
Date:   Tue, 06 Sep 2022 09:12:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     jarkko@kernel.org, a.fatoum@pengutronix.de, Jason@zx2c4.com,
        jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org, david@sigma-star.at, john.ernberg@actia.se,
        jmorris@namei.org, serge@hallyn.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, j.luebbe@pengutronix.de, ebiggers@kernel.org,
        richard@nod.at, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <047746e1134d5bdce699d8c021f849b6@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Am 2022-09-06 08:51, schrieb Pankaj Gupta:
> Hardware Bound key(HBK), is never acessible as plain key outside of the
> hardware boundary. Thus, it is un-usable, even if somehow fetched
> from kernel memory. It ensures run-time security.
> 
> This patchset adds generic support for classing the Hardware Bound Key,
> based on:
> 
> - Newly added flag-'is_hbk', added to the tfm.
> 
>   Consumer of the kernel crypto api, after allocating
>   the transformation, sets this flag based on the basis
>   of the type of key consumer has.
> 
> - This helps to influence the core processing logic
>   for the encapsulated algorithm.
> 
> - This flag is set by the consumer after allocating
>   the tfm and before calling the function crypto_xxx_setkey().
> 
> First implementation is based on CAAM.
> 
> NXP built CAAM IP is the Cryptographic Acceleration and Assurance 
> Module.
> This is contain by the i.MX and QorIQ SoCs by NXP.
> 
> CAAM is a suitable backend (source) for kernel trusted keys.
> This backend source can be used for run-time security as well
> by generating the hardware bound key.
> 
> Along with plain key, the CAAM generates black key. A black key is an
> encrypted key, which can only be decrypted inside CAAM. Hence, CAAM's
> black key can only be used by CAAM. Thus it is declared as a hardware 
> bound key.

What is the difference to the current trusted keys with CAAM?
When I tested the patch series back then, I wasn't able to import
a sealed key on another board with the same SoC.

-michael
