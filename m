Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D8CD5D86
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfJNIce (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 04:32:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:34525 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbfJNIce (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 04:32:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 01:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,295,1566889200"; 
   d="scan'208";a="225012217"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2019 01:32:31 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iJvmJ-0000Jr-Dk; Mon, 14 Oct 2019 16:32:31 +0800
Date:   Mon, 14 Oct 2019 16:32:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     ivan.lazeev@gmail.com
Cc:     kbuild-all@lists.01.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vanya Lazeev <ivan.lazeev@gmail.com>
Subject: Re: [PATCH v6] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <201910141623.SRwaPnfk%lkp@intel.com>
References: <20191002201212.32395-1-ivan.lazeev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002201212.32395-1-ivan.lazeev@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jss-tpmdd/next]
[cannot apply to v5.4-rc3 next-20191011]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/ivan-lazeev-gmail-com/tpm_crb-fix-fTPM-on-AMD-Zen-CPUs/20191003-054300
base:   git://git.infradead.org/users/jjs/linux-tpmdd next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-43-g0ccb3b4-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/char/tpm/tpm_crb.c:507:62: sparse: sparse: Using plain integer as NULL pointer

vim +507 drivers/char/tpm/tpm_crb.c

   501	
   502	static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
   503			      struct acpi_table_tpm2 *buf)
   504	{
   505		struct list_head acpi_resource_list;
   506		struct resource iores_array[TPM_CRB_MAX_RESOURCES];
 > 507		void __iomem *iobase_array[TPM_CRB_MAX_RESOURCES] = {0};
   508		struct resource *iores_range[] = {
   509			iores_array,
   510			iores_array + TPM_CRB_MAX_RESOURCES
   511		};
   512		struct device *dev = &device->dev;
   513		struct resource *iores;
   514		void __iomem **iobase_ptr;
   515		int num_resources, i;
   516		u32 pa_high, pa_low;
   517		u64 cmd_pa;
   518		u32 cmd_size;
   519		__le64 __rsp_pa;
   520		u64 rsp_pa;
   521		u32 rsp_size;
   522		int ret;
   523	
   524		INIT_LIST_HEAD(&acpi_resource_list);
   525		ret = acpi_dev_get_resources(device, &acpi_resource_list,
   526					     crb_check_resource, iores_range);
   527		if (ret < 0)
   528			return ret;
   529		acpi_dev_free_resource_list(&acpi_resource_list);
   530	
   531		if (iores_range[0] == iores_array) {
   532			dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
   533			return -EINVAL;
   534		} else if (!iores_range[0]) {
   535			dev_warn(dev, "TPM2 ACPI table defines too many memory resources\n");
   536			iores_range[0] = iores_range[1];
   537		}
   538	
   539		num_resources = iores_range[0] - iores_array;
   540	
   541		iores = NULL;
   542		iobase_ptr = NULL;
   543		for (i = 0; i < num_resources; ++i) {
   544			if (buf->control_address >= iores_array[i].start &&
   545			    buf->control_address + sizeof(struct crb_regs_tail) - 1 <=
   546			    iores_array[i].end) {
   547				iores = iores_array + i;
   548				iobase_ptr = iobase_array + i;
   549				break;
   550			}
   551		}
   552	
   553		priv->regs_t = crb_map_res(dev, iores, iobase_ptr, buf->control_address,
   554					   sizeof(struct crb_regs_tail));
   555	
   556		if (IS_ERR(priv->regs_t))
   557			return PTR_ERR(priv->regs_t);
   558	
   559		/* The ACPI IO region starts at the head area and continues to include
   560		 * the control area, as one nice sane region except for some older
   561		 * stuff that puts the control area outside the ACPI IO region.
   562		 */
   563		if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
   564		    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {
   565			if (iores &&
   566			    buf->control_address == iores->start +
   567			    sizeof(*priv->regs_h))
   568				priv->regs_h = *iobase_ptr;
   569			else
   570				dev_warn(dev, FW_BUG "Bad ACPI memory layout");
   571		}
   572	
   573		ret = __crb_request_locality(dev, priv, 0);
   574		if (ret)
   575			return ret;
   576	
   577		/*
   578		 * PTT HW bug w/a: wake up the device to access
   579		 * possibly not retained registers.
   580		 */
   581		ret = __crb_cmd_ready(dev, priv);
   582		if (ret)
   583			goto out_relinquish_locality;
   584	
   585		pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
   586		pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
   587		cmd_pa = ((u64)pa_high << 32) | pa_low;
   588		cmd_size = ioread32(&priv->regs_t->ctrl_cmd_size);
   589	
   590		iores = NULL;
   591		iobase_ptr = NULL;
   592		for (i = 0; i < num_resources; ++i) {
   593			if (cmd_pa >= iores_array[i].start &&
   594			    cmd_pa <= iores_array[i].end) {
   595				iores = iores_array + i;
   596				iobase_ptr = iobase_array + i;
   597				break;
   598			}
   599		}
   600	
   601		if (iores)
   602			cmd_size = crb_fixup_cmd_size(dev, iores, cmd_pa, cmd_size);
   603	
   604		dev_dbg(dev, "cmd_hi = %X cmd_low = %X cmd_size %X\n",
   605			pa_high, pa_low, cmd_size);
   606	
   607		priv->cmd = crb_map_res(dev, iores, iobase_ptr,	cmd_pa, cmd_size);
   608		if (IS_ERR(priv->cmd)) {
   609			ret = PTR_ERR(priv->cmd);
   610			goto out;
   611		}
   612	
   613		memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
   614		rsp_pa = le64_to_cpu(__rsp_pa);
   615		rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
   616	
   617		iores = NULL;
   618		iobase_ptr = NULL;
   619		for (i = 0; i < num_resources; ++i) {
   620			if (rsp_pa >= iores_array[i].start &&
   621			    rsp_pa <= iores_array[i].end) {
   622				iores = iores_array + i;
   623				iobase_ptr = iobase_array + i;
   624				break;
   625			}
   626		}
   627	
   628		if (iores)
   629			rsp_size = crb_fixup_cmd_size(dev, iores, rsp_pa, rsp_size);
   630	
   631		if (cmd_pa != rsp_pa) {
   632			priv->rsp = crb_map_res(dev, iores, iobase_ptr,
   633						rsp_pa, rsp_size);
   634			ret = PTR_ERR_OR_ZERO(priv->rsp);
   635			goto out;
   636		}
   637	
   638		/* According to the PTP specification, overlapping command and response
   639		 * buffer sizes must be identical.
   640		 */
   641		if (cmd_size != rsp_size) {
   642			dev_err(dev, FW_BUG "overlapping command and response buffer sizes are not identical");
   643			ret = -EINVAL;
   644			goto out;
   645		}
   646	
   647		priv->rsp = priv->cmd;
   648	
   649	out:
   650		if (!ret)
   651			priv->cmd_size = cmd_size;
   652	
   653		__crb_go_idle(dev, priv);
   654	
   655	out_relinquish_locality:
   656	
   657		__crb_relinquish_locality(dev, priv, 0);
   658	
   659		return ret;
   660	}
   661	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
