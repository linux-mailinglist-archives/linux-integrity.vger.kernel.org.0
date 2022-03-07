Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052034D0471
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Mar 2022 17:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbiCGQrF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Mar 2022 11:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiCGQrA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Mar 2022 11:47:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD26592D09;
        Mon,  7 Mar 2022 08:46:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F60FB81646;
        Mon,  7 Mar 2022 16:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C27C340EF;
        Mon,  7 Mar 2022 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646671563;
        bh=dduVYNYjI45iLgiaw8xX4aXIMQDDaw0lYUSciMWQNXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kxU05fg3J5MZMelr0NQfKzQF8u9Vwyj8cJCo5Y7PPZPqxwIeiPvkIxk/NAuUhCQ/V
         L/zuK+EldtEwS6L0X54H52vquhVDr82NYMKim4VwZBt84/yuD7NHIcRDe7RR5iNwM6
         PZ0pnDtWUKdu4eYl/ZPs3vogu4nE1JvyffIGTgF00gNDeNZsmkH/IFQIMkiEhazS3u
         rofAuVSDibFhV9GM16x1zchrShGehY4ZKZyVbOACojaBL6rfETi57GNQYBd2HmwNYQ
         lcKSUhgcY+WSSVGJNUVNMorYQcLkkMrAO4dP7OuhCKbHuEmE3+12SfHINDlozwwdTF
         GNf+Ly42ulR4A==
Date:   Mon, 7 Mar 2022 18:45:22 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Rework open/close/shutdown to avoid races
Message-ID: <YiY2oqg/X02SnYEl@iki.fi>
References: <20201215133801.546207-1-s.temerkhanov@gmail.com>
 <e7566e1e48f5be9dca034b4bfb67683b5d3cb88f.camel@HansenPartnership.com>
 <YiYnpsryEDlrryzU@iki.fi>
 <120839d2925750e278810b2ad211f5465638f7b0.camel@HansenPartnership.com>
 <YiY2X/0W+6aRHioN@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiY2X/0W+6aRHioN@iki.fi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 07, 2022 at 06:44:17PM +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 07, 2022 at 11:22:27AM -0500, James Bottomley wrote:
> > On Mon, 2022-03-07 at 17:41 +0200, Jarkko Sakkinen wrote:
> > [...]
> > > James, would it possible for you to construct a proper patch from
> > > this and send it so we could include it to the next PR (use my tree
> > > as baseline)?
> > 
> > Sure,  There's not really any identifiable patch for a fixes tag, since
> > the race really always existed.
> > 
> > How about the below.
> > 
> > James
> > 
> > -------------------8>8>8><8<8<8------------------
> > 
> > From 3e0e640e47e5728b68693c5d45bf3cdd0bff48ca Mon Sep 17 00:00:00 2001
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Date: Mon, 7 Mar 2022 11:16:55 -0500
> > Subject: [PATCH] tpm: use try_get_ops() in tpm-space.c
> > 
> > As part of the series conversion to remove nested TPM operations:
> > 
> > https://lore.kernel.org/all/20190205224723.19671-1-jarkko.sakkinen@linux.intel.com/
> > 
> > exposure of the chip->tpm_mutex was removed from much of the upper
> > level code.  In this conversion, tpm2_del_space() was missed.  This
> > didn't matter much because it's usually called closely after a
> > converted operation, so there's only a very tiny race window where the
> > chip can be removed before the space flushing is done which causes a
> > NULL deref on the mutex.  However, there are reports of this window
> > being hit in practice, so fix this by converting tpm2_del_space() to
> > use tpm_try_get_ops(), which performs all the teardown checks before
> > acquring the mutex.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > ---
> >  drivers/char/tpm/tpm2-space.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> > index 265ec72b1d81..ffb35f0154c1 100644
> > --- a/drivers/char/tpm/tpm2-space.c
> > +++ b/drivers/char/tpm/tpm2-space.c
> > @@ -58,12 +58,12 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
> >  
> >  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
> >  {
> > -	mutex_lock(&chip->tpm_mutex);
> > -	if (!tpm_chip_start(chip)) {
> > +
> > +	if (tpm_try_get_ops(chip) == 0) {
> >  		tpm2_flush_sessions(chip, space);
> > -		tpm_chip_stop(chip);
> > +		tpm_put_ops(chip);
> >  	}
> > -	mutex_unlock(&chip->tpm_mutex);
> > +
> >  	kfree(space->context_buf);
> >  	kfree(space->session_buf);
> >  }
> > -- 
> > 2.34.1
> > 
> > 
> 
> Thank you! LGTM. 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko

If possible, can you send this an identifiable patch (separate email)
with my reviewed-by applied, and I'll take it from there (i.e. it's
then available all trackers such patchwork etc.)?

BR, Jarkko
