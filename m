Return-Path: <linux-integrity+bounces-7438-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C3BE1655
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Oct 2025 05:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444BC4EC299
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Oct 2025 03:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302BC219E8D;
	Thu, 16 Oct 2025 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFuoeJjg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7852147F9
	for <linux-integrity@vger.kernel.org>; Thu, 16 Oct 2025 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760586923; cv=none; b=lT8gci2gnvgQEtYsIVtIAAwDGreXuP8mvq3KHRBUywmXnVvxzCuruLBPnuqAuhHh0SRkGVU3mECxUxNSDjDlPA5RUO7O4r1iowK7YwtVtf4J7Sjt23TfOp2Fie9XDFknnWwzvPa4aSccdC0RS7pZmYuv9DOSva7luAeXSIAoL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760586923; c=relaxed/simple;
	bh=uyz1GY4+vfaKF69cegJW5F5FnUUtXIpdHDZD1SOvAZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk+6U1RLv/9/prdgcJrgCXt2iM/MfQTwhelzPXZ0C7beJQzTSHcMTrYQ0UC6KsKqgexZ47Pby0zXiebFIyEKfJozvzmtfgt+1nlvPD2Jkzao9rxJriZyeMRsi22jyUZvKdRkZ8P0CJQvUi2FoQfrKBcmRfpEH708wcyOceBIvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFuoeJjg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760586919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zc86LD6zugfOCllRI8l5UX622RRX/t1Ywr+EQbxvvEc=;
	b=QFuoeJjgw5KcElF91/mRLiXzjB8mHs3Epsgf8JvwNRWu5yy4NL3uiDi6d+S2ehDkQH8Yod
	ToWcngKQyreJJQ7BISZQ7JLiXaAneoJj0YktfzmT1wX0tO8vvHoyaFrJpaMuBBEM+JAh2A
	AEpuhwVA7LcipjmyGg0NIGJIggJ9kTo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-bMXHUWSdOK2QgwdTJ0bE9w-1; Wed, 15 Oct 2025 23:55:16 -0400
X-MC-Unique: bMXHUWSdOK2QgwdTJ0bE9w-1
X-Mimecast-MFC-AGG-ID: bMXHUWSdOK2QgwdTJ0bE9w_1760586915
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so275845a91.3
        for <linux-integrity@vger.kernel.org>; Wed, 15 Oct 2025 20:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760586915; x=1761191715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc86LD6zugfOCllRI8l5UX622RRX/t1Ywr+EQbxvvEc=;
        b=dEtyNYqdg3d/w5fsASPPOCjuhX5FICqoymQpo5Dxm8bGOdgmlvh8nFFZ62LYL7JG34
         2VXWXpoUXMiv3GSBm2cnhxMtskINpyNN889G7N11Gkg188z4TO17K9cPSqVAnEgzh+yR
         cu9Soj+ozimmW2EQVLshFdxT08IrN4zTDzreuAL01MeJpyOaCbE/5GCcZZ84SD+0mule
         ga/0hxR/OzVCNeE2T1pgbbca08vzzkyZGq6ErXw3QlRiycnt4MrgFcvSQ9K3RJWvIIqk
         d7uUeQv09JHcviNdl+prLzbaDSSkvzEV0fMlHG07pptwpweRo1hvMw8+itBSlmDZRtti
         KNdQ==
X-Gm-Message-State: AOJu0YwHv3DaNL3st9JLXz95GLijEMJ6wBoMxbCKplH9CnxotR0QTFGU
	eER8Z9aCNTcJdYfjzm72oIvqpWj1Z1aYgSUHyyVDweLmUzFQHbTA/vYYOide+Gwd4YIxsWal6tE
	i355Bw4hdfH2PaPHvTFK4CmQFJyNEB5vUJWDG6plGGveNRJfTSg9tTEPGa42rJspWQuh58g==
X-Gm-Gg: ASbGnctigGB6RIPcLVIUcqXavbf12lQQPxTvuajEg6hc2CziFCliR5nNlH9PrkTvgCj
	+Hz8QA0+w16fAXok7tC6s0VsKWorfNmKcZkBghlPd+0XRc/nMay5DYHwF6TxjJhKbURxw5DvZH0
	cNmyW80+zf8b7/STRWLtlgLRD3G0muHM1UIZdYxGmg2nGdp0Z6oFzNwMCvX3Cu0+duzqKPtjB5l
	HBMDoOu+Hoze7ZBI4AJ58i3kKRabPZPTJG45mhFvvzXEG/g+g5g7TvLQWIu0jQlgYqPV+NzuGma
	37apWR+rgDTH4/5R9KpLiYQ7kz8kyoL625EWsGJimo6CjXRTQOWR77rSqzIHiT+iUw==
X-Received: by 2002:a17:90b:4d05:b0:32e:96b1:fb70 with SMTP id 98e67ed59e1d1-33b51118904mr44538916a91.12.1760586915103;
        Wed, 15 Oct 2025 20:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEg1HSgO+nMcnXRtAKiTx8Q7AQAReMvTuE/C3S8VuhwzjFekqA1Fpb56U887OfER7DJGa5MQ==
X-Received: by 2002:a17:90b:4d05:b0:32e:96b1:fb70 with SMTP id 98e67ed59e1d1-33b51118904mr44538861a91.12.1760586914538;
        Wed, 15 Oct 2025 20:55:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2472fe0bsm750566a12.17.2025.10.15.20.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:55:14 -0700 (PDT)
Date: Thu, 16 Oct 2025 11:51:23 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-integrity@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <barlwlddbdnk5ke2a4zbu7ckfzjssfo7lc4w6ffsg2cl6c7rmn@buuhox6wd6zt>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <202510030029.VRKgik99-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202510030029.VRKgik99-lkp@intel.com>

On Fri, Oct 03, 2025 at 01:17:30AM +0800, kernel test robot wrote:
>Hi Coiby,

Hi,

>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on cec1e6e5d1ab33403b809f79cd20d6aff124ccfe]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/ima-Fall-back-to-default-kernel-module-signature-verification/20250928-110501
>base:   cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
>patch link:    https://lore.kernel.org/r/20250928030358.3873311-1-coxu%40redhat.com
>patch subject: [PATCH] ima: Fall back to default kernel module signature verification
>config: i386-randconfig-012-20251002 (https://download.01.org/0day-ci/archive/20251003/202510030029.VRKgik99-lkp@intel.com/config)
>compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251003/202510030029.VRKgik99-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
>
>All errors (new ones prefixed by >>):
>
>   ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>>> security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'

Thanks for reporting the error! This happens when
set_module_sig_enforced is called without CONFIG_MODULE_SIG not enabled.
I'll address this issue by declaring set_module_sig_enforced only when
CONFIG_MODULE_SIG is enabled.

>
>
>vim +587 security/integrity/ima/ima_appraise.c
>
>   483	
>   484	/*
>   485	 * ima_appraise_measurement - appraise file measurement
>   486	 *
>   487	 * Call evm_verifyxattr() to verify the integrity of 'security.ima'.
>   488	 * Assuming success, compare the xattr hash with the collected measurement.
>   489	 *
>   490	 * Return 0 on success, error code otherwise
>   491	 */
>   492	int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>   493				     struct file *file, const unsigned char *filename,
>   494				     struct evm_ima_xattr_data *xattr_value,
>   495				     int xattr_len, const struct modsig *modsig)
>   496	{
>   497		static const char op[] = "appraise_data";
>   498		int audit_msgno = AUDIT_INTEGRITY_DATA;
>   499		const char *cause = "unknown";
>   500		struct dentry *dentry = file_dentry(file);
>   501		struct inode *inode = d_backing_inode(dentry);
>   502		enum integrity_status status = INTEGRITY_UNKNOWN;
>   503		int rc = xattr_len;
>   504		bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
>   505		bool enforce_module_sig = iint->flags & IMA_DIGSIG_REQUIRED && func == MODULE_CHECK;
>   506	
>   507		/* If not appraising a modsig or using default module verification, we need an xattr. */
>   508		if (!(inode->i_opflags & IOP_XATTR) && !try_modsig && !enforce_module_sig)
>   509			return INTEGRITY_UNKNOWN;
>   510	
>   511		/*
>   512		 * Unlike any of the other LSM hooks where the kernel enforces file
>   513		 * integrity, enforcing file integrity for the bprm_creds_for_exec()
>   514		 * LSM hook with the AT_EXECVE_CHECK flag is left up to the discretion
>   515		 * of the script interpreter(userspace). Differentiate kernel and
>   516		 * userspace enforced integrity audit messages.
>   517		 */
>   518		if (is_bprm_creds_for_exec(func, file))
>   519			audit_msgno = AUDIT_INTEGRITY_USERSPACE;
>   520	
>   521		/* If reading the xattr failed and there's no modsig or module verification, error out. */
>   522		if (rc <= 0 && !try_modsig && !enforce_module_sig) {
>   523			if (rc && rc != -ENODATA)
>   524				goto out;
>   525	
>   526			if (iint->flags & IMA_DIGSIG_REQUIRED) {
>   527				if (iint->flags & IMA_VERITY_REQUIRED)
>   528					cause = "verity-signature-required";
>   529				else
>   530					cause = "IMA-signature-required";
>   531			} else {
>   532				cause = "missing-hash";
>   533			}
>   534	
>   535			status = INTEGRITY_NOLABEL;
>   536			if (file->f_mode & FMODE_CREATED)
>   537				iint->flags |= IMA_NEW_FILE;
>   538			if ((iint->flags & IMA_NEW_FILE) &&
>   539			    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
>   540			     (inode->i_size == 0)))
>   541				status = INTEGRITY_PASS;
>   542			goto out;
>   543		}
>   544	
>   545		status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value,
>   546					 rc < 0 ? 0 : rc);
>   547		switch (status) {
>   548		case INTEGRITY_PASS:
>   549		case INTEGRITY_PASS_IMMUTABLE:
>   550		case INTEGRITY_UNKNOWN:
>   551			break;
>   552		case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
>   553			/* Fine to not have xattrs when using a modsig or default module verification. */
>   554			if (try_modsig || enforce_module_sig)
>   555				break;
>   556			fallthrough;
>   557		case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
>   558			cause = "missing-HMAC";
>   559			goto out;
>   560		case INTEGRITY_FAIL_IMMUTABLE:
>   561			set_bit(IMA_DIGSIG, &iint->atomic_flags);
>   562			cause = "invalid-fail-immutable";
>   563			goto out;
>   564		case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
>   565			cause = "invalid-HMAC";
>   566			goto out;
>   567		default:
>   568			WARN_ONCE(true, "Unexpected integrity status %d\n", status);
>   569		}
>   570	
>   571		if (xattr_value)
>   572			rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
>   573					  &cause);
>   574	
>   575		/*
>   576		 * If we have a modsig and either no imasig or the imasig's key isn't
>   577		 * known, then try verifying the modsig.
>   578		 */
>   579		if (try_modsig &&
>   580		    (!xattr_value || xattr_value->type == IMA_XATTR_DIGEST_NG ||
>   581		     rc == -ENOKEY))
>   582			rc = modsig_verify(func, modsig, &status, &cause);
>   583	
>   584		/* Fall back to default kernel module signature verification */
>   585		if (rc && enforce_module_sig) {
>   586			rc = 0;
> > 587			set_module_sig_enforced();
>   588			/* CONFIG_MODULE_SIG may be disabled */
>   589			if (is_module_sig_enforced()) {
>   590				rc = 0;
>   591				status = INTEGRITY_PASS;
>   592				pr_debug("Fall back to default kernel module verification for %s\n", filename);
>   593			}
>   594		}
>   595	
>   596	out:
>   597		/*
>   598		 * File signatures on some filesystems can not be properly verified.
>   599		 * When such filesystems are mounted by an untrusted mounter or on a
>   600		 * system not willing to accept such a risk, fail the file signature
>   601		 * verification.
>   602		 */
>   603		if ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
>   604		    ((inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) ||
>   605		     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
>   606			status = INTEGRITY_FAIL;
>   607			cause = "unverifiable-signature";
>   608			integrity_audit_msg(audit_msgno, inode, filename,
>   609					    op, cause, rc, 0);
>   610		} else if (status != INTEGRITY_PASS) {
>   611			/* Fix mode, but don't replace file signatures. */
>   612			if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
>   613			    (!xattr_value ||
>   614			     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>   615				if (!ima_fix_xattr(dentry, iint))
>   616					status = INTEGRITY_PASS;
>   617			}
>   618	
>   619			/*
>   620			 * Permit new files with file/EVM portable signatures, but
>   621			 * without data.
>   622			 */
>   623			if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
>   624			    test_bit(IMA_DIGSIG, &iint->atomic_flags)) {
>   625				status = INTEGRITY_PASS;
>   626			}
>   627	
>   628			integrity_audit_msg(audit_msgno, inode, filename,
>   629					    op, cause, rc, 0);
>   630		} else {
>   631			ima_cache_flags(iint, func);
>   632		}
>   633	
>   634		ima_set_cache_status(iint, func, status);
>   635		return status;
>   636	}
>   637	
>
>-- 
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki
>

-- 
Best regards,
Coiby


