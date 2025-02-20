Return-Path: <linux-integrity+bounces-4918-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E97A3CE46
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 01:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A512B172AB7
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF17C5FEE6;
	Thu, 20 Feb 2025 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEBV1IaM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AD63214;
	Thu, 20 Feb 2025 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012881; cv=none; b=uh0mZ4KkyOLGVtVebd7H1JaiifQcDyeaF2ec0Fs3d/qQ71F0jc2BvyBaefNTVlU5dMmAHEl7rKiOe/OspMTGEDYpDlWgv0txZa0rT4cZrBaE2Ugskk0cuNLg3gMqSbMoyFSbPNLttV8haLFM03s9NUDcQg48vZDjdpYsppNDgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012881; c=relaxed/simple;
	bh=hwUtCzqyh6aH1mIHsXsfvOdcnu0WliYUJzQAHSkkG70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIPAb3MIpo0bsb3XLnsLT8UGnsQzkmp6vCZqUEBVrF34OpFlXIAT6BxrTBAvThgbjSmy7TmcC5P7UdFI/AyrXzmfnByxYITPl0cz8qxg/qfjIBrFacZxc/7+o1aSsZWaGFXdxqvuV08LjW9tQoEqOIm89AVB2rB3UNB/KJyW+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEBV1IaM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740012880; x=1771548880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hwUtCzqyh6aH1mIHsXsfvOdcnu0WliYUJzQAHSkkG70=;
  b=hEBV1IaM63DUG1hRRr21QcZ0SfdcHNI2nzbZQhEYQ48DbGneMWhVEXFq
   g+Wu0tXQ6MGAIJxjaMDiqyNzJ0IOivYLTUFlWKwS6V6SUPHeeq27VJOf0
   NVcSi+YH7CAkDLwWFbzZMbTGuH8UtIpnML4aB7lseCGZOeZu2Dm10qwG+
   f84p5Qdy5HOtMdG3SrYEQaY9LTUwByboemqm/F9Xu8cxul9yGle57fv+B
   oQW8r4mYyizFM1fsskl8zMZeeSv2Hhh9o/V04cl73/L7iR9VXIzwA/Fg5
   T8psbrXtZIs6jFr/2o6e9kTkOWXTIbz7tR2SI7077IjDML+YyUeVM4LiP
   g==;
X-CSE-ConnectionGUID: SC/dPss+SeypeadUHbrp7Q==
X-CSE-MsgGUID: hJGucJOAQOenEd7oFzgNPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52209162"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52209162"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:54:39 -0800
X-CSE-ConnectionGUID: qeMsjbubQyOQIon3FZs7uQ==
X-CSE-MsgGUID: 4Mqc+Lu2SYmP5XegMdo/+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115785521"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 19 Feb 2025 16:54:34 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkupg-0003hv-13;
	Thu, 20 Feb 2025 00:54:29 +0000
Date: Thu, 20 Feb 2025 08:53:48 +0800
From: kernel test robot <lkp@intel.com>
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com, eric.snowberg@oracle.com,
	ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
	bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
Message-ID: <202502200848.MJEuphR1-lkp@intel.com>
References: <20250218225502.747963-3-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218225502.747963-3-chenste@linux.microsoft.com>

Hi steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc3 next-20250219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-define-and-call-ima_alloc_kexec_file_buf/20250219-065931
base:   linus/master
patch link:    https://lore.kernel.org/r/20250218225502.747963-3-chenste%40linux.microsoft.com
patch subject: [PATCH v8 2/7] kexec: define functions to map and unmap segments
config: x86_64-buildonly-randconfig-004-20250220 (https://download.01.org/0day-ci/archive/20250220/202502200848.MJEuphR1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502200848.MJEuphR1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502200848.MJEuphR1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/crash_dump.h:5,
                    from mm/mm_init.c:30:
>> include/linux/kexec.h:479:47: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     479 | static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
         |                                               ^~~~~~


vim +479 include/linux/kexec.h

   466	
   467	#define kexec_dprintk(fmt, arg...) \
   468	        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
   469	
   470	extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
   471	extern void kimage_unmap_segment(void *buffer);
   472	#else /* !CONFIG_KEXEC_CORE */
   473	struct pt_regs;
   474	struct task_struct;
   475	static inline void __crash_kexec(struct pt_regs *regs) { }
   476	static inline void crash_kexec(struct pt_regs *regs) { }
   477	static inline int kexec_should_crash(struct task_struct *p) { return 0; }
   478	static inline int kexec_crash_loaded(void) { return 0; }
 > 479	static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
   480	{ return NULL; }
   481	static inline void kimage_unmap_segment(void *buffer) { }
   482	#define kexec_in_progress false
   483	#endif /* CONFIG_KEXEC_CORE */
   484	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

