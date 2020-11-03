Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4542A3B62
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 05:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgKCERy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Nov 2020 23:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgKCERy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Nov 2020 23:17:54 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 735C720756;
        Tue,  3 Nov 2020 04:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604377073;
        bh=4OGHzAxz7WFZtNs9CphqLWKlBm+j+M7Z6Slfy8+C7l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FaZqIVLslCNcANh8eI2xrVj7ZNLGIvVmIJD9mjF78ps8UnFoiFY6reggnVK4IyE+C
         Fj2O+6i5AruspGSHxbKMr0khNaYwqpQpkbkHeVwsTzFaggIdK+YB5A6btOEtxHpMmJ
         MaNRwXjTU3NRdDd0cHlExMyBYL8Ce7vZXYAm7rGU=
Date:   Tue, 3 Nov 2020 06:17:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
Message-ID: <20201103041749.GB56284@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
 <87zh4hg4wg.fsf@redhat.com>
 <20201024121718.GC32960@kernel.org>
 <20201030124335.GD522355@kernel.org>
 <837dbe43b7507a765553260289de5fd8eee397c4.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <837dbe43b7507a765553260289de5fd8eee397c4.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 30, 2020 at 08:49:27AM -0700, James Bottomley wrote:
> On Fri, 2020-10-30 at 14:43 +0200, Jarkko Sakkinen wrote:
> [...]
> > I tested this with:
> > 
> > - 
> > https://ark.intel.com/content/www/us/en/ark/products/84861/intel-nuc-kit-nuc5i5myhe.html
> >   dTPM 1.2
> > - 
> > https://ark.intel.com/content/www/us/en/ark/products/74483/intel-nuc-kit-dc53427hye.html
> >   dTPM 2.0
> > 
> > I did not get "TPM interrupt not working, polling instead" to klog.
> > But I neither see tpm0 in /proc/interrupts. What I'm doing wrong?
> 
> That's usually what you get when ACPI specifies the interrupt isn't
> connected (we don't try to probe it).
> 
> James

Right, I'll test today with the same NUC's with "force=1".

/Jarkko
