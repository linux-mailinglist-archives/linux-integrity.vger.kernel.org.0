Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD52641F50
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Dec 2022 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiLDTxx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Dec 2022 14:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiLDTxw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Dec 2022 14:53:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562210FC3;
        Sun,  4 Dec 2022 11:53:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B330760EA4;
        Sun,  4 Dec 2022 19:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C86C433C1;
        Sun,  4 Dec 2022 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670183630;
        bh=RLejQR7sYA3aTLkFNwubNQVioKbtcndgBCOdLg6ZlU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGGfM9j8OPNiM8KB2G4UDdXoizFVhZw0DgWJ10XBkD3eWES5J4QqyCDji6ZIYaAn9
         7OYt+ef56LxKqPy68cFafdoBI0/r0xkcCKRwAqihhWx0RMHUS7svifRh7g88jCo/NM
         ZYO9SAKY9FstMu31U+AhdVl3U40iwT0kSIYIsh82JH8l6i31oeHYuP7ysO2UYAqQby
         YuRBWbLoKkvEThY1Od1kBsLVPoiW6RjAa4O8xNae7HEV29M05AH9P7ciABJkK+WcQN
         FiheLC7vXXfvrYACscCakjiJH7KZlfWUcwNOWlH1UHFfjR9KNpHk6KyIXQ08Zsh6Nh
         nzdyMG2h/18UQ==
Date:   Sun, 4 Dec 2022 19:53:45 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tpm/tpm_crb: Fix error message in
 __crb_relinquish_locality()
Message-ID: <Y4z6yYHSidjsXABk@kernel.org>
References: <1668195533-16761-1-git-send-email-mikelley@microsoft.com>
 <Y4OSnFFhj+20wiO0@kernel.org>
 <BYAPR21MB1688C889A9EC7773EAC2CA0AD7129@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y4z6OGSyvJtdVzIi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4z6OGSyvJtdVzIi@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 04, 2022 at 07:51:20PM +0000, Jarkko Sakkinen wrote:
> On Tue, Nov 29, 2022 at 04:34:09AM +0000, Michael Kelley (LINUX) wrote:
> > From: Jarkko Sakkinen <jarkko@kernel.org> Sent: Sunday, November 27, 2022 8:39 AM
> > > 
> > > On Fri, Nov 11, 2022 at 11:38:53AM -0800, Michael Kelley wrote:
> > > > The error message in __crb_relinquish_locality() mentions requestAccess
> > > > instead of Relinquish. Fix it.
> > > >
> > > > Fixes: 888d867df441 ("tpm: cmd_ready command can be issued only after granting locality")
> > > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > > ---
> > > >  drivers/char/tpm/tpm_crb.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > > > index 1860665..65f8f17 100644
> > > > --- a/drivers/char/tpm/tpm_crb.c
> > > > +++ b/drivers/char/tpm/tpm_crb.c
> > > > @@ -252,7 +252,7 @@ static int __crb_relinquish_locality(struct device *dev,
> > > >  	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
> > > >  	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
> > > >  				 TPM2_TIMEOUT_C)) {
> > > > -		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
> > > > +		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed out\n");
> > > >  		return -ETIME;
> > > >  	}
> > > >
> > > > --
> > > > 1.8.3.1
> > > >
> > > 
> > > Please explain.
> > > 
> > 
> > There are two parallel functions:  __crb_request_locality() and
> > __crb_relinquish_locality().  In the current code, both return the
> > same text in the error message if a timeout occurs.  That
> > error message seems appropriate for __crb_request_locality()
> > since it is setting the "requestAccess" bit.
> > 
> > But the error message seems inappropriate for
> > __crb_relinquish_locality(), which is setting the "Relinquish" bit.
> > So the patch changes the error message to indicate that the
> > timeout occurred in setting the Relinquish bit.
> > 
> > I'm looking at Section 6.5.3.2.2.1 in the TCG PC Client Platform
> > TPM Profile Specification for TPM 2.0, Version 1.05 Revision 14.
> > This is where the "requestAccess" and "Relinquish" bits are defined.
> > 
> > Or maybe I am not understanding what you are getting at with
> > "Please explain."
> 
> I misread the callback name, when I first looked into this (in
> too much rush). You're absolutely correct.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

BR, Jarkko
