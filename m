Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF6528C6A
	for <lists+linux-integrity@lfdr.de>; Mon, 16 May 2022 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiEPRzv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiEPRzu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 13:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34661FA4D;
        Mon, 16 May 2022 10:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F13361328;
        Mon, 16 May 2022 17:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79485C385AA;
        Mon, 16 May 2022 17:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652723747;
        bh=goXFeXlLpONwFnhWgolTtOIqWpucoeNyIZd7yZ63G8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XdsOZPA+/BUEtLbSivCtZZwJuxQuGJXMUKKGdG4MBng3xZN9iF7EQ3w5ngbpsNv7A
         BVoivSm4VxmWF9R34FX93AB9LP55jOwrJ+goUqGXYv9LIXmv4+AV/8LT9+k0jQxXTY
         D3CxqoYU93eX7QC0VxnOBFNNPL0pa+KqrQNd/SSQ4val2+62PCN7HrWM80y1fpu/FS
         PyDE8IAgaipY06SDw8mDghglChuxRBC2Tl9dEhPcHq70D/MT53+6FA/2dmebMHJE/t
         RSNAvZmv7fjWUND55bFMquyv2OJeoSFZV0A0LNhJViikYkc76rDZphcEp1chZ7FNuY
         zXooKYJBZeZxQ==
Date:   Mon, 16 May 2022 20:54:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Johannes Holland <johannes.holland@infineon.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
Message-ID: <YoKPxMLuWWK2al9F@kernel.org>
References: <20220510112902.23213-1-johannes.holland@infineon.com>
 <YnvTSqRgYkWu0qgp@kernel.org>
 <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 12, 2022 at 08:21:17AM -0400, Mimi Zohar wrote:
> On Wed, 2022-05-11 at 18:16 +0300, Jarkko Sakkinen wrote:
> > On Tue, May 10, 2022 at 01:29:03PM +0200, Johannes Holland wrote:
> > > To comply with protocol requirements, minimum polling times must often
> > > be adhered to. Therefore, a macro like tpm_msleep() should sleep at
> > > least the given amount of time (not up to the given period). Have
> > > tpm_msleep() sleep at least the given number of milliseconds.
> > > 
> > > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > > ---
> > >  drivers/char/tpm/tpm.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > index 2163c6ee0d36..0971b55fffe3 100644
> > > --- a/drivers/char/tpm/tpm.h
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -185,8 +185,8 @@ int tpm_pm_resume(struct device *dev);
> > >  
> > >  static inline void tpm_msleep(unsigned int delay_msec)
> > >  {
> > > -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
> > > -		     delay_msec * 1000);
> > > +	usleep_range(delay_msec * 1000, (delay_msec * 1000)
> > > +		     + TPM_TIMEOUT_RANGE_US);
> > >  };
> > >  
> > >  int tpm_chip_start(struct tpm_chip *chip);
> > > -- 
> > > 2.34.1
> > > 
> > 
> > For this I would really like to hear a 2nd opinion from Nayna and Mimi.
> 
> This patch reverts commit 5ef924d9e2e8 ("tpm: use tpm_msleep() value as
> max delay").    Are you experiencing TPM issues that require it?
> 
> thanks,
> 
> Mimi

Yeah, there's no data to support making anything.  Without a live
system having issues with this, I guess this quite definitive NAK.

BR, Jarkko
