Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2860E3B1B59
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Jun 2021 15:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFWNnP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Jun 2021 09:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFWNnO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Jun 2021 09:43:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D2B561026;
        Wed, 23 Jun 2021 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624455656;
        bh=hp/aYblv11Mm7MYqH6yzkPKurU3z4uVQvYmzL6oO6Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDdIvlrFghBgMPEBg9PyhyZ8jhEqms1eQIrEjgJ9E96oT8ubepMe6sOvXFnfJk1bg
         0kAKEfJT6tmzQCv6ibZVkIaUFE6M8XkGEtI7fwFgG/tkYxdpEAiajYC4dGYTdC8fN6
         kvK35+516HUJAnZiefHV7rh2SnZUvqgASQOJSBo5MbFqcdbVPlFho4xRT5zJmBR96H
         c2pGNjV5M1Re+onzQsRz5C+BWRlgxR4KlskJY6L2J2hs44O/0AXvmkGkviv5g741Xm
         w9y8N3B2rMjC5jvfnrcN5qiI8N9X0BoHeFFB1jBiEh2PPaBWN7/TXOY8+cSglu/LZl
         jXjZ1cNPAkE8A==
Date:   Wed, 23 Jun 2021 16:40:54 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
Message-ID: <20210623134054.45gjj2wbgz7jpjmy@kernel.org>
References: <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
 <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
 <49bfb4a7-eb3c-77f9-ff8e-b37617a26195@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bfb4a7-eb3c-77f9-ff8e-b37617a26195@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 21, 2021 at 02:04:52PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/14/21 3:33 PM, Hans de Goede wrote:
> > Hi,
> > 
> > On 6/1/21 6:04 PM, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
> >>>> Interestingly enough the first backtrace is also happening on a:
> >>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
> >>>>
> >>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
> >>>> all reports are about the XPS 13 9310. I wonder if there is an
> >>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
> >>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
> >>>
> >>> This is helpful for sure that these all are happening on matching hardware.
> >>
> >> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
> >> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
> >>
> >> 1. Backtrace starting with a call to ima_add_boot_aggregate
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> >>
> >> 2. Backtrace starting with a call to tpm_dev_async_work:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
> >> (note this one is not easily reproducible)
> >>
> >> 3. Backtrace starting with a call to rng_dev_read:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> >>
> >> 3. is the new one. All bugs linked above are public, all 3 backtraces
> >> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
> >> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
> > 
> > Quick status update, I've got a response from a XPS 13 9310 user in:
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> > 
> > Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
> > and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
> > (I expected this because all the bug-reports started when the interrupt
> > code got fixed/re-enabled a while ago).
> 
> One more status update.
> 
> - A new 4th variant of the backtrace has been spotted, where the problem hits
> when called from probe() -> tpm2_auto_startup -> tpm2_do_selftest, see:
> https://bugzilla.redhat.com/show_bug.cgi?id=1958381
> 
> - So far all reports with kernel >= 5.12.6 have been on a Dell XPS 13 9310
> models. But the new variant is happening on a Dell XPS 15 9500 and the
> backtrace starting at ima_add_boot_aggregate is also being reported on
> a Dell XPS 15 9500 (as well as on the XPS 13 9310).
> 
> Regards,
> 
> Hans

OK, I'll have to query if I could borrow that laptop from someone. It's
fairly common laptop, i.e. might be possible.

/Jarkko
