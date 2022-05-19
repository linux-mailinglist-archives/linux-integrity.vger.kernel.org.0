Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6A52E0AA
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 01:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiESXnC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 May 2022 19:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiESXnB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 May 2022 19:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136CEB042E;
        Thu, 19 May 2022 16:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1B1461943;
        Thu, 19 May 2022 23:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9BEC385AA;
        Thu, 19 May 2022 23:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653003780;
        bh=6JGyfhNXfNm06GnBDot5qMy5WIBj4ipB36DG8PIGeWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDDeKqV+B8s4g1Gv66ZmQTK/XyaX3H7n7/hVJ9z1x1I3SE8cSo7uEAKJ27J2PvKjW
         68R61oWOiNwsgwwjDMdoCT11grrtc0Xlsp8L12B0gzJWr6PViSMOsraQAAsSqyS05o
         wCREsib0UGEoKw2BhZv5rW7X7F1i0J8vsGgniXyc29mJ9tuht1Lx7cKRnQU7E6YXn/
         mqLTVtoMsdT5x4sRDlHqNHXZY/sIaTryjTuntCXlz04hdJV00c1y+0yFAIVR8zHC8B
         oCCnThSzW7wqKw90ygLEVR4V1XgAmhTK7HDcrak+yFRGhoZNYYuN7J5TbGjkRxodyf
         aeQMgM4NJ2Gcg==
Date:   Fri, 20 May 2022 02:41:21 +0300
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
Message-ID: <YobVoQ+enx0IY4z1@kernel.org>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <YoKZwFkfcl7ixTF4@kernel.org>
 <4d4ecd4b-9683-08a0-7a5f-11a7ff86ea6d@pengutronix.de>
 <c511995075cafb35bfefcbfe6fa6e84aa31c536f.camel@kernel.org>
 <6f6a5524-9661-9a9f-a674-915efa33f6f6@pengutronix.de>
 <YoUJgUbSRVnTfTj/@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUJgUbSRVnTfTj/@iki.fi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 18, 2022 at 05:58:09PM +0300, Jarkko Sakkinen wrote:
> On Wed, May 18, 2022 at 06:36:18AM +0200, Ahmad Fatoum wrote:
> > On 18.05.22 03:08, Jarkko Sakkinen wrote:
> > > On Tue, 2022-05-17 at 14:44 +0200, Ahmad Fatoum wrote:
> > >> Hello Herbert,
> > >>
> > >> On 16.05.22 20:36, Jarkko Sakkinen wrote:
> > >>> On Fri, May 13, 2022 at 04:56:58PM +0200, Ahmad Fatoum wrote:
> > >>> I can probably pick these unless objections?
> > >>
> > >> Pankaj has given his Reviewed-by for the CAAM parts he co-maintains,
> > >> is it ok for this to go in via Jarkko's tree?
> > >>
> > >> Note that applying this series on top of jarkko/linux-tpmdd.git has a
> > >> trivial conflict when merged with herbert/cryptodev-2.6.git:
> > >> Two independently added Kconfig options need to coexist in
> > >> drivers/crypto/caam/Kconfig.
> > >>
> > >> I can resend my series rebased if needed.
> > >>
> > >> Cheers,
> > >> Ahmad
> > >>
> > >>>
> > >>> BR, Jarkko
> > >>>
> > >>
> > >>
> > > 
> > > This came up:
> > > 
> > > https://lore.kernel.org/keyrings/0e8da958a222e5c1dccaaf1600b08bdb8705b48e.camel@kernel.org/
> > 
> > And it turned out to be a misunderstanding. Or do you think there is still anything
> > to do there?
> > 
> > Thanks,
> > Ahmad
> 
> Oops, you're right, sorry.
> 
> Yeah, I guess I can pick these patches now.

Applied:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=next

BR, Jarkko
