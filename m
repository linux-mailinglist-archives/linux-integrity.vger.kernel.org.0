Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7516FCB25
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 17:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKNQzM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 11:55:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:43693 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfKNQzM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 11:55:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 08:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="203343870"
Received: from pkamlakx-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.10.73])
  by fmsmga007.fm.intel.com with ESMTP; 14 Nov 2019 08:55:08 -0800
Date:   Thu, 14 Nov 2019 18:55:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191114165357.GA11107@linux.intel.com>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca>
 <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 12, 2019 at 01:28:49PM -0700, Jerry Snitselaar wrote:
> On Tue, Nov 12, 2019 at 1:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Nov 12, 2019 at 01:23:33PM -0700, Jerry Snitselaar wrote:
> > > On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > > > > With power gating moved out of the tpm_transmit code we need
> > > > > to power on the TPM prior to calling tpm_get_timeouts.
> > > > >
> > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: linux-stable@vger.kernel.org
> > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > > > > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > > > index 270f43acbb77..cb101cec8f8b 100644
> > > > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > > > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> > > > >                * to make sure it works. May as well use that command to set the
> > > > >                * proper timeouts for the driver.
> > > > >                */
> > > > > +             tpm_chip_start(chip);
> > > > >               if (tpm_get_timeouts(chip)) {
> > > > >                       dev_err(dev, "Could not get TPM timeouts and durations\n");
> > > > >                       rc = -ENODEV;
> > > > > +                     tpm_stop_chip(chip);
> > > > >                       goto out_err;
> > > > >               }
> > > >
> > > > Couldn't this call just be removed?
> > > >
> > > > /Jarkko
> > > >
> > >
> > > Probably. It will eventually get called when tpm_chip_register
> > > happens. I don't know what the reason was for trying it prior to the
> > > irq probe.
> >
> > At least tis once needed the timeouts before registration because it
> > was issuing TPM commands to complete its setup.
> >
> > If timeouts have not been set then no TPM command should be executed.
> >
> > Jason
> >
> 
> Would it function with the timeout values set at the beginning of
> tpm_tis_core_init (max values)?

tpm_get_timeouts() should be replaced with:

if (tpm_chip_start()) {
	dev_err(dev, "Could not get TPM timeouts and durations\n");
	rc = -ENODEV;
	goto out_err;
}

tpm_stop_chip(chip);

tpm_get_timeouts() is called by tpm_auto_startup(). Also the function
should be moved to tpm_chip.c and converted to a static function so
that it won't be called from random cal sites like above.

/Jarkko
