Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4BE67A376
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 20:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjAXT6Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 14:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjAXT6W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 14:58:22 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C06199;
        Tue, 24 Jan 2023 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674590301; x=1706126301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EcefF71Khqhe8GPdaIYqqV/01GQpF3MPSO6bGHMMsp8=;
  b=d64XQ53jNNzWp7ziUbMXQiXL/K1E02W3EQfO6HcYLe84x3VAvqkQgW8c
   IdUDv40Brof+Oh4E6ZPC97BcHOWh/XOotq8SPtCi3JPtlUDBCAP/LUSL9
   ors3ssD27AXjNaWp67XJAX+A4nxmV0on/6cc8Kw87PFGSvaXM0vutvkv0
   bqUkJgOA0OIKx7hwz0y3kVPbA7uxyebMwvXyWxWhaPiAwj0iGuyXppGN7
   hbuHfJLU1Lzluf88300BOHu8o3w87C+mrzLfcEO7l6HjUVjG9NB1tojlN
   FoLu5wQWqkBEfzVMLb5tjjOsMHNhbUevpCYapucGyoGr/jEG3p3CYXDBI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="327646591"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="327646591"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 11:58:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="750937856"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="750937856"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2023 11:58:17 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKPQv-0006jg-02;
        Tue, 24 Jan 2023 19:58:17 +0000
Date:   Wed, 25 Jan 2023 03:57:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 01/11] tpm: move buffer handling from static inlines
 to real functions
Message-ID: <202301250315.ZgtsNzSm-lkp@intel.com>
References: <20230124175516.5984-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124175516.5984-2-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230124175516.5984-2-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH v2 01/11] tpm: move buffer handling from static inlines to real functions
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230125/202301250315.ZgtsNzSm-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/484b879d0bfceec899fea147a76d12f7072d9f23
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
        git checkout 484b879d0bfceec899fea147a76d12f7072d9f23
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/char/tpm/tpm-buf.c:46:5: warning: no previous prototype for 'tpm_buf_tag' [-Wmissing-prototypes]
      46 | u16 tpm_buf_tag(struct tpm_buf *buf)
         |     ^~~~~~~~~~~


vim +/tpm_buf_tag +46 drivers/char/tpm/tpm-buf.c

    45	
  > 46	u16 tpm_buf_tag(struct tpm_buf *buf)
    47	{
    48		struct tpm_header *head = (struct tpm_header *)buf->data;
    49	
    50		return be16_to_cpu(head->tag);
    51	}
    52	EXPORT_SYMBOL_GPL(tpm_buf_tag);
    53	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
