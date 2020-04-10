Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC21A4B83
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2020 23:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDJVMb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Apr 2020 17:12:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:7963 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgDJVMa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Apr 2020 17:12:30 -0400
IronPort-SDR: ikWVQlZK2TsJnHScaUpVCdOJXpWXRkyqfaW3BBh71pxCCGdN5T4OR7eRzhLwFtEdMjJctrtnRO
 6nP+VHqscKeQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 14:12:31 -0700
IronPort-SDR: gmOEdKdVkRVd+gQ22nBZmiXGyuKyadbol9sWGPF+B5W9oLVh1rVAxr6lVTGrbNUMDbycc4JS3I
 EVNNhcPWNuvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="331281098"
Received: from sartorig-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.43.100])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2020 14:12:27 -0700
Date:   Sat, 11 Apr 2020 00:12:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200410211225.GA75170@linux.intel.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410163826.GM11886@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410163826.GM11886@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 10, 2020 at 01:38:26PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> > Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> > TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> > the TPM_CHIP_FLAG_IRQ ever.
> 
> This all used to work..
> 
> > So the whole IRQ probing code is not useful, worse we rely on the
> > IRQ-test path of tpm_tis_send() to call disable_interrupts() if
> > interrupts do not work, but that path never gets entered because we
> > never set the TPM_CHIP_FLAG_IRQ.
> 
> The IRQ probing code should be deleted.
>  
> > On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
> > to use and never free creates an interrupt storm followed by
> > an "irq XX: nobody cared" oops.
> 
> Is this related to probing?

Found it:

https://bugzilla.kernel.org/show_bug.cgi?id=203561

Has existed for a quite a while.

/Jarkko
