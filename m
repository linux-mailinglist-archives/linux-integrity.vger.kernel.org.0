Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CED283F28
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Oct 2020 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgJES6P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 14:58:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:13106 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgJES6O (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 14:58:14 -0400
IronPort-SDR: qBzxd600PAAKXuWcZmv5KkLhWAyiiA5Gw2jzK9cuWBfshjEnW7IhxIGx4vc6YkknMyCYSUR5O6
 3Zps/4lJf2Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="143777232"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="143777232"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 11:57:51 -0700
IronPort-SDR: XQFzy1nWECI8gWCy9rU+Z8fMRwiGb5ejws9ZmtpsDf+uX9GgRB4Z1Ztxh21rSTDiL0Z24oZdrE
 y6jWTAE4o1nQ==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="459759036"
Received: from unknown (HELO localhost) ([10.249.32.156])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 10:03:51 -0700
Date:   Mon, 5 Oct 2020 20:03:32 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 2/5] tpm_tis: Clean up locality release
Message-ID: <20201005170332.GD6232@linux.intel.com>
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
> 
> ---
> 
> v2: added fixes

Also, this should go to cover letter (with some detail on the fixes).

/Jarkko
