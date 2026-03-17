Return-Path: <linux-integrity+bounces-9004-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A1EJbNDuWmK+QEAu9opvQ
	(envelope-from <linux-integrity+bounces-9004-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 13:06:11 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B0A2A9806
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 13:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C57730B8E4B
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A15345CC0;
	Tue, 17 Mar 2026 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6YE142E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6707345CA1
	for <linux-integrity@vger.kernel.org>; Tue, 17 Mar 2026 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748977; cv=none; b=tJW1jy554Znt7pleS2Bp7w6PNJ+8AwryXOGsSCzA1zp5KuCcCCN+3+6WBumb5VG54XdIPIxhTm3fwMYjycVPz4jTIZqkSCXz3CduV5GoJV7Kr6yGj6qr4OdSuEwLq+oUoI2g3k+DDF7ApMe7yq/H5m6tVef6jV21ykvRvrgUsX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748977; c=relaxed/simple;
	bh=0ghWhRMo/zBQOajsrpPrLiom8CQEziJRRTiCKNRPSTw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ngYljVqKb9T6zX3vVmjaaLRvxp7A0Nn0zUERhVjQ3ZOOCbvqoCh4k8tyETc0wZh+AHKdXgTbbAPz8fMzaAvEkED8Eh6TDuk8nEYSvgS56spyucOeDa2Gd/KicdQrpRj9VSTNscjuUm+o28voOFgtm5VKDJyx0fOxvEnty4CJphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6YE142E; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773748976; x=1805284976;
  h=date:from:to:cc:subject:message-id;
  bh=0ghWhRMo/zBQOajsrpPrLiom8CQEziJRRTiCKNRPSTw=;
  b=B6YE142EMbhZi4sKH9gzrxU2X+ssM69LMB2WaNklHoRLMTFzAKdQYctH
   gfCVs6HLkCr+towYqmVadR9Y8YJXzouB2XmOxwQsShdg2LQ+Dx9I8sloN
   P1Zohj60r2gz0RSyEQ8tpfP/sXS2k7W8SveZUMONnEh3KFSK/t6ncZPR0
   zV/IHCiZ47ns7/jFNGxLgJtAWEW49q+NTcZVj+6LYTc/8345FJXU8papZ
   wnVnXMZbTN1Qi0ZnBa7nn5KNKtZykBTmDaYtdm9CBZJdySj4N1wqUhX0w
   SbGq+KrWAWVMBX2yCadLr9t0Uhxb/H6KE41eOGCT+6eBv/4boqQKpBUcr
   w==;
X-CSE-ConnectionGUID: rDxRcyvPTOmhYPn4+d0oDA==
X-CSE-MsgGUID: 8leGn41NQt+loYdg+7vW4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85477112"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85477112"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 05:02:55 -0700
X-CSE-ConnectionGUID: IhT40Ia/Tf+zOAGwGjXOMg==
X-CSE-MsgGUID: Q5vVrOmiQD6J235GZb0mbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="260153773"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 Mar 2026 05:02:53 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2T8M-000000000MF-47KT;
	Tue, 17 Mar 2026 12:02:50 +0000
Date: Tue, 17 Mar 2026 20:02:23 +0800
From: kernel test robot <lkp@intel.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-integrity@vger.kernel.org
Subject: [zohar-integrity:next-integrity.ima-sigv3-support-1 13/15]
 security/integrity/evm/evm_main.c:267:22: error: too many arguments to
 function 'integrity_digsig_verify'
Message-ID: <202603171952.z3Qgv7vC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9004-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: B8B0A2A9806
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity.ima-sigv3-support-1
head:   9037cd4a36eb9554fb5968a4c1a990d44843190b
commit: d45011bbc88d112e7eea4dbb9a1b3b0081d0b30a [13/15] ima: Define asymmetric_verify_v3() to verify IMA sigv3 signatures
config: i386-randconfig-006-20260317 (https://download.01.org/0day-ci/archive/20260317/202603171952.z3Qgv7vC-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260317/202603171952.z3Qgv7vC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603171952.z3Qgv7vC-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/integrity/evm/evm_main.c: In function 'evm_verify_hmac':
>> security/integrity/evm/evm_main.c:267:22: error: too many arguments to function 'integrity_digsig_verify'
     267 |                 rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from security/integrity/evm/evm.h:18,
                    from security/integrity/evm/evm_main.c:28:
   security/integrity/evm/../integrity.h:143:19: note: declared here
     143 | static inline int integrity_digsig_verify(const unsigned int id,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~


vim +/integrity_digsig_verify +267 security/integrity/evm/evm_main.c

cd708c938f055c Mimi Zohar            2023-12-18  172  
66dbc325afcef9 Mimi Zohar            2011-03-15  173  /*
66dbc325afcef9 Mimi Zohar            2011-03-15  174   * evm_verify_hmac - calculate and compare the HMAC with the EVM xattr
66dbc325afcef9 Mimi Zohar            2011-03-15  175   *
66dbc325afcef9 Mimi Zohar            2011-03-15  176   * Compute the HMAC on the dentry's protected set of extended attributes
7102ebcd65c1cd Mimi Zohar            2011-05-12  177   * and compare it against the stored security.evm xattr.
7102ebcd65c1cd Mimi Zohar            2011-05-12  178   *
7102ebcd65c1cd Mimi Zohar            2011-05-12  179   * For performance:
ceb5faef848b2f Tanya Agarwal         2025-01-24  180   * - use the previously retrieved xattr value and length to calculate the
66dbc325afcef9 Mimi Zohar            2011-03-15  181   *   HMAC.)
7102ebcd65c1cd Mimi Zohar            2011-05-12  182   * - cache the verification result in the iint, when available.
66dbc325afcef9 Mimi Zohar            2011-03-15  183   *
66dbc325afcef9 Mimi Zohar            2011-03-15  184   * Returns integrity status
66dbc325afcef9 Mimi Zohar            2011-03-15  185   */
66dbc325afcef9 Mimi Zohar            2011-03-15  186  static enum integrity_status evm_verify_hmac(struct dentry *dentry,
66dbc325afcef9 Mimi Zohar            2011-03-15  187  					     const char *xattr_name,
66dbc325afcef9 Mimi Zohar            2011-03-15  188  					     char *xattr_value,
75a323e604fc77 Roberto Sassu         2024-02-15  189  					     size_t xattr_value_len)
66dbc325afcef9 Mimi Zohar            2011-03-15  190  {
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  191  	struct evm_ima_xattr_data *xattr_data = NULL;
5feeb61183dde9 Matthew Garrett       2018-06-08  192  	struct signature_v2_hdr *hdr;
566be59ab86c0e Mimi Zohar            2011-08-22  193  	enum integrity_status evm_status = INTEGRITY_PASS;
5feeb61183dde9 Matthew Garrett       2018-06-08  194  	struct evm_digest digest;
75a323e604fc77 Roberto Sassu         2024-02-15  195  	struct inode *inode = d_backing_inode(dentry);
75a323e604fc77 Roberto Sassu         2024-02-15  196  	struct evm_iint_cache *iint = evm_iint_inode(inode);
cdef685be5b4ae Roberto Sassu         2021-05-14  197  	int rc, xattr_len, evm_immutable = 0;
66dbc325afcef9 Mimi Zohar            2011-03-15  198  
50b977481fce90 Matthew Garrett       2017-11-07  199  	if (iint && (iint->evm_status == INTEGRITY_PASS ||
50b977481fce90 Matthew Garrett       2017-11-07  200  		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
24e0198efe0df5 Dmitry Kasatkin       2011-05-06  201  		return iint->evm_status;
66dbc325afcef9 Mimi Zohar            2011-03-15  202  
47add87ad18147 Stefan Berger         2024-02-23  203  	/*
47add87ad18147 Stefan Berger         2024-02-23  204  	 * On unsupported filesystems without EVM_INIT_X509 enabled, skip
47add87ad18147 Stefan Berger         2024-02-23  205  	 * signature verification.
47add87ad18147 Stefan Berger         2024-02-23  206  	 */
5e2e4d0ea5c2c8 Stefan Berger         2024-02-23  207  	if (!(evm_initialized & EVM_INIT_X509) &&
5e2e4d0ea5c2c8 Stefan Berger         2024-02-23  208  	    is_unsupported_hmac_fs(dentry))
cd708c938f055c Mimi Zohar            2023-12-18  209  		return INTEGRITY_UNKNOWN;
cd708c938f055c Mimi Zohar            2023-12-18  210  
6d38ca01c0c2d6 Dmitry Kasatkin       2011-05-06  211  	/* if status is not PASS, try to check again - against -ENOMEM */
6d38ca01c0c2d6 Dmitry Kasatkin       2011-05-06  212  
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  213  	/* first need to know the sig type */
4609e1f18e19c3 Christian Brauner     2023-01-13  214  	rc = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, XATTR_NAME_EVM,
c7c7a1a18af4c3 Tycho Andersen        2021-01-21  215  				(char **)&xattr_data, 0, GFP_NOFS);
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  216  	if (rc <= 0) {
1f1009791b2e81 Dmitry Kasatkin       2014-08-15  217  		evm_status = INTEGRITY_FAIL;
1f1009791b2e81 Dmitry Kasatkin       2014-08-15  218  		if (rc == -ENODATA) {
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  219  			rc = evm_find_protected_xattrs(dentry);
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  220  			if (rc > 0)
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  221  				evm_status = INTEGRITY_NOLABEL;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  222  			else if (rc == 0)
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  223  				evm_status = INTEGRITY_NOXATTRS; /* new file */
1f1009791b2e81 Dmitry Kasatkin       2014-08-15  224  		} else if (rc == -EOPNOTSUPP) {
1f1009791b2e81 Dmitry Kasatkin       2014-08-15  225  			evm_status = INTEGRITY_UNKNOWN;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  226  		}
566be59ab86c0e Mimi Zohar            2011-08-22  227  		goto out;
566be59ab86c0e Mimi Zohar            2011-08-22  228  	}
66dbc325afcef9 Mimi Zohar            2011-03-15  229  
b1aaab22e263d0 Dmitry Kasatkin       2013-10-10  230  	xattr_len = rc;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  231  
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  232  	/* check value type */
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  233  	switch (xattr_data->type) {
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  234  	case EVM_XATTR_HMAC:
650b29dbdf2caf Thiago Jung Bauermann 2019-06-11  235  		if (xattr_len != sizeof(struct evm_xattr)) {
b4bfec7f4a8642 Seth Forshee          2016-08-01  236  			evm_status = INTEGRITY_FAIL;
b4bfec7f4a8642 Seth Forshee          2016-08-01  237  			goto out;
b4bfec7f4a8642 Seth Forshee          2016-08-01  238  		}
5feeb61183dde9 Matthew Garrett       2018-06-08  239  
5feeb61183dde9 Matthew Garrett       2018-06-08  240  		digest.hdr.algo = HASH_ALGO_SHA1;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  241  		rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
a652aa59068bd7 Stefan Berger         2024-02-23  242  				   xattr_value_len, &digest, iint);
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  243  		if (rc)
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  244  			break;
650b29dbdf2caf Thiago Jung Bauermann 2019-06-11  245  		rc = crypto_memneq(xattr_data->data, digest.digest,
5feeb61183dde9 Matthew Garrett       2018-06-08  246  				   SHA1_DIGEST_SIZE);
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  247  		if (rc)
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  248  			rc = -EINVAL;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  249  		break;
50b977481fce90 Matthew Garrett       2017-11-07  250  	case EVM_XATTR_PORTABLE_DIGSIG:
cdef685be5b4ae Roberto Sassu         2021-05-14  251  		evm_immutable = 1;
cdef685be5b4ae Roberto Sassu         2021-05-14  252  		fallthrough;
cdef685be5b4ae Roberto Sassu         2021-05-14  253  	case EVM_IMA_XATTR_DIGSIG:
455b6c9112eff8 Roberto Sassu         2020-09-04  254  		/* accept xattr with non-empty signature field */
455b6c9112eff8 Roberto Sassu         2020-09-04  255  		if (xattr_len <= sizeof(struct signature_v2_hdr)) {
455b6c9112eff8 Roberto Sassu         2020-09-04  256  			evm_status = INTEGRITY_FAIL;
455b6c9112eff8 Roberto Sassu         2020-09-04  257  			goto out;
455b6c9112eff8 Roberto Sassu         2020-09-04  258  		}
455b6c9112eff8 Roberto Sassu         2020-09-04  259  
5feeb61183dde9 Matthew Garrett       2018-06-08  260  		hdr = (struct signature_v2_hdr *)xattr_data;
5feeb61183dde9 Matthew Garrett       2018-06-08  261  		digest.hdr.algo = hdr->hash_algo;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  262  		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
a652aa59068bd7 Stefan Berger         2024-02-23  263  				   xattr_value_len, xattr_data->type, &digest,
a652aa59068bd7 Stefan Berger         2024-02-23  264  				   iint);
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  265  		if (rc)
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  266  			break;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01 @267  		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
b1aaab22e263d0 Dmitry Kasatkin       2013-10-10  268  					(const char *)xattr_data, xattr_len,
d45011bbc88d11 Mimi Zohar            2026-03-10  269  					digest.digest, digest.hdr.length,
d45011bbc88d11 Mimi Zohar            2026-03-10  270  					digest.hdr.algo);
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  271  		if (!rc) {
50b977481fce90 Matthew Garrett       2017-11-07  272  			if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
50b977481fce90 Matthew Garrett       2017-11-07  273  				if (iint)
50b977481fce90 Matthew Garrett       2017-11-07  274  					iint->flags |= EVM_IMMUTABLE_DIGSIG;
50b977481fce90 Matthew Garrett       2017-11-07  275  				evm_status = INTEGRITY_PASS_IMMUTABLE;
70946c4ac2a9e0 Sascha Hauer          2018-03-01  276  			} else if (!IS_RDONLY(inode) &&
70946c4ac2a9e0 Sascha Hauer          2018-03-01  277  				   !(inode->i_sb->s_readonly_remount) &&
47add87ad18147 Stefan Berger         2024-02-23  278  				   !IS_IMMUTABLE(inode) &&
5e2e4d0ea5c2c8 Stefan Berger         2024-02-23  279  				   !is_unsupported_hmac_fs(dentry)) {
c2baec7ffaf6a2 Dmitry Kasatkin       2014-10-01  280  				evm_update_evmxattr(dentry, xattr_name,
c2baec7ffaf6a2 Dmitry Kasatkin       2014-10-01  281  						    xattr_value,
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  282  						    xattr_value_len);
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  283  			}
50b977481fce90 Matthew Garrett       2017-11-07  284  		}
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  285  		break;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  286  	default:
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  287  		rc = -EINVAL;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  288  		break;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  289  	}
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  290  
cdef685be5b4ae Roberto Sassu         2021-05-14  291  	if (rc) {
cdef685be5b4ae Roberto Sassu         2021-05-14  292  		if (rc == -ENODATA)
cdef685be5b4ae Roberto Sassu         2021-05-14  293  			evm_status = INTEGRITY_NOXATTRS;
cdef685be5b4ae Roberto Sassu         2021-05-14  294  		else if (evm_immutable)
cdef685be5b4ae Roberto Sassu         2021-05-14  295  			evm_status = INTEGRITY_FAIL_IMMUTABLE;
cdef685be5b4ae Roberto Sassu         2021-05-14  296  		else
cdef685be5b4ae Roberto Sassu         2021-05-14  297  			evm_status = INTEGRITY_FAIL;
cdef685be5b4ae Roberto Sassu         2021-05-14  298  	}
87ac3d002d567f Mimi Zohar            2021-05-13  299  	pr_debug("digest: (%d) [%*phN]\n", digest.hdr.length, digest.hdr.length,
87ac3d002d567f Mimi Zohar            2021-05-13  300  		  digest.digest);
7102ebcd65c1cd Mimi Zohar            2011-05-12  301  out:
7102ebcd65c1cd Mimi Zohar            2011-05-12  302  	if (iint)
7102ebcd65c1cd Mimi Zohar            2011-05-12  303  		iint->evm_status = evm_status;
15647eb3985ef3 Dmitry Kasatkin       2011-09-01  304  	kfree(xattr_data);
7102ebcd65c1cd Mimi Zohar            2011-05-12  305  	return evm_status;
66dbc325afcef9 Mimi Zohar            2011-03-15  306  }
66dbc325afcef9 Mimi Zohar            2011-03-15  307  

:::::: The code at line 267 was first introduced by commit
:::::: 15647eb3985ef30dfd657038924dc85c03026733 evm: digital signature verification support

:::::: TO: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
:::::: CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

