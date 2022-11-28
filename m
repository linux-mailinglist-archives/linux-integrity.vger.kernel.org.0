Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D82639F22
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 02:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiK1B7b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 20:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1B7a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 20:59:30 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625E6DFFF;
        Sun, 27 Nov 2022 17:59:29 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:59:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669600767;
        bh=6bLjo6zSUiel5ocq0aZAs181VjD/dTQcfURr0PI89DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEgFqC5bZJylcOj3OUuUE57So9eNi4aGm4JR+yTVOjMtCr1+EimA4Lm4X5bGV3hkg
         Bqf/KYPqlrYvrwi3JOOk3LBckYrlVnbn+gNrNrAbJoDIbwf0DAM3Jnc45a38n9yDKo
         jOgUz3mxYrj41XnBxeAwr7su/LlFa2baKlQbmJtM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/3] certs: log hash value on blacklist error
Message-ID: <8b9e9bf8-ae44-485a-9b30-85a71a236f06@t-8ch.de>
References: <20221118040343.2958-1-linux@weissschuh.net>
 <20221118040343.2958-2-linux@weissschuh.net>
 <Y4QK2cmptp4vpRj/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4QK2cmptp4vpRj/@kernel.org>
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

On 2022-11-28 03:11+0200, Jarkko Sakkinen wrote:
> "Make blacklisted hash available in klog"
> 
> On Fri, Nov 18, 2022 at 05:03:41AM +0100, Thomas Weißschuh wrote:
> > Without this information these logs are not actionable.
> 
> Without blacklisted hash?
> 
> > For example on duplicate blacklisted hashes reported by the system
> > firmware users should be able to report the erroneous hashes to their
> > system vendors.
> > 
> > While we are at it use the dedicated format string for ERR_PTR.
> 
> Lacks the beef so saying "while we are at it" makes no sense.

What about this:

  [PATCH] certs: make blacklisted hash available in klog

  One common situation triggering this log statement are duplicate hashes
  reported by the system firmware.

  These duplicates should be removed from the firmware.

  Without logging the blacklisted hash triggering the issue however the users
  can not report it properly to the firmware vendors and the firmware vendors
  can not easily see which specific hash is duplicated.

  While changing the log message also use the dedicated ERR_PTR format
  placeholder for the returned error value.

> > Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
> 
> Why does this count as a bug?

These error logs are confusing to users, prompting them to waste time
investigating them and even mess with their firmware settings.
(As indicated in the threads linked from the cover letter)

The most correct fix would be patches 2 and 3 from this series.

I was not sure if patch 2 would be acceptable for stable as it introduces new
infrastructure code.
So patch 1 enables users to report the issue to their firmware vendors and get
the spurious logs resolved that way.

If these assumptions are incorrect I can fold patch 1 into patch 3.

But are patch 2 and 3 material for stable?

> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  certs/blacklist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/certs/blacklist.c b/certs/blacklist.c
> > index 41f10601cc72..6e260c4b6a19 100644
> > --- a/certs/blacklist.c
> > +++ b/certs/blacklist.c
> > @@ -192,7 +192,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
> >  				   KEY_ALLOC_NOT_IN_QUOTA |
> >  				   KEY_ALLOC_BUILT_IN);
> >  	if (IS_ERR(key)) {
> > -		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
> > +		pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
> >  		return PTR_ERR(key);
> >  	}
> >  	return 0;
> > -- 
> > 2.38.1
> > 
> 
> BR, Jarkko
