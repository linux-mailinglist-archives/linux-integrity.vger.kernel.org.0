Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5798B283D0C
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Oct 2020 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgJERJX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 13:09:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:23042 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgJERJX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 13:09:23 -0400
IronPort-SDR: nxWCBMYQ9ZRKeOfQE3kfru8pAGGsgrP+IzIDVNo1UXtzFCGxvctYqLe58uGcBeEPCjIPmINJ9Q
 BPv3PgpyvgLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="181596980"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="181596980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 10:06:07 -0700
IronPort-SDR: 9+478EWewl0HYFtTSp5EVLWHBKy90rV2LPTYIDhRC9lxrwwdjXKORhsI2IjBtATyIahzUv9z+z
 Teg/vM/9gsKQ==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="296356736"
Received: from unknown (HELO localhost) ([10.249.32.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 10:05:58 -0700
Date:   Mon, 5 Oct 2020 20:05:56 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
Message-ID: <20201005170556.GF6232@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 01, 2020 at 11:09:24AM -0700, James Bottomley wrote:
> There are two problems with our current interrupt probing: firstly the
> TPM_CHIP_FLAG_IRQ never gets set initially, so a check for interrupts
> is never done.  Fix this by setting the flag before we generate and
> interrupt for probing.  Secondly our IRQ setup may be ineffective on a
> TPM without legacy access cycles becuase according to the TPM
> Interface Specification the interrupt registers are only writeable in
> the current locality, so issue a request_locality before setting up
> the interrupts.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> ---
> 
> v2: improved description

Ditto.

/Jarkko
