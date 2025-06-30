Return-Path: <linux-integrity+bounces-6569-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293EAED316
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 05:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0470172EA8
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 03:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9E196C7C;
	Mon, 30 Jun 2025 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvlrBwED"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F175194A44;
	Mon, 30 Jun 2025 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255348; cv=none; b=T7QHycx2x3KXfRmwqjQOVK0ekevqZ7IEY7SAixgr/9EC3VeveI28E9qm3WdmsfukPI8izZVv1uhROLQ1z2kTY/Di0lQkma2rG52xeIobfkfktyxHx5tc3J3FHIPwaKyGEXg2AhIuJ4+8fGo/7UP0esD0Q6qc3JRRj0Kki5P0/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255348; c=relaxed/simple;
	bh=QPyADK9zPp0ngvuNL56VT5gNsd2clYF5WbJ46q3uXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsP/uUY/OjGjUPGOWr98bU2TXCAEVuXZEk9VT3tLtPR2N9pTaW2YpZL1/kAUOgeAmpFA4KIcrAvdCLYNdE6d6hC/cYyvhIkVwbXOCxkKaaruyYOFkL0HspYkeEWK/HjpHdvRPoJfNOhv2UPACN0gedxsw1DWbf1oMw0beii4sQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvlrBwED; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751255346; x=1782791346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPyADK9zPp0ngvuNL56VT5gNsd2clYF5WbJ46q3uXaA=;
  b=jvlrBwEDABjfnDySfFpwDzRE7FkRo71yuLzBmtKfC3HyVWAZhcFkWlyt
   N7dsjx5RAF0btPtSBIfYwPTFS4JTWBL07ac5ejo2UK8L9CQzrWs4sO6/M
   CV/WmuDxAi1T/wqM7pJP1yGC8DxuLuU5fMKcyQAfJV4IBlTxg6W5SsnXl
   yu48PeGnqpALp+R6Ufeee6WIIJAkxJolKdJYQRdzi39+YDB27/ep07189
   1TPV1MzxqYVujbWeUCSmxB4LeGRu0nQyP6BtbFXLiooZHmMraKIoDHG4u
   f6ESqyVRCrCvz5OmKvvImArICiDAIdGI1exro3MwcgeCpKEWAt9OJzcZn
   A==;
X-CSE-ConnectionGUID: +uMWrFreTHWI/3n/lD9IUQ==
X-CSE-MsgGUID: wrWGeLEgROGGwNjWF1JxMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53412535"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="53412535"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 20:49:05 -0700
X-CSE-ConnectionGUID: KQUAA6GzTP+FamccfauLqQ==
X-CSE-MsgGUID: q8TfAvgnTNqN40i//1jc3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="154049717"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jun 2025 20:49:00 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uW5Vq-000YRG-1Z;
	Mon, 30 Jun 2025 03:48:58 +0000
Date: Mon, 30 Jun 2025 11:48:49 +0800
From: kernel test robot <lkp@intel.com>
To: GONG Ruiqi <gongruiqi1@huawei.com>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, Eric Snowberg <eric.snowberg@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, "Lee, Chun-Yi" <jlee@suse.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, Lu Jialin <lujialin4@huawei.com>,
	gongruiqi1@huawei.com
Subject: Re: [PATCH v2] integrity: Extract secure boot enquiry function out
 of IMA
Message-ID: <202506301150.yT6MxuHD-lkp@intel.com>
References: <20250628063251.321370-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628063251.321370-1-gongruiqi1@huawei.com>

Hi GONG,

kernel test robot noticed the following build errors:

[auto build test ERROR on zohar-integrity/next-integrity]
[also build test ERROR on powerpc/next powerpc/fixes s390/features linus/master v6.16-rc4 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/GONG-Ruiqi/integrity-Extract-secure-boot-enquiry-function-out-of-IMA/20250628-142236
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20250628063251.321370-1-gongruiqi1%40huawei.com
patch subject: [PATCH v2] integrity: Extract secure boot enquiry function out of IMA
config: x86_64-randconfig-102-20250630 (https://download.01.org/0day-ci/archive/20250630/202506301150.yT6MxuHD-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250630/202506301150.yT6MxuHD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506301150.yT6MxuHD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: arch_integrity_get_secureboot
   >>> referenced by ima_main.c:922 (security/integrity/ima/ima_main.c:922)
   >>>               vmlinux.o:(ima_load_data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

