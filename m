Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEB352BEB4
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiERO4l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbiERO4d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 10:56:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5319FF45;
        Wed, 18 May 2022 07:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3758B82124;
        Wed, 18 May 2022 14:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616F0C385A5;
        Wed, 18 May 2022 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652885788;
        bh=JoHYiEVfVna108Cm8DYUO6EeVHUhH/jsA2hx84cxhc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXloz30g2ROWJVE5AwCu6ZoycqVAtob21szWjAezE1juW3k44jgPVBlzoPpNtuRvo
         FulCY7iLDeRngt1eLgkyV+EK2jWMlRvaC7TZrnBeRQGco3i5PE9l1IZn0smZdfHEpD
         UNC5/YDJLLD4NcdQ9Bc+UwKTFXLZu/tJWPTS9WBLpP99RQVsnF3GP3ExVMeVW0MCB9
         VUgQCtT2t8iN16fDAGHBL96TyetYvqsbhoPgrIuYXtk7GKSpv9m7WEboi56ITE+XQi
         VoAcy6cVoubz5/pS3D+7QJ50FkmTSgFeda7uGNQRpBgZVUCvwgqyzmmHcVgZHsZn+O
         qfumUFmSmYViA==
Date:   Wed, 18 May 2022 17:58:09 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v10 0/7] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Message-ID: <YoUJgUbSRVnTfTj/@iki.fi>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <YoKZwFkfcl7ixTF4@kernel.org>
 <4d4ecd4b-9683-08a0-7a5f-11a7ff86ea6d@pengutronix.de>
 <c511995075cafb35bfefcbfe6fa6e84aa31c536f.camel@kernel.org>
 <6f6a5524-9661-9a9f-a674-915efa33f6f6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6a5524-9661-9a9f-a674-915efa33f6f6@pengutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 18, 2022 at 06:36:18AM +0200, Ahmad Fatoum wrote:
> On 18.05.22 03:08, Jarkko Sakkinen wrote:
> > On Tue, 2022-05-17 at 14:44 +0200, Ahmad Fatoum wrote:
> >> Hello Herbert,
> >>
> >> On 16.05.22 20:36, Jarkko Sakkinen wrote:
> >>> On Fri, May 13, 2022 at 04:56:58PM +0200, Ahmad Fatoum wrote:
> >>> I can probably pick these unless objections?
> >>
> >> Pankaj has given his Reviewed-by for the CAAM parts he co-maintains,
> >> is it ok for this to go in via Jarkko's tree?
> >>
> >> Note that applying this series on top of jarkko/linux-tpmdd.git has a
> >> trivial conflict when merged with herbert/cryptodev-2.6.git:
> >> Two independently added Kconfig options need to coexist in
> >> drivers/crypto/caam/Kconfig.
> >>
> >> I can resend my series rebased if needed.
> >>
> >> Cheers,
> >> Ahmad
> >>
> >>>
> >>> BR, Jarkko
> >>>
> >>
> >>
> > 
> > This came up:
> > 
> > https://lore.kernel.org/keyrings/0e8da958a222e5c1dccaaf1600b08bdb8705b48e.camel@kernel.org/
> 
> And it turned out to be a misunderstanding. Or do you think there is still anything
> to do there?
> 
> Thanks,
> Ahmad

Oops, you're right, sorry.

Yeah, I guess I can pick these patches now.

BR, Jarkko
