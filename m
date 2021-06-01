Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D9A3979AF
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFASEN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 14:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhFASEK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 14:04:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B52F360FF3;
        Tue,  1 Jun 2021 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622570549;
        bh=zIcq/lzQrAquMvZy8YrZ+VDWtfi6PaKx+P0tdu2acak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dW3A5hKQ1S6voI4b94VENFMw/6KipKjpHAQMkIycdM/EOvUvAFAZFfz/o2XJYm7FB
         0dwUfDYHtpoS/UuVy/w3NtVOKKJqp64ltXitIBMRGZmY958vJxH9eD907cOwWxxG9Z
         W286po8JyckvOsnLrlKRQCkiawDEIcpPynS3Dg3ceshu6n2XGlDZrbk0F5qS1lulzV
         8w7muoJaOkl2pf3fa6BuQLmPDaTq73MaPkEQ8z7RTAIaj+iesCOxcx8h5QLXcP0OaT
         4uKNe7MZMMy0t5xYVHRmfHm2o+Gb6f34Qh/DzMdFPjq8fjAl1dv8g0Mtl5g+fXfPh0
         1dPYPu0rhNcJg==
Date:   Tue, 1 Jun 2021 21:02:26 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
Message-ID: <20210601180226.ioql2j5o2y2cm3ap@kernel.org>
References: <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
 <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <df7bcbfa-1706-1b8f-f32e-01c2d5e4ac7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df7bcbfa-1706-1b8f-f32e-01c2d5e4ac7c@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 31, 2021 at 10:24:05AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
> > On Thu, May 27, 2021 at 05:27:49PM +0200, Hans de Goede wrote:
> >> This is from:
> >> https://retrace.fedoraproject.org/faf/reports/74723/  (public)
> > 
> > I wonder if this occurs only with O_NONBLOCK.
> > 
> > Any chances to get the output of
> > 
> >   sudo tools/testing/selftests/tpm2/test_smoke.sh
> > 
> > ?
> > 
> > It's obvious that there is some sort of bug, but it's not yet obvious that
> > this bug is connected to the locality issue yet, as in this case locality
> > is successfully reserved by tpm_try_get_ops() in tpm_dev_async_work()
> > (driver/chars/tpm/tpm-dev-common.c).
> 
> As mentioned I've asked the user to try with tpm_tis.interrupts=0 and see
> if that makes a difference. I got a reply that the user only hit this
> once and that this is not (easily) reproducible :|

This is not about interrupts. It's about opening the file with O_NONBLOCK.
I.e. the function returns and defers sending the command.

> "looks like a spurious problem that may already be solved."
> 
> I did get permission to open up the bug (make it public) so if you want
> more info it is probably easiest if you interact directly with the
> reporter here:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
> 
> If you don't already have a bugzilla.redhat.com account, creating one
> is super easy, you only need to enter your email address and pick a
> password.

I'll create one. I don't actually remember if I have one or not :-)

/Jarkko
