Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C909320B0D5
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 13:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgFZLsZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 07:48:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:58816 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgFZLsY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 07:48:24 -0400
IronPort-SDR: 5+EEvxyg8DboDNAfDye9gWcabUAmkjNcxL+EJhq333oz7Oa+KCfIT/MwJMNueZ91GfJJDLyDL+
 obq4HNAxw3bQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="206808006"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="206808006"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 04:48:23 -0700
IronPort-SDR: sk2c1RyxRzxThVfJXQRlMz6jaM1lBrKQ5sjaHU8pPXbhnKQlgutuwtf/Ahf5hCE0jRvOiGCcjZ
 yARpo/X5g3Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="479804764"
Received: from cgheban-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.199])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2020 04:48:18 -0700
Date:   Fri, 26 Jun 2020 14:48:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: tpm2-space: Resize session and context buffers
 dynamically
Message-ID: <20200626114815.GA5847@linux.intel.com>
References: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
 <8d19d5e2-91bc-09ad-6b94-d51a7aad6376@linux.ibm.com>
 <20200625212556.GC20341@linux.intel.com>
 <031020b9-dc0a-3c2f-32e4-4bb2db4b5a2b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031020b9-dc0a-3c2f-32e4-4bb2db4b5a2b@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 05:27:50PM -0400, Stefan Berger wrote:
> On 6/25/20 5:25 PM, Jarkko Sakkinen wrote:
> > On Thu, Jun 25, 2020 at 08:41:18AM -0400, Stefan Berger wrote:
> > > On 6/25/20 12:38 AM, Jarkko Sakkinen wrote:
> > > > Re-allocate context and session buffers when needed. Scale them in page
> > > > increments so that the reallocation is only seldomly required, and thus
> > > > causes minimal stress to the system. Add a static maximum limit of four
> > > > pages for buffer sizes.
> > > > 
> > > > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > > Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > You don't want to try a fixes tag? None of the previous versions of this
> > > code will work with newer versions of the TPM 2 then...
> > It's not a regression.
> 
> Ok, so distros will have to backport it.

Now that you mentioned PPC64 in some other email that would make this a
regression since x86 provides less space for keys than PPC64.

I studied PPC64 a bit and it actually allows max 256 kB page size, which
is too much for us, given that there is no accounting implemented for
TPM spaces (so far, should be done eventually).

So to summarize: 0 the idea would decrease the limit on PPC64 and
increase it on ther arch's.  `

Dynamic scaling is over to top for fixing the issue, which means that I
will just define static size of 16 kB for the buffer. We can reconsider
it if we hit the roof again.

/Jarkko
