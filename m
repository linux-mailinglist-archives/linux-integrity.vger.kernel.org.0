Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D718F284321
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 02:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgJFAFC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 20:05:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:27494 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgJFAFB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 20:05:01 -0400
IronPort-SDR: vjLFyHaAJ80cQ2EZtPOx5DspRM+hRI2IaBRCZL7HCNm75qtUV7xGYKYaEVzrBI833Rwj2qBdCR
 dNsU+ifJa4JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="228315228"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="228315228"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP; 05 Oct 2020 16:08:09 -0700
IronPort-SDR: J40Uh6ZbUasPYeZbClXCNZUeeTMOXuM06Run0H3ONaIrOwaEjdT+ZyS+PUc4ELjG8Tq2jB4EAT
 7EH0Qn4hPIYA==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="460072579"
Received: from gtudori-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.57])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 13:34:36 -0700
Date:   Mon, 5 Oct 2020 23:34:30 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 2/5] tpm_tis: Clean up locality release
Message-ID: <20201005203430.GB45618@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
 <20201005170219.GC6232@linux.intel.com>
 <aa9bf3f821ab8f3ed8dc663112c67ca0f8e96c81.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9bf3f821ab8f3ed8dc663112c67ca0f8e96c81.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 05, 2020 at 12:05:07PM -0700, James Bottomley wrote:
> On Mon, 2020-10-05 at 20:02 +0300, Jarkko Sakkinen wrote:
> > On Thu, Oct 01, 2020 at 11:09:22AM -0700, James Bottomley wrote:
> > > The current release locality code seems to be based on the
> > > misunderstanding that the TPM interrupts when a locality is
> > > released: it doesn't, only when the locality is acquired.
> > > 
> > > Furthermore, there seems to be no point in waiting for the locality
> > > to be released.  All it does is penalize the last TPM
> > > user.  However, if there's no next TPM user, this is a pointless
> > > wait and if there is a next TPM user, they'll pay the penalty
> > > waiting for the new locality (or possibly not if it's the same as
> > > the old locality).
> > > 
> > > Fix the code by making release_locality as simple write to release
> > > with no waiting for completion.
> > > 
> > > Fixes: 33bafe90824b ("tpm_tis: verify locality released before
> > > returning from release_locality")
> > > Signed-off-by: James Bottomley <
> > > James.Bottomley@HansenPartnership.com>
> > 
> > So, if I got it right this is dependent on 1/5 to address Jerry's
> > issue? I.e. if this has a fixes tag and previous does not, it will
> > not fully fix the situation when backporting?
> 
> Yes, exactly.  Technically 1/5 isn't really fixing anything at all,
> it's changing from the current fix where we wait for the locality to be
> released at the back end of a TIS TPM operation to a new fix where we
> correctly check the conditions in the locality acquisition.  After the
> new fix is done, we can eliminate all the wait code in locality
> release.
> 
> James

OK, ignore my changelog etc. cosmectic comments unless there is need
for another revision. I will add the necessary tags.

I'm holding with reviewed-by up until Jerry can get ack for these
changes. If he ack's, the it's all good as far as I'm concerned.

/Jarkko
