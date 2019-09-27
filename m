Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D95C080C
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2019 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfI0O4X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Sep 2019 10:56:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:61335 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfI0O4X (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Sep 2019 10:56:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 07:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="214854333"
Received: from mdauner2-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.39.118])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2019 07:56:20 -0700
Date:   Fri, 27 Sep 2019 17:56:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20190927145607.GA9614@linux.intel.com>
References: <20190925215646.24844-1-ivan.lazeev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925215646.24844-1-ivan.lazeev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 26, 2019 at 12:56:46AM +0300, ivan.lazeev@gmail.com wrote:
> +struct tpm_crb_resources {
> +	struct resource iores[TPM_CRB_MAX_RESOURCES];
> +	void __iomem *iobase[TPM_CRB_MAX_RESOURCES];
> +	int num;
> +};

Do not add a new struct.

> +
>  static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
>  				unsigned long timeout)
>  {
> @@ -432,38 +438,75 @@ static const struct tpm_class_ops tpm_crb = {
>  	.req_complete_val = CRB_DRV_STS_COMPLETE,
>  };
>  
> +static bool tpm_crb_resource_contains(struct resource *iores,
> +				      u64 address)
> +{
> +	return address >= iores->start && address <= iores->end;
> +}

Open code this. Makes the code only more unreadable.

> +static int tpm_crb_containing_res_idx(struct tpm_crb_resources *resources,
> +				      u64 address)
> +{
> +	int res_idx;

Use "int i;"

> +
> +	for (res_idx = 0; res_idx < resources->num; ++res_idx) {
> +		if (tpm_crb_resource_contains(&resources->iores[res_idx],
> +					      address))
> +			return res_idx;
> +	}
> +
> +	return -1;
> +}

Open code this. Two call sites do not make the function worth it.

> +
>  static int crb_check_resource(struct acpi_resource *ares, void *data)
>  {
> -	struct resource *io_res = data;
> +	struct tpm_crb_resources *resources = data;
>  	struct resource_win win;
>  	struct resource *res = &(win.res);
>  
>  	if (acpi_dev_resource_memory(ares, res) ||
>  	    acpi_dev_resource_address_space(ares, &win)) {
> -		*io_res = *res;
> -		io_res->name = NULL;
> +		if (resources->num < TPM_CRB_MAX_RESOURCES) {
> +			resources->iores[resources->num] = *res;
> +			resources->iores[resources->num].name = NULL;
> +		}
> +		resources->num += 1;
>  	}
>  
>  	return 1;
>  }
>  
> -static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
> -				 struct resource *io_res, u64 start, u32 size)
> +static void __iomem *crb_map_res(struct device *dev,
> +				 struct tpm_crb_resources *resources,
> +				 int res_idx,
> +				 u64 start, u32 size)
>  {
>  	struct resource new_res = {
>  		.start	= start,
>  		.end	= start + size - 1,
>  		.flags	= IORESOURCE_MEM,
>  	};
> +	struct resource *iores;
> +	void __iomem *iobase;
>  
>  	/* Detect a 64 bit address on a 32 bit system */
>  	if (start != new_res.start)
>  		return (void __iomem *) ERR_PTR(-EINVAL);
>  
> -	if (!resource_contains(io_res, &new_res))
> +	if (res_idx < 0)
>  		return devm_ioremap_resource(dev, &new_res);
>  
> -	return priv->iobase + (new_res.start - io_res->start);
> +	iores = &resources->iores[res_idx];
> +	iobase = resources->iobase[res_idx];
> +	if (!iobase) {
> +		iobase = devm_ioremap_resource(dev, iores);
> +		if (IS_ERR(iobase))
> +			return iobase;
> +
> +		resources->iobase[res_idx] = iobase;
> +	}
> +
> +	return iobase + (new_res.start - iores->start);
>  }
>  
>  /*
> @@ -490,9 +533,10 @@ static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
>  static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  		      struct acpi_table_tpm2 *buf)
>  {
> -	struct list_head resources;
> -	struct resource io_res;
> +	struct list_head acpi_resources;
>  	struct device *dev = &device->dev;
> +	struct tpm_crb_resources resources;
> +	int res_idx;
>  	u32 pa_high, pa_low;
>  	u64 cmd_pa;
>  	u32 cmd_size;
> @@ -501,21 +545,36 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  	u32 rsp_size;
>  	int ret;
>  
> -	INIT_LIST_HEAD(&resources);
> -	ret = acpi_dev_get_resources(device, &resources, crb_check_resource,
> -				     &io_res);
> +	INIT_LIST_HEAD(&acpi_resources);
> +	memset(&resources, 0, sizeof(resources));
> +	ret = acpi_dev_get_resources(device, &acpi_resources,
> +				     crb_check_resource, &resources);
>  	if (ret < 0)
>  		return ret;
> -	acpi_dev_free_resource_list(&resources);
> +	acpi_dev_free_resource_list(&acpi_resources);
>  
> -	if (resource_type(&io_res) != IORESOURCE_MEM) {
> +	if (resources.num == 0) {
>  		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
>  		return -EINVAL;
> +	} else if (resources.num > TPM_CRB_MAX_RESOURCES) {
> +		dev_warn(dev, FW_BUG "TPM2 ACPI table defines too many memory resources\n");
> +		resources.num = TPM_CRB_MAX_RESOURCES;

Remove FW_BUG as this would not be a bug.

/Jarkko
