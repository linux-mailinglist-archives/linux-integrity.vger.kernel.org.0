Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B8E61F9F6
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 17:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKGQfi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 11:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiKGQfh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 11:35:37 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3ABBF;
        Mon,  7 Nov 2022 08:35:36 -0800 (PST)
Date:   Mon, 7 Nov 2022 17:35:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667838934;
        bh=QO+AH8+RKxg573nBkHttain+idpepyb5rcFtAAmb7HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIU/RB62uXmFHonTf6LauX2MA6kUtmpix9Lr4zDDqAqHAAtjh5v4w8VKV/2fBuwmh
         +4IFlJ3a7Dz8WKSWefUIDM8tD9FVkvEkpcMIJKJJKhxZtasLWBayaLk6R+DgmClBxW
         LK8ufaNBmHhn87Dmchhfp0DAciqZAwTqMUUr4FSE=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] certs: Prevent spurious errors on repeated blacklisting
Message-ID: <706c75af-9569-42fd-ba68-533ed931d55d@t-8ch.de>
References: <20221104014704.3469-1-linux@weissschuh.net>
 <3b997266-067c-975c-911a-da146fe9033a@digikod.net>
 <db5890d8-3a3d-4ca7-bb58-655c26164587@t-8ch.de>
 <8692915f-437c-56fd-8984-d6febf533fa9@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8692915f-437c-56fd-8984-d6febf533fa9@digikod.net>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022-11-07 17:20+0100, Mickaël Salaün wrote:
> On 07/11/2022 16:55, Thomas Weißschuh wrote:
> > On 2022-11-07 14:12+0100, Mickaël Salaün wrote:
> > > This is a follow-up of
> > > https://lore.kernel.org/r/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de
> > > 
> > > Added Jarkko, Mark Pearson, Eric Snowberg and more ML in Cc.
> > > 
> > > 
> > > On 04/11/2022 02:47, Thomas Weißschuh wrote:
> > > > When the blacklist keyring was changed to allow updates from the root
> > > > user it gained an ->update() function that disallows all updates.
> > > > When the a hash is blacklisted multiple times from the builtin or
> > > > firmware-provided blacklist this spams prominent logs during boot:
> > > > 
> > > > [    0.890814] blacklist: Problem blacklisting hash (-13)
> > > > 
> > > > As all these repeated calls to mark_raw_hash_blacklisted() would create
> > > > the same keyring entry again anyways these errors can be safely ignored.
> > > 
> > > These errors can indeed be safely ignored, however they highlight issues
> > > with some firmware vendors not checking nor optimizing their blocked hashes.
> > > This raises security concerns, and it should be fixed by firmware vendors.
> > 
> > Thanks, I was not aware that these are worth fixing.
> > 
> > > > Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > ---
> > > >    certs/blacklist.c | 4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/certs/blacklist.c b/certs/blacklist.c
> > > > index 41f10601cc72..5f7f2882ced7 100644
> > > > --- a/certs/blacklist.c
> > > > +++ b/certs/blacklist.c
> > > > @@ -191,7 +191,9 @@ static int mark_raw_hash_blacklisted(const char *hash)
> > > >    				   BLACKLIST_KEY_PERM,
> > > >    				   KEY_ALLOC_NOT_IN_QUOTA |
> > > >    				   KEY_ALLOC_BUILT_IN);
> > > > -	if (IS_ERR(key)) {
> > > > +
> > > > +	/* Blacklisting the same hash twice fails but would be idempotent */
> > > > +	if (IS_ERR(key) && PTR_ERR(key) != -EACCES) {
> > > 
> > > We should not hide EACCES errors. This logs issues, which is correct for
> > > duplicate hashes, and can help firmware vendors to fix their database. I'd
> > > really like to see a different log message instead: change the duplicate
> > > entry error code from EACCES to EEXIST, and call pr_warn for this specific
> > > case.
> > 
> > Returning EACCES would require some deeper changes to how the keyring is set up
> 
> I guess you meant EEXIST?

Indeed, sorry.

> > or even changes to the keyring core itself to introduce a key_create() (without
> > update) function.
> > 
> > Is this something you would take a look at, or should I try to do it?
> > (I have no previous knowledge about the keyring subsystem)
> 
> Please take a look. I think it should not be too complex.

Will do.

My plan is to create a new function key_create() that does takes the core logic
of key_create_or_update() and fails with EEXIST if needed.

> > In any case it probably would also be good to log the problematic hashes
> > themselves, so users can properly report the issue to their firmware vendors.
> 
> Agree

I'll send a patch for that, too.

As for this patch's Fixes-tag, it could refer to either the commit that
introduced the logging in the first place or the one that actively started to
trigger it:
* 734114f8782f ("KEYS: Add a system blacklist keyring")
* 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")

Personally I'd tend to use the latter.

> > > >    		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
> > > >    		return PTR_ERR(key);
> > > >    	}
> > > > 
> > > > base-commit: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
