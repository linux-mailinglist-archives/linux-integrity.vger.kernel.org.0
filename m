Return-Path: <linux-integrity+bounces-4276-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514289E1B87
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1296F284917
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935111DF98D;
	Tue,  3 Dec 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bjOmS4An"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C122500BB;
	Tue,  3 Dec 2024 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227211; cv=none; b=kPgxd5SoKOxpR2ov0anoU51CmNSuaS+uuSqje7ncgHpqrNnGb0yq7UtUprtOvjriXM7PiPkaJVjROXNyyhaMEuS1ZQqBPjnfMbdFUbp+hGxgi2kz/KFkZNFzcdElPmZODXWPI4u4bhj9SGLg7VjV0/nG3CxrgTPvuXd71s0H+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227211; c=relaxed/simple;
	bh=CMt8X3Hmt3yabztimpR+ulUyfvruG2LG3+5FXadS/Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsDA+awDayc26fX2Q2Xl90TDMmtVwG3yFTj0td3LSkSFFnyHBLhCarARMbXRRmruxhZYwc8BrYFH3E4tq3vijmjw0Q+4J8duxbYQHnDE42/C3zYxrjnlHgmM8iedyOQq69sjjYiDEEtYG8y8qmLWy0J/m+LYtXXquH2K0BfRQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bjOmS4An; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y2fD93VWyzrZN;
	Tue,  3 Dec 2024 12:52:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733226777;
	bh=EzSBlNqBL6lCmaIIrqhLDGVc/DV5ofgikjZdLcgCDkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjOmS4An+lERmyGsmnrp6Ic7/QHZi2uZqUaZx76we35hFEpeZ36lpbrmoB1eQmZ8L
	 PunjS8DnYDwwv5YZ4WgMjdkZ691reDfaXx4wYA+hq2CI/MgiTgJaTvNtly8v9tUcmw
	 isisnU3hfOELkb0bcsnBanHjaPAaw6WGXzx8esE4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y2fD84YXHzlLD;
	Tue,  3 Dec 2024 12:52:56 +0100 (CET)
Date: Tue, 3 Dec 2024 12:52:54 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org
Subject: Re: [RFC PATCH] ima: instantiate the bprm_creds_for_exec() hook
Message-ID: <20241203.evei6IeKai4E@digikod.net>
References: <20241127150526.97348-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127150526.97348-1-zohar@linux.ibm.com>
X-Infomaniak-Routing: alpha

CCing Jeff, Kees, Paul, and audit@

I guess this RFC is superseded by
https://lore.kernel.org/r/20241127210234.121546-1-zohar@linux.ibm.com
(and then doesn't need a reply) but for reference, here was may main
concern anyway.

On Wed, Nov 27, 2024 at 10:05:26AM -0500, Mimi Zohar wrote:
> Like direct file execution (e.g. ./script.sh), indirect file exection
> (e.g. sh script.sh) need to be measured and appraised.  Instantiate
> the new security_bprm_creds_for_exec() hook to measure and verify the
> indirect file's integrity.  Unlike direct file execution, indirect file
> execution is optionally enforced by the interpreter.
> 
> Define two new audit messages:
> - Userspace-enforcing-IMA-signature-required
> - Userspace-not-enforcing-IMA-signature-required
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_appraise.c | 24 +++++++++++++++++++++++-
>  security/integrity/ima/ima_main.c     | 22 ++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 656c709b974f..5a3b5cdecb51 100644
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
> @@ -469,6 +471,26 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
>  	return rc;
>  }
>  
> +static int is_bprm_creds_for_exec(enum ima_hooks func, struct file *file,
> +				  const char **cause)
> +{
> +	const struct cred *cred = current_cred();
> +	struct linux_binprm *bprm = NULL;
> +
> +	if (func == BPRM_CHECK) {
> +		bprm = container_of(&file, struct linux_binprm, file);
> +		if (!bprm->is_check)
> +			return 0;
> +
> +		if (cred->securebits & SECBIT_EXEC_RESTRICT_FILE)

The is_bprm_creds_for_exec() implementation from the next patch series
doesn't check securebits anymore, but for reference, LSMs should not
rely on caller's securebits to infer a behavior because user space could
just not check these bits.  For instance, on tailored systems such as
chromeOS, the libc could call execveat+AT_EXECVE_CHECK whatever
SECBIT_EXEC_RESTRICT_FILE is set or not:
https://lore.kernel.org/r/20241127.aizae7eeHohn@digikod.net

> +			*cause = "Userspace-enforcing-IMA-signature-required";
> +		else
> +			*cause = "Userspace-not-enforcing-IMA-signature-required";
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * ima_appraise_measurement - appraise file measurement
>   *
> @@ -502,7 +524,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  		if (iint->flags & IMA_DIGSIG_REQUIRED) {
>  			if (iint->flags & IMA_VERITY_REQUIRED)
>  				cause = "verity-signature-required";
> -			else
> +			else if (!is_bprm_creds_for_exec(func, file, &cause))
>  				cause = "IMA-signature-required";
>  		} else {
>  			cause = "missing-hash";
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

