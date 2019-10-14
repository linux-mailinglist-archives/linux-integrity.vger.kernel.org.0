Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC26D6A2C
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 21:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfJNTc2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 15:32:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:47611 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbfJNTc2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 15:32:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 12:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="370222687"
Received: from kridax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.7.178])
  by orsmga005.jf.intel.com with ESMTP; 14 Oct 2019 12:32:25 -0700
Date:   Mon, 14 Oct 2019 22:32:24 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v2] tpm: use GFP kernel for tpm_buf allocations
Message-ID: <20191014193224.GF15552@linux.intel.com>
References: <1570809779.24157.1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570809779.24157.1.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 11, 2019 at 09:02:59AM -0700, James Bottomley wrote:
> The current code uses GFP_HIGHMEM, which is wrong because GFP_HIGHMEM
> (on 32 bit systems) is memory ordinarily inaccessible to the kernel
> and should only be used for allocations affecting userspace.  In order
> to make highmem visible to the kernel on 32 bit it has to be kmapped,
> which consumes valuable entries in the kmap region.  Since the tpm_buf
> is only ever used in the kernel, switch to using a GFP_KERNEL
> allocation so as not to waste kmap space on 32 bits.
> 
> Fixes: a74f8b36352e (tpm: introduce tpm_buf)
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

I'll apply this without a fixes tag as there is no failing system.
Agree that it was not the best design decision to use GFP_HIGHMEM.

/Jarkko
