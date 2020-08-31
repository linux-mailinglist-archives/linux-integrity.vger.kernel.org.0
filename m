Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F27257AE9
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgHaNzf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 09:55:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:25173 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgHaNzc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 09:55:32 -0400
IronPort-SDR: FZLc/Okp5nlr0B/GbNIdItGY3Xw6XHlDljA2FlhOj+MR62rIWJyrJqcAA9ryBkZqsh9mhrwOya
 yJhQ/uEzB6dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144649132"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="144649132"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 06:55:32 -0700
IronPort-SDR: 42ZChNozaJ/VtINQ4MqDRE1NN1XmA/0C5vpiRDdj0JpxV87XgVp+S74pqH03cIAjTEssoeBerj
 Msf9Cc7KcdjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="476736102"
Received: from mrogowsk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.243])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2020 06:55:30 -0700
Date:   Mon, 31 Aug 2020 16:55:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200831135529.GA4814@linux.intel.com>
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

Ya, has been a while so had to check.

Also, looking at the discussion in the past I'm very confused is this
problem related to particular models of a particular vendor or does this
occur among multiple vendors.

Also, the inline comment needs a rewrite. It literally says that this
has not been observed in practice, which literally tells me not to
merge this one. Also the explanation "status is somewhow bad" does not
really make any sense. I don't know what it means something is "somehow
bad".



This must be clarified in the commit message.

> Thanks again,
> Jason

/Jarkko
