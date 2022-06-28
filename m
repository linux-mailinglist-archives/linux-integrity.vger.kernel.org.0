Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D3055EA5D
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 18:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiF1Qze (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jun 2022 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiF1Qys (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jun 2022 12:54:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146E623164;
        Tue, 28 Jun 2022 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656435208; x=1687971208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lk9i+UFDFPdV2X5SBVGrwZ4ywWGVr3wZW7Ti7xnz5Js=;
  b=LBnYK7pIdoOPEQsjFbnRHlbrJSuU2zdtucqQ8Ri4f724EuJ49Mb7iBvF
   Ck7lMab4V0bq9/04SCIIbekqAAHU9qvF81g2wGRNE5SkU2lLk7rGZP04h
   /cRrn2MWL84oKyQAjczLGpFMVK2jGXIxQeEriCCpyTV7wpc2ZNm/UMDkG
   lH7+YV6YnMR+MttmRRWcKb41kne999ETvP6F5pI3qHZo6UL2ogn8zmkKd
   rbg3htcwrsg7eQYj40gtuz8O84HpXSVEr5OLzLXs9bDdiTuIX4NC75kCN
   mD2m9zsfSbkr+qIfMsKUYkxJbC/rWc2L+liyIgyPHwpgOpVmQLItQy30W
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="279338975"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="279338975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 09:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="646993101"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2022 09:53:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6ESq-000ARG-UR;
        Tue, 28 Jun 2022 16:53:24 +0000
Date:   Wed, 29 Jun 2022 00:53:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, nayna@linux.ibm.com, nasastry@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 3/3] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <202206290021.AodC96Vc-lkp@intel.com>
References: <20220616154130.2052541-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616154130.2052541-4-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on linus/master v5.19-rc4 next-20220628]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220616-234240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 0a35780c755ccec097d15c6b4ff8b246a89f1689
config: parisc-randconfig-r012-20220627 (https://download.01.org/0day-ci/archive/20220629/202206290021.AodC96Vc-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c28e0f7321d0b7245454e811a3dd0f2134d9dd74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220616-234240
        git checkout c28e0f7321d0b7245454e811a3dd0f2134d9dd74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/of/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/of/kexec.c: In function 'tpm_add_kexec_buffer':
>> drivers/of/kexec.c:371:18: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
     371 |         buffer = vmalloc(size);
         |                  ^~~~~~~
         |                  kvmalloc
   drivers/of/kexec.c:371:16: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     371 |         buffer = vmalloc(size);
         |                ^
   drivers/of/kexec.c: In function 'tpm_post_kexec':
   drivers/of/kexec.c:446:42: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     446 |                 *(u64 *)newprop->value = (u64)phyaddr;
         |                                          ^
   cc1: some warnings being treated as errors


vim +371 drivers/of/kexec.c

   349	
   350	void tpm_add_kexec_buffer(struct kimage *image)
   351	{
   352		struct kexec_buf kbuf = { .image = image, .buf_align = 1,
   353					  .buf_min = 0, .buf_max = ULONG_MAX,
   354					  .top_down = true };
   355		struct device_node *np;
   356		void *buffer;
   357		u32 size;
   358		u64 base;
   359		int ret;
   360	
   361		if (!IS_ENABLED(CONFIG_PPC64))
   362			return;
   363	
   364		np = of_find_node_by_name(NULL, "vtpm");
   365		if (!np)
   366			return;
   367	
   368		if (of_tpm_get_sml_parameters(np, &base, &size) < 0)
   369			return;
   370	
 > 371		buffer = vmalloc(size);
   372		if (!buffer)
   373			return;
   374		memcpy(buffer, __va(base), size);
   375	
   376		kbuf.buffer = buffer;
   377		kbuf.bufsz = size;
   378		kbuf.memsz = size;
   379		ret = kexec_add_buffer(&kbuf);
   380		if (ret) {
   381			pr_err("Error passing over kexec TPM measurement log buffer: %d\n",
   382			       ret);
   383			return;
   384		}
   385	
   386		image->tpm_buffer = buffer;
   387		image->tpm_buffer_addr = kbuf.mem;
   388		image->tpm_buffer_size = size;
   389	}
   390	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
