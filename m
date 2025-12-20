Return-Path: <linux-integrity+bounces-8128-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED99CD3518
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Dec 2025 19:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24DD9300D4AA
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Dec 2025 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A797288522;
	Sat, 20 Dec 2025 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdQFTHDq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1C1E3762;
	Sat, 20 Dec 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766255933; cv=none; b=HUxG8nteVOBDKuXUkSASfXCluwIDUe4IwlAOF2UtZfNfV3OzraCzdKk1uMfFmeQtOqQTroSSd4m0/CEdFiIYf4+aAIIBiYNCq9uawo0emzldYGcuD/ml8rqD4LCdrlYBvhAlVN2kt9h8rQvi9kjICksXyWiPEsoSW62F/H+gyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766255933; c=relaxed/simple;
	bh=sIv2/vz4KM5uQHFVZnr+fQ8fBs+RtrgrOEAyyUeI0P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYHN1EWscvgTCp67TTA8pbH4HpxuhkHgSmzOydg62NQMNYkNSgXoc2JweY+bxccC1hLe2A3aP+F+D18Y72oFO/yTt8gm44ZmdweTM4wVTuVi5fNz4YY8bmMeiAhsGBsrgXQJRQWy+8x1vP1oN0IOF0Rl/6OcglMC2zrG0Pk7RhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdQFTHDq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766255931; x=1797791931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sIv2/vz4KM5uQHFVZnr+fQ8fBs+RtrgrOEAyyUeI0P4=;
  b=HdQFTHDqHshq4M+F8KNfYfwKyS5pdyhZss1ELqIQDx8RLt2G1Z6OdDhr
   3p/Mw2T5tMzzHci5TrfpCJl3CKFAwtC/aBhZIYIDjRH91ZAIGbSdCDgJ1
   QKh8shWz24UJtDC+4CbUSQZcC16RA9G3ZKMIohhFxyWGIJvsqxznAjmcV
   3uSCmiIBAmg8K/Rlvv3hunoRd/irAV79lHkG2RYRXDkIQbYQ4FwJ4DRse
   xWDS0a7IphdsJh2aFICaVbvEMtHd/7n6BpY+dDBaNxfMZm/zIhZXlPkJ8
   o2b5edRedsRsCZ1d1/JANWw3EkP+WLOnslvibMSHjEW/2U4DIn6MihM3s
   g==;
X-CSE-ConnectionGUID: CpEHC/sqQNaBWy7qb0prZA==
X-CSE-MsgGUID: w7rhapQlTSOpY0W2ToBcuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="68228468"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="68228468"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 10:38:50 -0800
X-CSE-ConnectionGUID: DzXvQjlPRu2cJWiE2H02tg==
X-CSE-MsgGUID: 9oYV5tvTRNGvLk1YqVoopQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="198387665"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 20 Dec 2025 10:38:46 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX1ql-000000004kC-1vNi;
	Sat, 20 Dec 2025 18:38:43 +0000
Date: Sat, 20 Dec 2025 19:37:51 +0100
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
Message-ID: <202512201956.LY8Y70Fd-lkp@intel.com>
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
config: powerpc64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251220/202512201956.LY8Y70Fd-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512201956.LY8Y70Fd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512201956.LY8Y70Fd-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/integrity/ima/ima_main.c: In function 'process_measurement':
>> security/integrity/ima/ima_main.c:427:30: error: too many arguments to function 'ima_appraise_measurement'; expected 7, have 8
     427 |                         rc = ima_appraise_measurement(func, iint, file,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~
     428 |                                                       pathname, xattr_value,
     429 |                                                       xattr_len, modsig, bprm_is_check);
         |                                                                          ~~~~~~~~~~~~~
   In file included from security/integrity/ima/ima_main.c:32:
   security/integrity/ima/ima.h:463:19: note: declared here
     463 | static inline int ima_appraise_measurement(enum ima_hooks func,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/ima_appraise_measurement +427 security/integrity/ima/ima_main.c

3323eec921efd8 Mimi Zohar            2009-02-04  235  
d906c10d8a3165 Matthew Garrett       2018-01-08  236  static int process_measurement(struct file *file, const struct cred *cred,
37f670aacd4811 Casey Schaufler       2024-10-09  237  			       struct lsm_prop *prop, char *buf, loff_t size,
c200892b46ba3d Coiby Xu              2025-11-19  238  			       int mask, enum ima_hooks func,
073872ff30b34d Chris J Arges         2025-12-19  239  			       enum kernel_read_file_id read_id, bool bprm_is_check)
3323eec921efd8 Mimi Zohar            2009-02-04  240  {
c21632b66895eb Stefan Berger         2024-02-23  241  	struct inode *real_inode, *inode = file_inode(file);
4de2f084fbff41 Roberto Sassu         2024-02-15  242  	struct ima_iint_cache *iint = NULL;
19453ce0bcfbdf Matthew Garrett       2019-06-19  243  	struct ima_template_desc *template_desc = NULL;
cd9b909a117210 Stefan Berger         2024-02-23  244  	struct inode *metadata_inode;
ea1046d4c57ee6 Dmitry Kasatkin       2012-09-04  245  	char *pathbuf = NULL;
bc15ed663e7e53 Mimi Zohar            2017-01-17  246  	char filename[NAME_MAX];
ea1046d4c57ee6 Dmitry Kasatkin       2012-09-04  247  	const char *pathname = NULL;
0d73a55208e94f Dmitry Kasatkin       2017-12-05  248  	int rc = 0, action, must_appraise = 0;
725de7fabb9fe4 Eric Richter          2016-06-01  249  	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
1525b06d99b117 Dmitry Kasatkin       2014-10-30  250  	struct evm_ima_xattr_data *xattr_value = NULL;
39b07096364a42 Thiago Jung Bauermann 2019-06-27  251  	struct modsig *modsig = NULL;
d3634d0f426bde Dmitry Kasatkin       2013-04-25  252  	int xattr_len = 0;
f7a859ff7395c0 Roberto Sassu         2014-09-12  253  	bool violation_check;
1525b06d99b117 Dmitry Kasatkin       2014-10-30  254  	enum hash_algo hash_algo;
1624dc0086056c THOBY Simon           2021-08-16  255  	unsigned int allowed_algos = 0;
3323eec921efd8 Mimi Zohar            2009-02-04  256  
a756024efea259 Roberto Sassu         2014-09-12  257  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
3323eec921efd8 Mimi Zohar            2009-02-04  258  		return 0;
bc7d2a3e66b404 Eric Paris            2010-10-25  259  
d79d72e02485c0 Mimi Zohar            2012-12-03  260  	/* Return an IMA_MEASURE, IMA_APPRAISE, IMA_AUDIT action
d79d72e02485c0 Mimi Zohar            2012-12-03  261  	 * bitmask based on the appraise/audit/measurement policy.
d79d72e02485c0 Mimi Zohar            2012-12-03  262  	 * Included is the appraise submask.
d79d72e02485c0 Mimi Zohar            2012-12-03  263  	 */
37f670aacd4811 Casey Schaufler       2024-10-09  264  	action = ima_get_action(file_mnt_idmap(file), inode, cred, prop,
1624dc0086056c THOBY Simon           2021-08-16  265  				mask, func, &pcr, &template_desc, NULL,
1624dc0086056c THOBY Simon           2021-08-16  266  				&allowed_algos);
4958db3245fa65 Roberto Sassu         2023-01-31  267  	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
4958db3245fa65 Roberto Sassu         2023-01-31  268  			    func == MMAP_CHECK_REQPROT) &&
30d68cb0c37ebe Frederick Lawler      2025-03-27  269  			   (ima_policy_flag & IMA_MEASURE) &&
30d68cb0c37ebe Frederick Lawler      2025-03-27  270  			   ((action & IMA_MEASURE) ||
30d68cb0c37ebe Frederick Lawler      2025-03-27  271  			    (file->f_mode & FMODE_WRITE)));
f7a859ff7395c0 Roberto Sassu         2014-09-12  272  	if (!action && !violation_check)
2fe5d6def1672a Mimi Zohar            2012-02-13  273  		return 0;
2fe5d6def1672a Mimi Zohar            2012-02-13  274  
2fe5d6def1672a Mimi Zohar            2012-02-13  275  	must_appraise = action & IMA_APPRAISE;
bc7d2a3e66b404 Eric Paris            2010-10-25  276  
5a73fcfa8875a9 Mimi Zohar            2012-12-05  277  	/*  Is the appraise rule hook specific?  */
3a8a2eadc4946c Dmitry Kasatkin       2014-09-03  278  	if (action & IMA_FILE_APPRAISE)
4ad87a3d7444de Mimi Zohar            2016-01-14  279  		func = FILE_CHECK;
5a73fcfa8875a9 Mimi Zohar            2012-12-05  280  
5955102c9984fa Al Viro               2016-01-22  281  	inode_lock(inode);
2fe5d6def1672a Mimi Zohar            2012-02-13  282  
f7a859ff7395c0 Roberto Sassu         2014-09-12  283  	if (action) {
4de2f084fbff41 Roberto Sassu         2024-02-15  284  		iint = ima_inode_get(inode);
bf2276d10ce58f Dmitry Kasatkin       2011-10-19  285  		if (!iint)
0d73a55208e94f Dmitry Kasatkin       2017-12-05  286  			rc = -ENOMEM;
f7a859ff7395c0 Roberto Sassu         2014-09-12  287  	}
f7a859ff7395c0 Roberto Sassu         2014-09-12  288  
0d73a55208e94f Dmitry Kasatkin       2017-12-05  289  	if (!rc && violation_check)
1b68bdf9cded82 Roberto Sassu         2014-09-12  290  		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
4e8581eefe720f Roberto Sassu         2017-11-30  291  					 &pathbuf, &pathname, filename);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  292  
0d73a55208e94f Dmitry Kasatkin       2017-12-05  293  	inode_unlock(inode);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  294  
0d73a55208e94f Dmitry Kasatkin       2017-12-05  295  	if (rc)
0d73a55208e94f Dmitry Kasatkin       2017-12-05  296  		goto out;
0d73a55208e94f Dmitry Kasatkin       2017-12-05  297  	if (!action)
0d73a55208e94f Dmitry Kasatkin       2017-12-05  298  		goto out;
0d73a55208e94f Dmitry Kasatkin       2017-12-05  299  
0d73a55208e94f Dmitry Kasatkin       2017-12-05  300  	mutex_lock(&iint->mutex);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  301  
0d73a55208e94f Dmitry Kasatkin       2017-12-05  302  	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
57a0ef02fefafc Roberto Sassu         2025-02-04  303  		/*
57a0ef02fefafc Roberto Sassu         2025-02-04  304  		 * Reset appraisal flags (action and non-action rule-specific)
57a0ef02fefafc Roberto Sassu         2025-02-04  305  		 * if ima_inode_post_setattr was called.
57a0ef02fefafc Roberto Sassu         2025-02-04  306  		 */
0d73a55208e94f Dmitry Kasatkin       2017-12-05  307  		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
0d73a55208e94f Dmitry Kasatkin       2017-12-05  308  				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
57a0ef02fefafc Roberto Sassu         2025-02-04  309  				 IMA_NONACTION_RULE_FLAGS);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  310  
d77ccdc644a59b Mimi Zohar            2018-02-21  311  	/*
d77ccdc644a59b Mimi Zohar            2018-02-21  312  	 * Re-evaulate the file if either the xattr has changed or the
d77ccdc644a59b Mimi Zohar            2018-02-21  313  	 * kernel has no way of detecting file change on the filesystem.
d77ccdc644a59b Mimi Zohar            2018-02-21  314  	 * (Limited to privileged mounted filesystems.)
d77ccdc644a59b Mimi Zohar            2018-02-21  315  	 */
d77ccdc644a59b Mimi Zohar            2018-02-21  316  	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
d77ccdc644a59b Mimi Zohar            2018-02-21  317  	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
9e67028e76514a Mimi Zohar            2018-02-21  318  	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
9e67028e76514a Mimi Zohar            2018-02-21  319  	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
0d73a55208e94f Dmitry Kasatkin       2017-12-05  320  		iint->flags &= ~IMA_DONE_MASK;
d77ccdc644a59b Mimi Zohar            2018-02-21  321  		iint->measured_pcrs = 0;
d77ccdc644a59b Mimi Zohar            2018-02-21  322  	}
bf2276d10ce58f Dmitry Kasatkin       2011-10-19  323  
c21632b66895eb Stefan Berger         2024-02-23  324  	/*
cd9b909a117210 Stefan Berger         2024-02-23  325  	 * On stacked filesystems, detect and re-evaluate file data and
cd9b909a117210 Stefan Berger         2024-02-23  326  	 * metadata changes.
c21632b66895eb Stefan Berger         2024-02-23  327  	 */
c21632b66895eb Stefan Berger         2024-02-23  328  	real_inode = d_real_inode(file_dentry(file));
c21632b66895eb Stefan Berger         2024-02-23  329  	if (real_inode != inode &&
b836c4d29f2744 Mimi Zohar            2023-10-18  330  	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
c21632b66895eb Stefan Berger         2024-02-23  331  		if (!IS_I_VERSION(real_inode) ||
309e2b775da8b2 Stefan Berger         2024-02-23  332  		    integrity_inode_attrs_changed(&iint->real_inode,
309e2b775da8b2 Stefan Berger         2024-02-23  333  						  real_inode)) {
b836c4d29f2744 Mimi Zohar            2023-10-18  334  			iint->flags &= ~IMA_DONE_MASK;
b836c4d29f2744 Mimi Zohar            2023-10-18  335  			iint->measured_pcrs = 0;
b836c4d29f2744 Mimi Zohar            2023-10-18  336  		}
cd9b909a117210 Stefan Berger         2024-02-23  337  
cd9b909a117210 Stefan Berger         2024-02-23  338  		/*
cd9b909a117210 Stefan Berger         2024-02-23  339  		 * Reset the EVM status when metadata changed.
cd9b909a117210 Stefan Berger         2024-02-23  340  		 */
cd9b909a117210 Stefan Berger         2024-02-23  341  		metadata_inode = d_inode(d_real(file_dentry(file),
cd9b909a117210 Stefan Berger         2024-02-23  342  					 D_REAL_METADATA));
cd9b909a117210 Stefan Berger         2024-02-23  343  		if (evm_metadata_changed(inode, metadata_inode))
cd9b909a117210 Stefan Berger         2024-02-23  344  			iint->flags &= ~(IMA_APPRAISED |
cd9b909a117210 Stefan Berger         2024-02-23  345  					 IMA_APPRAISED_SUBMASK);
b836c4d29f2744 Mimi Zohar            2023-10-18  346  	}
b836c4d29f2744 Mimi Zohar            2023-10-18  347  
2fe5d6def1672a Mimi Zohar            2012-02-13  348  	/* Determine if already appraised/measured based on bitmask
d79d72e02485c0 Mimi Zohar            2012-12-03  349  	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
d79d72e02485c0 Mimi Zohar            2012-12-03  350  	 *  IMA_AUDIT, IMA_AUDITED)
d79d72e02485c0 Mimi Zohar            2012-12-03  351  	 */
2fe5d6def1672a Mimi Zohar            2012-02-13  352  	iint->flags |= action;
0e5a247cb37a97 Dmitry Kasatkin       2012-06-08  353  	action &= IMA_DO_MASK;
a422638d492a35 Eric Richter          2016-06-01  354  	action &= ~((iint->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
a422638d492a35 Eric Richter          2016-06-01  355  
a422638d492a35 Eric Richter          2016-06-01  356  	/* If target pcr is already measured, unset IMA_MEASURE action */
a422638d492a35 Eric Richter          2016-06-01  357  	if ((action & IMA_MEASURE) && (iint->measured_pcrs & (0x1 << pcr)))
a422638d492a35 Eric Richter          2016-06-01  358  		action ^= IMA_MEASURE;
2fe5d6def1672a Mimi Zohar            2012-02-13  359  
da1b0029f527a9 Mimi Zohar            2016-09-29  360  	/* HASH sets the digital signature and update flags, nothing else */
da1b0029f527a9 Mimi Zohar            2016-09-29  361  	if ((action & IMA_HASH) &&
da1b0029f527a9 Mimi Zohar            2016-09-29  362  	    !(test_bit(IMA_DIGSIG, &iint->atomic_flags))) {
f6fbd8cbf3ed19 Paul Moore            2022-11-09  363  		xattr_len = ima_read_xattr(file_dentry(file),
f6fbd8cbf3ed19 Paul Moore            2022-11-09  364  					   &xattr_value, xattr_len);
da1b0029f527a9 Mimi Zohar            2016-09-29  365  		if ((xattr_value && xattr_len > 2) &&
da1b0029f527a9 Mimi Zohar            2016-09-29  366  		    (xattr_value->type == EVM_IMA_XATTR_DIGSIG))
da1b0029f527a9 Mimi Zohar            2016-09-29  367  			set_bit(IMA_DIGSIG, &iint->atomic_flags);
da1b0029f527a9 Mimi Zohar            2016-09-29  368  		iint->flags |= IMA_HASHED;
da1b0029f527a9 Mimi Zohar            2016-09-29  369  		action ^= IMA_HASH;
da1b0029f527a9 Mimi Zohar            2016-09-29  370  		set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
da1b0029f527a9 Mimi Zohar            2016-09-29  371  	}
da1b0029f527a9 Mimi Zohar            2016-09-29  372  
2fe5d6def1672a Mimi Zohar            2012-02-13  373  	/* Nothing to do, just return existing appraised status */
2fe5d6def1672a Mimi Zohar            2012-02-13  374  	if (!action) {
2cd4737bc85022 Mimi Zohar            2019-04-30  375  		if (must_appraise) {
2cd4737bc85022 Mimi Zohar            2019-04-30  376  			rc = mmap_violation_check(func, file, &pathbuf,
2cd4737bc85022 Mimi Zohar            2019-04-30  377  						  &pathname, filename);
2cd4737bc85022 Mimi Zohar            2019-04-30  378  			if (!rc)
4ad87a3d7444de Mimi Zohar            2016-01-14  379  				rc = ima_get_cache_status(iint, func);
2cd4737bc85022 Mimi Zohar            2019-04-30  380  		}
0d73a55208e94f Dmitry Kasatkin       2017-12-05  381  		goto out_locked;
2fe5d6def1672a Mimi Zohar            2012-02-13  382  	}
3323eec921efd8 Mimi Zohar            2009-02-04  383  
f68c05f4d2d4e1 Dmitry Kasatkin       2014-08-22  384  	if ((action & IMA_APPRAISE_SUBMASK) ||
39b07096364a42 Thiago Jung Bauermann 2019-06-27  385  	    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0) {
1525b06d99b117 Dmitry Kasatkin       2014-10-30  386  		/* read 'security.ima' */
f6fbd8cbf3ed19 Paul Moore            2022-11-09  387  		xattr_len = ima_read_xattr(file_dentry(file),
f6fbd8cbf3ed19 Paul Moore            2022-11-09  388  					   &xattr_value, xattr_len);
d3634d0f426bde Dmitry Kasatkin       2013-04-25  389  
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  390  		/*
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  391  		 * Read the appended modsig if allowed by the policy, and allow
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  392  		 * an additional measurement list entry, if needed, based on the
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  393  		 * template format and whether the file was already measured.
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  394  		 */
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  395  		if (iint->flags & IMA_MODSIG_ALLOWED) {
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  396  			rc = ima_read_modsig(func, buf, size, &modsig);
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  397  
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  398  			if (!rc && ima_template_has_modsig(template_desc) &&
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  399  			    iint->flags & IMA_MEASURED)
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  400  				action |= IMA_MEASURE;
e5092255bb3967 Thiago Jung Bauermann 2019-06-27  401  		}
39b07096364a42 Thiago Jung Bauermann 2019-06-27  402  	}
39b07096364a42 Thiago Jung Bauermann 2019-06-27  403  
1525b06d99b117 Dmitry Kasatkin       2014-10-30  404  	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
1525b06d99b117 Dmitry Kasatkin       2014-10-30  405  
15588227e086ec Thiago Jung Bauermann 2019-06-27  406  	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
6dc387d52eb67f Matt Bobrowski        2023-01-04  407  	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
0d73a55208e94f Dmitry Kasatkin       2017-12-05  408  		goto out_locked;
08e1b76ae399a0 Mimi Zohar            2012-06-20  409  
c200892b46ba3d Coiby Xu              2025-11-19  410  	/* Defer measuring/appraising kernel modules to READING_MODULE */
c200892b46ba3d Coiby Xu              2025-11-19  411  	if (read_id == READING_MODULE_COMPRESSED) {
c200892b46ba3d Coiby Xu              2025-11-19  412  		must_appraise = 0;
c200892b46ba3d Coiby Xu              2025-11-19  413  		goto out_locked;
c200892b46ba3d Coiby Xu              2025-11-19  414  	}
c200892b46ba3d Coiby Xu              2025-11-19  415  
bc15ed663e7e53 Mimi Zohar            2017-01-17  416  	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
bc15ed663e7e53 Mimi Zohar            2017-01-17  417  		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
08e1b76ae399a0 Mimi Zohar            2012-06-20  418  
2fe5d6def1672a Mimi Zohar            2012-02-13  419  	if (action & IMA_MEASURE)
bcbc9b0cf6d8f3 Mimi Zohar            2013-07-23  420  		ima_store_measurement(iint, file, pathname,
3878d505aa718b Thiago Jung Bauermann 2019-06-27  421  				      xattr_value, xattr_len, modsig, pcr,
19453ce0bcfbdf Matthew Garrett       2019-06-19  422  				      template_desc);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  423  	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
273df864cf7466 Nayna Jain            2019-10-30  424  		rc = ima_check_blacklist(iint, modsig, pcr);
273df864cf7466 Nayna Jain            2019-10-30  425  		if (rc != -EPERM) {
0d73a55208e94f Dmitry Kasatkin       2017-12-05  426  			inode_lock(inode);
273df864cf7466 Nayna Jain            2019-10-30 @427  			rc = ima_appraise_measurement(func, iint, file,
273df864cf7466 Nayna Jain            2019-10-30  428  						      pathname, xattr_value,
073872ff30b34d Chris J Arges         2025-12-19  429  						      xattr_len, modsig, bprm_is_check);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  430  			inode_unlock(inode);
273df864cf7466 Nayna Jain            2019-10-30  431  		}
2cd4737bc85022 Mimi Zohar            2019-04-30  432  		if (!rc)
2cd4737bc85022 Mimi Zohar            2019-04-30  433  			rc = mmap_violation_check(func, file, &pathbuf,
2cd4737bc85022 Mimi Zohar            2019-04-30  434  						  &pathname, filename);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  435  	}
e7c568e0fd0cf6 Peter Moody           2012-06-14  436  	if (action & IMA_AUDIT)
ea1046d4c57ee6 Dmitry Kasatkin       2012-09-04  437  		ima_audit_measurement(iint, pathname);
f7a859ff7395c0 Roberto Sassu         2014-09-12  438  
f3cc6b25dcc561 Mimi Zohar            2017-06-17  439  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
f3cc6b25dcc561 Mimi Zohar            2017-06-17  440  		rc = 0;
1624dc0086056c THOBY Simon           2021-08-16  441  
1624dc0086056c THOBY Simon           2021-08-16  442  	/* Ensure the digest was generated using an allowed algorithm */
1624dc0086056c THOBY Simon           2021-08-16  443  	if (rc == 0 && must_appraise && allowed_algos != 0 &&
1624dc0086056c THOBY Simon           2021-08-16  444  	    (allowed_algos & (1U << hash_algo)) == 0) {
1624dc0086056c THOBY Simon           2021-08-16  445  		rc = -EACCES;
1624dc0086056c THOBY Simon           2021-08-16  446  
1624dc0086056c THOBY Simon           2021-08-16  447  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
1624dc0086056c THOBY Simon           2021-08-16  448  				    pathname, "collect_data",
1624dc0086056c THOBY Simon           2021-08-16  449  				    "denied-hash-algorithm", rc, 0);
1624dc0086056c THOBY Simon           2021-08-16  450  	}
0d73a55208e94f Dmitry Kasatkin       2017-12-05  451  out_locked:
0d73a55208e94f Dmitry Kasatkin       2017-12-05  452  	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
05d1a717ec0430 Mimi Zohar            2016-02-29  453  	     !(iint->flags & IMA_NEW_FILE))
a175b8bb29ebba Dmitry Kasatkin       2012-09-27  454  		rc = -EACCES;
0d73a55208e94f Dmitry Kasatkin       2017-12-05  455  	mutex_unlock(&iint->mutex);
f7a859ff7395c0 Roberto Sassu         2014-09-12  456  	kfree(xattr_value);
39b07096364a42 Thiago Jung Bauermann 2019-06-27  457  	ima_free_modsig(modsig);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  458  out:
456f5fd3f6017f Dmitry Kasatkin       2014-10-01  459  	if (pathbuf)
456f5fd3f6017f Dmitry Kasatkin       2014-10-01  460  		__putname(pathbuf);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  461  	if (must_appraise) {
0d73a55208e94f Dmitry Kasatkin       2017-12-05  462  		if (rc && (ima_appraise & IMA_APPRAISE_ENFORCE))
750943a30714b7 Dmitry Kasatkin       2012-09-27  463  			return -EACCES;
0d73a55208e94f Dmitry Kasatkin       2017-12-05  464  		if (file->f_mode & FMODE_WRITE)
0d73a55208e94f Dmitry Kasatkin       2017-12-05  465  			set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
0d73a55208e94f Dmitry Kasatkin       2017-12-05  466  	}
750943a30714b7 Dmitry Kasatkin       2012-09-27  467  	return 0;
3323eec921efd8 Mimi Zohar            2009-02-04  468  }
3323eec921efd8 Mimi Zohar            2009-02-04  469  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

