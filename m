Return-Path: <linux-integrity+bounces-4277-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D729E1BA2
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 13:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3537282F3C
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 12:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BED1E47C6;
	Tue,  3 Dec 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0rvZcnnB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FDD1E0493
	for <linux-integrity@vger.kernel.org>; Tue,  3 Dec 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227519; cv=none; b=j7fOyu7hWyFPke2UUk21X1DMVGFRQVLSJTMJkgn1M+0oef3GY6lpwPp4kFauQvo1LF+WmLVsNo9FVfuGrzs4ijWlqXj2uX5iXH/W3PMnWHxi1+LDoeE3t8LgWisBBQexSyxdjaseaX65KAEsv/zwK3H4r7o6c2ta5OWPr7GK2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227519; c=relaxed/simple;
	bh=UUMCAK54vilNWuna+YwLJMxKEe2Eq3QWfp++Cp1M26k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG3e6tnBPTp1uWfSIeflYBaFq418CM978TlUC8JiXE2Rm0dYyTFNHXVYTE54QZaww74Zh+x0XoWQm1EFw6wog88G4JKB/oz1QVfCIIKqXuY7l9JRhzxLKLzmQQEBaXr4fi1l1VybBZJC63IdFFe7igyfjWp5uRbBNzPniZEqlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0rvZcnnB; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y2fLR0bX6zrCx;
	Tue,  3 Dec 2024 12:58:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733227102;
	bh=ZHN+M1OgAsPjHuTDfmE/sUQa2uwyVUjKo1L/pEgvz4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0rvZcnnBMVnOp8YtO+aIpTDhXL6bOyySjJ9L7FDejcCj63I7+vmEXzts9mFL+FKvd
	 ZQrhqI9vQH7Uz/OvbjDED0kEb0agvSb1GPgCSWu9Tp/o5IByZSCsQ2RfpRB0xNqz8T
	 GWCSQoNAaN7Amlj9S1owoq2BDYJDwKUvLq+J+jxw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y2fLQ0xg9zphs;
	Tue,  3 Dec 2024 12:58:22 +0100 (CET)
Date: Tue, 3 Dec 2024 12:58:20 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Fan Wu <wufan@kernel.org>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	audit@vger.kernel.org
Subject: Re: [PATCH] ima: instantiate the bprm_creds_for_exec() hook
Message-ID: <20241203.ta8eiziX7kah@digikod.net>
References: <20241127210234.121546-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127210234.121546-1-zohar@linux.ibm.com>
X-Infomaniak-Routing: alpha

Fan, would IPE need a similar update?

See https://lore.kernel.org/r/20241127210234.121546-1-zohar@linux.ibm.com

On Wed, Nov 27, 2024 at 04:02:34PM -0500, Mimi Zohar wrote:
> Like direct file execution (e.g. ./script.sh), indirect file execution
> (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> the new security_bprm_creds_for_exec() hook to measure and verify the
> indirect file's integrity.  Unlike direct file execution, indirect file
> execution integrity is optionally enforced by the interpreter.
> 
> Update the audit messages to differentiate between kernel and userspace
> enforced integrity.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_appraise.c | 84 ++++++++++++++++++++-------
>  security/integrity/ima/ima_main.c     | 22 +++++++
>  2 files changed, 86 insertions(+), 20 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 656c709b974f..b5f8e49cde9d 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/file.h>
> +#include <linux/binfmts.h>
>  #include <linux/fs.h>
>  #include <linux/xattr.h>
>  #include <linux/magic.h>
> @@ -16,6 +17,7 @@
>  #include <linux/fsverity.h>
>  #include <keys/system_keyring.h>
>  #include <uapi/linux/fsverity.h>
> +#include <linux/securebits.h>
>  
>  #include "ima.h"
>  
> @@ -276,7 +278,8 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
>   */
>  static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  			struct evm_ima_xattr_data *xattr_value, int xattr_len,
> -			enum integrity_status *status, const char **cause)
> +			enum integrity_status *status, const char **cause,
> +			bool is_check)
>  {
>  	struct ima_max_digest_data hash;
>  	struct signature_v2_hdr *sig;
> @@ -292,9 +295,11 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  		if (*status != INTEGRITY_PASS_IMMUTABLE) {
>  			if (iint->flags & IMA_DIGSIG_REQUIRED) {
>  				if (iint->flags & IMA_VERITY_REQUIRED)
> -					*cause = "verity-signature-required";
> +					*cause = !is_check ? "verity-signature-required" :
> +						"verity-signature-required(userspace)";
>  				else
> -					*cause = "IMA-signature-required";
> +					*cause = !is_check ? "IMA-signature-required" :
> +						"IMA-signature-required(userspace)";
>  				*status = INTEGRITY_FAIL;
>  				break;
>  			}
> @@ -314,7 +319,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  		else
>  			rc = -EINVAL;
>  		if (rc) {
> -			*cause = "invalid-hash";
> +			*cause = !is_check ? "invalid-hash" :
> +				"invalid-hash(userspace)";
>  			*status = INTEGRITY_FAIL;
>  			break;
>  		}
> @@ -325,14 +331,16 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  
>  		mask = IMA_DIGSIG_REQUIRED | IMA_VERITY_REQUIRED;
>  		if ((iint->flags & mask) == mask) {
> -			*cause = "verity-signature-required";
> +			*cause = !is_check ? "verity-signature-required" :
> +				"verity-signature-required(userspace)";
>  			*status = INTEGRITY_FAIL;
>  			break;
>  		}
>  
>  		sig = (typeof(sig))xattr_value;
>  		if (sig->version >= 3) {
> -			*cause = "invalid-signature-version";
> +			*cause = !is_check ? "invalid-signature-version" :
> +				"invalid-signature-version(userspace)";
>  			*status = INTEGRITY_FAIL;
>  			break;
>  		}
> @@ -353,7 +361,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  						     iint->ima_hash->digest,
>  						     iint->ima_hash->length);
>  		if (rc) {
> -			*cause = "invalid-signature";
> +			*cause = !is_check ? "invalid-signature" :
> +				"invalid-signature(userspace)";
>  			*status = INTEGRITY_FAIL;
>  		} else {
>  			*status = INTEGRITY_PASS;
> @@ -364,7 +373,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  
>  		if (iint->flags & IMA_DIGSIG_REQUIRED) {
>  			if (!(iint->flags & IMA_VERITY_REQUIRED)) {
> -				*cause = "IMA-signature-required";
> +				*cause = !is_check ? "IMA-signature-required" :
> +					"IMA-signature-required(userspace)";
>  				*status = INTEGRITY_FAIL;
>  				break;
>  			}
> @@ -372,7 +382,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  
>  		sig = (typeof(sig))xattr_value;
>  		if (sig->version != 3) {
> -			*cause = "invalid-signature-version";
> +			*cause = !is_check ? "invalid-signature-version" :
> +				"invalid-signature-version(userspace)";
>  			*status = INTEGRITY_FAIL;
>  			break;
>  		}
> @@ -382,7 +393,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  				       container_of(&hash.hdr,
>  					       struct ima_digest_data, hdr));
>  		if (rc) {
> -			*cause = "sigv3-hashing-error";
> +			*cause = !is_check ? "sigv3-hashing-error" :
> +				"sigv3-hashing-error(userspace)";
>  			*status = INTEGRITY_FAIL;
>  			break;
>  		}
> @@ -392,7 +404,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  					     xattr_len, hash.digest,
>  					     hash.hdr.length);
>  		if (rc) {
> -			*cause = "invalid-verity-signature";
> +			*cause = !is_check ? "invalid-verity-signature" :
> +				"invalid-verify-signature(userspace)";
>  			*status = INTEGRITY_FAIL;
>  		} else {
>  			*status = INTEGRITY_PASS;
> @@ -401,7 +414,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  		break;
>  	default:
>  		*status = INTEGRITY_UNKNOWN;
> -		*cause = "unknown-ima-data";
> +		*cause = !is_check ? "unknown-ima-data" :
> +			"unknown-ima-data(userspace)";
>  		break;
>  	}
>  
> @@ -469,6 +483,18 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
>  	return rc;
>  }
>  
> +static int is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
> +{
> +	struct linux_binprm *bprm = NULL;
> +
> +	if (func == BPRM_CHECK) {
> +		bprm = container_of(&file, struct linux_binprm, file);
> +		if (bprm->is_check)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * ima_appraise_measurement - appraise file measurement
>   *
> @@ -489,11 +515,24 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  	enum integrity_status status = INTEGRITY_UNKNOWN;
>  	int rc = xattr_len;
>  	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
> +	bool is_check = false;
>  
>  	/* If not appraising a modsig, we need an xattr. */
>  	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
>  		return INTEGRITY_UNKNOWN;
>  
> +	/*
> +	 * Unlike any of the other LSM hooks where the kernel enforces file
> +	 * integrity, enforcing file integrity for the bprm_creds_for_exec()
> +	 * LSM hook is left up to the discretion of the script interpreter
> +	 * (userspace).
> +	 *
> +	 * Since the SECBIT_EXEC_RESTRICT_FILE flag is just a hint as to
> +	 * userspace intentions, simply annotate the audit messages indicating
> +	 * a userspace based query.
> +	 */
> +	is_check = is_bprm_creds_for_exec(func, file);
> +
>  	/* If reading the xattr failed and there's no modsig, error out. */
>  	if (rc <= 0 && !try_modsig) {
>  		if (rc && rc != -ENODATA)
> @@ -501,11 +540,14 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  
>  		if (iint->flags & IMA_DIGSIG_REQUIRED) {
>  			if (iint->flags & IMA_VERITY_REQUIRED)
> -				cause = "verity-signature-required";
> +				cause = !is_check ? "verity-signature-required" :
> +					"verity-signature-required(userspace)";
>  			else
> -				cause = "IMA-signature-required";
> +				cause = !is_check ? "IMA-signature-required" :
> +					"IMA-signature-required(userspace)";
>  		} else {
> -			cause = "missing-hash";
> +			cause = !is_check ? "missing-hash" :
> +				"missing-hash(userspace)";
>  		}
>  
>  		status = INTEGRITY_NOLABEL;
> @@ -531,14 +573,15 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  			break;
>  		fallthrough;
>  	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
> -		cause = "missing-HMAC";
> +		cause = !is_check ? "missing-HMAC" : "missing-HMAC(userspace)";
>  		goto out;
>  	case INTEGRITY_FAIL_IMMUTABLE:
>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
> -		cause = "invalid-fail-immutable";
> +		cause = !is_check ? "invalid-fail-immutable" :
> +		       "invalid-fail-immutable(userspace)";
>  		goto out;
>  	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
> -		cause = "invalid-HMAC";
> +		cause = !is_check ? "invalid-HMAC" : "invalid-HMAC(userspace)";
>  		goto out;
>  	default:
>  		WARN_ONCE(true, "Unexpected integrity status %d\n", status);
> @@ -546,7 +589,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  
>  	if (xattr_value)
>  		rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
> -				  &cause);
> +				  &cause, is_check);
>  
>  	/*
>  	 * If we have a modsig and either no imasig or the imasig's key isn't
> @@ -568,7 +611,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  	    ((inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) ||
>  	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
>  		status = INTEGRITY_FAIL;
> -		cause = "unverifiable-signature";
> +		cause = !is_check ? "unverifiable-signature" :
> +			"unverifiable-signature(userspace)";
>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>  				    op, cause, rc, 0);
>  	} else if (status != INTEGRITY_PASS) {
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 06132cf47016..2b5d6bae77a4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -554,6 +554,27 @@ static int ima_bprm_check(struct linux_binprm *bprm)
>  				   MAY_EXEC, CREDS_CHECK);
>  }
>  
> +/**
> + * ima_bprm_creds_for_exec - based on policy, collect/store/appraise measurement.
> + * @bprm: contains the linux_binprm structure
> + *
> + * Based on the IMA policy and the execvat(2) AT_CHECK flag, measure and
> + * appraise the integrity of a file to be executed by script interpreters.
> + * Unlike any of the other LSM hooks where the kernel enforces file integrity,
> + * enforcing file integrity is left up to the discretion of the script
> + * interpreter (userspace).
> + *
> + * On success return 0.  On integrity appraisal error, assuming the file
> + * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
> + */
> +static int ima_bprm_creds_for_exec(struct linux_binprm *bprm)
> +{
> +	if (!bprm->is_check)
> +		return 0;
> +
> +	return ima_bprm_check(bprm);
> +}
> +
>  /**
>   * ima_file_check - based on policy, collect/store measurement.
>   * @file: pointer to the file to be measured
> @@ -1177,6 +1198,7 @@ static int __init init_ima(void)
>  
>  static struct security_hook_list ima_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
> +	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
>  	LSM_HOOK_INIT(file_post_open, ima_file_check),
>  	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
>  	LSM_HOOK_INIT(file_release, ima_file_free),
> -- 
> 2.47.0
> 
> 

