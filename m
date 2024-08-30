Return-Path: <linux-integrity+bounces-3436-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4DC96655E
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 17:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240E528539D
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70E1B5EC2;
	Fri, 30 Aug 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eh/KlOCB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE81B581C;
	Fri, 30 Aug 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031583; cv=none; b=Doq6gnLvY/6+S/WynQuvRidUm6TXF2PzGsX3kW791LTlwz3kNmka8jyBoWSQYKUecVsWOtujkRmjc221Z6wLxFK3x1RUXb3s1w+qzaADwmpnfx5Q8wdDjISWguw0nTSMdr2bQlI6v16UA8m4HxTdkWV25+vdZ5YevyJ7uMdPZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031583; c=relaxed/simple;
	bh=xsFTu4zK6e/bQKyKpNXx4yuqJpMh03KU59hP5ZIhsFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNShblW7HsshQbdlcbVDyQS+RNTUB34mazGyeUImT+MAK9SpoXHdkVKpr9fWhOTKmDsgEnCCFD1lh5z/qZILAsOfv1T4QLmRzjp4+fvSQ3ogZDbFiTlm6EvVKjK921mTCsbeVRdwtQ9v/nl2ndn+mO5Mc6+QEbTPIUspmoMFo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eh/KlOCB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725031582; x=1756567582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xsFTu4zK6e/bQKyKpNXx4yuqJpMh03KU59hP5ZIhsFo=;
  b=eh/KlOCBuzkHHqPwn3kNgFkz01JTt8Lm9thbJh88UzfXEylMClA7VMhH
   7JMsgntE4hteSujXxl+bK/9GrA1keboxvxGaY7M//pt4GdMFqrxSVMTO/
   JJegXOEW3rsOgsyxATfA78UIDUkXKXtombxAKLAVrsAcRsU+lWatQPTju
   bQZrfDowEn3mmRU+tcj1vwQqWWydbQYyGva8VlUE/y+xdabRC03hmLWOi
   gxy5CavtgUGsliXFDP4gUEFHk/8wuCzLRsR3CbEyQh/mHOVXoWalHyn7F
   gZezg7aTxxGGQ1gHbNx32+x2yfif0K5mErSW/Q7EgGNt0dqgjCRvT7sFF
   g==;
X-CSE-ConnectionGUID: BRXH8Rl7TLqgUtQhMNlyGQ==
X-CSE-MsgGUID: W8jgzZTdQ5C2m5IOIeWWvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13299643"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13299643"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 08:26:20 -0700
X-CSE-ConnectionGUID: qSo7wQuiRQOgWqbJHGSuaA==
X-CSE-MsgGUID: xWQhpaPgQ7q/KjwQk08jIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63941617"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Aug 2024 08:26:15 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk3Vt-0001a2-19;
	Fri, 30 Aug 2024 15:26:13 +0000
Date: Fri, 30 Aug 2024 23:26:09 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
	serge@hallyn.com, keescook@chromium.org,
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, mic@digikod.net,
	linux-integrity@vger.kernel.org, audit@vger.kernel.org,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 10/13] LSM: Create new security_cred_getlsmblob LSM
 hook
Message-ID: <202408302309.08WssiJu-lkp@intel.com>
References: <20240830003411.16818-11-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830003411.16818-11-casey@schaufler-ca.com>

Hi Casey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-audit/next]
[also build test WARNING on pcmoore-selinux/next zohar-integrity/next-integrity linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Add-the-lsmblob-data-structure/20240830-085050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
patch link:    https://lore.kernel.org/r/20240830003411.16818-11-casey%40schaufler-ca.com
patch subject: [PATCH v2 10/13] LSM: Create new security_cred_getlsmblob LSM hook
config: i386-buildonly-randconfig-006-20240830 (https://download.01.org/0day-ci/archive/20240830/202408302309.08WssiJu-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408302309.08WssiJu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408302309.08WssiJu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/dma/swiotlb.c:53:
   In file included from include/trace/events/swiotlb.h:41:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   include/linux/security.h:1199:3: error: use of undeclared identifier 'secid'
    1199 |         *secid = 0;
         |          ^
>> kernel/dma/swiotlb.c:639:20: warning: shift count >= width of type [-Wshift-count-overflow]
     638 |                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     639 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
     640 |                     !(gfp & (__GFP_DMA32 | __GFP_DMA)))
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
>> kernel/dma/swiotlb.c:639:20: warning: shift count >= width of type [-Wshift-count-overflow]
     638 |                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     639 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
     640 |                     !(gfp & (__GFP_DMA32 | __GFP_DMA)))
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:61: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
>> kernel/dma/swiotlb.c:639:20: warning: shift count >= width of type [-Wshift-count-overflow]
     638 |                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     639 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
     640 |                     !(gfp & (__GFP_DMA32 | __GFP_DMA)))
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:86: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:68:3: note: expanded from macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   3 warnings and 1 error generated.


vim +639 kernel/dma/swiotlb.c

79636caad3618e Petr Tesarik 2023-08-01  602  
79636caad3618e Petr Tesarik 2023-08-01  603  /**
79636caad3618e Petr Tesarik 2023-08-01  604   * swiotlb_alloc_tlb() - allocate a dynamic IO TLB buffer
79636caad3618e Petr Tesarik 2023-08-01  605   * @dev:	Device for which a memory pool is allocated.
79636caad3618e Petr Tesarik 2023-08-01  606   * @bytes:	Size of the buffer.
79636caad3618e Petr Tesarik 2023-08-01  607   * @phys_limit:	Maximum allowed physical address of the buffer.
79636caad3618e Petr Tesarik 2023-08-01  608   * @gfp:	GFP flags for the allocation.
79636caad3618e Petr Tesarik 2023-08-01  609   *
79636caad3618e Petr Tesarik 2023-08-01  610   * Return: Allocated pages, or %NULL on allocation failure.
79636caad3618e Petr Tesarik 2023-08-01  611   */
79636caad3618e Petr Tesarik 2023-08-01  612  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
79636caad3618e Petr Tesarik 2023-08-01  613  		u64 phys_limit, gfp_t gfp)
79636caad3618e Petr Tesarik 2023-08-01  614  {
79636caad3618e Petr Tesarik 2023-08-01  615  	struct page *page;
79636caad3618e Petr Tesarik 2023-08-01  616  
79636caad3618e Petr Tesarik 2023-08-01  617  	/*
79636caad3618e Petr Tesarik 2023-08-01  618  	 * Allocate from the atomic pools if memory is encrypted and
79636caad3618e Petr Tesarik 2023-08-01  619  	 * the allocation is atomic, because decrypting may block.
79636caad3618e Petr Tesarik 2023-08-01  620  	 */
79636caad3618e Petr Tesarik 2023-08-01  621  	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
79636caad3618e Petr Tesarik 2023-08-01  622  		void *vaddr;
79636caad3618e Petr Tesarik 2023-08-01  623  
79636caad3618e Petr Tesarik 2023-08-01  624  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
79636caad3618e Petr Tesarik 2023-08-01  625  			return NULL;
79636caad3618e Petr Tesarik 2023-08-01  626  
79636caad3618e Petr Tesarik 2023-08-01  627  		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
79636caad3618e Petr Tesarik 2023-08-01  628  					   dma_coherent_ok);
79636caad3618e Petr Tesarik 2023-08-01  629  	}
79636caad3618e Petr Tesarik 2023-08-01  630  
79636caad3618e Petr Tesarik 2023-08-01  631  	gfp &= ~GFP_ZONEMASK;
79636caad3618e Petr Tesarik 2023-08-01  632  	if (phys_limit <= DMA_BIT_MASK(zone_dma_bits))
79636caad3618e Petr Tesarik 2023-08-01  633  		gfp |= __GFP_DMA;
79636caad3618e Petr Tesarik 2023-08-01  634  	else if (phys_limit <= DMA_BIT_MASK(32))
79636caad3618e Petr Tesarik 2023-08-01  635  		gfp |= __GFP_DMA32;
79636caad3618e Petr Tesarik 2023-08-01  636  
a5e3b127455d07 Petr Tesarik 2023-11-02  637  	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
79636caad3618e Petr Tesarik 2023-08-01  638  		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
79636caad3618e Petr Tesarik 2023-08-01 @639  		    phys_limit < DMA_BIT_MASK(64) &&
79636caad3618e Petr Tesarik 2023-08-01  640  		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
79636caad3618e Petr Tesarik 2023-08-01  641  			gfp |= __GFP_DMA32;
79636caad3618e Petr Tesarik 2023-08-01  642  		else if (IS_ENABLED(CONFIG_ZONE_DMA) &&
79636caad3618e Petr Tesarik 2023-08-01  643  			 !(gfp & __GFP_DMA))
79636caad3618e Petr Tesarik 2023-08-01  644  			gfp = (gfp & ~__GFP_DMA32) | __GFP_DMA;
79636caad3618e Petr Tesarik 2023-08-01  645  		else
79636caad3618e Petr Tesarik 2023-08-01  646  			return NULL;
79636caad3618e Petr Tesarik 2023-08-01  647  	}
79636caad3618e Petr Tesarik 2023-08-01  648  
79636caad3618e Petr Tesarik 2023-08-01  649  	return page;
79636caad3618e Petr Tesarik 2023-08-01  650  }
79636caad3618e Petr Tesarik 2023-08-01  651  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

