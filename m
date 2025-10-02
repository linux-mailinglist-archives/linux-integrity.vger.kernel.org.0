Return-Path: <linux-integrity+bounces-7360-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1944EBB4A52
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Oct 2025 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C19320F00
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Oct 2025 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D362673B0;
	Thu,  2 Oct 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHRZWhxS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533625B662;
	Thu,  2 Oct 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425517; cv=none; b=Bg6+aV3iBfG8LRJ4HVKKZXjHGiEwAMmSMhWhOf5GfJ1p1JPwnaMjXVYafZiFPlkFwNI8+i8HXR6McNx9RlcQpnjXJOzvoOtbB9Pz4PVbgxeTmxvlVrdqqDP3/kdAZAXhEjM3QvlGe5g0VdAg3sgP00fIHuf8k27VlYye7tiFxxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425517; c=relaxed/simple;
	bh=02lOA8M4b99FTI12clEcVWJmZe9RgZyngHhaHKvYHnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrifqvfNR8+K5ho7iz3h9Cc/G/cU0bFhp3/IZRStTnZJo42cOGS2VSbreqaf06ZGpBNk90nEU/w/IcHADBodPMKVAi3SOikx2qIaFsqEMy1JnVEGyqfYfUQQx8moSPbVgCdCkDsfCh/f4hAk5FS8AO+tQCz+ZqIK/kenEbKpQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHRZWhxS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759425516; x=1790961516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=02lOA8M4b99FTI12clEcVWJmZe9RgZyngHhaHKvYHnU=;
  b=hHRZWhxSMFdeSpI9gzx0VBt635Jk63gJVimE0rQhP2/iXTVSrJjpF1bE
   4DFUwwaXBHnqn4YiH3VRv8/NMiEVeTqTP52Cr0SSr35kolKRPeXNzwKpt
   jUxeWaEQtDSj2eIX9LFgMpPVRiAGl/lALV3M/zQW6UBpUtkQOmulrvHzW
   K3O9y9v1mbn2yQOi1Evb0u1sUWvliILqNSFSRaS/hYFmZkP8eSiuL1Ode
   zOtGPQfy3leG3+jXyQvGIIgmN/hesI0+YGcrl4WJKM9JVpmwL8hzO7LsR
   yRqLf6ZbWxbGYqV1RjS+yVyJ68g9Bg9Ers64aWKiz+Hs7qQ3aZbvJw0+O
   A==;
X-CSE-ConnectionGUID: Q81euc8LRn6dYuz/wmkk5w==
X-CSE-MsgGUID: XrEWZX8kTD+iUeOWr59itw==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61878083"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="61878083"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 10:18:35 -0700
X-CSE-ConnectionGUID: TBUpOEUBQpqe67YSZddDYQ==
X-CSE-MsgGUID: TcQTY7GcSaOH1JblNzYj5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="184282752"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Oct 2025 10:18:31 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4Mwm-0003yt-1s;
	Thu, 02 Oct 2025 17:18:28 +0000
Date: Fri, 3 Oct 2025 01:17:30 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Karel Srot <ksrot@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <202510030029.VRKgik99-lkp@intel.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928030358.3873311-1-coxu@redhat.com>

Hi Coiby,

kernel test robot noticed the following build errors:

[auto build test ERROR on cec1e6e5d1ab33403b809f79cd20d6aff124ccfe]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/ima-Fall-back-to-default-kernel-module-signature-verification/20250928-110501
base:   cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
patch link:    https://lore.kernel.org/r/20250928030358.3873311-1-coxu%40redhat.com
patch subject: [PATCH] ima: Fall back to default kernel module signature verification
config: i386-randconfig-012-20251002 (https://download.01.org/0day-ci/archive/20251003/202510030029.VRKgik99-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251003/202510030029.VRKgik99-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>> security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'


vim +587 security/integrity/ima/ima_appraise.c

   483	
   484	/*
   485	 * ima_appraise_measurement - appraise file measurement
   486	 *
   487	 * Call evm_verifyxattr() to verify the integrity of 'security.ima'.
   488	 * Assuming success, compare the xattr hash with the collected measurement.
   489	 *
   490	 * Return 0 on success, error code otherwise
   491	 */
   492	int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
   493				     struct file *file, const unsigned char *filename,
   494				     struct evm_ima_xattr_data *xattr_value,
   495				     int xattr_len, const struct modsig *modsig)
   496	{
   497		static const char op[] = "appraise_data";
   498		int audit_msgno = AUDIT_INTEGRITY_DATA;
   499		const char *cause = "unknown";
   500		struct dentry *dentry = file_dentry(file);
   501		struct inode *inode = d_backing_inode(dentry);
   502		enum integrity_status status = INTEGRITY_UNKNOWN;
   503		int rc = xattr_len;
   504		bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
   505		bool enforce_module_sig = iint->flags & IMA_DIGSIG_REQUIRED && func == MODULE_CHECK;
   506	
   507		/* If not appraising a modsig or using default module verification, we need an xattr. */
   508		if (!(inode->i_opflags & IOP_XATTR) && !try_modsig && !enforce_module_sig)
   509			return INTEGRITY_UNKNOWN;
   510	
   511		/*
   512		 * Unlike any of the other LSM hooks where the kernel enforces file
   513		 * integrity, enforcing file integrity for the bprm_creds_for_exec()
   514		 * LSM hook with the AT_EXECVE_CHECK flag is left up to the discretion
   515		 * of the script interpreter(userspace). Differentiate kernel and
   516		 * userspace enforced integrity audit messages.
   517		 */
   518		if (is_bprm_creds_for_exec(func, file))
   519			audit_msgno = AUDIT_INTEGRITY_USERSPACE;
   520	
   521		/* If reading the xattr failed and there's no modsig or module verification, error out. */
   522		if (rc <= 0 && !try_modsig && !enforce_module_sig) {
   523			if (rc && rc != -ENODATA)
   524				goto out;
   525	
   526			if (iint->flags & IMA_DIGSIG_REQUIRED) {
   527				if (iint->flags & IMA_VERITY_REQUIRED)
   528					cause = "verity-signature-required";
   529				else
   530					cause = "IMA-signature-required";
   531			} else {
   532				cause = "missing-hash";
   533			}
   534	
   535			status = INTEGRITY_NOLABEL;
   536			if (file->f_mode & FMODE_CREATED)
   537				iint->flags |= IMA_NEW_FILE;
   538			if ((iint->flags & IMA_NEW_FILE) &&
   539			    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
   540			     (inode->i_size == 0)))
   541				status = INTEGRITY_PASS;
   542			goto out;
   543		}
   544	
   545		status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value,
   546					 rc < 0 ? 0 : rc);
   547		switch (status) {
   548		case INTEGRITY_PASS:
   549		case INTEGRITY_PASS_IMMUTABLE:
   550		case INTEGRITY_UNKNOWN:
   551			break;
   552		case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
   553			/* Fine to not have xattrs when using a modsig or default module verification. */
   554			if (try_modsig || enforce_module_sig)
   555				break;
   556			fallthrough;
   557		case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
   558			cause = "missing-HMAC";
   559			goto out;
   560		case INTEGRITY_FAIL_IMMUTABLE:
   561			set_bit(IMA_DIGSIG, &iint->atomic_flags);
   562			cause = "invalid-fail-immutable";
   563			goto out;
   564		case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
   565			cause = "invalid-HMAC";
   566			goto out;
   567		default:
   568			WARN_ONCE(true, "Unexpected integrity status %d\n", status);
   569		}
   570	
   571		if (xattr_value)
   572			rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
   573					  &cause);
   574	
   575		/*
   576		 * If we have a modsig and either no imasig or the imasig's key isn't
   577		 * known, then try verifying the modsig.
   578		 */
   579		if (try_modsig &&
   580		    (!xattr_value || xattr_value->type == IMA_XATTR_DIGEST_NG ||
   581		     rc == -ENOKEY))
   582			rc = modsig_verify(func, modsig, &status, &cause);
   583	
   584		/* Fall back to default kernel module signature verification */
   585		if (rc && enforce_module_sig) {
   586			rc = 0;
 > 587			set_module_sig_enforced();
   588			/* CONFIG_MODULE_SIG may be disabled */
   589			if (is_module_sig_enforced()) {
   590				rc = 0;
   591				status = INTEGRITY_PASS;
   592				pr_debug("Fall back to default kernel module verification for %s\n", filename);
   593			}
   594		}
   595	
   596	out:
   597		/*
   598		 * File signatures on some filesystems can not be properly verified.
   599		 * When such filesystems are mounted by an untrusted mounter or on a
   600		 * system not willing to accept such a risk, fail the file signature
   601		 * verification.
   602		 */
   603		if ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
   604		    ((inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) ||
   605		     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
   606			status = INTEGRITY_FAIL;
   607			cause = "unverifiable-signature";
   608			integrity_audit_msg(audit_msgno, inode, filename,
   609					    op, cause, rc, 0);
   610		} else if (status != INTEGRITY_PASS) {
   611			/* Fix mode, but don't replace file signatures. */
   612			if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
   613			    (!xattr_value ||
   614			     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
   615				if (!ima_fix_xattr(dentry, iint))
   616					status = INTEGRITY_PASS;
   617			}
   618	
   619			/*
   620			 * Permit new files with file/EVM portable signatures, but
   621			 * without data.
   622			 */
   623			if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
   624			    test_bit(IMA_DIGSIG, &iint->atomic_flags)) {
   625				status = INTEGRITY_PASS;
   626			}
   627	
   628			integrity_audit_msg(audit_msgno, inode, filename,
   629					    op, cause, rc, 0);
   630		} else {
   631			ima_cache_flags(iint, func);
   632		}
   633	
   634		ima_set_cache_status(iint, func, status);
   635		return status;
   636	}
   637	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

