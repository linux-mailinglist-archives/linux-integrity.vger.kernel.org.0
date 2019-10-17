Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06ECADB235
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Oct 2019 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391115AbfJQQVs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Oct 2019 12:21:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:33920 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391091AbfJQQVs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Oct 2019 12:21:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 09:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="347809155"
Received: from eshoguli-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.19.56])
  by orsmga004.jf.intel.com with ESMTP; 17 Oct 2019 09:21:42 -0700
Date:   Thu, 17 Oct 2019 19:21:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
Message-ID: <20191017162141.GA6667@linux.intel.com>
References: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
 <20191015170450.GB5444@ziepe.ca>
 <20191016103805.GA10184@linux.intel.com>
 <20191016104322.GC10184@linux.intel.com>
 <20191016160908.GA3637@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016160908.GA3637@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 16, 2019 at 01:09:08PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2019 at 01:43:22PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Oct 16, 2019 at 01:38:05PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Oct 15, 2019 at 02:04:50PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Oct 15, 2019 at 03:47:02PM +0300, Jarkko Sakkinen wrote:
> > > > > Salt the result that comes from the TPM RNG with random bytes from the
> > > > > kernel RNG. This will allow to use tpm_get_random() as a substitute for
> > > > > get_random_bytes().  TPM could have a bug (making results predicatable),
> > > > > backdoor or even an inteposer in the bus. Salting gives protections
> > > > > against these concerns.
> > > > 
> > > > Seems like a dangerous use case, why would any kernel user that cared
> > > > about quality of randomness ever call a tpm_* API to get quality
> > > > random data?
> > > 
> > > This is related to this discussion:
> > > 
> > > https://lore.kernel.org/linux-integrity/CAE=NcrY3BTvD-L2XP6bsO=9oAJLtSD0wYpUymVkAGAnYObsPzQ@mail.gmail.com/T/#t
> > > 
> > > I could also move this to the call site.
> > 
> > But I hear you anyway.
> > 
> > I think for trusted keys the best strategy would be to do
> > exactly this:
> > 
> > 1. Generate one random value with get_random_bytes_arch()
> > 2. Generate another with backend specific technology (we
> >    have now two TPM and TEE) if an RNG available.
> > 3. Xor the values together.
> 
> Feels like something the random core should handle - maybe some way to
> say 'my trust model requires trust in this RNG' and then the random
> core can more heavily weight data from that RNG

Yeah, I think. I'll study these emails threads and RNG implementation
a bit when I have more time. Now I think I lack some knowledge to say
anything educated so better to take a step back and go back to the
drawing board.

Thank you for the suggestion.

/Jarkko
