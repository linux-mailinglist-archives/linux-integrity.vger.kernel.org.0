Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BD82A5B06
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Nov 2020 01:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgKDAdE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 19:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbgKDAb4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 19:31:56 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B022E223C7;
        Wed,  4 Nov 2020 00:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604449916;
        bh=4WyzzWpdyX2gmLrfBgrNdhVIrA6XmqZWk8TnluDAYow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdS/DyVW0knocGZaGpBcerAb4me77e8sLegJzk7VhfbtdUrm0J4D0FWA/gqvNdpb7
         QQCwO/lfAusBdjScUw0+FLyTNRca1JbcDdZB63fGCPIwf1NPB3SEm4NPitl1VNLAql
         Dud8S+fDX/+sqKpB6fkfS36oYNHGa9GKa4t8/l6M=
Date:   Wed, 4 Nov 2020 02:31:51 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
Message-ID: <20201104003151.GA19460@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
 <87zh4hg4wg.fsf@redhat.com>
 <20201024121718.GC32960@kernel.org>
 <20201030124335.GD522355@kernel.org>
 <837dbe43b7507a765553260289de5fd8eee397c4.camel@HansenPartnership.com>
 <87sg9vbsnh.fsf@redhat.com>
 <20201103044328.GA58053@kernel.org>
 <87pn4uoxki.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn4uoxki.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 03, 2020 at 04:00:29PM -0700, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-11-02 21:43 MST:
> 
> > On Fri, Oct 30, 2020 at 09:11:30AM -0700, Jerry Snitselaar wrote:
> >> 
> >> James Bottomley @ 2020-10-30 08:49 MST:
> >> 
> >> > On Fri, 2020-10-30 at 14:43 +0200, Jarkko Sakkinen wrote:
> >> > [...]
> >> >> I tested this with:
> >> >> 
> >> >> - 
> >> >> https://ark.intel.com/content/www/us/en/ark/products/84861/intel-nuc-kit-nuc5i5myhe.html
> >> >>   dTPM 1.2
> >> >> - 
> >> >> https://ark.intel.com/content/www/us/en/ark/products/74483/intel-nuc-kit-dc53427hye.html
> >> >>   dTPM 2.0
> >> >> 
> >> >> I did not get "TPM interrupt not working, polling instead" to klog.
> >> >> But I neither see tpm0 in /proc/interrupts. What I'm doing wrong?
> >> >
> >> > That's usually what you get when ACPI specifies the interrupt isn't
> >> > connected (we don't try to probe it).
> >> >
> >> > James
> >> 
> >> That is the problem I've been running into. When I do find a system
> >> with a tpm and using tpm_tis, it usually seems to not have the interrupt
> >> connected.
> >> 
> >> Should this commit have:
> >> 
> >> Fixes: 570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific")
> >> 
> >> That is where TPM_CHIP_FLAG_IRQ was added and not set for tpm_tis.
> >
> > Have you tested 4eea703caaac?
> >
> > /Jarkko
> 
> Is that the right commit id?
> 
> 4eea703caaac tpm: drop 'iobase' from struct tpm_vendor_specific | 2016-06-25 | (Christophe Ricard)

Yeah.

/Jarkko
