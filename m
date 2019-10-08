Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236DCD0396
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2019 00:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJHWwH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Oct 2019 18:52:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:1870 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJHWwH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Oct 2019 18:52:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 15:52:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,272,1566889200"; 
   d="scan'208";a="187448951"
Received: from jhogan1-mobl.ger.corp.intel.com (HELO localhost) ([10.252.2.221])
  by orsmga008.jf.intel.com with ESMTP; 08 Oct 2019 15:52:02 -0700
Date:   Wed, 9 Oct 2019 01:52:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] tpm: Use GFP_KERNEL for allocating struct tpm_buf
Message-ID: <20191008225202.GA12089@linux.intel.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
 <20191003185103.26347-2-jarkko.sakkinen@linux.intel.com>
 <1570148716.10818.19.camel@linux.ibm.com>
 <20191006095005.GA7660@linux.intel.com>
 <1570475528.4242.2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570475528.4242.2.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 07, 2019 at 12:12:08PM -0700, James Bottomley wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Subject: [PATCH] tpm: use GFP kernel for tpm_buf allocations
> 
> The current code uses GFP_HIGHMEM, which is wrong because GFP_HIGHMEM
> (on 32 bit systems) is memory ordinarily inaccessible to the kernel
> and should only be used for allocations affecting userspace.  In order
> to make highmem visible to the kernel on 32 bit it has to be kmapped,
> which consumes valuable entries in the kmap region.  Since the tpm_buf
> is only ever used in the kernel, switch to using a GFP_KERNEL
> allocation so as not to waste kmap space on 32 bits.
> 
> Fixes: a74f8b36352e (tpm: introduce tpm_buf)
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Thanks a lot. Makes a lot more sense than the patch that I sent.

Reviewed-by:  Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
