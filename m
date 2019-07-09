Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22E163984
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2019 18:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfGIQie (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jul 2019 12:38:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:35477 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfGIQie (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jul 2019 12:38:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 09:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="173613342"
Received: from mmaitert-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.34.54])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2019 09:38:28 -0700
Date:   Tue, 9 Jul 2019 19:38:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2] tpm: tpm_ibm_vtpm: Fix unallocated banks
Message-ID: <20190709163827.2u6jeflrhg44q7dy@linux.intel.com>
References: <1562458725-15999-1-git-send-email-nayna@linux.ibm.com>
 <586c629b6d3c718f0c1585d77fe175fe007b27b1.camel@linux.intel.com>
 <1562624644.11461.66.camel@linux.ibm.com>
 <20190708224304.GA25838@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190708224304.GA25838@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 08, 2019 at 03:43:04PM -0700, Christoph Hellwig wrote:
> On Mon, Jul 08, 2019 at 06:24:04PM -0400, Mimi Zohar wrote:
> > > static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> > > {
> > > 	int rc;
> > > 
> > > 	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> > >      	     tpm2_get_pcr_allocation(chip) :
> > >      	     tpm1_get_pcr_allocation(chip);
> > 
> > > 
> > > 	return rc > 0 ? -ENODEV : rc;
> > > }
> > > 
> > > This addresses the issue that Stefan also pointed out. You have to
> > > deal with the TPM error codes.
> > 
> > Hm, in the past I was told by Christoph not to use the ternary
> > operator.  Have things changed?  Other than removing the comment, the
> > only other difference is the return.
> 
> In the end it is a matter of personal preference, but I find the
> quote version above using the ternary horribly obsfucated.

I fully agree that the return statement is an obsfucated mess and
not a good place at all for using ternary operator.

/Jarkko
