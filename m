Return-Path: <linux-integrity+bounces-8127-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 292EBCD3193
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Dec 2025 16:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 983ED3010AB0
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Dec 2025 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6426FA5B;
	Sat, 20 Dec 2025 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsmdWWje"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21926F2AD;
	Sat, 20 Dec 2025 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244109; cv=none; b=FTrXX20fHkvRo2P9bLP7wHhpdfWD5VlOaXfWoHG+SW58rg1IYp2vZ5upWAp05EE/seighVEXMQl0BcBCCxP7Wb3Ym5bQVdxrxcdIEeQmg0ST1XtWrH1tuinETejxpd9vLzGadxIvN6iQRJapqUeJHg83Rtf0Zr9VJCrR5PISC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244109; c=relaxed/simple;
	bh=NjY3JMdOK8jrfC4Nq2dQYCX2l+pMW1t2mckvjy00Mps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrFih6DsLuGzC3Qm3KyjWHinZBG+UAVUKkp1WpIO5kGA+yw9hfa6hIPAsXtQtndDUOyGO3HMpy7hUF2E0R0FpfWyRxhEhmZMhGb3IAXyf8KhwKPL3LRV1FIYb6UshqciEiDJoEWIFmRUwdWXMEwMVg0laiWw1O65PQjETnfjjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsmdWWje; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766244107; x=1797780107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NjY3JMdOK8jrfC4Nq2dQYCX2l+pMW1t2mckvjy00Mps=;
  b=dsmdWWjeE+qQEYn5KHStyHZd+uB/eN9kKhY59tccX0/DPh2598ZQCywn
   MJHfksK/bOtj0xNsv17Mg0yqPTNDPiHKjSy1rjHSN7sTx/egnPwDOLsYq
   M4r42rCikWDDkg9UdpEtGBGWygdiExNa8UTRWBLbgTJZmQzld+qNLTG9T
   bQ9sXUYQduTEjXWnq/tbhsvzbjPYNmxz42USlW6dK4OMW5ZX/K3uOZBdb
   HSzRI8IpBooccWQcpDMrYk1k/dZ9+SfiNQTich/qYCmgEZm3XqWaMLEnO
   ctoahw6yrhHMJSdJUrc3mjfzKJMMgPdUyxni9uM72B41IcMJfv+UiswY6
   w==;
X-CSE-ConnectionGUID: 8XJnCaiTQGuLQq1kcVkZ1w==
X-CSE-MsgGUID: gIfLyiNsSP2Cg2K/bEEjBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="68153729"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="68153729"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:21:46 -0800
X-CSE-ConnectionGUID: fpTfV4MIRJ6CTuNLMdbHAA==
X-CSE-MsgGUID: fvMVinswSlS7iyQ8nLoFIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="204053589"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 20 Dec 2025 07:21:43 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWym3-000000004fM-44z2;
	Sat, 20 Dec 2025 15:21:39 +0000
Date: Sat, 20 Dec 2025 16:21:12 +0100
From: kernel test robot <lkp@intel.com>
To: Chris J Arges <carges@cloudflare.com>, zohar@linux.ibm.com,
	roberto.sassu@huawei.com
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Kees Cook <kees@kernel.org>, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()
Message-ID: <202512201634.hYE4i2PX-lkp@intel.com>
References: <20251219195456.912190-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219195456.912190-1-carges@cloudflare.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on zohar-integrity/next-integrity]
[also build test ERROR on linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-J-Arges/ima-Fix-stack-out-of-bounds-in-is_bprm_creds_for_exec/20251220-035711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20251219195456.912190-1-carges%40cloudflare.com
patch subject: [PATCH] ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251220/202512201634.hYE4i2PX-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512201634.hYE4i2PX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512201634.hYE4i2PX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/integrity/ima/ima_main.c:429:32: error: too many arguments to function call, expected 7, have 8
     427 |                         rc = ima_appraise_measurement(func, iint, file,
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~
     428 |                                                       pathname, xattr_value,
     429 |                                                       xattr_len, modsig, bprm_is_check);
         |                                                                          ^~~~~~~~~~~~~
   security/integrity/ima/ima.h:463:19: note: 'ima_appraise_measurement' declared here
     463 | static inline int ima_appraise_measurement(enum ima_hooks func,
         |                   ^                        ~~~~~~~~~~~~~~~~~~~~
     464 |                                            struct ima_iint_cache *iint,
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     465 |                                            struct file *file,
         |                                            ~~~~~~~~~~~~~~~~~~
     466 |                                            const unsigned char *filename,
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     467 |                                            struct evm_ima_xattr_data *xattr_value,
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     468 |                                            int xattr_len,
         |                                            ~~~~~~~~~~~~~~
     469 |                                            const struct modsig *modsig)
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +429 security/integrity/ima/ima_main.c

   235	
   236	static int process_measurement(struct file *file, const struct cred *cred,
   237				       struct lsm_prop *prop, char *buf, loff_t size,
   238				       int mask, enum ima_hooks func,
   239				       enum kernel_read_file_id read_id, bool bprm_is_check)
   240	{
   241		struct inode *real_inode, *inode = file_inode(file);
   242		struct ima_iint_cache *iint = NULL;
   243		struct ima_template_desc *template_desc = NULL;
   244		struct inode *metadata_inode;
   245		char *pathbuf = NULL;
   246		char filename[NAME_MAX];
   247		const char *pathname = NULL;
   248		int rc = 0, action, must_appraise = 0;
   249		int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
   250		struct evm_ima_xattr_data *xattr_value = NULL;
   251		struct modsig *modsig = NULL;
   252		int xattr_len = 0;
   253		bool violation_check;
   254		enum hash_algo hash_algo;
   255		unsigned int allowed_algos = 0;
   256	
   257		if (!ima_policy_flag || !S_ISREG(inode->i_mode))
   258			return 0;
   259	
   260		/* Return an IMA_MEASURE, IMA_APPRAISE, IMA_AUDIT action
   261		 * bitmask based on the appraise/audit/measurement policy.
   262		 * Included is the appraise submask.
   263		 */
   264		action = ima_get_action(file_mnt_idmap(file), inode, cred, prop,
   265					mask, func, &pcr, &template_desc, NULL,
   266					&allowed_algos);
   267		violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
   268				    func == MMAP_CHECK_REQPROT) &&
   269				   (ima_policy_flag & IMA_MEASURE) &&
   270				   ((action & IMA_MEASURE) ||
   271				    (file->f_mode & FMODE_WRITE)));
   272		if (!action && !violation_check)
   273			return 0;
   274	
   275		must_appraise = action & IMA_APPRAISE;
   276	
   277		/*  Is the appraise rule hook specific?  */
   278		if (action & IMA_FILE_APPRAISE)
   279			func = FILE_CHECK;
   280	
   281		inode_lock(inode);
   282	
   283		if (action) {
   284			iint = ima_inode_get(inode);
   285			if (!iint)
   286				rc = -ENOMEM;
   287		}
   288	
   289		if (!rc && violation_check)
   290			ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
   291						 &pathbuf, &pathname, filename);
   292	
   293		inode_unlock(inode);
   294	
   295		if (rc)
   296			goto out;
   297		if (!action)
   298			goto out;
   299	
   300		mutex_lock(&iint->mutex);
   301	
   302		if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
   303			/*
   304			 * Reset appraisal flags (action and non-action rule-specific)
   305			 * if ima_inode_post_setattr was called.
   306			 */
   307			iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
   308					 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
   309					 IMA_NONACTION_RULE_FLAGS);
   310	
   311		/*
   312		 * Re-evaulate the file if either the xattr has changed or the
   313		 * kernel has no way of detecting file change on the filesystem.
   314		 * (Limited to privileged mounted filesystems.)
   315		 */
   316		if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
   317		    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
   318		     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
   319		     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
   320			iint->flags &= ~IMA_DONE_MASK;
   321			iint->measured_pcrs = 0;
   322		}
   323	
   324		/*
   325		 * On stacked filesystems, detect and re-evaluate file data and
   326		 * metadata changes.
   327		 */
   328		real_inode = d_real_inode(file_dentry(file));
   329		if (real_inode != inode &&
   330		    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
   331			if (!IS_I_VERSION(real_inode) ||
   332			    integrity_inode_attrs_changed(&iint->real_inode,
   333							  real_inode)) {
   334				iint->flags &= ~IMA_DONE_MASK;
   335				iint->measured_pcrs = 0;
   336			}
   337	
   338			/*
   339			 * Reset the EVM status when metadata changed.
   340			 */
   341			metadata_inode = d_inode(d_real(file_dentry(file),
   342						 D_REAL_METADATA));
   343			if (evm_metadata_changed(inode, metadata_inode))
   344				iint->flags &= ~(IMA_APPRAISED |
   345						 IMA_APPRAISED_SUBMASK);
   346		}
   347	
   348		/* Determine if already appraised/measured based on bitmask
   349		 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
   350		 *  IMA_AUDIT, IMA_AUDITED)
   351		 */
   352		iint->flags |= action;
   353		action &= IMA_DO_MASK;
   354		action &= ~((iint->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
   355	
   356		/* If target pcr is already measured, unset IMA_MEASURE action */
   357		if ((action & IMA_MEASURE) && (iint->measured_pcrs & (0x1 << pcr)))
   358			action ^= IMA_MEASURE;
   359	
   360		/* HASH sets the digital signature and update flags, nothing else */
   361		if ((action & IMA_HASH) &&
   362		    !(test_bit(IMA_DIGSIG, &iint->atomic_flags))) {
   363			xattr_len = ima_read_xattr(file_dentry(file),
   364						   &xattr_value, xattr_len);
   365			if ((xattr_value && xattr_len > 2) &&
   366			    (xattr_value->type == EVM_IMA_XATTR_DIGSIG))
   367				set_bit(IMA_DIGSIG, &iint->atomic_flags);
   368			iint->flags |= IMA_HASHED;
   369			action ^= IMA_HASH;
   370			set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
   371		}
   372	
   373		/* Nothing to do, just return existing appraised status */
   374		if (!action) {
   375			if (must_appraise) {
   376				rc = mmap_violation_check(func, file, &pathbuf,
   377							  &pathname, filename);
   378				if (!rc)
   379					rc = ima_get_cache_status(iint, func);
   380			}
   381			goto out_locked;
   382		}
   383	
   384		if ((action & IMA_APPRAISE_SUBMASK) ||
   385		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0) {
   386			/* read 'security.ima' */
   387			xattr_len = ima_read_xattr(file_dentry(file),
   388						   &xattr_value, xattr_len);
   389	
   390			/*
   391			 * Read the appended modsig if allowed by the policy, and allow
   392			 * an additional measurement list entry, if needed, based on the
   393			 * template format and whether the file was already measured.
   394			 */
   395			if (iint->flags & IMA_MODSIG_ALLOWED) {
   396				rc = ima_read_modsig(func, buf, size, &modsig);
   397	
   398				if (!rc && ima_template_has_modsig(template_desc) &&
   399				    iint->flags & IMA_MEASURED)
   400					action |= IMA_MEASURE;
   401			}
   402		}
   403	
   404		hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
   405	
   406		rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
   407		if (rc != 0 && rc != -EBADF && rc != -EINVAL)
   408			goto out_locked;
   409	
   410		/* Defer measuring/appraising kernel modules to READING_MODULE */
   411		if (read_id == READING_MODULE_COMPRESSED) {
   412			must_appraise = 0;
   413			goto out_locked;
   414		}
   415	
   416		if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
   417			pathname = ima_d_path(&file->f_path, &pathbuf, filename);
   418	
   419		if (action & IMA_MEASURE)
   420			ima_store_measurement(iint, file, pathname,
   421					      xattr_value, xattr_len, modsig, pcr,
   422					      template_desc);
   423		if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
   424			rc = ima_check_blacklist(iint, modsig, pcr);
   425			if (rc != -EPERM) {
   426				inode_lock(inode);
   427				rc = ima_appraise_measurement(func, iint, file,
   428							      pathname, xattr_value,
 > 429							      xattr_len, modsig, bprm_is_check);
   430				inode_unlock(inode);
   431			}
   432			if (!rc)
   433				rc = mmap_violation_check(func, file, &pathbuf,
   434							  &pathname, filename);
   435		}
   436		if (action & IMA_AUDIT)
   437			ima_audit_measurement(iint, pathname);
   438	
   439		if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
   440			rc = 0;
   441	
   442		/* Ensure the digest was generated using an allowed algorithm */
   443		if (rc == 0 && must_appraise && allowed_algos != 0 &&
   444		    (allowed_algos & (1U << hash_algo)) == 0) {
   445			rc = -EACCES;
   446	
   447			integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
   448					    pathname, "collect_data",
   449					    "denied-hash-algorithm", rc, 0);
   450		}
   451	out_locked:
   452		if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
   453		     !(iint->flags & IMA_NEW_FILE))
   454			rc = -EACCES;
   455		mutex_unlock(&iint->mutex);
   456		kfree(xattr_value);
   457		ima_free_modsig(modsig);
   458	out:
   459		if (pathbuf)
   460			__putname(pathbuf);
   461		if (must_appraise) {
   462			if (rc && (ima_appraise & IMA_APPRAISE_ENFORCE))
   463				return -EACCES;
   464			if (file->f_mode & FMODE_WRITE)
   465				set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
   466		}
   467		return 0;
   468	}
   469	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

