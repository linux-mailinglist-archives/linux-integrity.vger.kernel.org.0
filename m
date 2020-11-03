Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6842A3B7A
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 05:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgKCEne (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Nov 2020 23:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgKCEne (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Nov 2020 23:43:34 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A00207BB;
        Tue,  3 Nov 2020 04:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604378613;
        bh=744BrGTw3BJtm5DzR5GgZcmHpaqVKx7nxLQ4zI6bBJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emDVtYO1f+7pZU4ltoBPdEEzmA5L1htCESCj4qkZ1wH/YCQHof4zKooO+ALHnN8vc
         gT1D5Q0F98vVB22cW/cgSJCOLnYJMHXHpJDHZx2ZmJD7tL5Rpae/y8uHRkKYMQiC2K
         h1tbNmcM4WHgLHAJbnPGhljWHCdS0lwR72pnPT80=
Date:   Tue, 3 Nov 2020 06:43:28 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
Message-ID: <20201103044328.GA58053@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
 <87zh4hg4wg.fsf@redhat.com>
 <20201024121718.GC32960@kernel.org>
 <20201030124335.GD522355@kernel.org>
 <837dbe43b7507a765553260289de5fd8eee397c4.camel@HansenPartnership.com>
 <87sg9vbsnh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg9vbsnh.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 30, 2020 at 09:11:30AM -0700, Jerry Snitselaar wrote:
> 
> James Bottomley @ 2020-10-30 08:49 MST:
> 
> > On Fri, 2020-10-30 at 14:43 +0200, Jarkko Sakkinen wrote:
> > [...]
> >> I tested this with:
> >> 
> >> - 
> >> https://ark.intel.com/content/www/us/en/ark/products/84861/intel-nuc-kit-nuc5i5myhe.html
> >>   dTPM 1.2
> >> - 
> >> https://ark.intel.com/content/www/us/en/ark/products/74483/intel-nuc-kit-dc53427hye.html
> >>   dTPM 2.0
> >> 
> >> I did not get "TPM interrupt not working, polling instead" to klog.
> >> But I neither see tpm0 in /proc/interrupts. What I'm doing wrong?
> >
> > That's usually what you get when ACPI specifies the interrupt isn't
> > connected (we don't try to probe it).
> >
> > James
> 
> That is the problem I've been running into. When I do find a system
> with a tpm and using tpm_tis, it usually seems to not have the interrupt
> connected.
> 
> Should this commit have:
> 
> Fixes: 570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific")
> 
> That is where TPM_CHIP_FLAG_IRQ was added and not set for tpm_tis.

Have you tested 4eea703caaac?

/Jarkko
