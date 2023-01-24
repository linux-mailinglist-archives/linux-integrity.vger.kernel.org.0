Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379F967A442
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 21:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjAXUtX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 15:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjAXUtW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 15:49:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B125085E;
        Tue, 24 Jan 2023 12:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674593362; x=1706129362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SAGTyu0NZjQQ1lZMeVMsnNVl2mQ2gFETvNK1VWxOzds=;
  b=eqGzblQ8yAEgqFFenYKW2cHEMUSruh6+hSGSi5rKGfz2FlKihdTlvPz8
   Z99Jtbr0C3PjZTg/svi5XsY8Zhr375tf9zgMHE6h6E2SIN7okYCx+TmDP
   a7ienweNsZt9taKpAwgYXwUDAJJkG4xlHREiOVflhCUDjvVR3dwUHuurD
   /q5GPfC7ADRzSBYrqNZt8pOE+LkOqKIY1cmK8K9OUbkyKqddcM+cSo3R/
   xOixbxmElwbnsxqCECG6Q/rnOmeN5PhaKZOhFcud9QDQ8pyC08xVrm6Lh
   oY/ieeWbtrbXRUJNTZahMUuDCzFsAtuu9gBnikvpBa15Rp+3XnAa73oja
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="326435092"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="326435092"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 12:49:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="750953868"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="750953868"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2023 12:49:20 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKQEJ-0006m0-15;
        Tue, 24 Jan 2023 20:49:19 +0000
Date:   Wed, 25 Jan 2023 04:48:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
Message-ID: <202301250432.kZ4b6794-lkp@intel.com>
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus zohar-integrity/next-integrity linus/master v6.2-rc5 next-20230124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
patch link:    https://lore.kernel.org/r/20230124175516.5984-7-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session handling code
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230125/202301250432.kZ4b6794-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dc0fc74718b4a786aba4a954233e8ab3afdcc03c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
        git checkout dc0fc74718b4a786aba4a954233e8ab3afdcc03c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/char/tpm/tpm2-sessions.c:1184:5: warning: no previous prototype for 'tpm2_create_null_primary' [-Wmissing-prototypes]
    1184 | int tpm2_create_null_primary(struct tpm_chip *chip) {
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/char/tpm/tpm2-sessions.c:352: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * tpm_buf_append_hmac_session() append a TPM session element


vim +/tpm2_create_null_primary +1184 drivers/char/tpm/tpm2-sessions.c

  1183	
> 1184	int tpm2_create_null_primary(struct tpm_chip *chip) {
  1185		u32 nullkey;
  1186		int rc;
  1187	
  1188		rc = tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey);
  1189	
  1190		if (rc == TPM2_RC_SUCCESS) {
  1191			unsigned int offset = 0; /* dummy offset for tpmkeycontext */
  1192	
  1193			rc = tpm2_save_context(chip, nullkey, chip->tpmkeycontext,
  1194					       sizeof(chip->tpmkeycontext), &offset);
  1195			tpm2_flush_context(chip, nullkey);
  1196		}
  1197	
  1198		return rc;
  1199	}
  1200	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
