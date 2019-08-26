Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6712E9CE26
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2019 13:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfHZLcn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 07:32:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:59660 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbfHZLcn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 07:32:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 04:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="355401973"
Received: from dcondura-mobl.ger.corp.intel.com (HELO localhost) ([10.249.37.53])
  by orsmga005.jf.intel.com with ESMTP; 26 Aug 2019 04:32:40 -0700
Date:   Mon, 26 Aug 2019 14:32:39 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_crb: Fix an improper buffer size calculation bug
Message-ID: <20190826113239.2tliwil35gsqap54@linux.intel.com>
References: <20190826074400.54794-1-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826074400.54794-1-kkamagui@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 26, 2019 at 04:44:00PM +0900, Seunghun Han wrote:
> I'm Seunghun Han and work at the Affiliated Institute of ETRI. I found

You can drop the first sentence from the commit message. The SoB below
is sufficient.

> a bug related to improper buffer size calculation in crb_fixup_cmd_size
> function.

The purpose is to cap to the ACPI region when we partially overlap to
workaround BIOS's reporting corrupted ACPI tables so that we don't get
failure from devm_ioremap().

The only funky thing in that function is that it lets through a buffer
that is fully outside the ACPI region. There actually exists hardware
with this configuration.

> When the TPM CRB regions are two or more, the crb_map_io function calls
> crb_fixup_cmd_size twice to calculate command buffer size and response
> buffer size. The purpose of crb_fixup_cmd_size function is to trust
> the ACPI region information.

This is not true. The driver deals with only one ACPI region ATM.

> However, the function compares only io_res argument with start and size
> arguments.  It means the io_res argument is one of command buffer and
> response buffer regions. It also means the other region is not calculated
> correctly by the function because io_res argument doesn't cover all TPM
> CRB regions.

The driver gets command and response buffer metrics from the TPM2 ACPI
table, not from the ACPI region.

> To fix this bug, I change crb_check_resource function for storing all TPB
> CRB regions to a list and use the list to calculate command buffer size
> and response buffer size correctly.

This cannot be categorized as a bug. It is simply as new type of hardware.
Can you explain in detail what type of hardware are you using?

> ---
>  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index e59f1f91d7f3..b0e94e02e5eb 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -442,6 +442,9 @@ static int crb_check_resource(struct acpi_resource *ares, void *data)
>  	    acpi_dev_resource_address_space(ares, &win)) {
>  		*io_res = *res;
>  		io_res->name = NULL;
> +
> +		/* Add this TPM CRB resource to the list */
> +		return 0;
>  	}
>  
>  	return 1;
> @@ -471,20 +474,30 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
>   * region vs the registers. Trust the ACPI region. Such broken systems
>   * probably cannot send large TPM commands since the buffer will be truncated.
>   */
> -static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
> +static u64 crb_fixup_cmd_size(struct device *dev, struct list_head *resources,
>  			      u64 start, u64 size)

With a quick spin w/o knowing the details of the hardware I'm dealing
with it you should probably reduce the fixup function as

static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
			      u64 start, u64 size)
{
	if (start + size - 1 <= io_res->end)
		 return size;

	dev_err(dev,
		 FW_BUG "ACPI region does not cover the entire command/response buffer. %pr vs %llx %llx\n",
		 io_res, start, size);

	return io_res->end - start + 1;
}

Then call this inside the loop.

Looking at your change it does not make much sense to me.

There is a weird asymmetry in it:

1. The code loops through all found ACPI regions when looking for
   intersections with the command and response buffers.
2. The devm_ioremap() is done only to the last seen ACPI region. Why the
   multiple regions matter for fixup's but not in this case?

/Jarkko
