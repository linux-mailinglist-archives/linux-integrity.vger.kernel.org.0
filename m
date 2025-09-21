Return-Path: <linux-integrity+bounces-7212-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BF5B8D805
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707C917C7DA
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94075246774;
	Sun, 21 Sep 2025 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjhZX+ra"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32E23E335;
	Sun, 21 Sep 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758444902; cv=none; b=dmCOLuez3rG5uhkznQ7yJd0KEiWGDGKj+Q0eslGSniU2WWxODrNw2ZHlqLrEqYIOXyeclIDoSLXmjtEVhkIwCzZbH+2HrCTbsoEDMs3GAsuWLSM+xY/vArYFVP1A+Guapr6QvtB/v1ViB/YsoKqInNsK5vBHJHY9/XvRygcVxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758444902; c=relaxed/simple;
	bh=lX4I080+ZJyUqGQDOkoCt2JceIv9FnwbMsyV4Qiw/7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIH9/LXB/VqLiA+fqMjjRNwUVj9gGBJseH2Vn+Cc7+XZ6jzSuAkWDjNaNLnAzBZChe24m/OnhAaqdvBV/drelNrmbhZehR5JT1XWwwf5LEDTm3g/JANLK+MJGzTywgi+uSii1LOVLv3JT2KfOhIiFEwwaChyENg5A4b3tGfUjfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjhZX+ra; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758444900; x=1789980900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lX4I080+ZJyUqGQDOkoCt2JceIv9FnwbMsyV4Qiw/7E=;
  b=LjhZX+rasyLiVjKffBIWOaaX6tamyV1VU15tHIKP35PPmvV6YvB+iqac
   TnRW0GF6GX7HBL+VjuLwI9ks/WXWFFKnXbCC7CAFEbfFaWY4d3ARkD0T8
   C0fXhV9E/rm4yvPZcshDmxoMlNqwOQ66xJYoVcvD1MiyWCJ/JONjDSjPv
   uMwKuLCHklK27ObANoHdDvj3PYy2poV8p8mkGaJz2/ieNCak8esRLvr11
   ErwYgC9BJsrHhFnOVPO6frVNzfPw8i92dpj1nBNfdP8ovf+SKjXuXI1wV
   WpmEoMEwQpMuoSHBJYhjGKG34BpNMM/Drm3f+wdneBs0UyoEwAuscrqTF
   A==;
X-CSE-ConnectionGUID: 5dfcHhWKS5GNIDrV0v2rrw==
X-CSE-MsgGUID: i86rEMstSvqe1LvKsI0JqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64541491"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64541491"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 01:54:59 -0700
X-CSE-ConnectionGUID: NJCzjAXtRrypPeDwvgXgyw==
X-CSE-MsgGUID: jxZOsUj4RSSgga78K34U4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,282,1751266800"; 
   d="scan'208";a="181364168"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 21 Sep 2025 01:54:56 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0FqB-0000c5-0Y;
	Sun, 21 Sep 2025 08:54:51 +0000
Date: Sun, 21 Sep 2025 16:53:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 1/4] tpm: Make TPM buffer allocations more robust
Message-ID: <202509211636.ZaHdTpHP-lkp@intel.com>
References: <20250921020804.1088824-2-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921020804.1088824-2-jarkko@kernel.org>

Hi Jarkko,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250919]
[cannot apply to char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.17-rc6 v6.17-rc5 v6.17-rc4 v6.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jarkko-Sakkinen/tpm-Make-TPM-buffer-allocations-more-robust/20250921-102024
base:   next-20250919
patch link:    https://lore.kernel.org/r/20250921020804.1088824-2-jarkko%40kernel.org
patch subject: [PATCH v10 1/4] tpm: Make TPM buffer allocations more robust
config: x86_64-buildonly-randconfig-001-20250921 (https://download.01.org/0day-ci/archive/20250921/202509211636.ZaHdTpHP-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250921/202509211636.ZaHdTpHP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509211636.ZaHdTpHP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/char/tpm/tpm-buf.c:20:9: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
      19 |                         WARN(1, "%s: size mismatch: %u != %u\n", __func__, buf_size,
         |                                                           ~~
         |                                                           %lu
      20 |                              buf->capacity + sizeof(*buf));
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:141:29: note: expanded from macro 'WARN'
     141 |                 __WARN_printf(TAINT_WARN, format);                      \
         |                                           ^~~~~~
   include/asm-generic/bug.h:112:17: note: expanded from macro '__WARN_printf'
     112 |                 __warn_printk(arg);                                     \
         |                               ^~~
   1 warning generated.


vim +20 drivers/char/tpm/tpm-buf.c

     9	
    10	static void __tpm_buf_size_invariant(struct tpm_buf *buf, u16 buf_size)
    11	{
    12		if (!buf->capacity) {
    13			if (buf_size > TPM_BUF_MAX_SIZE) {
    14				WARN(1, "%s: size overflow: %u\n", __func__, buf_size);
    15				buf->flags |= TPM_BUF_ERROR;
    16			}
    17		} else {
    18			if (buf_size != buf->capacity + sizeof(*buf)) {
    19				WARN(1, "%s: size mismatch: %u != %u\n", __func__, buf_size,
  > 20				     buf->capacity + sizeof(*buf));
    21				buf->flags |= TPM_BUF_ERROR;
    22			}
    23		}
    24	}
    25	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

