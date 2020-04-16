Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC91ACF4D
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbgDPSCy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 14:02:54 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48162 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbgDPSCx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 14:02:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0DC8A8EE284;
        Thu, 16 Apr 2020 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587060173;
        bh=UEqF8eMnkVoY14lICF5EXp2rtfD2vShbd03Y8DEP48E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=buui1FSAaiDSe41kPJEJgr4XYO800jjQ0DPh7RRr38/5aecGIRDJXQkHYqPQuwKtA
         qNYeMHu6slD3NyYRzV6F8lbOKUgpnnXb0T+47nA7+wOFI/Eq+ckEc7IfVGixcLNfhE
         80GYYKJsB2j+XBYezMaOkp0ebT/ZZlg1va1aRJv4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AHAR2C8Jue4I; Thu, 16 Apr 2020 11:02:52 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6BFDE8EE0A4;
        Thu, 16 Apr 2020 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587060172;
        bh=UEqF8eMnkVoY14lICF5EXp2rtfD2vShbd03Y8DEP48E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o+I4BoZ4hE83at6sd9OCtBkyFmGsIygimdQ5XyGMO6Y3Ov5MrFzyD2cN3Kb6Af+kW
         G2ohFnuOyJG65Z+T0MGVedwKrnGPNm8JSJMyyDRubq3ReOsJNBajeXcYj0zcPDVS9Z
         p0OYSnNLk/Ynwr+nqUuhWFxwDaXJuHJhlNCWMPkc=
Message-ID: <1587060171.15329.7.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Date:   Thu, 16 Apr 2020 11:02:51 -0700
In-Reply-To: <20200416002442.GB673482@vader>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
         <1586994699.3931.18.camel@HansenPartnership.com>
         <20200416001605.GA673482@vader> <20200416002442.GB673482@vader>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-04-15 at 17:24 -0700, Omar Sandoval wrote:
> On Wed, Apr 15, 2020 at 05:16:05PM -0700, Omar Sandoval wrote:
> > On Wed, Apr 15, 2020 at 04:51:39PM -0700, James Bottomley wrote:
> > > On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> > > > From: Omar Sandoval <osandov@fb.com>
> > > > 
> > > > We've encountered a particular model of STMicroelectronics TPM
> > > > that transiently returns a bad value in the status register.
> > > > This causes the kernel to believe that the TPM is ready to
> > > > receive a command when it actually isn't, which in turn causes
> > > > the send to time out in get_burstcount(). In testing, reading
> > > > the status register one extra time convinces the TPM to return
> > > > a valid value.
> > > 
> > > Interesting, I've got a very early upgradeable nuvoton that seems
> > > to be behaving like this.
> > 
> > I'll attach the userspace reproducer I used to figure this out. I'd
> > be interested to see if it times out on your TPM, too. Note that it
> > bangs on /dev/mem and assumes that the MMIO address is 0xfed40000.
> > That seems to be the hard-coded address for x86 in the kernel, but
> > just to be safe you might want to check `grep MSFT0101
> > /proc/iomem`.
> 
> Forgot to attach it, of course...


Thanks!  You facebook guys run with interesting kernel options ... I
eventually had to disable CONFIG_STRICT_DEVMEM and rebuild my kernel to
get it to run.

However, the bad news is that this isn't my problem, it seems to be
more timeout related  I get the same symptoms: logs full of

[14570.626594] tpm tpm0: tpm_try_transmit: tpm_send: error -62

and the TPM won't recover until the box is reset.  To get my TPM to be
usable, I have to fiddle our default timeouts like this:

--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -41,8 +41,8 @@ enum tpm_timeout {
        TPM_TIMEOUT_RETRY = 100, /* msecs */
        TPM_TIMEOUT_RANGE_US = 300,     /* usecs */
        TPM_TIMEOUT_POLL = 1,   /* msecs */
-       TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
-       TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
+       TPM_TIMEOUT_USECS_MIN = 750,      /* usecs */
+       TPM_TIMEOUT_USECS_MAX = 1000,      /* usecs */
 };

But I think the problem is unique to my nuvoton because there haven't
been any other reports of problems like this ... and with these
timeouts my system functions normally in spite of me being a heavy TPM
user.

James

