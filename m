Return-Path: <linux-integrity+bounces-9024-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jnzmJm5Nv2kp1wMAu9opvQ
	(envelope-from <linux-integrity+bounces-9024-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2026 03:01:18 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB56F2E7EF5
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2026 03:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96C903016D14
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2026 02:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91874126F3B;
	Sun, 22 Mar 2026 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZJWAI6r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB740DFBE;
	Sun, 22 Mar 2026 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774144873; cv=none; b=IUNbyaeK8ROH0V/5UXdQziK+B9ZnD4dVA+zPaj2SKKWenVKaqtR6ReGAG1sfbVAbsEPmnWsQSFxJiS7UoxoAZvGDBZLVQZ6XNTwv4pOrDkwmRELjFQsBPx2x4bIsM+KBFcHd1fOhVe3ToQMzB5vxeilXFleKbvRfp1nBVwsW3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774144873; c=relaxed/simple;
	bh=ScmjluGtv5MNt9F1fRePDNsYZzDjPwtXOtfc53smfLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw2JgQh69fsb4MoSpfS4fXbgc/pjJncWzBYWvN9BwzUXFWGjqWvqywh+Qa3bSrj8HytD3WtDobl1wMT371NJ/8MkmKXXsZdyVQphetV+QpUl8zUT4w0456HSyyiODxx9OUq4CDM9Ts3sePoGeUe2a6kxOZiIDKFsuNHRf1G4wss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZJWAI6r; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774144871; x=1805680871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ScmjluGtv5MNt9F1fRePDNsYZzDjPwtXOtfc53smfLE=;
  b=UZJWAI6rwP2QcGNseInxHiDIbckLSeb3oV/txtlmX7X9veXhwQ/bwu6y
   VSoU075bvS0pSYleoLEnwzZ/AIBE1tyIStqdfzyLk/STu+4C7otI3WtmF
   uOjX+iD8DE4FmldYau0SY7+5q38MDcJ4Ik5dYfWAHvTCib49lLTC1HMTU
   XdVJRUy5QV8NcAPRhfkPRzUsQBjS/VZyfrnZP4QxlBs6O05BKX0iCRQKL
   1jWOIo5nRtRyPJr5edAM7/FmaLSaFq5hkXdAAu7bBL5V7iTaQTUNZPhI9
   o/KiPoV8hJIFeVZK16FY5mVzdQ3+8W7uoG2EJqBA1ChUto7u2BittG+Ux
   A==;
X-CSE-ConnectionGUID: acv2wPJeSvSF0Z17iSWfJg==
X-CSE-MsgGUID: 0OEHc+y5RH2oXINXCXlZeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75093899"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="75093899"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 19:01:10 -0700
X-CSE-ConnectionGUID: 4iqZcCQFQDahQwPUCFmPcg==
X-CSE-MsgGUID: ptBhm/47RbiH28TLvWPlEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="222746200"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 21 Mar 2026 19:01:06 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w487j-000000001VR-2cL1;
	Sun, 22 Mar 2026 02:01:03 +0000
Date: Sun, 22 Mar 2026 10:00:55 +0800
From: kernel test robot <lkp@intel.com>
To: Alec Brown <alec.r.brown@oracle.com>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, jarkko@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, peterhuewe@gmx.de,
	jarkko.sakkinen@iki.fi, jgg@ziepe.ca, ross.philipson@oracle.com,
	dpsmith@apertussolutions.com, daniel.kiper@oracle.com,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
	ardb@kernel.org, alec.r.brown@oracle.com
Subject: Re: [PATCH 4/4] tpm: Move TPM common base definitions to the command
 header
Message-ID: <202603220920.LNzslwgU-lkp@intel.com>
References: <20260317160613.2899129-5-alec.r.brown@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317160613.2899129-5-alec.r.brown@oracle.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9024-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmx.de,iki.fi,ziepe.ca,oracle.com,apertussolutions.com,googlegroups.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: EB56F2E7EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Alec,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v7.0-rc4 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alec-Brown/tpm-Initial-step-to-reorganize-TPM-public-headers/20260322-021741
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20260317160613.2899129-5-alec.r.brown%40oracle.com
patch subject: [PATCH 4/4] tpm: Move TPM common base definitions to the command header
config: arm-randconfig-r132-20260322 (https://download.01.org/0day-ci/archive/20260322/202603220920.LNzslwgU-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 4abb927bacf37f18f6359a41639a6d1b3bffffb5)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603220920.LNzslwgU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603220920.LNzslwgU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/char/tpm/tpm-dev-common.c:19:
   In file included from drivers/char/tpm/tpm.h:29:
   include/linux/tpm_eventlog.h:167:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
     167 |         int mapping_size;
         |             ^
   In file included from drivers/char/tpm/tpm-dev-common.c:19:
   In file included from drivers/char/tpm/tpm.h:28:
   In file included from include/linux/tpm.h:28:
>> include/linux/tpm_command.h:517:2: warning: field  within 'struct tpm_header' is less aligned than 'union tpm_header::(anonymous at include/linux/tpm_command.h:517:2)' and is usually due to 'struct tpm_header' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     517 |         union {
         |         ^
   2 warnings generated.
--
   In file included from drivers/char/tpm/tpm-buf.c:7:
   In file included from include/linux/tpm.h:28:
>> include/linux/tpm_command.h:517:2: warning: field  within 'struct tpm_header' is less aligned than 'union tpm_header::(anonymous at include/linux/tpm_command.h:517:2)' and is usually due to 'struct tpm_header' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     517 |         union {
         |         ^
   1 warning generated.


vim +517 include/linux/tpm_command.h

   513	
   514	struct tpm_header {
   515		__be16 tag;
   516		__be32 length;
 > 517		union {
   518			__be32 ordinal;
   519			__be32 return_code;
   520		};
   521	} __packed;
   522	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

