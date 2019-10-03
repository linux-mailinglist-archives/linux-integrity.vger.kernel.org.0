Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D67C9DF8
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 14:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfJCMDG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 08:03:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:46222 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbfJCMDF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 08:03:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 05:03:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,252,1566889200"; 
   d="scan'208";a="367021691"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.161])
  by orsmga005.jf.intel.com with ESMTP; 03 Oct 2019 05:03:02 -0700
Date:   Thu, 3 Oct 2019 15:03:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191003120302.GB10038@linux.intel.com>
References: <20191002201212.32395-1-ivan.lazeev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002201212.32395-1-ivan.lazeev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 02, 2019 at 11:12:12PM +0300, ivan.lazeev@gmail.com wrote:
> From: Vanya Lazeev <ivan.lazeev@gmail.com>
> 
> Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> 
> cmd/rsp buffers are expected to be in the same ACPI region.
> For Zen+ CPUs BIOS's might report two different regions, some of
> them also report region sizes inconsistent with values from TPM
> registers.
> 
> Memory configuration on ASRock x470 ITX:
> 
> db0a0000-dc59efff : Reserved
>         dc57e000-dc57efff : MSFT0101:00
>         dc582000-dc582fff : MSFT0101:00
> 
> Work around the issue by storing ACPI regions declared for the
> device in a fixed array and adding an array for pointers to
> corresponding possibly allocated resources in crb_map_io function.
> This data was previously held for a single resource
> in struct crb_priv (iobase field) and local variable io_res in
> crb_map_io function. ACPI resources array is used to find index of
> corresponding region for each buffer and make the buffer size
> consistent with region's length. Array of pointers to allocated
> resources is used to map the region at most once.
> 
> Signed-off-by: Ivan Lazeev <ivan.lazeev@gmail.com>

I'm getting soon Udoo Bolt that I should be able to use to test this
change.

> ---
> Changes in v6:
> 	- got rid of new structures
> 	- open coded helper functions
> 	- removed incorrect FW_BUG
> 
>  drivers/char/tpm/tpm_crb.c | 126 +++++++++++++++++++++++++++----------
>  1 file changed, 93 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index e59f1f91d7f3..8177406aecd6 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -22,6 +22,7 @@
>  #include "tpm.h"
>  
>  #define ACPI_SIG_TPM2 "TPM2"
> +#define TPM_CRB_MAX_RESOURCES 3
>  
>  static const guid_t crb_acpi_start_guid =
>  	GUID_INIT(0x6BBF6CAB, 0x5463, 0x4714,
> @@ -91,7 +92,6 @@ enum crb_status {
>  struct crb_priv {
>  	u32 sm;
>  	const char *hid;
> -	void __iomem *iobase;
>  	struct crb_regs_head __iomem *regs_h;
>  	struct crb_regs_tail __iomem *regs_t;
>  	u8 __iomem *cmd;
> @@ -434,21 +434,27 @@ static const struct tpm_class_ops tpm_crb = {
>  
>  static int crb_check_resource(struct acpi_resource *ares, void *data)
>  {
> -	struct resource *io_res = data;
> +	struct resource **iores_range = data;
>  	struct resource_win win;
>  	struct resource *res = &(win.res);
>  
>  	if (acpi_dev_resource_memory(ares, res) ||
>  	    acpi_dev_resource_address_space(ares, &win)) {
> -		*io_res = *res;
> -		io_res->name = NULL;
> +		if (iores_range[0] == iores_range[1])
> +			iores_range[0] = NULL;
> +
> +		if (iores_range[0]) {
> +			*iores_range[0] = *res;
> +			iores_range[0]->name = NULL;
> +			iores_range[0] += 1;
> +		}

You could get away without iores_range by having an extra
terminator entry in the iores_array.

Overally this starts to look good.

/Jarkko
