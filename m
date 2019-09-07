Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA07AC997
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Sep 2019 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfIGVtP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 Sep 2019 17:49:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:28678 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfIGVtP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 Sep 2019 17:49:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 14:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="177970505"
Received: from dpotapen-mobl1.ger.corp.intel.com ([10.252.53.110])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2019 14:49:12 -0700
Message-ID: <180a3a0fd33cbac9df8adf65999c53a9ddc20bf5.camel@linux.intel.com>
Subject: Re: [PATCH] tpm_crb: fix fTPM on AMD Zen+ CPUs
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 08 Sep 2019 00:49:11 +0300
In-Reply-To: <20190904190332.25019-1-ivan.lazeev@gmail.com>
References: <20190904190332.25019-1-ivan.lazeev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-09-04 at 22:03 +0300, ivan.lazeev@gmail.com wrote:
> From: Ivan Lazeev <ivan.lazeev@gmail.com>
> 
> Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> 
> cmd/rsp buffers are expected to be in the same ACPI region.
> For Zen+ CPUs BIOS's might report two different regions, some of
> them also report region sizes inconsistent with values from TPM
> registers.
> 
> Work around the issue by storing ACPI regions declared for the
> device in a list, then using it to find entry corresponding
> to each buffer. Use information from the entry to map each resource
> at most once and make buffer size consistent with the length of the
> region.
> 
> Signed-off-by: Ivan Lazeev <ivan.lazeev@gmail.com>

Can you add the relevant pieces of /proc/iomem output to the commit
message so we can see the memory configuration? I don't have the
hardware available where this kind of situation occurs.

> ---
> 
> Tested on ASRock x470 ITX motherboard with Ryzen 2600X CPU.
> However, I don't have any other hardware to test the changes on and no
> expertise to be sure that other TPMs won't break as a result.

You can still ask yourself that if the hardware describes the memory
with only one region do the code flows reduce mostly to do the same as
before this patch. It is not the same as testing with such hardware but
it is still a good mental exercise.

To summarize, I do get "not having hardware" part but completely
disqualify "not having expertise" part as the expertise needed here has
nothing specific to do with TPMs :-)

> 
>  drivers/char/tpm/tpm_crb.c | 137 +++++++++++++++++++++++++++----------
>  1 file changed, 101 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index e59f1f91d7f3..0bcfe52db5d6 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -91,7 +91,6 @@ enum crb_status {
>  struct crb_priv {
>  	u32 sm;
>  	const char *hid;
> -	void __iomem *iobase;
>  	struct crb_regs_head __iomem *regs_h;
>  	struct crb_regs_tail __iomem *regs_t;
>  	u8 __iomem *cmd;
> @@ -108,6 +107,12 @@ struct tpm2_crb_smc {
>  	u32 smc_func_id;
>  };
>  
> +struct crb_resource {
> +	struct resource io_res;
> +	void __iomem *iobase;
> +	struct list_head node;
> +};

Please rename 'node' as 'list' for the sake of coherency with the rest
of the kernel and io_res as iores for the sake of coherency with the
other fields.

I think it would be cleaner to do the following:

1. Start with empty resource list.
2. Everytime crb_map_res() is called it does check the existing
   resources and does a ACPI walk on need basis at most adding
   one new entry.

In other words, crb_map_res() gets the list and appends one entry when
necessary.

Overhead of doing multiple walks is irrelevant here. The simplicity and
clarity win.

/Jarkko

