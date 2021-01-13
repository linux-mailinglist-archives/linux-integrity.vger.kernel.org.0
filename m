Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1782F544E
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 21:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbhAMUue (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 15:50:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:38755 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbhAMUue (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 15:50:34 -0500
IronPort-SDR: 56EI0SNGX9Nft8jhNAIXJisnB5SGmAkw6h1doiKa64x1f/O09I/VsENRdINkJqM0UhenuK3omG
 4eNCAjm/v21A==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="178414012"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="178414012"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 12:48:48 -0800
IronPort-SDR: rHVvrGzVetfwJcqgH210rqMOwDQKD3UGfT2r+h7Sp+jK1CIvTenPmsXq02/At9fsMeoBchq8wZ
 hnF1g6XHKfoQ==
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="572141573"
Received: from oslutsk1-mobl1.ccr.corp.intel.com (HELO linux.intel.com) ([10.249.40.71])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 12:48:46 -0800
Date:   Wed, 13 Jan 2021 22:48:41 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <X/9cqbUN263oR8gZ@linux.intel.com>
References: <20210113015958.6685-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113015958.6685-1-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 12, 2021 at 05:59:57PM -0800, James Bottomley wrote:
> This represents v5 which has the spelling mistake fixed and the WARN
> on unrecognized TPM hash algorithm becoming a dev_err.
> 
> We've had a fairly extensive discussion and iterated to agreement on
> the output format, which becomes our ABI being one single compact hex
> representation of the hash value per file according to sysfs rules,
> with the file hierarchy going under
> 
>   /sys/class/tpm/tmp<x>/pcr-<hash>/<pcr number>
> 
> So to get the value of PCR 7 in the sha256 bank of the default TPM I'd do
> 
>    cat /sys/class/tpm/tpm0/pcr-sha256/7
>    2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42
> 
> If you need the binary hash of a set of PCRs, as is required for TPM
> policy statements that lock to PCRs, you'd use something like:
> 
>   cat /sys/class/tpm/tpm0/pcr-sha256/{1,6,7}|xxd -r -p|sha256sum
> 
> Which produces the binary hash of PCRs 1, 6 and 7 in that order.
> 
> Note that this patch also adds the sha1 bank for TPM 1.2 in the same
> manner (one file per PCR) but does not remove the existing pcrs file
> which has the space separated all PCRs in one file format of
> 
>   PCR-00: 7D 29 CB 08 0C 0F C4 16 7A 0E 9A F7 C6 D3 97 CD C1 21 A7 69 
>   PCR-01: 9C B6 79 4C E4 4B 62 97 4C AB 55 13 1A 2F 7E AE 09 B3 30 BE 
>   ...
> 
> 
> James
> 
> ---
> 
> James Bottomley (1):
>   tpm: add sysfs exports for all banks of PCR registers
> 
>  drivers/char/tpm/tpm-sysfs.c | 179 +++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h          |   9 +-
>  2 files changed, 187 insertions(+), 1 deletion(-)
> 
> -- 
> 2.26.2
> 

After clearing out Greg's remarks, can you use jarkko@kernel.org
for the next version?

/Jarkko
