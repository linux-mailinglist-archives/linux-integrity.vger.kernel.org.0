Return-Path: <linux-integrity+bounces-4251-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A739DBD29
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Nov 2024 22:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF691649E8
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Nov 2024 21:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D3A537F8;
	Thu, 28 Nov 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQ05mUVh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F114F9ED;
	Thu, 28 Nov 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828109; cv=none; b=B5dE0PVH6pVKbA+NOHDJAYZsgO9WTZGAwl0oO6AYoBQwx3Zu3vMWXsIPj6nag4+MLSJt8NlKE+Mvl7GBrnQIswBY5OJkZvVlaXKMqkI7/4+1L9pCi7tPmjHXrl9wSw+rG2hz0rTllqBSanEVR3FEvwpO79oPeWOk/76YaLdaDuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828109; c=relaxed/simple;
	bh=/OJtRx1FY9ovQap3Q78I0ih2AiBCsYSAtG/6gia7k+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNGJTtULqlrAL719869nfYFWZ/BfrtK8HwqJcEUU23WiGj38WYTuXtTnxy0pthsaOx3ijFMdrrTfNPjpOZH8IT2Mee0PQnprSoIe2kINzn2IEeet24Nc1iJGLSuokid2WEQI4GooXA7jAhrRBgDS8iX5Fzv3qUQdrVgCxKHu148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQ05mUVh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732828107; x=1764364107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/OJtRx1FY9ovQap3Q78I0ih2AiBCsYSAtG/6gia7k+Y=;
  b=AQ05mUVh7K5lgSLWg18um3IqRYFjotjD8cDeS8r3XUhJnta47NtOtu8V
   uh/RDKhxNSpV4szjRk7ty1J6Fk0FqQP6GQgjIFhxn/J987SM+hxwJYQyd
   mXRsHWt8N9KtYRV3oijMsdnNfHMIoAlf7xdOT2X7huW7Z5VirsG9GbxPf
   HgoHi5ee5nAvKZU4hv5JakPkZWhpJIMJNwVANG/qPX9MJ3uoYqV+sJtcC
   I1+0rjKDD8UpvWcvQ1Y2cixfT5HwkgsfZFKRgtEUn0kDfVTsaPG3q2MTO
   FL78CCwk8KArI1lOcYQsJLd/zIjmmCtinJv9vV5QgkR38KUGaNopcowOy
   Q==;
X-CSE-ConnectionGUID: NCW7KixBSfmyOCHmbKy8gQ==
X-CSE-MsgGUID: gVxsYdF4RnWb6Ef2hVIyvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="43734263"
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="43734263"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 13:08:27 -0800
X-CSE-ConnectionGUID: FOa+daaARsuFumC2FuNs/A==
X-CSE-MsgGUID: mmuFnT+7TOKprVa0qmE/ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="96408269"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Nov 2024 13:08:24 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGlkM-000A2z-1L;
	Thu, 28 Nov 2024 21:08:22 +0000
Date: Fri, 29 Nov 2024 05:07:42 +0800
From: kernel test robot <lkp@intel.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mimi Zohar <zohar@linux.ibm.com>,
	=?unknown-8bit?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: instantiate the bprm_creds_for_exec() hook
Message-ID: <202411290413.VUC6seTw-lkp@intel.com>
References: <20241127210234.121546-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127210234.121546-1-zohar@linux.ibm.com>

Hi Mimi,

kernel test robot noticed the following build errors:

[auto build test ERROR on zohar-integrity/next-integrity]
[also build test ERROR on linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mimi-Zohar/ima-instantiate-the-bprm_creds_for_exec-hook/20241128-120656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20241127210234.121546-1-zohar%40linux.ibm.com
patch subject: [PATCH] ima: instantiate the bprm_creds_for_exec() hook
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241129/202411290413.VUC6seTw-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411290413.VUC6seTw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411290413.VUC6seTw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from security/integrity/ima/ima_main.c:23:
   In file included from include/linux/mman.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from security/integrity/ima/ima_main.c:26:
   In file included from include/linux/ima.h:12:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from security/integrity/ima/ima_main.c:26:
   In file included from include/linux/ima.h:12:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from security/integrity/ima/ima_main.c:26:
   In file included from include/linux/ima.h:12:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> security/integrity/ima/ima_main.c:572:13: error: no member named 'is_check' in 'struct linux_binprm'
     572 |         if (!bprm->is_check)
         |              ~~~~  ^
   7 warnings and 1 error generated.
--
   In file included from security/integrity/ima/ima_appraise.c:13:
   In file included from include/linux/xattr.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from security/integrity/ima/ima_appraise.c:15:
   In file included from include/linux/ima.h:12:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from security/integrity/ima/ima_appraise.c:15:
   In file included from include/linux/ima.h:12:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from security/integrity/ima/ima_appraise.c:15:
   In file included from include/linux/ima.h:12:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> security/integrity/ima/ima_appraise.c:492:13: error: no member named 'is_check' in 'struct linux_binprm'
     492 |                 if (bprm->is_check)
         |                     ~~~~  ^
   7 warnings and 1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +572 security/integrity/ima/ima_main.c

   556	
   557	/**
   558	 * ima_bprm_creds_for_exec - based on policy, collect/store/appraise measurement.
   559	 * @bprm: contains the linux_binprm structure
   560	 *
   561	 * Based on the IMA policy and the execvat(2) AT_CHECK flag, measure and
   562	 * appraise the integrity of a file to be executed by script interpreters.
   563	 * Unlike any of the other LSM hooks where the kernel enforces file integrity,
   564	 * enforcing file integrity is left up to the discretion of the script
   565	 * interpreter (userspace).
   566	 *
   567	 * On success return 0.  On integrity appraisal error, assuming the file
   568	 * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
   569	 */
   570	static int ima_bprm_creds_for_exec(struct linux_binprm *bprm)
   571	{
 > 572		if (!bprm->is_check)
   573			return 0;
   574	
   575		return ima_bprm_check(bprm);
   576	}
   577	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

