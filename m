Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF49C8E1
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2019 07:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfHZF7J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 01:59:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:34419 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfHZF7J (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 01:59:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2019 22:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="174103428"
Received: from chlopez-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.38.177])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2019 22:59:05 -0700
Date:   Mon, 26 Aug 2019 08:59:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_crb: Add an AMD fTPM support feature
Message-ID: <20190826055903.5um5pfweoszibem3@linux.intel.com>
References: <20190825174019.5977-1-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825174019.5977-1-kkamagui@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 26, 2019 at 02:40:19AM +0900, Seunghun Han wrote:
> I'm Seunghun Han and work at the Affiliated Institute of ETRI. I got an AMD
> system which had a Ryzen Threadripper 1950X and MSI mainboard, and I had
> a problem with AMD's fTPM. My machine showed an error message below, and
> the fTPM didn't work because of it.
> 
> [    5.732084] tpm_crb MSFT0101:00: can't request region for resource
>                [mem 0x79b4f000-0x79b4ffff]
> [    5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16
> 
> When I saw the iomem areas and found two TPM CRB regions were in the ACPI
> NVS area.  The iomem regions are below.
> 
> 79a39000-79b6afff : ACPI Non-volatile Storage
>   79b4b000-79b4bfff : MSFT0101:00
>   79b4f000-79b4ffff : MSFT0101:00
> 
> After analyzing this issue, I found out that a busy bit was set to the ACPI
> NVS area, and the current Linux kernel allowed nothing to be assigned in
> it. I also found that the kernel couldn't calculate the sizes of command
> and response buffers correctly when the TPM regions were two or more.
> 
> To support AMD's fTPM, I removed the busy bit from the ACPI NVS area
> so that AMD's fTPM regions could be assigned in it. I also fixed the bug
> that did not calculate the sizes of command and response buffer correctly.
> 
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>

You need to split this into multiple patches e.g. if you think you've
fixed a bug, please write a patch with just the bug fix and nothing
else.

For further information, read the section three of

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

I'd also recommend to check out the earlier discussion on ACPI NVS:

https://lore.kernel.org/linux-integrity/BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com/

/Jarkko
