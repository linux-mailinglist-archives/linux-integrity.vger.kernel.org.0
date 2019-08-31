Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B979BA4672
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Sep 2019 00:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfHaW15 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 31 Aug 2019 18:27:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:54054 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfHaW15 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 31 Aug 2019 18:27:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2019 15:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,451,1559545200"; 
   d="scan'208";a="211309903"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2019 15:27:55 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i4Bqd-0006W4-8s; Sun, 01 Sep 2019 06:27:55 +0800
Date:   Sun, 1 Sep 2019 06:27:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     kbuild-all@01.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
Message-ID: <201909010620.mIDwNGDO%lkp@intel.com>
References: <20190830095639.4562-3-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830095639.4562-3-kkamagui@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Seunghun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jss-tpmdd/next]
[cannot apply to v5.3-rc6 next-20190830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Seunghun-Han/Enhance-support-for-the-AMD-s-fTPM/20190901-042313
base:   git://git.infradead.org/users/jjs/linux-tpmdd next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/char/tpm/tpm_crb.c:457:29-32: WARNING: Suspicious code. resource_size is maybe missing with res

vim +457 drivers/char/tpm/tpm_crb.c

   452	
   453	static void __iomem *crb_ioremap_resource(struct device *dev,
   454						  const struct resource *res)
   455	{
   456		int rc;
 > 457		resource_size_t size = res->end - res->start;
   458	
   459		/* Broken BIOS assigns command and response buffers in ACPI NVS region.
   460		 * Check intersections between a resource and ACPI NVS for W/A.
   461		 */
   462		rc = region_intersects(res->start, size, IORESOURCE_MEM |
   463				       IORESOURCE_BUSY, IORES_DESC_ACPI_NV_STORAGE);
   464		if (rc != REGION_DISJOINT) {
   465			dev_err(dev,
   466				FW_BUG "Resource overlaps with a ACPI NVS. %pr\n",
   467				res);
   468			return devm_ioremap(dev, res->start, size);
   469		}
   470	
   471		return devm_ioremap_resource(dev, res);
   472	}
   473	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
