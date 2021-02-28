Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A6632717E
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Feb 2021 09:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhB1H7r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Feb 2021 02:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhB1H7q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Feb 2021 02:59:46 -0500
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:84:22e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18070C06174A;
        Sat, 27 Feb 2021 23:59:05 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 1B1A540A0A; Sun, 28 Feb 2021 07:59:02 +0000 (UTC)
Date:   Sun, 28 Feb 2021 07:59:02 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jarkko@kernel.org, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 2/9] tpm: Allow PCR 23 to be restricted to kernel-only use
Message-ID: <20210228075902.GA9183@codon.org.uk>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-3-matthewgarrett@google.com>
 <b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 24, 2021 at 10:00:53AM -0800, James Bottomley wrote:
> On Sat, 2021-02-20 at 01:32 +0000, Matthew Garrett wrote:
> > Under certain circumstances it might be desirable to enable the
> > creation of TPM-backed secrets that are only accessible to the
> > kernel. In an ideal world this could be achieved by using TPM
> > localities, but these don't appear to be available on consumer
> > systems.
> 
> I don't understand this ... the localities seem to work fine on all the
> systems I have ... is this some embedded thing?

I haven't made it work on an HP Z440 or a Lenovo P520. So now I'm
wondering whether having chipsets with TXT support (even if it's turned
off) confuse this point. Sigh. I'd really prefer to use localities than
a PCR, so if it works on client platforms I'd be inclined to say we'll
do a self-test and go for that, and workstation vendors can just
recommend their customers use UPSes or something.

> >  An alternative is to simply block userland from modifying one of the
> > resettable PCRs, leaving it available to the kernel. If the kernel
> > ensures that no userland can access the TPM while it is carrying out
> > work, it can reset PCR 23, extend it to an arbitrary value, create or
> > load a secret, and then reset the PCR again. Even if userland somehow
> > obtains the sealed material, it will be unable to unseal it since PCR
> > 23 will never be in the appropriate state.
> 
> This seems a bit arbitrary: You're removing this PCR from user space
> accessibility, but PCR 23 is defined as "Application Support" how can
> we be sure no application will actually want to use it (and then fail)?

Absolutely no way of guaranteeing that, and enabling this option is
certainly an ABI break.

> Since PCRs are very scarce, why not use a NV index instead.  They're
> still a bounded resource, but most TPMs have far more of them than they
> do PCRs, and the address space is much bigger so picking a nice
> arbitrary 24 bit value reduces the chance of collisions.

How many write cycles do we expect the NV to survive? But I'll find a
client system with a TPM and play with locality support there - maybe we
can just avoid this problem anyway.
