Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B910F204620
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 02:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbgFWAsU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 20:48:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:23082 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731716AbgFWAsU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 20:48:20 -0400
IronPort-SDR: xcbKq55JFyPn2Z7U8E0/rcd0GOQD0Xsbhoi4YsCsgHD2bacIy/rS/HLrgQ1x+50DWvtB12BkXd
 Z7cZV+iHuG+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="145420202"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="145420202"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 17:48:19 -0700
IronPort-SDR: 9jEEJuxfpBhX37hxIAiIqJr7MzUGTlfXJVnvnstDhgdyY8D03DaTh7iAXHM34LgVacTLSlUS2/
 c/icCE4uxyQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="275173913"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2020 17:48:14 -0700
Date:   Tue, 23 Jun 2020 03:48:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     stefanb@linux.ibm.com, mpe@ellerman.id.au, peterhuewe@gmx.de,
        jgg@ziepe.ca, nayna@linux.ibm.com, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] tpm: ibmvtpm: Wait for ready buffer before probing for
 TPM2 attributes
Message-ID: <20200623004813.GB28795@linux.intel.com>
References: <20200619033040.121412-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619033040.121412-1-david@gibson.dropbear.id.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 19, 2020 at 01:30:40PM +1000, David Gibson wrote:
> The tpm2_get_cc_attrs_tbl() call will result in TPM commands being issued,
> which will need the use of the internal command/response buffer.  But,
> we're issuing this *before* we've waited to make sure that buffer is
> allocated.
> 
> This can result in intermittent failures to probe if the hypervisor / TPM
> implementation doesn't respond quickly enough.  I find it fails almost
> every time with an 8 vcpu guest under KVM with software emulated TPM.
> 
> To fix it, just move the tpm2_get_cc_attrs_tlb() call after the
> existing code to wait for initialization, which will ensure the buffer
> is allocated.
> 
> Fixes: 18b3670d79ae9 ("tpm: ibmvtpm: Add support for TPM2")
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
