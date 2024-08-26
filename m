Return-Path: <linux-integrity+bounces-3381-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9895FB9A
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2024 23:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC8C1F22AB7
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2024 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3D199242;
	Mon, 26 Aug 2024 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAtXZjz3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85E13C8EA;
	Mon, 26 Aug 2024 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707477; cv=none; b=WS9Kzm+cDsUqWhmjafrMj2zYn6wWqzvlyTUtSgJUQQBzgOkbNtlj+9XVAnp33ppro2lq0GUAO9UH3jXFn7vrtykDSHRZe5sTYrADAzBOgW/X1Aw7W+SnK5fAWN+e1l+i3+bN6beDGNHWYo6ax/wCfCGuEXi7X/vWTzIsgU1fuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707477; c=relaxed/simple;
	bh=J1sh0JGMwBFt+RuTIyEsiQH6h/297F/9Mo1VkS8wDQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUi5NVPf7TTosHn5NPA86BwgrjyFntLFyov5yII/r+M6WOdmLouqKsT5x4Ut0bAxqGTP/Evgabo6ZTA05uH3LYXKEtP9A96h7sT6j3sLtgD1KOmbB9lQ8PYQCejB+HDEyC1dCCo6jSOMT3BHixrffF/EflHISZX74RnIxsQUtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAtXZjz3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724707476; x=1756243476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J1sh0JGMwBFt+RuTIyEsiQH6h/297F/9Mo1VkS8wDQ0=;
  b=iAtXZjz3EOd1S6HLYg6PCD4zCWiYtDtpuLzYG0mTCDgAB8cwljRQTQvx
   hi3hdqrUEsMNZhMplRoSEsor6FJsnBmCetgJlj65ljmbEYJCi3PUpmYkR
   cMzYI1G+j8X7GgVLIGWSTYXEpLYLldOS28/8oEO53if59fbhCpVb4ZNd8
   0ob2TQozPNkPhM3XBsW07/O1Y+3Zh5h9urwko/Od8b6nRxdFksmZnzgbp
   R0D47GfxDZ0fbfvzlgYXlSLzRrNnhsfG66sBvgH0o08TY9pBOhH0yz01w
   VcicIbliM2bEorcy3sVLEuXU/Hyk2DX1zJv7Wy9Bk0wn6EmgImbIO1yLV
   w==;
X-CSE-ConnectionGUID: g6QesiqmSvynN0KJifAGMg==
X-CSE-MsgGUID: yEwqeXOoTQOmmtV7XmKPoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23337144"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23337144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 14:24:35 -0700
X-CSE-ConnectionGUID: /Epz5TVJRmKWkjh2VxUsjg==
X-CSE-MsgGUID: Dct1gWmaT0eV6Pz1/y1SBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="93369759"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2024 14:24:31 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sihCO-000Hc2-0L;
	Mon, 26 Aug 2024 21:24:28 +0000
Date: Tue, 27 Aug 2024 05:24:01 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jmorris@namei.org, serge@hallyn.com,
	keescook@chromium.org, john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org, mic@digikod.net,
	linux-integrity@vger.kernel.org, linux-audit@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH 07/13] LSM: Use lsmblob in security_current_getsecid
Message-ID: <202408270512.9cZ78Eog-lkp@intel.com>
References: <20240825190048.13289-8-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825190048.13289-8-casey@schaufler-ca.com>

Hi Casey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-selinux/next]
[also build test WARNING on zohar-integrity/next-integrity linus/master pcmoore-audit/next v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Add-the-lsmblob-data-structure/20240826-170520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20240825190048.13289-8-casey%40schaufler-ca.com
patch subject: [PATCH 07/13] LSM: Use lsmblob in security_current_getsecid
config: arc-randconfig-001-20240827 (https://download.01.org/0day-ci/archive/20240827/202408270512.9cZ78Eog-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270512.9cZ78Eog-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270512.9cZ78Eog-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/smack/smack_lsm.c:2265: warning: Function parameter or struct member 'blob' not described in 'smack_task_getlsmblob_obj'
>> security/smack/smack_lsm.c:2265: warning: Excess function parameter 'secid' description in 'smack_task_getlsmblob_obj'


vim +2265 security/smack/smack_lsm.c

1fb057dcde11b35 Paul Moore      2021-02-19  2255  
1fb057dcde11b35 Paul Moore      2021-02-19  2256  /**
fd64f9693f6c226 Casey Schaufler 2024-08-25  2257   * smack_task_getlsmblob_obj - get the objective data of the task
1fb057dcde11b35 Paul Moore      2021-02-19  2258   * @p: the task
1fb057dcde11b35 Paul Moore      2021-02-19  2259   * @secid: where to put the result
1fb057dcde11b35 Paul Moore      2021-02-19  2260   *
1fb057dcde11b35 Paul Moore      2021-02-19  2261   * Sets the secid to contain a u32 version of the task's objective smack label.
e114e473771c848 Casey Schaufler 2008-02-04  2262   */
fd64f9693f6c226 Casey Schaufler 2024-08-25  2263  static void smack_task_getlsmblob_obj(struct task_struct *p,
fd64f9693f6c226 Casey Schaufler 2024-08-25  2264  				      struct lsmblob *blob)
e114e473771c848 Casey Schaufler 2008-02-04 @2265  {
1fb057dcde11b35 Paul Moore      2021-02-19  2266  	struct smack_known *skp = smk_of_task_struct_obj(p);
2f823ff8bec03a1 Casey Schaufler 2013-05-22  2267  
fd64f9693f6c226 Casey Schaufler 2024-08-25  2268  	blob->smack.skp = skp;
fd64f9693f6c226 Casey Schaufler 2024-08-25  2269  	/* scaffolding */
fd64f9693f6c226 Casey Schaufler 2024-08-25  2270  	blob->scaffold.secid = skp->smk_secid;
e114e473771c848 Casey Schaufler 2008-02-04  2271  }
e114e473771c848 Casey Schaufler 2008-02-04  2272  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

