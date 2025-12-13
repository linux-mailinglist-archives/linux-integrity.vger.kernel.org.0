Return-Path: <linux-integrity+bounces-7949-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED40CBB227
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 19:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08EE330056F7
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5D1E7C23;
	Sat, 13 Dec 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+83Sv1J"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DB14B08A;
	Sat, 13 Dec 2025 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765650136; cv=none; b=GKM+Uuqo0+timK6lNMqIeFQ5DciZ8CwXtRkdtS2t6r7SX5OWJhqY+8JJox48FMW8a7OJ7NeWEvtOtacq6pOFxCmOYGq+RK4PaxUsepXfjMz61dvXcfqu80f1zHqpCUWnpywLUBAbFYSW4LTwKPDZWpdxzMNEaEQfwFFDB6oDyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765650136; c=relaxed/simple;
	bh=VuBIHLj7oBoIFj+NYV7CqgXjiAwFMwo/5flHJXzbGpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9L/fd1UzfkwNJ+LyemxOAKHR+0BoYdrxpjXNG894RLt2ZSFmZehFXomRTYqxO2s8O5FYpppj97l9q0hpFo86DaVopHTkQYAcwxdUJzSwpJ24sGliGxq3ZE/IHfTs4kIw4I88GJX9GlzaV3nEdZI0vHhB4eVhtjnD9dbsPwBNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+83Sv1J; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765650135; x=1797186135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VuBIHLj7oBoIFj+NYV7CqgXjiAwFMwo/5flHJXzbGpU=;
  b=N+83Sv1J/hmE59e6rryVg1PgpDPQHdZ5S+W/nJawCvtbnKO9r/SLxi83
   9NXCnpieteZUEG3EnlkD/V39gJ/ELO1f6pnzSuOGPhhydJqAzGhJlvDZT
   DPYHmWi/9Gfn0pkcEXhfzstewsEdQ+J3usOQpKhioMyan/E49hBKnwxb/
   HttvgX+coTRrloYea9MnTl1FjAwnNbL6/O2rJ8wkyZGW26JCn1Ky+QVo6
   Zj+fbkjjCsRxPB8gOON50SfgiNowDRjIdwGr2D6NqwLHbALqXLEuGHKf1
   dPrK2tBp1IyxqYWxwq7lee9OTXHsa5VGXARkaw19Q5bCRhVlU4I5qTwBf
   A==;
X-CSE-ConnectionGUID: nT8RobxnQ7KMRz51cNHyuQ==
X-CSE-MsgGUID: OUMnBNglQyK3MrCFzfDMzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11641"; a="67775494"
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="67775494"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 10:22:15 -0800
X-CSE-ConnectionGUID: kpb4Me8lSF+sDoGI1o3j3g==
X-CSE-MsgGUID: uTVLjPT4R3a324lOlH8OJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="197620802"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Dec 2025 10:22:11 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUUFs-00000000837-40oj;
	Sat, 13 Dec 2025 18:22:08 +0000
Date: Sun, 14 Dec 2025 02:21:12 +0800
From: kernel test robot <lkp@intel.com>
To: Srish Srinivasan <ssrish@linux.ibm.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	James.Bottomley@hansenpartnership.com, jarkko@kernel.org,
	zohar@linux.ibm.com, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	ssrish@linux.ibm.com
Subject: Re: [PATCH 2/6] powerpc/pseries: move the PLPKS config inside its
 own sysfs directory
Message-ID: <202512140150.PUqCvp88-lkp@intel.com>
References: <20251213052618.190691-3-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213052618.190691-3-ssrish@linux.ibm.com>

Hi Srish,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes zohar-integrity/next-integrity linus/master v6.18 next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srish-Srinivasan/pseries-plpks-fix-kernel-doc-comment-inconsistencies/20251213-132948
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20251213052618.190691-3-ssrish%40linux.ibm.com
patch subject: [PATCH 2/6] powerpc/pseries: move the PLPKS config inside its own sysfs directory
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20251214/202512140150.PUqCvp88-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251214/202512140150.PUqCvp88-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512140150.PUqCvp88-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/prom.c:59:
>> arch/powerpc/include/asm/plpks.h:118:12: warning: 'plpks_config_create_softlink' defined but not used [-Wunused-function]
     118 | static int plpks_config_create_softlink(struct kobject *from) { return 0; }
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/plpks_config_create_softlink +118 arch/powerpc/include/asm/plpks.h

   111	
   112	int plpks_config_create_softlink(struct kobject *from);
   113	#else // CONFIG_PSERIES_PLPKS
   114	static inline bool plpks_is_available(void) { return false; }
   115	static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
   116	static inline void plpks_early_init_devtree(void) { }
   117	static inline int plpks_populate_fdt(void *fdt) { BUILD_BUG(); }
 > 118	static int plpks_config_create_softlink(struct kobject *from) { return 0; }
   119	#endif // CONFIG_PSERIES_PLPKS
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

