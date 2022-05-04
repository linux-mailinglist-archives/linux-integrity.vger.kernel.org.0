Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882B3519642
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 06:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiEDEQU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 00:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiEDEQU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 00:16:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B931D0E4;
        Tue,  3 May 2022 21:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88C72B8233B;
        Wed,  4 May 2022 04:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B7AC385A5;
        Wed,  4 May 2022 04:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651637562;
        bh=6IuMu/V1V2LFwUSjO2vX4u2K+F8reYl3W/byGs58gCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prUycLXEk9oQ/44wSAL3GZXCojC0Rcz6yK+sObqX4XhVaDQ7pNglr1qPA0J88lWm1
         UEAYm/H0xSpq1wGn1+bgbCEqlObsRHtQEMVIOCuvGQPCtjpZBdZ9WxbciJau7HO0CQ
         AuK0IN1XYk16C04xdDwSzcwNFxm7QblV4lwyO2l/eZjmizY6vEcV/uE/vhyqoTqxU4
         bdO2mQrDzLX+2gXZzx1qHJT6Mkp2P8GoE9nHlDJUvy08aQ5bhk7Rm5HGTRrvbHx/bn
         TaubNOkeXWx0o3A9SUQQVDMFbBVWaefUx5ZBiQ/EQfxS2zfzAePJBRg37MzuD4g5hP
         jyDw/SaK/PSvg==
Date:   Wed, 4 May 2022 07:11:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [EXT] [PATCH v7 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Message-ID: <YnH85FKdUN7DW8J8@kernel.org>
References: <20220415205647.46056-1-a.fatoum@pengutronix.de>
 <DU2PR04MB86306B75C018C7CAB9FFA57195FD9@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <73bb42fc-5d69-0c89-d42f-226a6d13248f@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73bb42fc-5d69-0c89-d42f-226a6d13248f@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 28, 2022 at 03:44:27PM +0200, Ahmad Fatoum wrote:
> Hello Pankaj,
> 
> On 28.04.22 14:50, Pankaj Gupta wrote:
> > Hi Ahmad,
> > 
> > I have tested the patch-set.
> > It is working as expected even when CAAM is compiled as kernel module.
> > 
> > Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Tested-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> 
> Thanks for test and review. I have applied the tags on all patches
> in the series except the Tested-by for the last two. I think a Tested-by
> for maintainer and doc changes looks a bit odd. ^^
> 
> I will incorporate Jarkko's documentation feedback and send a new series
> shortly.

Thank you for doing that (putting tags to correct place).

BR, Jarkko
