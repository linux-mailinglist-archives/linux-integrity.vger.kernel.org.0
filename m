Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC927E80F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 13:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgI3L7o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 07:59:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:22014 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbgI3L7o (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 07:59:44 -0400
IronPort-SDR: GT0V0zrL41J9/jxByVazz5ixAttefc8tmetxBZy/FW0lzSRmLlhfoSoDfbcV94B31adgB8uUoB
 5Zhw0x4CqBgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="159814765"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="159814765"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 04:59:43 -0700
IronPort-SDR: gu367M5H2ZN4V7avZSxV5vhUUKmsscYKkex41phaa8EYkUSvBzRcdNs7o+aVxO7VqxRbqeRA3T
 UB8Fky3LGTiQ==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="497212937"
Received: from lbentzio-mobl.ger.corp.intel.com (HELO localhost) ([10.252.32.88])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 04:59:41 -0700
Date:   Wed, 30 Sep 2020 14:59:39 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20200930115939.GB7612@linux.intel.com>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
 <20200930055314.GA21664@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930055314.GA21664@dell5510>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 30, 2020 at 07:53:14AM +0200, Petr Vorel wrote:
> Hi Jarkko,
> 
> > Hi, is there something specific I should look at in this patch set?
> 
> I'm sorry to bother you with LTP specific code. Can you have a quick look if I
> didn't overlook anything obvious in reading PCR files (read_pcr_tpm*())?
> 
> I'm surprised that it's working on my TPM 2.0 which does not export
> /sys/kernel/security/tpm0/binary_bios_measurements (using evmctl).

Thank you, this was actually really important remark and reminder.

OK so I think James' patch is stuck because of me, i.e.

https://lore.kernel.org/linux-integrity/20200911114820.GB6877@linux.intel.com/

I'm sorry about this. The final final conclusion is that the way it
exports PCRs is just fine.

Can you test this version?

https://patchwork.kernel.org/patch/11759729/

I can then add reviewd-by and apply it and you don't have to do any sort
of stupid hacks.

/Jarkkko
