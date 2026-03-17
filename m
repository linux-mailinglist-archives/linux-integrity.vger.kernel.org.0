Return-Path: <linux-integrity+bounces-9003-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNK6NXYcuWm8rAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9003-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 10:18:46 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418E2A6744
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 10:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9CBB3028EA8
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55039EF15;
	Tue, 17 Mar 2026 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIbz4T/V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2236C5B4
	for <linux-integrity@vger.kernel.org>; Tue, 17 Mar 2026 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739051; cv=none; b=rf1kB0ZyKh2r5xod/OOk56CpmKnFR8mm3XeXO7CgM572e2kha6qE/+qRUMjpeCPugs1uDPXxzpHBtsj1VtsriKno9kzkUAoQc7TPtDhG1JtqQdxUqcrZ0FhLpTmA2evEcUO0naz4bsP+KRStQvpwkJIhMWcgN9DkaWka5fCpEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739051; c=relaxed/simple;
	bh=Oo5C74gSLvjpWx5l8lOVZYjD324Hln5Lo2lcxM0GgCg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EctBQ74zW9sXQiw4z4ZwmhFUeNHXHbdWFpvxNg1kTC5qmGYZZNavtsVnbxl2FiPUmpekoULqbTVvmuUg5GdonCLSyr0LNF5ToFpRTIZAXfrCJZZzBKHK6NbWhnAdw0qYX6xBYzzfILOTm7RbcG0uAktMFX5s/PlkvyZxaIw9nOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIbz4T/V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773739047; x=1805275047;
  h=date:from:to:cc:subject:message-id;
  bh=Oo5C74gSLvjpWx5l8lOVZYjD324Hln5Lo2lcxM0GgCg=;
  b=kIbz4T/VvUmk4yWY+8b6fZlLP/dEFbvVn/10huRfH32zQnnn5dVcuRJz
   DfR6kAYiazzZRJqNdQxCqryJFNEAr7qb/nK9kIkY21zVDUrNgKu+4hZfP
   DRCmWkdcmuSVGM5tFACDQv9W4iOd8CU2uNYVXkw56cX9JgrN2D8CpnvmR
   KZgPpucAFnxyoJyytntQvFz6d4qYtj0fzR/WkO0gvGwhsbg4ypnJ9tAlK
   6Ef0MHkc7OB61IoZqMTdIkwyWNS76jn1FOHaq8F72eR61sfgvVCv2sPBb
   OOMhDN6JXlMoKiejqPNgRmjP2vam30SYw/eZMdn8Ts4XUduXRl6uCm27w
   g==;
X-CSE-ConnectionGUID: 1nYRZmzzQyOM/nxmWs5oHg==
X-CSE-MsgGUID: 8tYoFjLnRdSBO+T67uFd0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78660445"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="78660445"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 02:17:26 -0700
X-CSE-ConnectionGUID: /c2GqzjjTmSc6c/uwI0f6g==
X-CSE-MsgGUID: P7ADY+oLQx6ZB3HqzcB2Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226674494"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Mar 2026 02:17:25 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2QYE-0000000009h-0mGC;
	Tue, 17 Mar 2026 09:17:22 +0000
Date: Tue, 17 Mar 2026 17:16:25 +0800
From: kernel test robot <lkp@intel.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-integrity@vger.kernel.org
Subject: [zohar-integrity:next-integrity.ima-sigv3-support-1 13/15]
 security/integrity/evm/evm_main.c:270:6: error: too many arguments to
 function call, expected 5, have 6
Message-ID: <202603171719.U8qaT87C-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9003-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 8418E2A6744
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity.ima-sigv3-support-1
head:   9037cd4a36eb9554fb5968a4c1a990d44843190b
commit: d45011bbc88d112e7eea4dbb9a1b3b0081d0b30a [13/15] ima: Define asymmetric_verify_v3() to verify IMA sigv3 signatures
config: i386-buildonly-randconfig-005-20260317 (https://download.01.org/0day-ci/archive/20260317/202603171719.U8qaT87C-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260317/202603171719.U8qaT87C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603171719.U8qaT87C-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/integrity/evm/evm_main.c:270:6: error: too many arguments to function call, expected 5, have 6
     267 |                 rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
         |                      ~~~~~~~~~~~~~~~~~~~~~~~
     268 |                                         (const char *)xattr_data, xattr_len,
     269 |                                         digest.digest, digest.hdr.length,
     270 |                                         digest.hdr.algo);
         |                                         ^~~~~~~~~~~~~~~
   security/integrity/evm/../integrity.h:143:19: note: 'integrity_digsig_verify' declared here
     143 | static inline int integrity_digsig_verify(const unsigned int id,
         |                   ^                       ~~~~~~~~~~~~~~~~~~~~~~
     144 |                                           const char *sig, int siglen,
         |                                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     145 |                                           const char *digest, int digestlen)
         |                                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +270 security/integrity/evm/evm_main.c

   172	
   173	/*
   174	 * evm_verify_hmac - calculate and compare the HMAC with the EVM xattr
   175	 *
   176	 * Compute the HMAC on the dentry's protected set of extended attributes
   177	 * and compare it against the stored security.evm xattr.
   178	 *
   179	 * For performance:
   180	 * - use the previously retrieved xattr value and length to calculate the
   181	 *   HMAC.)
   182	 * - cache the verification result in the iint, when available.
   183	 *
   184	 * Returns integrity status
   185	 */
   186	static enum integrity_status evm_verify_hmac(struct dentry *dentry,
   187						     const char *xattr_name,
   188						     char *xattr_value,
   189						     size_t xattr_value_len)
   190	{
   191		struct evm_ima_xattr_data *xattr_data = NULL;
   192		struct signature_v2_hdr *hdr;
   193		enum integrity_status evm_status = INTEGRITY_PASS;
   194		struct evm_digest digest;
   195		struct inode *inode = d_backing_inode(dentry);
   196		struct evm_iint_cache *iint = evm_iint_inode(inode);
   197		int rc, xattr_len, evm_immutable = 0;
   198	
   199		if (iint && (iint->evm_status == INTEGRITY_PASS ||
   200			     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
   201			return iint->evm_status;
   202	
   203		/*
   204		 * On unsupported filesystems without EVM_INIT_X509 enabled, skip
   205		 * signature verification.
   206		 */
   207		if (!(evm_initialized & EVM_INIT_X509) &&
   208		    is_unsupported_hmac_fs(dentry))
   209			return INTEGRITY_UNKNOWN;
   210	
   211		/* if status is not PASS, try to check again - against -ENOMEM */
   212	
   213		/* first need to know the sig type */
   214		rc = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, XATTR_NAME_EVM,
   215					(char **)&xattr_data, 0, GFP_NOFS);
   216		if (rc <= 0) {
   217			evm_status = INTEGRITY_FAIL;
   218			if (rc == -ENODATA) {
   219				rc = evm_find_protected_xattrs(dentry);
   220				if (rc > 0)
   221					evm_status = INTEGRITY_NOLABEL;
   222				else if (rc == 0)
   223					evm_status = INTEGRITY_NOXATTRS; /* new file */
   224			} else if (rc == -EOPNOTSUPP) {
   225				evm_status = INTEGRITY_UNKNOWN;
   226			}
   227			goto out;
   228		}
   229	
   230		xattr_len = rc;
   231	
   232		/* check value type */
   233		switch (xattr_data->type) {
   234		case EVM_XATTR_HMAC:
   235			if (xattr_len != sizeof(struct evm_xattr)) {
   236				evm_status = INTEGRITY_FAIL;
   237				goto out;
   238			}
   239	
   240			digest.hdr.algo = HASH_ALGO_SHA1;
   241			rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
   242					   xattr_value_len, &digest, iint);
   243			if (rc)
   244				break;
   245			rc = crypto_memneq(xattr_data->data, digest.digest,
   246					   SHA1_DIGEST_SIZE);
   247			if (rc)
   248				rc = -EINVAL;
   249			break;
   250		case EVM_XATTR_PORTABLE_DIGSIG:
   251			evm_immutable = 1;
   252			fallthrough;
   253		case EVM_IMA_XATTR_DIGSIG:
   254			/* accept xattr with non-empty signature field */
   255			if (xattr_len <= sizeof(struct signature_v2_hdr)) {
   256				evm_status = INTEGRITY_FAIL;
   257				goto out;
   258			}
   259	
   260			hdr = (struct signature_v2_hdr *)xattr_data;
   261			digest.hdr.algo = hdr->hash_algo;
   262			rc = evm_calc_hash(dentry, xattr_name, xattr_value,
   263					   xattr_value_len, xattr_data->type, &digest,
   264					   iint);
   265			if (rc)
   266				break;
   267			rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
   268						(const char *)xattr_data, xattr_len,
   269						digest.digest, digest.hdr.length,
 > 270						digest.hdr.algo);
   271			if (!rc) {
   272				if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
   273					if (iint)
   274						iint->flags |= EVM_IMMUTABLE_DIGSIG;
   275					evm_status = INTEGRITY_PASS_IMMUTABLE;
   276				} else if (!IS_RDONLY(inode) &&
   277					   !(inode->i_sb->s_readonly_remount) &&
   278					   !IS_IMMUTABLE(inode) &&
   279					   !is_unsupported_hmac_fs(dentry)) {
   280					evm_update_evmxattr(dentry, xattr_name,
   281							    xattr_value,
   282							    xattr_value_len);
   283				}
   284			}
   285			break;
   286		default:
   287			rc = -EINVAL;
   288			break;
   289		}
   290	
   291		if (rc) {
   292			if (rc == -ENODATA)
   293				evm_status = INTEGRITY_NOXATTRS;
   294			else if (evm_immutable)
   295				evm_status = INTEGRITY_FAIL_IMMUTABLE;
   296			else
   297				evm_status = INTEGRITY_FAIL;
   298		}
   299		pr_debug("digest: (%d) [%*phN]\n", digest.hdr.length, digest.hdr.length,
   300			  digest.digest);
   301	out:
   302		if (iint)
   303			iint->evm_status = evm_status;
   304		kfree(xattr_data);
   305		return evm_status;
   306	}
   307	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

