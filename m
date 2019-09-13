Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894C9B2114
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2019 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390359AbfIMNcl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Sep 2019 09:32:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:1052 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389185AbfIMNMk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Sep 2019 09:12:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 06:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,501,1559545200"; 
   d="scan'208";a="215371241"
Received: from ddungax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.37.38])
  by fmsmga002.fm.intel.com with ESMTP; 13 Sep 2019 06:12:35 -0700
Date:   Fri, 13 Sep 2019 14:12:34 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vanya Lazeev <ivan.lazeev@gmail.com>
Subject: Re: [PATCH v2 2/2] tpm: tpm_crb: enhance resource mapping mechanism
 for supporting AMD's fTPM
Message-ID: <20190913131234.GA7412@linux.intel.com>
References: <20190909090906.28700-1-kkamagui@gmail.com>
 <20190909090906.28700-3-kkamagui@gmail.com>
 <20190910144215.GA30780@linux.intel.com>
 <20190910150342.GA1920@linux.intel.com>
 <CAHjaAcRf3fcJMp6AwVRTrVaABZVzSkhBwRcpKZogAS4SSDK3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHjaAcRf3fcJMp6AwVRTrVaABZVzSkhBwRcpKZogAS4SSDK3zg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 11, 2019 at 12:28:18AM +0900, Seunghun Han wrote:
> > Matthew pointed out that having a hook in NVS driver is better solution
> > because it is nil functionality if the TPM driver is loaded. We need
> > functions to:
> >
> > 1. Request a region from the NVS driver (when tpm_crb loads)
> > 2. Release a region back to the NVS Driver (when tpm_crb unloads).
> >
> > My proposal would unnecessarily duplicate code and also leave a
> > side-effect when TPM is not used in the first place.
> >
> > I see this as the overally best solution. If you can come up with a
> > patch for the NVS side and changes to CRB drivers to utilize the new
> > hooks, then combined with Vanya's changes we have a sustainable solution
> > for AMD fTPM.
> 
> It's a great solution. I will update this patch on your advice and
> send it to you soon.
> 
> By the way, I have a question about your advice.
> If we handle the NVS region with NVS driver, calling devm_ioremap()
> function is fine like crb_ioremap_resource() function in this patch?

No, you should reclaim the resource that conflicts and return it back
when tpm_crb is unregistered (e.g. rmmod tpm_crb).

I would try something like enumerating iomem resources with
walk_iomem_res_desc(). I would advice to peek at arch/x86/kernel/crash.c
for an example how to use this for NVS regions
(IORES_DESC_ACPI_NV_STORAGE).

E.g. you could use a callback for it along the lines of:

static int crb_find_iomem_res_cb(struct resource *res, void *io_res_ptr)
{
	struct resource *io_res = io_res_ptr;

	if (res->start == io_res->start && res->end == io_res->end) {
		/*
		 * Backup all resource data so that it can be inserted
		 * later on with the flags it had etc.
		 */
		*io_res = *res;
		return 1;
	}

	return 0;
}

Then you could __release_region() to unallocate the source. When tpm_crb
is removed you can then allocate and insert a resource with data
matching it had.


/Jarkko
