Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1B3B7792
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhF2SHP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 14:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhF2SHP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 14:07:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5073061D3A;
        Tue, 29 Jun 2021 18:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624989887;
        bh=YPOFHBD348Q6Wp5csZojpDL738bfPnIZe0WaHzsW8iQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alMGrkfAVKyXHfz7kvFhCDlF3gVCz99Jo97v+Qzznt+72rSBOHsgKIs7CYVt3Um5o
         gwBpPmPBmrmUCYCPsmI35/Om/m7BFxAvAiHpTRcqueA4ESrr5byovb1I4lZ2/z0BOt
         YkDCBumN/FI4Zvy273xiUgtzJW3O9FUew7MOycwyInfO8uNBwvLPW7b3CYlE3RDpE3
         DLUUBlnaqK8xjIe78nE0AyYdAmy1XoX0KkOvm8T73rASoPW8y8nlkpJZxxMOf02Yn/
         LFht2uiGb87MPIXwhImV2dohiNynUCyi/wdDIaCJ6dM6dt/IK25SPhKN/AoRgEhHVO
         z006QAoZEjqbw==
Date:   Tue, 29 Jun 2021 21:04:45 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel
 backtraces]
Message-ID: <20210629180445.oind62rsktevm45q@kernel.org>
References: <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
 <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
 <49bfb4a7-eb3c-77f9-ff8e-b37617a26195@redhat.com>
 <20210623134054.45gjj2wbgz7jpjmy@kernel.org>
 <90ed51b4-66d4-fb10-ca8e-d99532028fab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ed51b4-66d4-fb10-ca8e-d99532028fab@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 23, 2021 at 03:54:59PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/23/21 3:40 PM, Jarkko Sakkinen wrote:
> > On Mon, Jun 21, 2021 at 02:04:52PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 6/14/21 3:33 PM, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 6/1/21 6:04 PM, Hans de Goede wrote:
> >>>> Hi,
> >>>>
> >>>> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
> >>>>>> Interestingly enough the first backtrace is also happening on a:
> >>>>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
> >>>>>>
> >>>>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
> >>>>>> all reports are about the XPS 13 9310. I wonder if there is an
> >>>>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
> >>>>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
> >>>>>
> >>>>> This is helpful for sure that these all are happening on matching hardware.
> >>>>
> >>>> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
> >>>> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
> >>>>
> >>>> 1. Backtrace starting with a call to ima_add_boot_aggregate
> >>>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> >>>>
> >>>> 2. Backtrace starting with a call to tpm_dev_async_work:
> >>>> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
> >>>> (note this one is not easily reproducible)
> >>>>
> >>>> 3. Backtrace starting with a call to rng_dev_read:
> >>>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> >>>>
> >>>> 3. is the new one. All bugs linked above are public, all 3 backtraces
> >>>> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
> >>>> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
> >>>
> >>> Quick status update, I've got a response from a XPS 13 9310 user in:
> >>>
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> >>>
> >>> Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
> >>> and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
> >>> (I expected this because all the bug-reports started when the interrupt
> >>> code got fixed/re-enabled a while ago).
> >>
> >> One more status update.
> >>
> >> - A new 4th variant of the backtrace has been spotted, where the problem hits
> >> when called from probe() -> tpm2_auto_startup -> tpm2_do_selftest, see:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1958381
> >>
> >> - So far all reports with kernel >= 5.12.6 have been on a Dell XPS 13 9310
> >> models. But the new variant is happening on a Dell XPS 15 9500 and the
> >> backtrace starting at ima_add_boot_aggregate is also being reported on
> >> a Dell XPS 15 9500 (as well as on the XPS 13 9310).
> >>
> >> Regards,
> >>
> >> Hans
> > 
> > OK, I'll have to query if I could borrow that laptop from someone. It's
> > fairly common laptop, i.e. might be possible.
> 
> In the mean time I've also got a report that this variant of the backtrace:
> 
> 1. Backtrace starting with a call to ima_add_boot_aggregate
> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> 
> Is also still happening with recent 5.12.y kernels on
> Dell Precision 7750 laptops. Both the Precision 7750 and the XPS 9500 use
> 10th gen comet lake processors (i7-10750H), where as the XPS 9310 is using
> an icelake processor. So the common denominator seems to be that they are
> all 2020 Dell laptop models using the latest Intel CPUs.
> 
> FYI the complete list of models on which some of the 4 backtrace variants
> are still seen on recent 5.12.y kernels is now:
> 
> Dell XPS 13 9310
> Dell XPS 15 9500
> Dell Precision 7750
> 
> Regards,
> 
> Hans

Does "tpm_tis.interrupts=0" uniformly workaround the issue?

/Jarkko
