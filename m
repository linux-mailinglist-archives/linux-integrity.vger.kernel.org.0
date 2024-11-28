Return-Path: <linux-integrity+bounces-4246-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF66A9DBAEA
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Nov 2024 16:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96666164131
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Nov 2024 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC841BD9CB;
	Thu, 28 Nov 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5aJp5ch"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C551BD03B;
	Thu, 28 Nov 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809440; cv=none; b=kPYvsDUnqMT87SlFz6+hnQFaG7/cnz1P+cNay95gIp9EoW9noR2hxZhdqdobTO5btp3B6B3Dsnf3GBQk9dPEifVSveHgBAUNQJn0eXSmjeGbhkHGyDZTivVXjEJGZHKLKK+nsfWTdNRLaZqAA2AHd6Rh6OVHc/MFZY2ASwDdItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809440; c=relaxed/simple;
	bh=q2CtXnqbC/72187yv3JLxnI/jJYe50m3supDHWMAw0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpKIHxdxA7a2IgC56/cis1gIBY+zKX42sfuCWhUoHBC6DVpFRrEoQUXeDuLtiHcFIGriEb5N2AzNFkcm7GTH8qnYRMsrGT8YBRVDUMnuuNiBNl41MCzXFtdNLkFgI76BDeR78qlGDTFxfrpPo+eo5RLHeZujzNezj4hRBLk4Q7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5aJp5ch; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732809439; x=1764345439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2CtXnqbC/72187yv3JLxnI/jJYe50m3supDHWMAw0g=;
  b=k5aJp5chnddF+iF8NeOa6NfzcPT82e+ehGaMc3AMMNhhbTAFJG4VcYgG
   1u2d//WMkBoNF/gHXKxKsHksR9R1gzXwbXDWWeZB9XBljseSF+EzU3wV2
   VSp61KbrxJd3h62/5ptsq6peCUHFf5viPNjSnrJTlCL25p3fpXETPGFAb
   hb8rqVyayrvibNHUxppRfI15V0ycIFeU03i4nYfT7h1+WmbW9xVaLeVQY
   INKT7QT4KJY6Nj53iYM4bYQj+jtqkjr4ws/5A+7l4LlpcA8e4xtjXfEV6
   SFJIV9GEVzQJNfCJtkquVCfAgAVGnpy08tEkrG+k5R0Bre+5PyTpDEN8I
   A==;
X-CSE-ConnectionGUID: C9+OKWy0TqWM5TuGkb+XdA==
X-CSE-MsgGUID: HZr/MKwfQUmiIKi2KumcAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="44106759"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="44106759"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 07:57:18 -0800
X-CSE-ConnectionGUID: n15I+mkxS9unv2kzSoRFOQ==
X-CSE-MsgGUID: pt9gFsgCQUuey5zlDQnxxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="97367760"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Nov 2024 07:57:17 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGgtG-0009kp-0Q;
	Thu, 28 Nov 2024 15:57:14 +0000
Date: Thu, 28 Nov 2024 23:57:04 +0800
From: kernel test robot <lkp@intel.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Mimi Zohar <zohar@linux.ibm.com>,
	=?unknown-8bit?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: instantiate the bprm_creds_for_exec() hook
Message-ID: <202411282320.KuWvLpDS-lkp@intel.com>
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
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20241128/202411282320.KuWvLpDS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411282320.KuWvLpDS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411282320.KuWvLpDS-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/integrity/ima/ima_main.c: In function 'ima_bprm_creds_for_exec':
>> security/integrity/ima/ima_main.c:572:18: error: 'struct linux_binprm' has no member named 'is_check'
     572 |         if (!bprm->is_check)
         |                  ^~
--
   security/integrity/ima/ima_appraise.c: In function 'is_bprm_creds_for_exec':
>> security/integrity/ima/ima_appraise.c:492:25: error: 'struct linux_binprm' has no member named 'is_check'
     492 |                 if (bprm->is_check)
         |                         ^~


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

