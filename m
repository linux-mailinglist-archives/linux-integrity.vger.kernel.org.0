Return-Path: <linux-integrity+bounces-4919-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC8A3CECA
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 02:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E67F189AD47
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 01:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC563146D53;
	Thu, 20 Feb 2025 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mu4rVNIu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465010FD;
	Thu, 20 Feb 2025 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015347; cv=none; b=piGjM1Q43pbLZXFhl01CFZw8brjOzSuUdjt2K1JFXamsFQijj4wBOx/hpVxINscKKyW0Ls6/1R7AxuUinWR8MEccE1rM9OFb2mlpBT8bNfhk2xwknQhoyGx+5bCY2vySUm35wIr+iyQsMSsLu8oPHv7e9QN1Gl2oSym9wsWVF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015347; c=relaxed/simple;
	bh=6zmoCVN+tM70IALjoYFIvZaT00kAmX8foq6e3TRZLYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOMukabAPbC3c8efTaV7u0ecbjnCSwxrYUaDT/gLFriM3dFr3CesGdd/j8WavWojl9YR5ovkjzDOKy/IAH7/Ogpy4/qqoyElv8baIZ30PHgVum9JUC3SoyP3U95fPsxJIplBNJF3zjsR8R7vaL653dbjYcq3GcFNCG6vvAD0Gyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mu4rVNIu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740015346; x=1771551346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6zmoCVN+tM70IALjoYFIvZaT00kAmX8foq6e3TRZLYA=;
  b=Mu4rVNIuDyj3zekZgP4iZky6LyT+so0kVjnUknmc4HaQV9PHGLWM3qIP
   +VsEvF4GoeqUuIOVWye35VeSdtvmU2B2IwscVIyad5LzmKTmQNdkAYnHm
   2AY51BoKy4rEANxCC4kHclZ+6IxWpbeLX2bglybB328zui9wO/+uVXt+9
   WwmTWEyhBiW49wahGhM0hsfDI6w1WpAn3dJdTsjFMf5DtM4COOWw7WP5C
   SfZM7xx9RtYnKvoMRDIA8CYBJ2TTfASgsOYyQMvzcxzP/KCvPdkVcEOnO
   7cObay4xP3Okm4diLtjlOp3icNI0j0DxXVptffAgt/2wYcMpgwBLroQuO
   w==;
X-CSE-ConnectionGUID: /6EzFPQtQX+tFT8mY1H+CQ==
X-CSE-MsgGUID: e/TL9PJxS9uyD27UCeV3Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63256299"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="63256299"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:35:45 -0800
X-CSE-ConnectionGUID: /CSaJmWzSfmHu8r7w0K3Sg==
X-CSE-MsgGUID: kf6Hjk7XR6md3lqe5LyxTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114622753"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 19 Feb 2025 17:35:41 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkvTW-0003jb-0R;
	Thu, 20 Feb 2025 01:35:38 +0000
Date: Thu, 20 Feb 2025 09:35:19 +0800
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
Subject: Re: [PATCH v8 5/7] ima: kexec: move IMA log copy from kexec load to
 execute
Message-ID: <202502200920.rOyK1770-lkp@intel.com>
References: <20250218225502.747963-6-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218225502.747963-6-chenste@linux.microsoft.com>

Hi steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.14-rc3 next-20250219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-define-and-call-ima_alloc_kexec_file_buf/20250219-065931
base:   linus/master
patch link:    https://lore.kernel.org/r/20250218225502.747963-6-chenste%40linux.microsoft.com
patch subject: [PATCH v8 5/7] ima: kexec: move IMA log copy from kexec load to execute
config: x86_64-buildonly-randconfig-001-20250220 (https://download.01.org/0day-ci/archive/20250220/202502200920.rOyK1770-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502200920.rOyK1770-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502200920.rOyK1770-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/kexec_file.c: In function 'kimage_file_post_load':
>> kernel/kexec_file.c:206:9: error: implicit declaration of function 'ima_kexec_post_load'; did you mean 'machine_kexec_post_load'? [-Werror=implicit-function-declaration]
     206 |         ima_kexec_post_load(image);
         |         ^~~~~~~~~~~~~~~~~~~
         |         machine_kexec_post_load
   cc1: some warnings being treated as errors


vim +206 kernel/kexec_file.c

   203	
   204	static void kimage_file_post_load(struct kimage *image)
   205	{
 > 206		ima_kexec_post_load(image);
   207	}
   208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

