Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2683A7E8C
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 15:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFONDO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 09:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhFONDK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 09:03:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E49961466;
        Tue, 15 Jun 2021 13:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623762066;
        bh=0qx8PslXNjaSVqsAsZwOnlLwdAwUt540nRP7ophND1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1j/DEFF9aUcfiswtgJpsVROchDv5vi3iGjEsTDsHegR/tLn670cbg+9y50SxgVH/
         q+qfC7IcNvc857ySkQUN0HKhRCqQRQ4/qeH45o9YMUza+oTiLfL45i42OfA1urOkSE
         CssX3QtY4tiO5ICRKvaTWKjWdmcxjR5tqcdYe174dOpPf6gF5tEgrdzL61CtJ8nPnD
         x8IfgAJ/9pd531/fuQYxnomJ0mkd6RzKB3JwY5tks1RdhBFh+kbpN23geKXYnbv8Gg
         Cj1930lM/2LUFHbpquPxDf4MD0Bn8+HIlPfAXj3Gy9cfmC/w3/zMLlsGrsGuQwMabG
         r3r65TduQuIfQ==
Date:   Tue, 15 Jun 2021 16:01:03 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
Message-ID: <20210615130103.sln2s6hq4fkufi5a@kernel.org>
References: <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
 <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 14, 2021 at 03:33:33PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/1/21 6:04 PM, Hans de Goede wrote:
> > Hi,
> > 
> > On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
> >>> Interestingly enough the first backtrace is also happening on a:
> >>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
> >>>
> >>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
> >>> all reports are about the XPS 13 9310. I wonder if there is an
> >>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
> >>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
> >>
> >> This is helpful for sure that these all are happening on matching hardware.
> > 
> > So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
> > with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
> > 
> > 1. Backtrace starting with a call to ima_add_boot_aggregate
> > https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> > 
> > 2. Backtrace starting with a call to tpm_dev_async_work:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1964974
> > (note this one is not easily reproducible)
> > 
> > 3. Backtrace starting with a call to rng_dev_read:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> > 
> > 3. is the new one. All bugs linked above are public, all 3 backtraces
> > so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
> > and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
> 
> Quick status update, I've got a response from a XPS 13 9310 user in:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> 
> Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
> and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
> (I expected this because all the bug-reports started when the interrupt
> code got fixed/re-enabled a while ago).
> 
> Si I think that there just is something broken wrt the interrupt setup
> on the XPS 13 9310 and that we should probably add an antry for the
> XPS 13 9310 to the already existing tpm_tis_dmi_table pointing to the
> also already existing tpm_tis_disable_irq callback.
> 
> If other people agree that that is probably the best way forward ?
> then I can prepare a patch and ask the user to test this.
> 
> Regards,
> 
> Hans

I think it all roots down to the use of TPM before tpm2_probe(), i.e.
TPM is not in expected state when tpm_chip_start() is called. I
suggested to try out adding tpm_chip_stop() right before
tpm_chip_start() in another response.

That's only thing that makes logically sense to me at least.

/Jarkko
