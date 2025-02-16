Return-Path: <linux-integrity+bounces-4834-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F47A37186
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Feb 2025 01:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B432216E60F
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Feb 2025 00:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3B623AD;
	Sun, 16 Feb 2025 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHvGniaz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D31FC8;
	Sun, 16 Feb 2025 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739665741; cv=none; b=hqCATZwiSFJG5BCVUhwmERMtFQh1av3NkLAXfneXPSf21DSdwHDMWRYsxeewEA3AMtMOqTcEpUAw/x2A6Wyk1UMYWzR4cO9dJ/HI3Qg6m7GcPE9YpYdmj0JJw9xh0OD4lGYqV23Hqm2abcgsn9/o0V5Mjgqqci0w7Kq1SfOHdfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739665741; c=relaxed/simple;
	bh=ptxeuYv+DMlsfr3xX9uWibwwGHo6HQ1eNYvjC87zIgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqNclcKr83TqIIfwPmJIONudFE6mtGyAT7vXdATYaKYwzpfOJQfT3cvnKueeYcaTMU8kS/b/PJJByK1OF59J+fUg0cmy9IkwEoh5vULQpYhxkOPdXzmMISDhdHdt1eVZt+b2unco+IOgvG6c8oWejN+T8i2IzEUnT1aKPZOeK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHvGniaz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739665740; x=1771201740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptxeuYv+DMlsfr3xX9uWibwwGHo6HQ1eNYvjC87zIgc=;
  b=aHvGniazVBeL8z/HdIJHllGoiF6ufc9olz0d0qKbLgDxsKum2GQFCtlG
   CkjSN6OvgyzHEmF4IAQpKs5Uo+pJGB2SUDkv//g+8tXhuJll+gZw0qIWO
   ul+LZdE9L/o4tc0wI3cAjBUtCntjtSNifjRleuLneZ7yDzOLkACx1ki2w
   X0wsm/rEmfdIOpSagVPoFP8xMA/BWiKmJSVIeo2gGpW+uqvuKVPhxipki
   DptzcOAviEgKv435weSotTMziIW/PcduWp/whL1dUU21uHhksgQwntpQ3
   F4KcHQ1Ge1E4/YxKq5Ad8qbata4MRA9ONqOT7Alc+RLKNIYdmk6rowh+Q
   A==;
X-CSE-ConnectionGUID: Y0AJ2VywS2Kdem0lyAtjPQ==
X-CSE-MsgGUID: 24YtorFeQ46PygfL+/NUYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40255637"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40255637"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 16:28:59 -0800
X-CSE-ConnectionGUID: YrjrGHGXQcaHZH/AlOcNHQ==
X-CSE-MsgGUID: cA6oL5o9TpuEvVCBmmt5Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114267907"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Feb 2025 16:28:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjSWj-001BRT-1Z;
	Sun, 16 Feb 2025 00:28:53 +0000
Date: Sun, 16 Feb 2025 08:28:00 +0800
From: kernel test robot <lkp@intel.com>
To: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
	jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] tpm_crb: implement driver compliant to CRB over
 FF-A
Message-ID: <202502160801.zzYlGtHn-lkp@intel.com>
References: <20250212220548.400447-2-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212220548.400447-2-stuart.yoder@arm.com>

Hi Stuart,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.14-rc2 next-20250214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stuart-Yoder/tpm_crb-implement-driver-compliant-to-CRB-over-FF-A/20250213-060938
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250212220548.400447-2-stuart.yoder%40arm.com
patch subject: [PATCH v2 1/5] tpm_crb: implement driver compliant to CRB over FF-A
config: arm64-randconfig-r073-20250214 (https://download.01.org/0day-ci/archive/20250216/202502160801.zzYlGtHn-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160801.zzYlGtHn-lkp@intel.com/

smatch warnings:
drivers/char/tpm/tpm_ffa_crb.c:272 ffa_crb_probe() warn: unsigned 'ffa_crb->minor_version' is never less than zero.

vim +272 drivers/char/tpm/tpm_ffa_crb.c

   230	
   231	static int ffa_crb_probe(struct ffa_device *ffa_dev)
   232	{
   233		int rc;
   234		struct ffa_crb *p;
   235	
   236		/* only one instance of a TPM partition is supported */
   237		if (ffa_crb && !IS_ERR_VALUE(ffa_crb))
   238			return -EEXIST;
   239	
   240		ffa_crb = ERR_PTR(-ENODEV); // set ffa_crb so we can detect probe failure
   241	
   242		if (!ffa_partition_supports_direct_recv(ffa_dev)) {
   243			pr_err("TPM partition doesn't support direct message receive.\n");
   244			return -EINVAL;
   245		}
   246	
   247		p = kzalloc(sizeof(*ffa_crb), GFP_KERNEL);
   248		if (!p)
   249			return -ENOMEM;
   250		ffa_crb = p;
   251	
   252		mutex_init(&ffa_crb->msg_data_lock);
   253		ffa_crb->ffa_dev = ffa_dev;
   254		ffa_dev_set_drvdata(ffa_dev, ffa_crb);
   255	
   256		/* if TPM is aarch32 use 32-bit SMCs */
   257		if (!ffa_partition_check_property(ffa_dev, FFA_PARTITION_AARCH64_EXEC))
   258			ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
   259	
   260		/* verify compatibility of TPM service version number */
   261		rc = ffa_crb_get_interface_version(&ffa_crb->major_version,
   262				&ffa_crb->minor_version);
   263		if (rc) {
   264			pr_err("failed to get crb interface version. rc:%d", rc);
   265			goto out;
   266		}
   267	
   268		pr_info("ABI version %u.%u", ffa_crb->major_version,
   269			ffa_crb->minor_version);
   270	
   271		if ((ffa_crb->major_version != FFA_CRB_VERSION_MAJOR) ||
 > 272		    (ffa_crb->minor_version < FFA_CRB_VERSION_MINOR)) {
   273			pr_err("Incompatible ABI version");
   274			goto out;
   275		}
   276	
   277		return 0;
   278	
   279	out:
   280		kfree(ffa_crb);
   281		ffa_crb = ERR_PTR(-ENODEV);
   282		return -EINVAL;
   283	}
   284	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

