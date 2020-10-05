Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A46283F26
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Oct 2020 20:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgJES5s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 14:57:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:38375 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgJES5s (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 14:57:48 -0400
IronPort-SDR: egey4e/OjL6iUY16bYWwn03Ofrx9KCZTrr958AfkLQwm2FXrWLENFlRIxDcyPp0rvdXpoWEE95
 cRogg9d+99jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="151136656"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="151136656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 11:57:42 -0700
IronPort-SDR: ysuBJkKAjr6J9XYhUvNzxnSfS7e6qT+3zF2Vw7gXICUZMgL6wGwFP6r4mr5167Tg2cndHryKeY
 c4nalbp6oi2A==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="459758656"
Received: from unknown (HELO localhost) ([10.249.32.156])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 10:02:42 -0700
Date:   Mon, 5 Oct 2020 20:02:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 2/5] tpm_tis: Clean up locality release
Message-ID: <20201005170219.GC6232@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 01, 2020 at 11:09:22AM -0700, James Bottomley wrote:
> The current release locality code seems to be based on the
> misunderstanding that the TPM interrupts when a locality is released:
> it doesn't, only when the locality is acquired.
> 
> Furthermore, there seems to be no point in waiting for the locality to
> be released.  All it does is penalize the last TPM user.  However, if
> there's no next TPM user, this is a pointless wait and if there is a
> next TPM user, they'll pay the penalty waiting for the new locality
> (or possibly not if it's the same as the old locality).
> 
> Fix the code by making release_locality as simple write to release
> with no waiting for completion.
> 
> Fixes: 33bafe90824b ("tpm_tis: verify locality released before returning from release_locality")
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

So, if I got it right this is dependent on 1/5 to address Jerry's
issue? I.e. if this has a fixes tag and previous does not, it will
not fully fix the situation when backporting?

/Jarkko
