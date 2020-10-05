Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85612842D6
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 01:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJEXIT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 19:08:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:32254 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgJEXIT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 19:08:19 -0400
IronPort-SDR: LFTtlw7w+wgodcFITQwyl2yLG3O+yZ/qEXtKpUa7OnA9eEdgts2T8f2dBFTCdfYL3jUCwnw/V1
 kyM1LTyvJz6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="164411510"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="164411510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 16:07:29 -0700
IronPort-SDR: JGcHAZs7a3rPiNYNplJVv3Ql2FDoxR7CaG6kuB+kXkkxqkHRJ4QUf64cYTZhDU32UG1rW5U2b2
 lq5x8ZSy5m3w==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="460069057"
Received: from gtudori-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.57])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 13:32:18 -0700
Date:   Mon, 5 Oct 2020 23:32:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 1/5] tpm_tis: Fix check_locality for correct locality
 acquisition
Message-ID: <20201005203215.GA45618@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-2-James.Bottomley@HansenPartnership.com>
 <20201005153418.GB6232@linux.intel.com>
 <14edea1f5092c2b8442165756b2ee32e56bed1eb.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14edea1f5092c2b8442165756b2ee32e56bed1eb.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 05, 2020 at 12:00:57PM -0700, James Bottomley wrote:
> On Mon, 2020-10-05 at 18:34 +0300, Jarkko Sakkinen wrote:
> > On Thu, Oct 01, 2020 at 11:09:21AM -0700, James Bottomley wrote:
> > > The TPM TIS specification says the TPM signals the acquisition of
> > > locality when the TMP_ACCESS_REQUEST_USE bit goes to one *and* the
> > > TPM_ACCESS_REQUEST_USE bit goes to zero.  Currently we only check
> > > the
> > 
> > Put a reference to the section.
> > 
> > I'm *guessing* that the spec is
> > 
> > https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis
> > 
> > Please have this and also location in this spec.
> 
> I can, but the TCG reorganizes its website every few months, so no URLs
> like that are permanent.

OK, that's good enough excuse :-( Let's then ignore this comment.
Just would had save trouble in future if that wasn't the case.

> > > former not the latter, so check both.  Adding the check on
> > > TPM_ACCESS_REQUEST_USE should fix the case where the locality is
> > > re-requested before the TPM has released it.  In this case the
> > > locality may get released briefly before it is reacquired, which
> > > causes all sorts of problems. However, with the added check,
> > > TPM_ACCESS_REQUEST_USE should remain 1 until the second request for
> > > the locality is granted.
> > 
> > The description is really good and understandable otherwise.
> > 
> > For me it is not obvious at all, why this is missing a fixes
> > tag?
> 
> It's been there ever since the initial commit:
> 
> commit 27084efee0c3dc0eb15b5ed750aa9f1adb3983c3
> Author: Leendert van Doorn <leendert@watson.ibm.com>
> Date:   Sat Apr 22 02:38:03 2006 -0700
> 
>     [PATCH] tpm: driver for next generation TPM chips

Then just "Cc: stable@vger.kernel.org" should do.

> > > Signed-off-by: James Bottomley <
> > > James.Bottomley@HansenPartnership.com>
> > > 
> > > ---
> > > 
> > > v2: added this patch
> > 
> > Use the cover letter for the changelog. I'm afraid that I might
> > miss these otherwise.
> 
> Submitting patches actually recommends doing this ... I think we want
> to keep to standard kernel process, but I can gather them in the cover
> letter as well.

Most of the patch sets that I encounter have the cover letter in the
changelog and usually it is great for getting overall image what is
happening.

In section 14 of "submitting patches" there is a remark that the area
just after the diffstat marker is a good place to store this kind of
information. I have not find any explicit instruction for patch sets,
i.e. I just trust the "majority vote".

> James

/Jarkko
