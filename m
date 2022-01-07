Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064B6487C46
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 19:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiAGSig (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jan 2022 13:38:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:47803 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbiAGSig (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jan 2022 13:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641580716; x=1673116716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aX0BdEbcfDa/OSEf5GO2WFRe0rvp1OkSlWcNIZx/r10=;
  b=QN56y/jFgcsLysgNdEZelkGdvza73nJ2k+W/8cEEwBHjCLltKjG4WODh
   PKJDPm573y8yTcZ8SCP2MOU8yM5duEBV/NxqzLNOEWeW74kMLmss1r7JA
   R2tEHpAHzQSumJ1BKyRA9ec1BSAAMagZn1t5wbfmFqn4Hrni+l3pXH6z6
   W02XiET33SwTGm8FYPByCctoMHV+vpEtBwpCDj/1/nI9DeevvB+NpMtET
   nch0qdFmz8dQKGTWwd+TNM4qyJuLKQB94q1o9UDbTaiU5KDghahzBj+Hi
   3zQjX5U/rvgPWIMQ/DEFthD3cp7nVvnaDVVuNwOc+KZy0zsi63lAyfHJN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="243115762"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="243115762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:37:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="622014628"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2022 10:37:07 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5u6s-000Ivw-Uq; Fri, 07 Jan 2022 18:37:06 +0000
Date:   Sat, 8 Jan 2022 02:36:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Suchanek <msuchanek@suse.de>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Michal Suchanek <msuchanek@suse.de>, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 3/6] kexec_file: Don't opencode appended signature
 verification.
Message-ID: <202201080202.yy2w2Wmg-lkp@intel.com>
References: <378d956adfa3be2a6d95a71391b4bb2f7458ada3.1641555875.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378d956adfa3be2a6d95a71391b4bb2f7458ada3.1641555875.git.msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Michal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on s390/features linus/master jeyu/modules-next v5.16-rc8 next-20220106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michal-Suchanek/KEXEC_SIG-with-appended-signature/20220107-195818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: hexagon-randconfig-r016-20220107 (https://download.01.org/0day-ci/archive/20220108/202201080202.yy2w2Wmg-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c59400c94a653abe5a5fbfd5bc166bd3ac1ebb41
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michal-Suchanek/KEXEC_SIG-with-appended-signature/20220107-195818
        git checkout c59400c94a653abe5a5fbfd5bc166bd3ac1ebb41
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/module.c:2898:40: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'size_t *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
                   err = verify_appended_signature(mod, &info->len,
                                                        ^~~~~~~~~~
   include/linux/verification.h:63:57: note: passing argument to parameter 'len' here
   int verify_appended_signature(const void *data, size_t *len, struct key *trusted_keys,
                                                           ^
   kernel/module.c:4804:6: warning: no previous prototype for function 'module_layout' [-Wmissing-prototypes]
   void module_layout(struct module *mod,
        ^
   kernel/module.c:4804:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void module_layout(struct module *mod,
   ^
   static 
   1 warning and 1 error generated.


vim +2898 kernel/module.c

  2880	
  2881	#ifdef CONFIG_MODULE_SIG
  2882	static int module_sig_check(struct load_info *info, int flags)
  2883	{
  2884		int err = -ENODATA;
  2885		const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
  2886		const char *reason;
  2887		const void *mod = info->hdr;
  2888	
  2889		/*
  2890		 * Require flags == 0, as a module with version information
  2891		 * removed is no longer the module that was signed
  2892		 */
  2893		if (flags == 0 &&
  2894		    info->len > markerlen &&
  2895		    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
  2896			/* We truncate the module to discard the signature */
  2897			info->len -= markerlen;
> 2898			err = verify_appended_signature(mod, &info->len,
  2899							VERIFY_USE_SECONDARY_KEYRING, "module");
  2900			if (!err) {
  2901				info->sig_ok = true;
  2902				return 0;
  2903			}
  2904		}
  2905	
  2906		/*
  2907		 * We don't permit modules to be loaded into the trusted kernels
  2908		 * without a valid signature on them, but if we're not enforcing,
  2909		 * certain errors are non-fatal.
  2910		 */
  2911		switch (err) {
  2912		case -ENODATA:
  2913			reason = "unsigned module";
  2914			break;
  2915		case -ENOPKG:
  2916			reason = "module with unsupported crypto";
  2917			break;
  2918		case -ENOKEY:
  2919			reason = "module with unavailable key";
  2920			break;
  2921	
  2922		default:
  2923			/*
  2924			 * All other errors are fatal, including lack of memory,
  2925			 * unparseable signatures, and signature check failures --
  2926			 * even if signatures aren't required.
  2927			 */
  2928			return err;
  2929		}
  2930	
  2931		if (is_module_sig_enforced()) {
  2932			pr_notice("Loading of %s is rejected\n", reason);
  2933			return -EKEYREJECTED;
  2934		}
  2935	
  2936		return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
  2937	}
  2938	#else /* !CONFIG_MODULE_SIG */
  2939	static int module_sig_check(struct load_info *info, int flags)
  2940	{
  2941		return 0;
  2942	}
  2943	#endif /* !CONFIG_MODULE_SIG */
  2944	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
