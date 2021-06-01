Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50793979B3
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFASE5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 14:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234554AbhFASE5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 14:04:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EE1261375;
        Tue,  1 Jun 2021 18:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622570596;
        bh=Zn9BLDM9dyE213DO0pYN68bRu3Na4QtN+fTTJKt5F6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B08LBfxuLzKYkomHoLMvpTslzQI7rxyr9yHQehqCkfARPOAhPBC8BACRCYomKdy8x
         FQA3lg98rXz5jogKEPtwBJLwmYuZER0uh5dc/KMcvyjJT5czny+2+I+Az/hEdPM0vT
         qCKHMTGqGc+3GudWSLQVRsKuDXBFArxRKvz23Mt5UgqWAJlULBy7FrG6vUXItdLcYD
         v7JJ/erV1dD19fVpxDBsubFsgC9PLi3HC+WVVOxhX4iif+hTdgpZkpdQokRDqTkJ3V
         zZIJ+6sYIFr5RE2Oee07q+EwVXaojy3dXWSunTgXnDttnMqhCumPPiVMNTmvn4Tc1r
         iUb36lGwl76EQ==
Date:   Tue, 1 Jun 2021 21:03:13 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
Message-ID: <20210601180313.vd32yqaqjjt5gzrv@kernel.org>
References: <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
 <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 01, 2021 at 06:04:40PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
> >> Interestingly enough the first backtrace is also happening on a:
> >> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
> >>
> >> So it seems that at least with 5.12.6 (which has the last 2 fixes)
> >> all reports are about the XPS 13 9310. I wonder if there is an
> >> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
> >> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
> > 
> > This is helpful for sure that these all are happening on matching hardware.
> 
> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
> 
> 1. Backtrace starting with a call to ima_add_boot_aggregate
> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> 
> 2. Backtrace starting with a call to tpm_dev_async_work:
> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
> (note this one is not easily reproducible)
> 
> 3. Backtrace starting with a call to rng_dev_read:
> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> 
> 3. is the new one. All bugs linked above are public, all 3 backtraces
> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.
> 
> Regards,
> 
> Hans

I'll put myself watcher for each of these once I have the account, thank
you (will take tomorrow, it's 9PM atm).


/Jarkko
