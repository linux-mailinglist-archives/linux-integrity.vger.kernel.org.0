Return-Path: <linux-integrity+bounces-1805-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB08807F9
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 00:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26721F22D74
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 23:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FB15FBB0;
	Tue, 19 Mar 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eelzPzGL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD55FDA1
	for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2024 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889244; cv=none; b=AtSKNSXsZobRMuGmZb/+9cSle6e++LOFcHJxxBoxNXJSCNmm2iCywlpBFEZ9RTiSjWNcdyjQgt2UY7q7ddGksk+gEm4Q9p3Weo6ujs5fInK4iQUaC2S/ta/S3XuZVoS7POjVUJnjB1fpHcvhF0tvzXcT8YaRxqPLZM1k0AGl8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889244; c=relaxed/simple;
	bh=QZfv3icIZ4/CHhSSd6nbOzwCM9N27jDWNszmTRrZFDg=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=nqMn+O3WZAiewdkkz+E52n+NHsb3e3mx62i6bh4jv6eHkUWFf4tS31BYHM/FwyYtJ8SQucehyZtOdw43oi6wv3H41PniV0yUCDWe15jztOhmNYLPdsuAX87Uf51CmFd9tuCzjgHZqiZWiQNivtt8EzEDrBIXjTnzFUfVmF0FgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eelzPzGL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78822adc835so284417785a.3
        for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2024 16:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710889240; x=1711494040; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zcXhR188v6exmS7H92imlEAx9k7OrrEpyfgcmj4MXK8=;
        b=eelzPzGLkjfwA6FpWGZMyLpzBdczbjpojkCHOs78511Hz9cc0SNLk4pa99vGtN7bEk
         xMv+fXB5gkPrDvMVH7o6bZ7snmB30gmsYYAba9Vj7/xXVnITSf1u27G9xk9vpztjyXFH
         ME5yKwKJRsMuwT+M0sahV48r9bBuVZpk6Ralt9PJNj8WUbYzEX43B3TDf3TvSTzMx1Ww
         2Cl7A3g20zSEb7FjSnFs+ztZ284zh60xUccvYi2saDbMRmLiygFgya9oAH1hp34ct5R/
         WUrrP1/FT/11qaXZsejFDgYea5D4jBrlhHds1/dpOCCXOS0JMTiMapQ0gROZmZJ/CO2O
         Ud3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889240; x=1711494040;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcXhR188v6exmS7H92imlEAx9k7OrrEpyfgcmj4MXK8=;
        b=WjFxPPmvNeHH+/acSrKtNc5UnrqzgeemHJ9duK2myNoaxLabWXIRh0+5T0XtOmvvNb
         b/mOLvtRCf5mX2Wdqbn1pLO6thIjBMxckjh5OBpdI+CCkFgieVT6698LrFyvVtp+3l1O
         yWB3+XXRZRhVZzzQcW3jWwNUMVFHKGaE7wwjVkIRMJZnqrxf6bGYh7SBSetG1/Vl2acO
         XAqSBFLfreAhVURDx/X5YUB6YBnMZb17Sd0izPxcpPawifmb2UQM7Ex5MensBgd/xnhc
         f1TpA1oLKg8J+/SeWWiZaD8trInaKgEYzTf4U6vg1mqdfpIiFtgRJs/NnowgH/TnZMEc
         3k1g==
X-Forwarded-Encrypted: i=1; AJvYcCUInowKRjzukIzJweGLot++tdiOR0Fx4zkZWODwb+IyZ51sjCmzOrVa55hC01HSV6GvtLW48rFzukelvL7Ga87rI5kSHSPGOXpIieK74T5A
X-Gm-Message-State: AOJu0YwCawEHaEwm9OAxDKMIFUqjiynu/uB7VuY17NYQgRfVLhArULSY
	p9ipk7vV+5aYHu7lzdOcgMKvOPnko2ssTrRVOviD044O+kPFY1gkOhQF+BoRzA==
X-Google-Smtp-Source: AGHT+IHzQEvbTybFxdOOiTqUl7ym4mHT4Zq9uXRmXAzKRWe5gmEcs6zFJSlc05jkl1alZKpFPU/CEg==
X-Received: by 2002:a05:620a:5cca:b0:789:ebd1:445a with SMTP id xr10-20020a05620a5cca00b00789ebd1445amr11360295qkn.42.1710889239710;
        Tue, 19 Mar 2024 16:00:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bp10-20020a05620a458a00b00789e8860ef7sm4208014qkb.121.2024.03.19.16.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 16:00:39 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:00:38 -0400
Message-ID: <fd1c5f7f7c7fe7125e70788149e08cd4@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v15 16/21] security: add security_inode_setintegrity()  hook
References: <1710560151-28904-17-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1710560151-28904-17-git-send-email-wufan@linux.microsoft.com>

On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> This patch introduces a new hook to save inode's integrity
> data. For example, for fsverity enabled files, LSMs can use this hook to save
> the verified fsverity builtin signature into the inode's security blob,
> and LSMs can make access decisions based on the data inside the signature,
> like the signer certificate.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> --
> v1-v14:
>   + Not present
> 
> v15:
>   + Introduced
> 
> ---
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      | 10 ++++++++++
>  security/security.c           | 28 ++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 6808ae763913..c88587fc3691 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -177,6 +177,9 @@ LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
>  LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
>  LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
>  LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
> +LSM_HOOK(int, 0, inode_setintegrity, struct inode *inode,
> +	 enum lsm_intgr_type type, const void *value, size_t size)
> +
>  LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
>  	 struct kernfs_node *kn)
>  LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 60b40b523d57..0885866b261e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -405,6 +405,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
>  void security_inode_getsecid(struct inode *inode, u32 *secid);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(const char *name);
> +int security_inode_setintegrity(struct inode *inode,
> +				enum lsm_intgr_type type, const void *value,
> +				size_t size);
>  int security_kernfs_init_security(struct kernfs_node *kn_dir,
>  				  struct kernfs_node *kn);
>  int security_file_permission(struct file *file, int mask);
> @@ -1021,6 +1024,13 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
>  	return 0;
>  }
>  
> +static inline int security_inode_setintegrity(struct inode *inode,
> +					      enum lsm_intgr_type, type,
> +					      const void *value, size_t size)
> +{
> +	return 0;
> +}
> +
>  static inline int security_kernfs_init_security(struct kernfs_node *kn_dir,
>  						struct kernfs_node *kn)
>  {
> diff --git a/security/security.c b/security/security.c
> index 8d88529ac904..c5d426d084ab 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2681,6 +2681,34 @@ int security_inode_copy_up_xattr(const char *name)
>  }
>  EXPORT_SYMBOL(security_inode_copy_up_xattr);
>  
> +/**
> + * security_inode_setintegrity() - Set the inode's integrity data
> + * @inode: inode
> + * @type: type of integrity, e.g. hash digest, signature, etc
> + * @value: the integrity value
> + * @size: size of the integrity value
> + *
> + * Register a verified integrity measurement of a inode with the LSM.
> + *
> + * Return: Returns 0 on success, negative values on failure.
> + */
> +int security_inode_setintegrity(struct inode *inode,
> +				enum lsm_intgr_type type, const void *value,
> +				size_t size)
> +{
> +	int rc = 0;
> +	struct security_hook_list *p;
> +
> +	hlist_for_each_entry(p, &security_hook_heads.inode_setintegrity, list) {
> +		rc = p->hook.inode_setintegrity(inode, type, value, size);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return LSM_RET_DEFAULT(inode_setintegrity);
> +}
> +EXPORT_SYMBOL(security_inode_setintegrity);

Same as the block device variant of this hook, we should convert this
to use the call_int_hook() macro unless there is a strong reason to
leave it open coded.

>  /**
>   * security_kernfs_init_security() - Init LSM context for a kernfs node
>   * @kn_dir: parent kernfs node
> -- 
> 2.44.0

--
paul-moore.com

