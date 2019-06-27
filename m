Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6083A5833B
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfF0NRf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 09:17:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:49336 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0NRe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 09:17:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 06:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="361147600"
Received: from unknown (HELO jsakkine-mobl1) ([10.252.36.47])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2019 06:17:29 -0700
Message-ID: <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Date:   Thu, 27 Jun 2019 16:17:29 +0300
In-Reply-To: <20190626235653.GL7898@sasha-vm>
References: <20190625201341.15865-1-sashal@kernel.org>
         <20190625201341.15865-2-sashal@kernel.org>
         <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
         <20190626235653.GL7898@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-06-26 at 19:56 -0400, Sasha Levin wrote:
> > You've used so much on this so shouldn't this have that somewhat new
> > co-developed-by tag? I'm also wondering can this work at all
> 
> Honestly, I've just been massaging this patch more than "authoring" it.
> If you feel strongly about it feel free to add a Co-authored patch with
> my name, but in my mind this is just Thiru's work.

This is just my subjective view but writing code is easier than making
it work in the mainline in 99% of cases. If this patch was doing
something revolutional, lets say a new outstanding scheduling algorithm,
then I would think otherwise. It is not. You without question deserve
both credit and also the blame (if this breaks everything) :-)

> > process-wise if the original author of the patch is also the only tester
> > of the patch?
> 
> There's not much we can do about this... Linaro folks have tested this
> without the fTPM firmware, so at the very least it won't explode for
> everyone. If for some reason non-microsoft folks see issues then we can
> submit patches on top to fix this, we're not just throwing this at you
> and running away.

So why any of those Linaro folks can't do it? I can add after tested-by
tag parentheses something explaining that context of testing. It is
reasonable given the circumstances.

I can also give an explanation in my next PR along the lines what you
are saying. This would definitely work for me.

/Jarkko

