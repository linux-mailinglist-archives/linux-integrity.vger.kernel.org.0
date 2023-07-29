Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9098F767CB0
	for <lists+linux-integrity@lfdr.de>; Sat, 29 Jul 2023 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjG2HGk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 29 Jul 2023 03:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2HGj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 29 Jul 2023 03:06:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A94444B5;
        Sat, 29 Jul 2023 00:06:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C24A21877;
        Sat, 29 Jul 2023 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690614387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hruDKRTvR5SMzi7846D24SG5JBDg1T39vGsU0UKcgHw=;
        b=k6X0Z60yBL/hsBDXkRrdPeeVfiVG5Rtwl7JTtjYHu3WMwYwCkIW1p8yh3OZj+4WEG1YwnF
        cHvyudx3r+tbRG1u9xKO2M/XD8CjNR18RbXPgwyKGOc1fg2aDomCcD3gDEnYzHq3dXeVWJ
        XYPIbuVdM12Vx4XEcVq6nlZf8KXhp+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690614387;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hruDKRTvR5SMzi7846D24SG5JBDg1T39vGsU0UKcgHw=;
        b=Wyj+5oronPPffqYsWt5qDvcUHtg+3OFtrT5COZnK/Cht0IeAj4oh+siKzM1bkBxaAKJot6
        wJXUwtNWA4LCJeCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C7EC13596;
        Sat, 29 Jul 2023 07:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NgDzDXO6xGQLFgAAMHmgww
        (envelope-from <tiwai@suse.de>); Sat, 29 Jul 2023 07:06:27 +0000
Date:   Sat, 29 Jul 2023 09:06:26 +0200
Message-ID: <878razdwnh.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Takashi Iwai" <tiwai@suse.de>, "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for TUXEDO InfinityBook S 15/17 Gen7
In-Reply-To: <CUE1URH8QI55.15YQBHZNSL2UJ@seitikki>
References: <20230726180035.14511-1-tiwai@suse.de>
        <CUE1URH8QI55.15YQBHZNSL2UJ@seitikki>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 28 Jul 2023 21:24:30 +0200,
Jarkko Sakkinen wrote:
> 
> On Wed Jul 26, 2023 at 6:00 PM UTC, Takashi Iwai wrote:
> > TUXEDO InfinityBook S 15/17 Gen7 suffers from an IRQ problem on
> > tpm_tis like a few other laptops.  Add an entry for the workaround.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> > Link: https://bugzilla.suse.com/show_bug.cgi?id=1213645
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  drivers/char/tpm/tpm_tis.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> > index cc42cf3de960..a98773ac2e55 100644
> > --- a/drivers/char/tpm/tpm_tis.c
> > +++ b/drivers/char/tpm/tpm_tis.c
> > @@ -162,6 +162,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
> >  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
> >  		},
> >  	},
> > +	{
> > +		.callback = tpm_tis_disable_irq,
> > +		.ident = "TUXEDO InfinityBook S 15/17 Gen7",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "TUXEDO InfinityBook S 15/17 Gen7"),
> > +		},
> > +	},
> >  	{
> >  		.callback = tpm_tis_disable_irq,
> >  		.ident = "UPX-TGL",
> > -- 
> > 2.35.3
> 
> Hi does this occur with the latest linux-next and/or v6.5-rc3?

Not tested yet, but do you have any relevant fix except for the commit
481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandled
IRQs")?  That commit was already tested, at least.


thanks,

Takashi
