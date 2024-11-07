Return-Path: <linux-integrity+bounces-4071-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD49C0FE8
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 21:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646DDB21DE1
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 20:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECBE218305;
	Thu,  7 Nov 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czGJ5vPl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8BC215F58;
	Thu,  7 Nov 2024 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012216; cv=none; b=X5a1nWFj47+8cvGRoVmJx2DOiZ0tNOaokivlW+ZE2XptmSBgBq40XBX5xzNYxJ98H+8SwLTiBcytlI7NpAmSSD6zX6gHzptwAcCFsknt2f00olO0hvwLI+IjqMdP5tCLWtNDAM+zb1KfHAGIyZb8h1GgDEKAt4pDeGSTAm+21a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012216; c=relaxed/simple;
	bh=y6ha6PbD3HilLPfJs2LLlgYjyadjBLnc4ntOhI/UGMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4wOZnj/LwnpFMmvhPAXDTZ1eYph4Q+a1I/92CrO7QEKJDxs4TMAGFOvGe32Apm8sF0d2IqmgaqRl9nIe51N8cfRQclZrlXCuvmmeuom+OHNFKdPpBr4XwDyxEJLpM+F4bD4HtIICghVjyi+vbB33AIt5ZYg3QmPEukMqYikcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czGJ5vPl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731012215; x=1762548215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y6ha6PbD3HilLPfJs2LLlgYjyadjBLnc4ntOhI/UGMA=;
  b=czGJ5vPlh7lmm0ByYWbWuRfq3P16z6qIr1HOwt+BKJYS+B74iHGTRYJp
   avPym/lcpIjy/Md9xty+2FII2Bto+HBeWxw4o6dECn2cZXaaCKRm4mQKa
   5pgBXjBCrsnKMSUOkgtS86UAvsMyXMEjLRZDdZHdNgp4k01+My/k2laVO
   sLrITFgztqhPP3xzvi0yFKTu1uuEXGZvVvXKVzG8/LGQvfMV/WJprysnv
   Fwn3SXuef64kOf2nJCjVdpNZPoObFN7R2aJQV2VZEn4FsVveoje2nTT33
   BZvDcWFpMgpxUhCpDnjcicJpjg0N2UqnJx41FTefQmiTGOs5ABHpDQkPm
   g==;
X-CSE-ConnectionGUID: /OtVkZBiTX2qpPROceBfBg==
X-CSE-MsgGUID: XxdLt28VQd+5y7GyHY4V0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="42254533"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="42254533"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:43:35 -0800
X-CSE-ConnectionGUID: DXtFXtcFQLaMvnC72LjI6Q==
X-CSE-MsgGUID: vVrUlfwHSv288JvqU1N1eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="90046116"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Nov 2024 12:43:31 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t99Lk-000qem-1n;
	Thu, 07 Nov 2024 20:43:28 +0000
Date: Fri, 8 Nov 2024 04:43:12 +0800
From: kernel test robot <lkp@intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
Message-ID: <202411080436.fb2O1apj-lkp@intel.com>
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
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.12-rc6 next-20241107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jarkko-Sakkinen/tpm-Opt-in-in-disable-PCR-integrity-protection/20241107-175515
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20241107095138.78209-1-jarkko%40kernel.org
patch subject: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
config: arm-randconfig-003-20241108 (https://download.01.org/0day-ci/archive/20241108/202411080436.fb2O1apj-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411080436.fb2O1apj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411080436.fb2O1apj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/char/tpm/tpm2-cmd.c:14:
   In file included from drivers/char/tpm/tpm.h:28:
   include/linux/tpm_eventlog.h:167:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
           int mapping_size;
               ^
>> drivers/char/tpm/tpm2-cmd.c:253:42: error: too few arguments to function call, expected 4, have 3
                   tpm_buf_append_name(chip, &buf, pcr_idx);
                   ~~~~~~~~~~~~~~~~~~~                    ^
   include/linux/tpm.h:504:6: note: 'tpm_buf_append_name' declared here
   void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
        ^
   1 warning and 1 error generated.


vim +253 drivers/char/tpm/tpm2-cmd.c

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

