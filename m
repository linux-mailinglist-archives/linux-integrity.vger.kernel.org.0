Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C06A76F3
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 23:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCAWns (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 17:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCAWnr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 17:43:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762971A66B;
        Wed,  1 Mar 2023 14:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677710623; x=1709246623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QcM62RcTYi5zvoGJymyxGLnQj3e1/GlbLkfJR0EShdo=;
  b=AULRsfYdZyqxS0WG/ztpDuMe+RLMHl48R8BfLqGyDFI6H5TaPYd8R67V
   Z95mlpIGr4Mye76jPSe45/f1eozgGTnl/FwyIHdnpIxiKqlph5yfh/lYn
   AoQGjGx5meNOqXdL4Lwh9zQ/KlWsLImCVvMcf9uq4NiGmbQFKij7K0oHo
   BTWMT7ftL+APcPI+NB1YWPHNod3pK4IJ9V/+gwun/cmAXVCY1rOP0+IMS
   e3Xq9S9KnAkhNbXY2ttis8QN7vLj5ScYhwm6H9IrgRXOdUZDECzu1x+yt
   7q2Bi/gTk9kPXGq/nXbyEJFcli9OT82dLrOCkUApe7RnhBQd0ICFdLqei
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="334571891"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="334571891"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 14:43:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="848838873"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="848838873"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2023 14:43:37 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXVAe-0006TP-38;
        Wed, 01 Mar 2023 22:43:36 +0000
Date:   Thu, 2 Mar 2023 06:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, robh+dt@kernel.org,
        broonie@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, thierry.reding@gmail.com,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: Re: [Patch V7 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <202303020622.v3NqL5mg-lkp@intel.com>
References: <20230301173353.28673-3-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301173353.28673-3-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Krishna,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.2 next-20230301]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Yarlagadda/spi-Add-TPM-HW-flow-flag/20230302-013628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20230301173353.28673-3-kyarlagadda%40nvidia.com
patch subject: [Patch V7 2/3] tpm_tis-spi: Add hardware wait polling
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230302/202303020622.v3NqL5mg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d47344c6b9ab634483742457f6692b01f02c4698
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-Yarlagadda/spi-Add-TPM-HW-flow-flag/20230302-013628
        git checkout d47344c6b9ab634483742457f6692b01f02c4698
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303020622.v3NqL5mg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/char/tpm/tpm_tis_spi_main.c:335:36: warning: 'acpi_tis_spi_match' defined but not used [-Wunused-const-variable=]
     335 | static const struct acpi_device_id acpi_tis_spi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~
   drivers/char/tpm/tpm_tis_spi_main.c: In function 'tpm_tis_spi_probe':
>> drivers/char/tpm/tpm_tis_spi_main.c:263:42: warning: 'phy' is used uninitialized [-Wuninitialized]
     263 |         struct spi_controller *ctlr = phy->spi_device->controller;
         |                                       ~~~^~~~~~~~~~~~
   drivers/char/tpm/tpm_tis_spi_main.c:262:33: note: 'phy' was declared here
     262 |         struct tpm_tis_spi_phy *phy;
         |                                 ^~~


vim +/phy +263 drivers/char/tpm/tpm_tis_spi_main.c

   259	
   260	static int tpm_tis_spi_probe(struct spi_device *dev)
   261	{
   262		struct tpm_tis_spi_phy *phy;
 > 263		struct spi_controller *ctlr = phy->spi_device->controller;
   264		int irq;
   265	
   266		phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
   267				   GFP_KERNEL);
   268		if (!phy)
   269			return -ENOMEM;
   270	
   271		phy->flow_control = tpm_tis_spi_flow_control;
   272	
   273		if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX)
   274			phy->spi_device->mode |= SPI_TPM_HW_FLOW;
   275	
   276		/* If the SPI device has an IRQ then use that */
   277		if (dev->irq > 0)
   278			irq = dev->irq;
   279		else
   280			irq = -1;
   281	
   282		init_completion(&phy->ready);
   283		return tpm_tis_spi_init(dev, phy, irq, &tpm_spi_phy_ops);
   284	}
   285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
