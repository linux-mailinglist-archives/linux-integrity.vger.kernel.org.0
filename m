Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EEE528C6E
	for <lists+linux-integrity@lfdr.de>; Mon, 16 May 2022 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbiEPR6p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 13:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiEPR6p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 13:58:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C8739BB6;
        Mon, 16 May 2022 10:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B26F8B815A3;
        Mon, 16 May 2022 17:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9EFC385AA;
        Mon, 16 May 2022 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652723921;
        bh=fEJHAl8Tx0tNCX6mwo3W2Lt3iVpIDp7W5UZcE1jWQRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ek+q6wuK6FdG4wJk8lFw+BmYVb7/hhCWbHn66LzXtUFX17u0Pgf0lVVdDQhqj7eHb
         ybGpwqjVPDXWPGRAlRnTa0CtQJXcsebuC7r4rzBJ0Nc3ZWYN7OVqwX024muH+aBCAL
         oC+Ak5ep3xZ+x0kG3FYjXT7I29q4UbyXZu3DB5Gkcc9iEm7X8+2UsEbv79T1un2xPE
         92QpnoKAM93RPtV1jks68Ix/7nGyAq5NjN/tzKel3N800ljNVJAQAmbKLJpwDfS/Pt
         DG5WFaePQQoiq/PYa/ZCCVvpOzedfBaeEmSse0sjCt8sweAOl+wbfaZ88r+juSUmiA
         pwCi+A/EJPCBA==
Date:   Mon, 16 May 2022 20:57:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Johannes Holland <johannes.holland@infineon.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
Message-ID: <YoKQchfJ//FUws7i@kernel.org>
References: <20220510112902.23213-1-johannes.holland@infineon.com>
 <YnvTSqRgYkWu0qgp@kernel.org>
 <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
 <eb9ef8aeab4c0284028c013a2c86b248719a46ae.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb9ef8aeab4c0284028c013a2c86b248719a46ae.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 12, 2022 at 08:32:55AM -0400, James Bottomley wrote:
> On Thu, 2022-05-12 at 08:21 -0400, Mimi Zohar wrote:
> > On Wed, 2022-05-11 at 18:16 +0300, Jarkko Sakkinen wrote:
> > > On Tue, May 10, 2022 at 01:29:03PM +0200, Johannes Holland wrote:
> > > > To comply with protocol requirements, minimum polling times must
> > > > often
> > > > be adhered to. Therefore, a macro like tpm_msleep() should sleep
> > > > at
> > > > least the given amount of time (not up to the given period). Have
> > > > tpm_msleep() sleep at least the given number of milliseconds.
> > > > 
> > > > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > > > ---
> > > >  drivers/char/tpm/tpm.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > > index 2163c6ee0d36..0971b55fffe3 100644
> > > > --- a/drivers/char/tpm/tpm.h
> > > > +++ b/drivers/char/tpm/tpm.h
> > > > @@ -185,8 +185,8 @@ int tpm_pm_resume(struct device *dev);
> > > >  
> > > >  static inline void tpm_msleep(unsigned int delay_msec)
> > > >  {
> > > > -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
> > > > -		     delay_msec * 1000);
> > > > +	usleep_range(delay_msec * 1000, (delay_msec * 1000)
> > > > +		     + TPM_TIMEOUT_RANGE_US);
> > > >  };
> > > >  
> > > >  int tpm_chip_start(struct tpm_chip *chip);
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > For this I would really like to hear a 2nd opinion from Nayna and
> > > Mimi.
> > 
> > This patch reverts commit 5ef924d9e2e8 ("tpm: use tpm_msleep() value
> > as max delay").    Are you experiencing TPM issues that require it?
> 
> I am:
> 
> https://lore.kernel.org/linux-integrity/1531328689.3260.8.camel@HansenPartnership.com/
> 
> I'm about 24h into a soak test of the patch with no TPM failure so far.
> I think it probably needs to run another 24h just to be sure, but it
> does seem the theory is sound (my TPM gets annoyed by being poked too
> soon) so reverting 5ef924d9e2e8 looks to be the correct action.  The
> only other ways I've found to fix this are either revert the
> usleep_range patch altogether or increase the timings:
> 
> https://lore.kernel.org/linux-integrity/1531329074.3260.9.camel@HansenPartnership.com/
> 
> Which obviously pushes the min past whatever issue my TPM is having
> even with 5ef924d9e2e8 applied.
> 
> Given that even the commit message for 5ef924d9e2e8 admits it only
> shaves about 12% off the TPM response time, that would appear to be an
> optimization too far if it's going to cause some TPMs to fail.
> 
> James

What if TPM started with the timings as they are now and use the
"reverted" timings if coming up too early?  The question here is
though,  is such complexity worth of anything or should we just
revert and do nothing else.

BR, Jarkko
