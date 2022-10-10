Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB06C5FA0FC
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Oct 2022 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJJPP6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Oct 2022 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJJPP5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Oct 2022 11:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85DC5756D;
        Mon, 10 Oct 2022 08:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C89660F7B;
        Mon, 10 Oct 2022 15:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49220C433C1;
        Mon, 10 Oct 2022 15:15:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="edLZ0aGR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665414951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXnY72mFsROmabRvf0J+Pa5RaskNobc+nX3HeIF4L9E=;
        b=edLZ0aGRKciBgrABCWwLTufhUStuvzwDRVkxkjKFePW+lIvwIpj0q6oKVCBECn48iexD0q
        f7ldV0FN6C5s9vl2nK7StLKdvr8cL1OjlA2j46fZFDVa+UAmKdnQOqkv/DyQDLX+HIniGg
        DvENCbC1YiSe+oWCytb5/z0zOJAMvXA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b7dc69e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 15:15:51 +0000 (UTC)
Date:   Mon, 10 Oct 2022 09:15:48 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "gilad@benyossef.com" <gilad@benyossef.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Message-ID: <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 10, 2022 at 11:15:00AM +0000, Pankaj Gupta wrote:
> > Nack.  You still have not provided a convincing argument why this is necessary
> > since there are plenty of existing drivers in the kernel already providing similar
> > features.
> > 
> CAAM is used as a trusted source for trusted keyring. CAAM can expose
> these keys either as plain key or HBK(hardware bound key- managed by
> the hardware only and never visible in plain outside of hardware).
> 
> Thus, Keys that are inside CAAM-backed-trusted-keyring, can either be
> plain key or HBK. So the trusted-key-payload requires additional flag
> & info(key-encryption-protocol)  to help differentiate it from each
> other. Now when CAAM trusted-key is presented to the kernel crypto
> framework, the additional information associated with the key, needs
> to be passed to the hardware driver. Currently the kernel keyring and
> kernel crypto frameworks are associated for plain key, but completely
> dis-associated for HBK. This patch addresses this problem.
> 
> Similar capabilities (trusted source), are there in other crypto
> accelerators on NXP SoC(s). Having hardware specific crypto algorithm
> name, does not seems to be a scalable solution.

Do you mean to say that other drivers that use hardware-backed keys do
so by setting "cra_name" to something particular? Like instead of "aes"
it'd be "aes-but-special-for-this-driver"? If so, that would seem to
break the design of the crypto API. Which driver did you see that does
this? Or perhaps, more generally, what are the drivers that Herbert is
talking about when he mentions the "plenty of existing drivers" that
already do this?

Jason
