Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741D825FB78
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgIGNaF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 09:30:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:30560 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbgIGNXm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 09:23:42 -0400
IronPort-SDR: YIOtZ0RxVqdkrHDTEjCzi+XcivZdQOD2rPuYTotW4IfzKYc1USIz1HAPVyDN/bB+8HvtrXtGx/
 UKkICNmCighA==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="158980954"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="158980954"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 06:21:20 -0700
IronPort-SDR: 67TxInViyyuhJoZuo28N/lVFwOX50sFNCTYi0WHYNPg3iPooMt+1vCVrtKlOnEdJPsbvf6+Dc6
 XPbNR3qIY8Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="340839872"
Received: from noezdal-mobl5.ger.corp.intel.com (HELO localhost) ([10.252.57.15])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2020 06:21:18 -0700
Date:   Mon, 7 Sep 2020 16:21:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
Message-ID: <20200907132121.GA106839@linux.intel.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200906203245.18429-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906203245.18429-2-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 06, 2020 at 01:32:45PM -0700, James Bottomley wrote:
> Create sysfs per hash groups with 24 PCR files in them one group,
> named pcr-<hash>, for each agile hash of the TPM.  The files are
> plugged in to a PCR read function which is TPM version agnostic, so
> this works also for TPM 1.2 but the hash is only sha1 in that case.
> 
> Note: the macros used to create the hashes emit spurious checkpatch
> warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> they'll break.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

I'm not sure why this should be in sysfs when event log is in
securityfs.

Also, securityfs does not have to follow sysfs requirements,
which gives ability to dump all PCRs in a single binary file.

Using ASCII for this is inefficient.

/Jarkko
