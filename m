Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DFF1D48C3
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 10:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgEOIrG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 May 2020 04:47:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:55112 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgEOIrG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 04:47:06 -0400
IronPort-SDR: 6A+6cKa2NSAOFoYW8M00yiVMFYpahkqV3gaa8pGL08KmaOjw4YVwRHicRHrj64x1rnmJyRCVYG
 Vcx4lg3XF5bQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 01:47:05 -0700
IronPort-SDR: b9BU4wNgz0exQPqDgRg3HcZQZGfsbVBh9fE73+IWHiFdgslzCq4GbFjI1+A3y7KobppWeraRFZ
 /pHOsX9DTAZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="438241836"
Received: from mgpinon-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.74])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2020 01:47:03 -0700
Date:   Fri, 15 May 2020 11:47:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-ID: <20200515084702.GA3404@linux.intel.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
 <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
 <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
 <1589514263.5759.25.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589514263.5759.25.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
> On Fri, 2020-05-15 at 05:22 +0300, Jarkko Sakkinen wrote:
> > On Thu, 2020-05-14 at 17:31 +0300, Jarkko Sakkinen wrote:
> > > I'm compiling now kernel with all series included.
> > > 
> > > Kind of checking if I could just take the whole series. Let see.
> > > 
> > > In all cases I want the style errors in 3/8 to be fixes with a
> > > helper
> > > but maybe better to hold before sending anything. Possibly that is
> > > all
> > > needed I'll just carve that patch myself.
> > > 
> > > Please don't do anything for the moment.
> > 
> > This is what I tried first (with the full series applied):
> > 
> > #!/bin/sh
> > 
> > die()
> > {
> > 	keyctl clear @u
> > 	./tpm2-flush --all-transient
> > 	exit $1
> > }
> > 
> > KEYHANDLE=$(./tpm2-root-key || die 1)
> > KEYID=$(keyctl add trusted kmk "new 32 keyhandle=$KEYHANDLE
> > hash=sha256" @u || die 1)
> > 
> > echo "$KEYID ($KEYHANDLE)"
> > 
> > keyctl pipe $KEYID > blob.hex || die 1
> > keyctl clear @u || die 1
> > 
> > echo "Import key from blob"
> > 
> > keyctl add trusted kmk "load `cat blob.hex` keyhandle=$KEYHANDLE" @u
> > || die 1
> > 
> > die 0
> > 
> > Result:
> > 
> > sudo ./keyctl-smoke.sh
> > 566201053 (0x80000000)
> > keyctl_read_alloc: Permission denied
> 
> Well, it's clearly failing in keyctl pipe
> 
> I do confess to never having tested a volatile primary, but I just did
> so and it works for me.  I will also add the keyhandle in the load
> isn't necessary, because it should be in the blob, but there should
> also be no harm (just tested).
> 
> However, I don't have keyctl_read_alloc in my tree, so it may be an
> incompatibility with another patch set.  What's your base and what
> other patches do you have applied?

http://git.infradead.org/users/jjs/linux-tpmdd.git

Or exactly:

git://git.infradead.org/users/jjs/linux-tpmdd.git (master)

/Jarkko
