Return-Path: <linux-integrity+bounces-61-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E727EDACB
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 05:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D676B20A6F
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 04:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A3F2F37;
	Thu, 16 Nov 2023 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cUShdtqX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DDD1A5
	for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2023 20:33:47 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7788f513872so20655685a.1
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2023 20:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109226; x=1700714026; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HOfDZdWy3FlMMU3byFQ5fyH9fZQUeVFWx7pZHVOBZ9I=;
        b=cUShdtqX6NpRR3sTAX0J50EPelbnHmQNFwtWvwzNOaB5PsWSbAaumzdhhDAezZ/KVs
         4uAi6bZhs7kWxiaREbmBkx5XOlv0YLLmHnOuaHpkfianch+ql9QBTSLz8ULbt4MoRQhP
         HS49Y2z6QZAsdUpvur/XvuVba1Prftyd00XHMiGESmfqTkMiO89y110AJ5j6llyg0rd4
         YD7CtJVPc4kiEp6m1LVvXvZuFGfh6vW8fiOQfNuQXj/6O7yuLxQdstH2aL6JGF64QybS
         i3RTojbP3mpDQJCYFP1Xh4eVjB/pRvLS5ma7lWrP4rC9H6MczSvb/71xmqO9qtnNDdKN
         yiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109226; x=1700714026;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOfDZdWy3FlMMU3byFQ5fyH9fZQUeVFWx7pZHVOBZ9I=;
        b=LrlJzypAFqMcoWTIXDiXUo2+WVAakHgCqm+prpeIjQvC/gTbPXg6LBTBVoJZTJX1KO
         T7XZVpdPrqKqJhTo7QScHOEs2zlu7DTWDGG3x7tlJf9EvLTzTrsabtEx1ena5DmTdaeT
         Wz4wpaXyqRytgRou7sF5nXPrEqfWkqzQ5t5ZDBdAszLvWhvzIuTQUwWSyP0l4R+oFKYB
         cA2OxggC2G3Y1lLXlhEyg6chhgXodTV2ycBIXd8LOIwYS+rsxPOCUhqNlaxlJxWbGLpw
         EJtV0eByfIg7oapcnwpTghgkNp9DQ+rJKkox7nv3vjhvqXp3HPzJoYQ4gVgEKXpTi2l0
         apvA==
X-Gm-Message-State: AOJu0YzGQyWi6HCXVXslFP+DSAzp3gp86OKfrjEWu4rTW3jWxyRoyRe5
	tojisTroK9QFXLB3K/EvW9NO
X-Google-Smtp-Source: AGHT+IER1laoQSGviRJQuTFe6S8/gip4gdebLlsXd5eO0S7LgScOwZM8Bh3pBl2l/YUS5yGMypAquA==
X-Received: by 2002:a05:620a:201c:b0:778:920a:7a70 with SMTP id c28-20020a05620a201c00b00778920a7a70mr8484989qka.66.1700109226313;
        Wed, 15 Nov 2023 20:33:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id qc3-20020a05620a654300b0076d25b11b62sm4033067qkn.38.2023.11.15.20.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:45 -0800 (PST)
Date: Wed, 15 Nov 2023 23:33:45 -0500
Message-ID: <231ff26ec85f437261753faf03b384e6.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 10/23] security: Introduce inode_post_setattr hook
References: <20231107134012.682009-11-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-11-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_setattr hook.
> 
> At inode_setattr hook, EVM verifies the file's existing HMAC value. At
> inode_post_setattr, EVM re-calculates the file's HMAC based on the modified
> file attributes and other file metadata.
> 
> Other LSMs could similarly take some action after successful file attribute
> change.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/attr.c                     |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 26 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index 7935d11d58b5..ce3bc7642e18 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2222,6 +2222,22 @@ int security_inode_setattr(struct mnt_idmap *idmap,
>  }
>  EXPORT_SYMBOL_GPL(security_inode_setattr);
>  
> +/**
> + * security_inode_post_setattr() - Update the inode after a setattr operation
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @ia_valid: file attributes set
> + *
> + * Update inode security field after successful setting file attributes.
> + */
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 int ia_valid)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;

I may be missing it, but I don't see the S_PRIVATE flag check in the
existing IMA or EVM hooks so I'm curious as to why it is added here?
Please don't misunderstand me, I think it makes sense to return early
on private dentrys/inodes, but why aren't we doing that now?

> +	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
> +}
> +
>  /**
>   * security_inode_getattr() - Check if getting file attributes is allowed
>   * @path: file
> -- 
> 2.34.1

--
paul-moore.com

