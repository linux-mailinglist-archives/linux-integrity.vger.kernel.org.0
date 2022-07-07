Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88384569943
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 06:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiGGE02 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 00:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGGE01 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 00:26:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF92FFE5;
        Wed,  6 Jul 2022 21:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657167986; x=1688703986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0UKCDk+QO7Jju1w2FSJQYoZZKRQ/VlNP3afiUk2ofuU=;
  b=CD8M3uAl1fpVW8/bflhhRH/9E4m7CiGbdZFwHkxeUDpoxy+4zU/uQOyn
   f4YC1EzV9ztCCS9eZxXix4aOBJV34J+DuRu0Yb4UT0AT8U26RkS01pY+4
   uHQLVDKo2O3HgChqYO9maD35/f6K0v24PkTCpG35PK2NPNv/wiV/+VFIY
   2H1HHNDI3/G8lBnGh+IdtUNGRREs8GEX0Uyr7XCnHqrYXcr1niiGOXfDQ
   Sri+wE90YHTRCFkWTjFS8/PWNV3ejoQJKeyHDVcfZWv+hx7QjNPpo3d3b
   HG0g3wjp/j8H2CPz/sfvKP0QrunYiIzw0Ixd+iiezhdgIXIggBbR6Jpsh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="264343142"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="264343142"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 21:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="683173227"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2022 21:26:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9J5p-000LXY-Rr;
        Thu, 07 Jul 2022 04:26:21 +0000
Date:   Thu, 7 Jul 2022 12:25:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5 6/6] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <202207071217.lAHS2W7R-lkp@intel.com>
References: <20220706152329.665636-7-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706152329.665636-7-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 03c765b0e3b4cb5063276b086c76f7a612856a9a]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec-ppc64/20220706-232658
base:   03c765b0e3b4cb5063276b086c76f7a612856a9a
config: s390-randconfig-r015-20220706 (https://download.01.org/0day-ci/archive/20220707/202207071217.lAHS2W7R-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/d5d97eac90ae272727cc71409e88360b7024b343
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec-ppc64/20220706-232658
        git checkout d5d97eac90ae272727cc71409e88360b7024b343
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/kexec_file.o: in function `__se_sys_kexec_file_load':
>> kexec_file.c:(.text+0xee2): undefined reference to `tpm_add_kexec_buffer'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0x1e4): undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: fsl-edma.c:(.text+0x32a): undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0xbe): undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/crypto/ccree/cc_driver.o: in function `ccree_probe':
   cc_driver.c:(.text+0xd4c): undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
   cc_debugfs.c:(.text+0x1b0): undefined reference to `debugfs_create_regset32'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: cc_debugfs.c:(.text+0x390): undefined reference to `debugfs_create_regset32'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
