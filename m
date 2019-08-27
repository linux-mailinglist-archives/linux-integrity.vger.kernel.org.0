Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB599EC48
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfH0PTT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 11:19:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:49780 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfH0PTT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 11:19:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 08:19:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="180256291"
Received: from jsakkine-mobl1.fi.intel.com (HELO localhost) ([10.237.66.169])
  by fmsmga008.fm.intel.com with ESMTP; 27 Aug 2019 08:19:16 -0700
Date:   Tue, 27 Aug 2019 18:19:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH] tpm_tis: Fix interrupt probing
Message-ID: <20190827151915.hb4xwr2vik2i5ryb@linux.intel.com>
References: <20190820122517.2086223-1-stefanb@linux.vnet.ibm.com>
 <20190827131400.qchcwa2act24c47b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827131400.qchcwa2act24c47b@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 27, 2019 at 04:14:00PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 20, 2019 at 08:25:17AM -0400, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > The interrupt probing of the TPM TIS was broken since we are trying to
> > run it without an active locality and without the TPM_CHIP_FLAG_IRQ set.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Need these:
> 
> Cc: linux-stable@vger.kernel.org
> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> 
> Thank you. I'll apply this to my tree.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

The commit went in the following form:

http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/9b558deab2c5d7dc23d5f7a4064892ede482ad32

I refined the long description as they should be written in imperative
form. I also changed it to consistently to speak about tpm_tis_core
instead of using two differing spellings (tpm_tis and TPM TIS). tpm_tis
is a different module than tpm_tis_core.

Unfortunately I had to drop the assignment statement because:

1. Generally speaking, two separate bug fixes should never reside in the
   same commit. They even need their own fixes tags in this case.
2. The commit message did not reason the assignment statement.

/Jarkko
