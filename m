Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA4662AFD0
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 00:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKOX5b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 18:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKOX53 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 18:57:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAA112AC5;
        Tue, 15 Nov 2022 15:57:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED9A5B81B58;
        Tue, 15 Nov 2022 23:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D81CC433C1;
        Tue, 15 Nov 2022 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668556645;
        bh=F0EaFC7p9syKhNI6Yd5oUqZ8NWsDoe5Sl1JvY5LDLow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsUI9EBxoYEYbZAsP6HR91ZdaNCsAJpP6ooWEWF7Y3ii/URHsfceHnM5L4hsS+U9+
         MaCK5wGQDxfK0c35tHrHTdf0f1cHNAFtgIrCUQnypDe7g8WIsl7sfwuNwmA8Yfma0T
         BWyMP3ggO2BW3/RCuotBKGLX3Vonaq2brYfB3WbFNeQkOdfPdvtQuYkJ5Z9cpZQ5PM
         NAmlN0JM3YQERjEvaNGBIFOKayF/y2Wzxk1MllYSu4REZDpgpl65jkvsYdxyUXehHL
         Jd77Rt5Ivc0KrqS0QxQf6IGIwy8I6JYHt5kaJ4SGk7kYw8JVA4bvr4v/ZLfOjgXsVc
         3+pZCCD58ff6w==
Date:   Wed, 16 Nov 2022 01:57:22 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] certs: Prevent spurious errors on repeated blacklisting
Message-ID: <Y3QnYhJGIkWCm4LQ@kernel.org>
References: <20221104014704.3469-1-linux@weissschuh.net>
 <3b997266-067c-975c-911a-da146fe9033a@digikod.net>
 <db5890d8-3a3d-4ca7-bb58-655c26164587@t-8ch.de>
 <8692915f-437c-56fd-8984-d6febf533fa9@digikod.net>
 <706c75af-9569-42fd-ba68-533ed931d55d@t-8ch.de>
 <e2909fe5-7fc4-c73a-b33a-e65fed1d837f@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2909fe5-7fc4-c73a-b33a-e65fed1d837f@digikod.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 07, 2022 at 08:40:09PM +0100, MickaÎl Sala¸n wrote:
> 
> On 07/11/2022 17:35, Thomas Weiﬂschuh wrote:
> > On 2022-11-07 17:20+0100, MickaÎl Sala¸n wrote:
> > > On 07/11/2022 16:55, Thomas Weiﬂschuh wrote:
> > > > On 2022-11-07 14:12+0100, MickaÎl Sala¸n wrote:
> > > > > This is a follow-up of
> > > > > https://lore.kernel.org/r/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de
> > > > > 
> > > > > Added Jarkko, Mark Pearson, Eric Snowberg and more ML in Cc.
> > > > > 
> > > > > 
> > > > > On 04/11/2022 02:47, Thomas Weiﬂschuh wrote:
> > > > > > When the blacklist keyring was changed to allow updates from the root
> > > > > > user it gained an ->update() function that disallows all updates.
> > > > > > When the a hash is blacklisted multiple times from the builtin or
> > > > > > firmware-provided blacklist this spams prominent logs during boot:
> > > > > > 
> > > > > > [    0.890814] blacklist: Problem blacklisting hash (-13)
> > > > > > 
> > > > > > As all these repeated calls to mark_raw_hash_blacklisted() would create
> > > > > > the same keyring entry again anyways these errors can be safely ignored.
> > > > > 
> > > > > These errors can indeed be safely ignored, however they highlight issues
> > > > > with some firmware vendors not checking nor optimizing their blocked hashes.
> > > > > This raises security concerns, and it should be fixed by firmware vendors.
> > > > 
> > > > Thanks, I was not aware that these are worth fixing.
> > > > 
> > > > > > Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
> > > > > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > > > > ---
> > > > > >     certs/blacklist.c | 4 +++-
> > > > > >     1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/certs/blacklist.c b/certs/blacklist.c
> > > > > > index 41f10601cc72..5f7f2882ced7 100644
> > > > > > --- a/certs/blacklist.c
> > > > > > +++ b/certs/blacklist.c
> > > > > > @@ -191,7 +191,9 @@ static int mark_raw_hash_blacklisted(const char *hash)
> > > > > >     				   BLACKLIST_KEY_PERM,
> > > > > >     				   KEY_ALLOC_NOT_IN_QUOTA |
> > > > > >     				   KEY_ALLOC_BUILT_IN);
> > > > > > -	if (IS_ERR(key)) {
> > > > > > +
> > > > > > +	/* Blacklisting the same hash twice fails but would be idempotent */
> > > > > > +	if (IS_ERR(key) && PTR_ERR(key) != -EACCES) {
> > > > > 
> > > > > We should not hide EACCES errors. This logs issues, which is correct for
> > > > > duplicate hashes, and can help firmware vendors to fix their database. I'd
> > > > > really like to see a different log message instead: change the duplicate
> > > > > entry error code from EACCES to EEXIST, and call pr_warn for this specific
> > > > > case.
> > > > 
> > > > Returning EACCES would require some deeper changes to how the keyring is set up
> > > 
> > > I guess you meant EEXIST?
> > 
> > Indeed, sorry.
> > 
> > > > or even changes to the keyring core itself to introduce a key_create() (without
> > > > update) function.
> > > > 
> > > > Is this something you would take a look at, or should I try to do it?
> > > > (I have no previous knowledge about the keyring subsystem)
> > > 
> > > Please take a look. I think it should not be too complex.
> > 
> > Will do.
> > 
> > My plan is to create a new function key_create() that does takes the core logic
> > of key_create_or_update() and fails with EEXIST if needed.
> > 
> > > > In any case it probably would also be good to log the problematic hashes
> > > > themselves, so users can properly report the issue to their firmware vendors.
> > > 
> > > Agree
> > 
> > I'll send a patch for that, too.
> 
> Good!
> 
> Jarkko, David, any though?

I'm happy to review a patch once it is available.

BR, Jarkko
