Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987667AA2A
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 07:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjAYGDs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 01:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjAYGDr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 01:03:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982C21BCA;
        Tue, 24 Jan 2023 22:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674626626; x=1706162626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k/+PLowZYVwtAdQHjzair5kZNl5YiNS6TKYVrXA87d4=;
  b=HHlj+agwj21y6ZLP3HyMT6nHWiCcM3UnJyGIFircK3MHF26NUp5IF0sq
   LcCTtnfHb7rcoFNdX6L+bHWA8ft9CzOaD/NeOvNo566hwe2E5VgQd8srf
   kXk/UCtaJpRKTZUVSKPAk5RMth0Y3yzEooddXZVxUriTrL5dW8ufdXCFw
   m66dBkhbCteXbVbocPjaW5sm0P2klF0G/FTYG67YMUsjbcOT3G/tOUyJL
   DgwMINIB1KHI51cnFUKeIIX/kMdRfUWkDPyuiokUVF0k87D5wVQwOYy+5
   pl8+sQ23DE6rh84UlbjWOs0encF8nJcsDCm2AsBma8lica87g+bcE45q7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="390994531"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="390994531"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 22:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="836250608"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="836250608"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2023 22:03:44 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKYsp-00075g-1S;
        Wed, 25 Jan 2023 06:03:43 +0000
Date:   Wed, 25 Jan 2023 14:03:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
Message-ID: <202301251326.r0t0nGZc-lkp@intel.com>
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
config: i386-randconfig-s002-20230123 (https://download.01.org/0day-ci/archive/20230125/202301251326.r0t0nGZc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/dc0fc74718b4a786aba4a954233e8ab3afdcc03c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
        git checkout dc0fc74718b4a786aba4a954233e8ab3afdcc03c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/char/tpm/tpm2-sessions.c:1184:5: sparse: sparse: symbol 'tpm2_create_null_primary' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
