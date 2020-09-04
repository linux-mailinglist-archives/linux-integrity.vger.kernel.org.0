Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE32025D852
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgIDMDf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 08:03:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:9695 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730073AbgIDMDb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 08:03:31 -0400
IronPort-SDR: lIIrEPhe8Vpg7HodJuIsTTTuD2DYXB4iFW5SRNYyYBkc3/hOQSEcopPm9SwIGtAugHuULABE87
 PMAicL9forvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="158706867"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="158706867"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 05:03:19 -0700
IronPort-SDR: 2srGKUNmMzUk8uU165RbEpVQdvL2n0U71fDpUBvN8ZJEb12PmPBkAYM3F56DsVtQEpW0H1FwtE
 fDNhitbOe8Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="376225692"
Received: from pipper-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.56.104])
  by orsmga001.jf.intel.com with ESMTP; 04 Sep 2020 05:03:17 -0700
Date:   Fri, 4 Sep 2020 15:03:17 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200904120317.GC39023@linux.intel.com>
References: <1586994699.3931.18.camel@HansenPartnership.com>
 <20200827152445.15439-1-jandryuk@gmail.com>
 <20200828231823.GA20705@linux.intel.com>
 <CAKf6xpvJTChV5+pULrWwx7JX+jS6r8nM9mGEBJLQN3P4D1uO_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKf6xpvJTChV5+pULrWwx7JX+jS6r8nM9mGEBJLQN3P4D1uO_g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 28, 2020 at 08:12:55PM -0400, Jason Andryuk wrote:
> On Fri, Aug 28, 2020 at 7:18 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Thu, Aug 27, 2020 at 11:24:45AM -0400, Jason Andryuk wrote:
> > > James Bottomley wrote:
> > > >On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> > > >> From: Omar Sandoval <osandov@fb.com>
> > > >>
> > > >> We've encountered a particular model of STMicroelectronics TPM that
> > > >> transiently returns a bad value in the status register. This causes
> > > >> the kernel to believe that the TPM is ready to receive a command when
> > > >> it actually isn't, which in turn causes the send to time out in
> > > >> get_burstcount(). In testing, reading the status register one extra
> > > >> time convinces the TPM to return a valid value.
> > > >
> > > >Interesting, I've got a very early upgradeable nuvoton that seems to be
> > > >behaving like this.
> > > >
> > > >> Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > >> ---
> > > >>  drivers/char/tpm/tpm_tis_core.c | 12 ++++++++++++
> > > >>  1 file changed, 12 insertions(+)
> > > >>
> > > >> diff --git a/drivers/char/tpm/tpm_tis_core.c
> > > >> b/drivers/char/tpm/tpm_tis_core.c
> > > >> index 27c6ca031e23..277a21027fc7 100644
> > > >> --- a/drivers/char/tpm/tpm_tis_core.c
> > > >> +++ b/drivers/char/tpm/tpm_tis_core.c
> > > >> @@ -238,6 +238,18 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
> > > >>    rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
> > > >>    if (rc < 0)
> > > >>            return 0;
> > > >> +  /*
> > > >> +   * Some STMicroelectronics TPMs have a bug where the status
> > > >> register is
> > > >> +   * sometimes bogus (all 1s) if read immediately after the
> > > >> access
> > > >> +   * register is written to. Bits 0, 1, and 5 are always
> > > >> supposed to read
> > > >> +   * as 0, so this is clearly invalid. Reading the register a
> > > >> second time
> > > >> +   * returns a valid value.
> > > >> +   */
> > > >> +  if (unlikely(status == 0xff)) {
> > > >> +          rc = tpm_tis_read8(priv, TPM_STS(priv->locality),
> > > >> &status);
> > > >> +          if (rc < 0)
> > > >> +                  return 0;
> > > >> +  }
> > > >
> > > >You theorize that your case is fixed by the second read, but what if it
> > > >isn't and the second read also returns 0xff?  Shouldn't we have a line
> > > >here saying
> > > >
> > > >if (unlikely(status == 0xff))
> > > >     status = 0;
> > > >
> > > >So if we get a second 0xff we just pretend the thing isn't ready?
> > >
> > > Thanks for the fix, Omar!
> > >
> > > I tried the patch and it helps with STM TPM2 issues where commands fail
> > > with the kernel reporting:
> > > tpm tpm0: Unable to read burstcount
> > > tpm tpm0: tpm_try_transmit: send(): error -16
> > >
> > > My testing was with 5.4, and I'd like to see this CC-ed stable.
> > >
> > > When trying to diagnose the issue before finding this patch, I found it
> > > was timing sensitive.  I was seeing failures in the OpenXT installer.
> > > The system is basically idle when issuing TPM commands which frequently
> > > failed.  The same hardware booted into a Fedora Live USB image didn't
> > > have any TPM command failures.  One notable difference between the two
> > > is Fedora is CONFIG_PREEMPT=y and OpenXT is CONFIG_PREEMPT_NONE=y.
> > > Switching OpenXT to PREEMPT=y helped some, but there were still some
> > > issues with commands failing.  The second interesting thing was running tpm
> > > commands in OpenXT under trace-cmd let them succeed.  I guess that was enough
> > > to throw the timing off.
> > >
> > > Anyway, I'd like to see this patch applied, please.
> > >
> > > Thanks,
> > > Jason
> >
> > There was v2 sent after this:
> >
> > https://patchwork.kernel.org/patch/11492125/
> 
> Thanks!  That one didn't come up in a search for STM on lore.kernel.org.
> 
> > Unfortunately it lacks changelog. What was changed between v1 and v2?
> > Why v3 has not been sent yet? I see a discussion with no final
> > conclusion.
> 
> Looks like v2 added James's suggestion with a comment (sorry the
> formating is off):
> 
> + /*
> + * The status is somehow still bad. This hasn't been observed in
> + * practice, but clear it just in case so that it doesn't appear
> + * to be ready.
> + */
> + if (unlikely(status == 0xff))
> +         status = 0;
> 
> But, yes, the decision on the alternate approach is unresolved.
> 
> Thanks again,
> Jason

I'm happy to apply this patch as soon as there is either v3 or some
resolution to v2 discussion.

/Jarkko
