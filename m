Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718F727F7A2
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 04:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJACB5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 22:01:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:32687 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJACB5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 22:01:57 -0400
IronPort-SDR: FIdNXQDOru03jflXb2+XBrN/HCXP9bz+Q6ScJO9sCg9m4GkeqorK65bQNaDshmi1lega19G5US
 HS3XTbBd9/Lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="142002428"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="142002428"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 19:01:56 -0700
IronPort-SDR: /aKLPbxMlWGc1VcD1s5P7K47z13tOe4fBwj8JwOuHr55OW2FsuiVrGa8bfU6e5v9CdxuiXn+ju
 fhhvzRb9W2gw==
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="500755865"
Received: from horasazn-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.91])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 19:01:54 -0700
Date:   Thu, 1 Oct 2020 05:01:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
Message-ID: <20201001020152.GB5971@linux.intel.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
 <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
 <87eemjgdy3.fsf@jsnitsel.users.ipa.redhat.com>
 <8ed5a80a9b2cfa37f0b8348906d292a7b1a1c02e.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed5a80a9b2cfa37f0b8348906d292a7b1a1c02e.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 30, 2020 at 04:03:25PM -0700, James Bottomley wrote:
> On Wed, 2020-09-30 at 14:19 -0700, Jerry Snitselaar wrote:
> > James Bottomley @ 2020-09-29 15:32 MST:
> > 
> > > The current release locality code seems to be based on the
> > > misunderstanding that the TPM interrupts when a locality is
> > > released: it doesn't, only when the locality is acquired.
> > > 
> > > Furthermore, there seems to be no point in waiting for the locality
> > > to be released.  All it does is penalize the last TPM
> > > user.  However, if there's no next TPM user, this is a pointless
> > > wait and if there is
> > > a
> > > next TPM user, they'll pay the penalty waiting for the new locality
> > > (or possibly not if it's the same as the old locality).
> > > 
> > > Fix the code by making release_locality as simple write to release
> > > with no waiting for completion.
> [...]
> > My recollection is that this was added because there were some chips
> > that took so long to release locality that a subsequent
> > request_locality call was seeing the locality as already active,
> > moving on, and then the locality was getting released out from under
> > the user.
> 
> Well, I could simply dump the interrupt code, which can never work and
> we could always poll.

Side-topic: What is the benefit of using int's in a TPM driver anyway? I
have never had any interest to dive into this with tpm_crb because I
don't have the answer.

*Perhaps* in some smallest form factor battery run devices you could get
some gain in run-time power saving but usually in such situations you
use something similar to TEE to do a measured boot.

/Jarkko
