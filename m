Return-Path: <linux-integrity+bounces-4060-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0349C07EE
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 14:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD72E1C20DAA
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA16E20FAB1;
	Thu,  7 Nov 2024 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQMi4t57"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02441EF0A2;
	Thu,  7 Nov 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987239; cv=none; b=lGoAg90c5hOhHg0aI55WS7NFM4/DzXCPVlCYmadZ6N49zCaNHEI7c9p22hQUDoVEMcHEUtGhhtGn0YOCfCMuB6ncC0lfrZxc8ZdeR8+Ic4wOY7VA9pCxFJ6q161FzWF1p8aG8KALzxGU+s3aENmP8nDsV4y3AhvTS+UMs6qyxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987239; c=relaxed/simple;
	bh=xE1dVbC+YVeuhiAWZuW8loujE3dbs7eHJ5Jqu+o7fVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+nh1MS/6ElfgyhetC3zYPpfNnbPxGUGYNs6QOYvIQZxmulhaj5+rmx9XjNeg9rajHCpsF0/5fna+fYhYyppUzH90YRWJGJV43VMjY3RFnNjDJGHfYnyI914KrBiXPmZ3IuszFedrm7S6AlsADn+WHqsHy/JP5Sk0Bqy6ajmKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQMi4t57; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730987238; x=1762523238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xE1dVbC+YVeuhiAWZuW8loujE3dbs7eHJ5Jqu+o7fVE=;
  b=CQMi4t57JXzrLESH3kWmkDvrNB3bpgC7ieVOFE231fIEOtCjuT0TCwQt
   trLKTdW6SGRCFYTRbBSCCgEnY+5GJsibTjTtjXXryxe7On3r5f3hbVK3W
   WIC97lIDqWCoRgZ3gZL6xFlr5s5lxoi+GqomVAue2kQsFfnUG1o3P365y
   2wTwIFQl6mG9rV1BHGEo8v7Hx4RpAkGHccdd7p+sDHCzCftHSNyl5bmQW
   Sny7tel/+55u0WLQypvZbgkBwWJvNAHT8gGAWB0mE47el35qxLr2eUgC1
   f2g8QExZchoSzZxoYlPlxhohmgkOQTLYoGL5Cov4OZghQWbxGQCP1s9g/
   w==;
X-CSE-ConnectionGUID: ko1mUnOBRP2E7o9tKSXzUw==
X-CSE-MsgGUID: F7WCITSLS22Com5qM7/Itg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30943318"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="30943318"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:47:17 -0800
X-CSE-ConnectionGUID: SemUo1zQRMOmOkgican78Q==
X-CSE-MsgGUID: SVH4Q6TfS7GZrjkG68indA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="89615619"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Nov 2024 05:47:13 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t92qt-000qJ6-35;
	Thu, 07 Nov 2024 13:47:11 +0000
Date: Thu, 7 Nov 2024 21:46:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: oe-kbuild-all@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
Message-ID: <202411072138.bgOIL36O-lkp@intel.com>
References: <20241107095138.78209-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107095138.78209-1-jarkko@kernel.org>

Hi Jarkko,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.12-rc6 next-20241106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jarkko-Sakkinen/tpm-Opt-in-in-disable-PCR-integrity-protection/20241107-175515
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20241107095138.78209-1-jarkko%40kernel.org
patch subject: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241107/202411072138.bgOIL36O-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411072138.bgOIL36O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411072138.bgOIL36O-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/char/tpm/tpm2-cmd.c: In function 'tpm2_pcr_extend':
>> drivers/char/tpm/tpm2-cmd.c:253:17: error: too few arguments to function 'tpm_buf_append_name'
     253 |                 tpm_buf_append_name(chip, &buf, pcr_idx);
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/char/tpm/tpm.h:27,
                    from drivers/char/tpm/tpm2-cmd.c:14:
   include/linux/tpm.h:504:6: note: declared here
     504 | void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
         |      ^~~~~~~~~~~~~~~~~~~


vim +/tpm_buf_append_name +253 drivers/char/tpm/tpm2-cmd.c

   222	
   223	/**
   224	 * tpm2_pcr_extend() - extend a PCR value
   225	 *
   226	 * @chip:	TPM chip to use.
   227	 * @pcr_idx:	index of the PCR.
   228	 * @digests:	list of pcr banks and corresponding digest values to extend.
   229	 *
   230	 * Return: Same as with tpm_transmit_cmd.
   231	 */
   232	int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
   233			    struct tpm_digest *digests)
   234	{
   235		struct tpm_buf buf;
   236		int rc;
   237		int i;
   238	
   239		if (!disable_pcr_integrity_protection) {
   240			rc = tpm2_start_auth_session(chip);
   241			if (rc)
   242				return rc;
   243		}
   244	
   245		rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
   246		if (rc) {
   247			if (!disable_pcr_integrity_protection)
   248				tpm2_end_auth_session(chip);
   249			return rc;
   250		}
   251	
   252		if (!disable_pcr_integrity_protection) {
 > 253			tpm_buf_append_name(chip, &buf, pcr_idx);
   254			tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
   255		} else {
   256			tpm_buf_append_handle(chip, &buf, pcr_idx);
   257			tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
   258		}
   259	
   260		tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
   261	
   262		for (i = 0; i < chip->nr_allocated_banks; i++) {
   263			tpm_buf_append_u16(&buf, digests[i].alg_id);
   264			tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
   265				       chip->allocated_banks[i].digest_size);
   266		}
   267	
   268		if (!disable_pcr_integrity_protection)
   269			tpm_buf_fill_hmac_session(chip, &buf);
   270		rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
   271		if (!disable_pcr_integrity_protection)
   272			rc = tpm_buf_check_hmac_response(chip, &buf, rc);
   273	
   274		tpm_buf_destroy(&buf);
   275	
   276		return rc;
   277	}
   278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

