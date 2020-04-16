Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F421ACE6C
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgDPRJw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 13:09:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:40442 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgDPRJv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 13:09:51 -0400
IronPort-SDR: +IEHz79vFGnyZSm1wSXe4mLFMla46vBl+EKQxs02xLy3FQsZahNvpz+fd8HO8It6ih9jxsrOj5
 mEXpT/1piBbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 10:09:47 -0700
IronPort-SDR: 26g97DMABcd9BgvNCYOwN/M5tWqKTOndQhjwYw27H4cEUyx8Kbdu0Ud6Onu4k33nXyDQRss5U/
 CvhLfXoVRcHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="299358161"
Received: from otazetdi-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.42.128])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Apr 2020 10:09:46 -0700
Date:   Thu, 16 Apr 2020 20:09:44 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200416170944.GE199110@linux.intel.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
 <1586994699.3931.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586994699.3931.18.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 15, 2020 at 04:51:39PM -0700, James Bottomley wrote:
> On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > We've encountered a particular model of STMicroelectronics TPM that
> > transiently returns a bad value in the status register. This causes
> > the kernel to believe that the TPM is ready to receive a command when
> > it actually isn't, which in turn causes the send to time out in
> > get_burstcount(). In testing, reading the status register one extra
> > time convinces the TPM to return a valid value.
> 
> Interesting, I've got a very early upgradeable nuvoton that seems to be
> behaving like this.
> 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > b/drivers/char/tpm/tpm_tis_core.c
> > index 27c6ca031e23..277a21027fc7 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -238,6 +238,18 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
> >  	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
> >  	if (rc < 0)
> >  		return 0;
> > +	/*
> > +	 * Some STMicroelectronics TPMs have a bug where the status
> > register is
> > +	 * sometimes bogus (all 1s) if read immediately after the
> > access
> > +	 * register is written to. Bits 0, 1, and 5 are always
> > supposed to read
> > +	 * as 0, so this is clearly invalid. Reading the register a
> > second time
> > +	 * returns a valid value.
> > +	 */
> > +	if (unlikely(status == 0xff)) {
> > +		rc = tpm_tis_read8(priv, TPM_STS(priv->locality),
> > &status);
> > +		if (rc < 0)
> > +			return 0;
> > +	}
> 
> You theorize that your case is fixed by the second read, but what if it
> isn't and the second read also returns 0xff?  Shouldn't we have a line
> here saying
> 
> if (unlikely(status == 0xff))
> 	status = 0;
> 
> So if we get a second 0xff we just pretend the thing isn't ready?

If it eventually settles, would it be better to poll it for a while?

Also, the commit message is ambiguous. "bad value" can be any random
bit sequence.

/Jarkko
