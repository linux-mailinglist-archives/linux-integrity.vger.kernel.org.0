Return-Path: <linux-integrity+bounces-6289-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA5ABFF55
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 00:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B4F3ACEA9
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39492367AC;
	Wed, 21 May 2025 22:11:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453A21E0A2;
	Wed, 21 May 2025 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747865508; cv=none; b=UGypgCsSePjqET/VtWyj5pu0elESMGyI8psv5THLqYihUeKeq44H8c2FEFBTedHv7Lb3Lj1o96tyO3Uh202HbteY1Da4yUF0PsP3j36cidJdDgpIKaQ5e9LH0FG0uBqwoHLYow+wf0N2DBPnuVo8I5tB39eTtkQWgBEyg0OpSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747865508; c=relaxed/simple;
	bh=PIxsFoyl0Qm3a53tAerIdBCz2QjjEP745QHvK76hLJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAnLMrbarNeG08SECWL4Ah+GiMZ02p/v3VVpNX3WHBjIi9JdH9ThUB0uPlrFOv6JIdR6V+fymx6VuW2hdVoSjvbIzd9OdByNLLrNRk8VkV/L8UBlp9XG4dBb2TA/KHo6pcDXfhJZPcgek1BtwEvx3hJGbOxcUS8EI1AYvNMSxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 073A61399; Wed, 21 May 2025 17:03:49 -0500 (CDT)
Date: Wed, 21 May 2025 17:03:49 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Simon THOBY <git@nightmared.fr>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 1/9] LSM: Introduce a new hook:
 security_kernel_module_load
Message-ID: <20250521220349.GA22189@mail.hallyn.com>
References: <20250521140121.591482-1-git@nightmared.fr>
 <20250521140121.591482-2-git@nightmared.fr>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521140121.591482-2-git@nightmared.fr>

On Wed, May 21, 2025 at 04:01:05PM +0200, Simon THOBY wrote:
> Introduce a new hook to allow LSMs to decide whether to block the load
> of a kernel module.
> 
> Two hooks already exist:
> - kernel_module_request is called when the kernel itself (not userspace)
>  request the load of a module, e.g. because a device was detected.
>  - security_kernel_load_data(LOADING_MODULE) is called when userspace calls
>  init_module/finit_module, but lack information about the module because
>  its  headers have not been loaded into kernel space, let alone parsed.
>  This may not be sufficient for some LSMs.
> 
> This new hook is similar to security_kernel_load_data(LOADING_MODULE),
> but called after the module signature and header are verified, and only
> takes the module name for now.
> 
> Signed-off-by: Simon THOBY <git@nightmared.fr>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/module.h        |  1 +
>  include/linux/security.h      |  6 ++++++
>  kernel/module/main.c          |  4 ++++
>  security/security.c           | 14 ++++++++++++++
>  5 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index bf3bbac4e02a..51c5212d8bb6 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -223,6 +223,7 @@ LSM_HOOK(void, LSM_RET_VOID, cred_getlsmprop, const struct cred *c,
>  LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
>  LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
>  LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
> +LSM_HOOK(int, 0, kernel_module_load, const char *kmod_name)
>  LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
>  LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
>  	 enum kernel_load_data_id id, char *description)
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8050f77c3b64..b6b8d6f7f599 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -39,6 +39,7 @@ struct modversion_info {
>  	char name[MODULE_NAME_LEN];
>  };
>  
> +struct load_info;
>  struct module;
>  struct exception_table_entry;
>  
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cc9b54d95d22..e175b2cc8caf 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -498,6 +498,7 @@ void security_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop);
>  int security_kernel_act_as(struct cred *new, u32 secid);
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>  int security_kernel_module_request(char *kmod_name);
> +int security_kernel_module_load(const char *kmod_name);
>  int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
>  int security_kernel_post_load_data(char *buf, loff_t size,
>  				   enum kernel_load_data_id id,
> @@ -1255,6 +1256,11 @@ static inline int security_kernel_module_request(char *kmod_name)
>  	return 0;
>  }
>  
> +static inline int security_kernel_module_load(const char *kmod_name)
> +{
> +	return 0;
> +}
> +
>  static inline int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
>  {
>  	return 0;
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index a2859dc3eea6..12a1a5f4d823 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3228,6 +3228,10 @@ static int early_mod_check(struct load_info *info, int flags)
>  		return -EPERM;
>  	}
>  
> +	err = security_kernel_module_load(info->name);

Would it be more useful to pass in the whole info struct?

> +	if (err)
> +		return err;
> +
>  	err = rewrite_section_headers(info, flags);
>  	if (err)
>  		return err;
> diff --git a/security/security.c b/security/security.c
> index fb57e8fddd91..b9430499c332 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3336,6 +3336,20 @@ int security_kernel_module_request(char *kmod_name)
>  	return call_int_hook(kernel_module_request, kmod_name);
>  }
>  
> +/**
> + * security_kernel_module_load() - Check if loading a module is allowed
> + * @kmod_name: name of the kernel module being loaded
> + *
> + * This method is called when the userspace called init_module/finit_module
> + * with a valid module
> + *
> + * Return: Returns 0 if successful.
> + */
> +int security_kernel_module_load(const char *kmod_name)
> +{
> +	return call_int_hook(kernel_module_load, kmod_name);
> +}
> +
>  /**
>   * security_kernel_read_file() - Read a file specified by userspace
>   * @file: file
> -- 
> 2.49.0
> 

