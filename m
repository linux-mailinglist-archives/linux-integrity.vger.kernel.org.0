Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026FF320330
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 03:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBTCko (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 21:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhBTCkl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 21:40:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14FCC64E54;
        Sat, 20 Feb 2021 02:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613788800;
        bh=ooKzW00f3SI1Zam8q3gu3lwsl6GYn5NRNI8l11jdPfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQu695I5upgN13n//hmuAnF+I9q+8+A9v0B0PksNfg3xe7mDKkZL3qvxbsrK4n4Sj
         xTpp6NVp/6XNCCqZEtNjceoA3bYeqmjBHrT382KR4o0ERg0WAtAZEu2s/7yauX9ApY
         6CZUieAu8eya6dTm+zRMir+hN3kkAvNARsILruM4qIwQdesJERNr7Yb2OTQ4kNSO30
         3ilaY8vgLj7c3NKfy4Yvy1u9z5NN27sU/MN9dQ5zzvt0gFjpWJmvaubdP7x8d1V06c
         S5T7hNMEM9CuvFDe8Py4I6TWxlzxduaCzsu/oJWEECIpjMtPLj8lJ+PR0VPra+Nay3
         iQ2bBzCmbnypA==
Date:   Sat, 20 Feb 2021 04:39:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v15 0/5] TPM 2.0 trusted key rework
Message-ID: <YDB2cdk9mGPaBpdB@kernel.org>
References: <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
 <YDACehLCy4f2sDzo@kernel.org>
 <17a8229bf8ebc87ad02429643aeee78d803f34f2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a8229bf8ebc87ad02429643aeee78d803f34f2.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 19, 2021 at 10:35:00AM -0800, James Bottomley wrote:
> On Fri, 2021-02-19 at 20:24 +0200, Jarkko Sakkinen wrote:
> > On Wed, Jan 27, 2021 at 11:06:12AM -0800, James Bottomley wrote:
> > > v15: fix 0day sign issue and add reviews and testeds
> > > 
> > > General cover letter minus policy bit:
> > > 
> > > This patch updates the trusted key code to export keys in the ASN.1
> > > format used by current TPM key tools (openssl_tpm2_engine and
> > > openconnect).  The current code will try to load keys containing
> > > policy, but being unable to formulate the policy commands necessary
> > > to
> > > load them, the unseal will always fail unless the policy is
> > > executed
> > > in user space and a pre-formed policy session passed in.
> > > 
> > > The key format is designed to be compatible with our two openssl
> > > engine implementations as well as with the format used by
> > > openconnect.
> > > I've added seal/unseal to my engine so I can use it for
> > > interoperability testing and I'll later use this for sealed
> > > symmetric
> > > keys via engine:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/
> > > 
> > > James
> > > 
> > > ---
> > > 
> > > James Bottomley (5):
> > >   lib: add ASN.1 encoder
> > >   oid_registry: Add TCG defined OIDS for TPM keys
> > >   security: keys: trusted: fix TPM2 authorizations
> > >   security: keys: trusted: use ASN.1 TPM2 key format for the blobs
> > >   security: keys: trusted: Make sealed key properly interoperable
> > 
> > This is online again in the master branch. 
> > 
> > I've mangled the commits as follows:
> > 
> > 1. Fixed my emails to jarkko@kernel.org.
> > 2. Adjusted the Makefile, i.e. separate lines for each entry.
> > 3. Fixed the checkpatch issues.
> > 
> > I guess we could potentially re-consider this to rc2 pull? With all
> > the mangling required, did not make sense to include this to the
> > first pull.
> 
> The way I usually do this in SCSI, because stuff always happens
> immediately before the merge window that causes some pull material to
> be held over, is an early push, which you've done followed by a late
> push on the Friday before the merge window closes of the rest of the
> stuff.  This is an example from the last but one merge window:
> 
> https://lore.kernel.org/linux-scsi/fdee2336d2a7eada3749e07c3cc6ea682f8200b3.camel@HansenPartnership.com/
> https://lore.kernel.org/linux-scsi/4affd2a9c347e5f1231485483bf852737ea08151.camel@HansenPartnership.com/
> 
> Linus seems to be happy with this pattern as long as it's well
> explained.
> 
> James

OK, thanks, I'll keep this in mind.

/Jarkko
