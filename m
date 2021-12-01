Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DFA464738
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 07:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhLAGjb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 01:39:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:29004 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhLAGjb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 01:39:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="260368092"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="260368092"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 22:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="677146995"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2021 22:36:08 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msJDr-000ENt-GT; Wed, 01 Dec 2021 06:36:07 +0000
Date:   Wed, 1 Dec 2021 14:35:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Barnes <robbarnes@google.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Rob Barnes <robbarnes@google.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: tpm: cr50: Set TPM_FIRMWARE_POWER_MANAGED based on
 device property
Message-ID: <202112011433.QeYkYJE1-lkp@intel.com>
References: <20211130235918.2216110-1-robbarnes@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130235918.2216110-1-robbarnes@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Rob,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on v5.16-rc3 next-20211201]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Rob-Barnes/char-tpm-cr50-Set-TPM_FIRMWARE_POWER_MANAGED-based-on-device-property/20211201-080132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 5d331b5922551637c586cdf5fdc1778910fc937f
config: hexagon-randconfig-r041-20211128 (https://download.01.org/0day-ci/archive/20211201/202112011433.QeYkYJE1-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4c5a69ab6ee4ba384abbbf714753053b5cd0de2c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rob-Barnes/char-tpm-cr50-Set-TPM_FIRMWARE_POWER_MANAGED-based-on-device-property/20211201-080132
        git checkout 4c5a69ab6ee4ba384abbbf714753053b5cd0de2c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/char/tpm/tpm_tis_spi_cr50.c:18:
   In file included from drivers/char/tpm/tpm_tis_core.h:22:
   In file included from drivers/char/tpm/tpm.h:28:
   include/linux/tpm_eventlog.h:167:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
           int mapping_size;
               ^
>> drivers/char/tpm/tpm_tis_spi_cr50.c:319:45: error: use of undeclared identifier 'dev'
           if (tpm_cr50_spi_is_firmware_power_managed(dev))
                                                      ^
   1 warning and 1 error generated.


vim +/dev +319 drivers/char/tpm/tpm_tis_spi_cr50.c

   263	
   264	int cr50_spi_probe(struct spi_device *spi)
   265	{
   266		struct tpm_tis_spi_phy *phy;
   267		struct cr50_spi_phy *cr50_phy;
   268		int ret;
   269		struct tpm_chip *chip;
   270	
   271		cr50_phy = devm_kzalloc(&spi->dev, sizeof(*cr50_phy), GFP_KERNEL);
   272		if (!cr50_phy)
   273			return -ENOMEM;
   274	
   275		phy = &cr50_phy->spi_phy;
   276		phy->flow_control = cr50_spi_flow_control;
   277		phy->wake_after = jiffies;
   278		init_completion(&phy->ready);
   279	
   280		cr50_phy->access_delay = CR50_NOIRQ_ACCESS_DELAY;
   281		cr50_phy->last_access = jiffies;
   282		mutex_init(&cr50_phy->time_track_mutex);
   283	
   284		if (spi->irq > 0) {
   285			ret = devm_request_irq(&spi->dev, spi->irq,
   286					       cr50_spi_irq_handler,
   287					       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
   288					       "cr50_spi", cr50_phy);
   289			if (ret < 0) {
   290				if (ret == -EPROBE_DEFER)
   291					return ret;
   292				dev_warn(&spi->dev, "Requesting IRQ %d failed: %d\n",
   293					 spi->irq, ret);
   294				/*
   295				 * This is not fatal, the driver will fall back to
   296				 * delays automatically, since ready will never
   297				 * be completed without a registered irq handler.
   298				 * So, just fall through.
   299				 */
   300			} else {
   301				/*
   302				 * IRQ requested, let's verify that it is actually
   303				 * triggered, before relying on it.
   304				 */
   305				cr50_phy->irq_needs_confirmation = true;
   306			}
   307		} else {
   308			dev_warn(&spi->dev,
   309				 "No IRQ - will use delays between transactions.\n");
   310		}
   311	
   312		ret = tpm_tis_spi_init(spi, phy, -1, &tpm_spi_cr50_phy_ops);
   313		if (ret)
   314			return ret;
   315	
   316		cr50_print_fw_version(&phy->priv);
   317	
   318		chip = dev_get_drvdata(&spi->dev);
 > 319		if (tpm_cr50_spi_is_firmware_power_managed(dev))
   320			chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
   321	
   322		return 0;
   323	}
   324	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
