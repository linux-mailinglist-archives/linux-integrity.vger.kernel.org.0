Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417CC6E6B6A
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Apr 2023 19:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjDRRud (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Apr 2023 13:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDRRu2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Apr 2023 13:50:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A515D31D;
        Tue, 18 Apr 2023 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681840216; x=1713376216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7EmeuTp2AWwh1GqSAAygCLfWauOKIDuUnAJOtFCpvdI=;
  b=LJpTNBMSSdyIQkGwdFUmjxtLSGPlTC5Epjzz9HLLw1dGnQnuIHbRwVYK
   JyOuvdD9JMwjHeyVUgOHJdpW69M+UN60SBb0pYyU18emApTyemGVKX6Fj
   OMxJguEitnwSHOa6SP5FKrTWFgnP02h4xUj/4F8ohnD5O5feof/1R+syh
   1l/YMAblWvbmVkkInQDowA7l1Q4dIL/QuggmkTgZ62v629wcnoAGL+hqY
   HNe7hfhWSh2c+W4Mxm3EGB5O+GkT++OK9LGXqVz16REwrfphdJuz53TBc
   UWbiV7qsoEkxh0QmJJhkXs9lx4LAJCnCEVM8tksKO634sbW+F4Im1DLMG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="334051375"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="334051375"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937337180"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="937337180"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2023 10:50:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1popSp-000dpl-1r;
        Tue, 18 Apr 2023 17:49:59 +0000
Date:   Wed, 19 Apr 2023 01:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v9 4/4] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <202304190146.FrlhoboB-lkp@intel.com>
References: <20230418134409.177485-5-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418134409.177485-5-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6a8f57ae2eb07ab39a6f0ccad60c760743051026]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/drivers-of-kexec-ima-Support-32-bit-platforms/20230418-214600
base:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
patch link:    https://lore.kernel.org/r/20230418134409.177485-5-stefanb%40linux.ibm.com
patch subject: [PATCH v9 4/4] tpm/kexec: Duplicate TPM measurement log in of-tree for kexec
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230419/202304190146.FrlhoboB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/16a833d47b9aca53a1b099dea4066b76b7f14ee1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/drivers-of-kexec-ima-Support-32-bit-platforms/20230418-214600
        git checkout 16a833d47b9aca53a1b099dea4066b76b7f14ee1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash drivers/input/mouse/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190146.FrlhoboB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/irqdomain.h:36,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/input/mouse/synaptics.c:30:
>> include/linux/of.h:1664:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
    1664 | static inline void tpm_add_kexec_buffer(struct kimage *image) { }
         |                                                ^~~~~~
   drivers/input/mouse/synaptics.c:164:27: warning: 'smbus_pnp_ids' defined but not used [-Wunused-const-variable=]
     164 | static const char * const smbus_pnp_ids[] = {
         |                           ^~~~~~~~~~~~~


vim +1664 include/linux/of.h

  1660	
  1661	#if defined(CONFIG_KEXEC_FILE) && defined(CONFIG_OF_FLATTREE)
  1662	void tpm_add_kexec_buffer(struct kimage *image);
  1663	#else
> 1664	static inline void tpm_add_kexec_buffer(struct kimage *image) { }
  1665	#endif
  1666	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
