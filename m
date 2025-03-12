Return-Path: <linux-integrity+bounces-5249-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE73EA5D8BA
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 09:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3203A4408
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E09235364;
	Wed, 12 Mar 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdPUjpQA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E31236A68;
	Wed, 12 Mar 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769896; cv=none; b=LDN5w4y4cgwSfbGQWeWxSlyovkgyqHsAgJgbE6zOet+N8IUWl4Q0s0UeXh0G+uvqGAzU3McAwXnX4b3TSsINU31/YtjAXMwn58dnZqLp3GbgCK8ib+g7OJSQf5sBpo/sSzU93wGOi4hzqa7Alq0EFVJ5XTm9PhdUikwGMS+Oawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769896; c=relaxed/simple;
	bh=HttexNxW0KtxV4sJ29IXJAlxzJTo/xsJm31W440ao9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy7ZBnBoarl+/ixpjnhlLPCwiPVipIzPD3k2W2OATaAuEN15o5WY/D2vmxe4/UF1fMts7GbOcTwJs+W44422iL7+VuZIpt57t7XwtXFjt49VcWxAe/rPojMcoget4QA9Fxj8fEQdAPZZYGH+djcl1QathAI2fRiOn6o6+ELEytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdPUjpQA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741769895; x=1773305895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HttexNxW0KtxV4sJ29IXJAlxzJTo/xsJm31W440ao9w=;
  b=FdPUjpQAbK7rAoHy+AnxNXMAzZ6p9RMqzJVR05iYNvmdLTd9SnQpBiem
   MdZPfbg5PqfhIp1oZfj0el78uNHDWjnTx13vn8+UD47zb81RZ7OXeRzJS
   w44EM4qg9AwQFZG9cpCexnnvx7lxrWal27dwJMNGdzUVIQwmMqQh7de23
   YR/QZIcCN3kABHJdp2B9hfXvmPsCsL+eNs9afN7CnSe/Iibo6JxaI+EzN
   1RicCcYgfTUUsY8gYWiv3HvkThouDwmeE0tjzFv+B6OmYJFvNWI5G/3nb
   jxl9pZ9Eymg2txTtDxojy6TL9NdRONB/khe3uLhpnqDaVF3mi5GG6zAep
   A==;
X-CSE-ConnectionGUID: c3sa/YkuRQmE7c17cBFpgw==
X-CSE-MsgGUID: Ad2R05TKQLyuWpzAtzgTSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="45618593"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="45618593"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 01:58:14 -0700
X-CSE-ConnectionGUID: UzbWyRTKQ0+krqIOMX7qPw==
X-CSE-MsgGUID: UBs0sv0gTUSLN+/Dr7g3Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121475893"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 12 Mar 2025 01:58:09 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsHug-0008Im-0k;
	Wed, 12 Mar 2025 08:58:06 +0000
Date: Wed, 12 Mar 2025 16:57:30 +0800
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
Subject: Re: [PATCH v9 4/7] ima: kexec: define functions to copy IMA log at
 soft boot
Message-ID: <202503121600.IMBKp2gC-lkp@intel.com>
References: <20250304190351.96975-5-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-5-chenste@linux.microsoft.com>

Hi steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on zohar-integrity/next-integrity]
[also build test WARNING on linus/master v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-copy-only-complete-measurement-records-across-kexec/20250305-031719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20250304190351.96975-5-chenste%40linux.microsoft.com
patch subject: [PATCH v9 4/7] ima: kexec: define functions to copy IMA log at soft boot
config: powerpc64-randconfig-r133-20250312 (https://download.01.org/0day-ci/archive/20250312/202503121600.IMBKp2gC-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250312/202503121600.IMBKp2gC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503121600.IMBKp2gC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   security/integrity/ima/ima_kexec.c:107:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] version @@     got restricted __le16 [usertype] @@
   security/integrity/ima/ima_kexec.c:107:30: sparse:     expected unsigned short [addressable] [assigned] [usertype] version
   security/integrity/ima/ima_kexec.c:107:30: sparse:     got restricted __le16 [usertype]
   security/integrity/ima/ima_kexec.c:108:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [addressable] [assigned] [usertype] count @@     got restricted __le64 [usertype] @@
   security/integrity/ima/ima_kexec.c:108:28: sparse:     expected unsigned long long [addressable] [assigned] [usertype] count
   security/integrity/ima/ima_kexec.c:108:28: sparse:     got restricted __le64 [usertype]
   security/integrity/ima/ima_kexec.c:109:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [addressable] [assigned] [usertype] buffer_size @@     got restricted __le64 [usertype] @@
   security/integrity/ima/ima_kexec.c:109:34: sparse:     expected unsigned long long [addressable] [assigned] [usertype] buffer_size
   security/integrity/ima/ima_kexec.c:109:34: sparse:     got restricted __le64 [usertype]
>> security/integrity/ima/ima_kexec.c:209:23: sparse: sparse: symbol 'update_buffer_nb' was not declared. Should it be static?

vim +/update_buffer_nb +209 security/integrity/ima/ima_kexec.c

   208	
 > 209	struct notifier_block update_buffer_nb = {
   210		.notifier_call = ima_update_kexec_buffer,
   211		.priority = 1,
   212	};
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

