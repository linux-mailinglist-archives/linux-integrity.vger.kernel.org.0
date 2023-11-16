Return-Path: <linux-integrity+bounces-65-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533047EDAD6
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 05:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26EB1F237B3
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 04:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C93CA57;
	Thu, 16 Nov 2023 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SwYS/wyu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F6A1B6
	for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2023 20:33:52 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cd4446cf5so2577891cf.3
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2023 20:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109231; x=1700714031; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRCIUlxMviG/akojIoiuUtAzlfA4z+ppx5JWcANslrQ=;
        b=SwYS/wyuZgZb9WJ0PIvbdBV7/u/Z74cHs86kLwpyUjEaxAXQtDq6If6SI7YvAdGeTm
         6CCGvzBiXTzyxPeSUfFgQNUfwXcV8V6Ol45lE8wSbPTJkP5Yh2x+QdBsmHJs9uBoL3oJ
         eGSmR68w0bH5KDsM4hsNba/8NMA/Dl9jaNVn85591Ud0BL+hq9WIzhpnHo13OE4hgLt2
         JmqI4uCRpXAqIc0dTXWhjm/I3Pxv3lu83q7bOIndslt95HTIOsiQ1Xi73YnnBvxqTy2N
         TcmKB0D9Z7rNvSj00Z8ubcL6V54Qfcuv/lxJwqOi5ttkVZ1DdMhAr9Q1PyDEV3fHaCAh
         hhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109231; x=1700714031;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRCIUlxMviG/akojIoiuUtAzlfA4z+ppx5JWcANslrQ=;
        b=K7reZ7qClcjp7ZLQsnH1VuplpuqWrEeVzKdu9Kxaf2Hjic4Jj+brWV+MWmxV+5AoyI
         d5FH+KrNw0aVO6LBssbxoL1yR9LWn46uwpwdrLmn7mrHhvYmHeI6gS44lU/LYLaUL+F5
         THa3BG0Gr+2ZskYXmbvA+e2zs0qfrl9QmSCjQgvw5KbuO3aylh6q+mCU0ejws6AY+ADJ
         n46JfcmavqkvvX+knBdXCqYXei0n1ur8iXPreLrACuto89u5r/pEmiUgb4Lbveyzdxix
         6JC6H5MI/Fm6Rm/M5RrcdmHBIjqDjWzbbHRtriRWT0KUxM+mSI6h0Z9or4idLa8yIiG8
         LScg==
X-Gm-Message-State: AOJu0YyyWzSD3XNWVAoLeSPEETsu2IFyXSmYw0kI7BJxzhgWil3az40w
	B1q7IfUcAMIkaZajBbUPzgzl
X-Google-Smtp-Source: AGHT+IHphFpDzgVFwOfukFTgf3tIsG9A83ycMGfQY4UVTT6EROx8wCbgF2iRta1hsOxzIr0MuKuWvQ==
X-Received: by 2002:a05:622a:1a9c:b0:412:24e6:a485 with SMTP id s28-20020a05622a1a9c00b0041224e6a485mr8399280qtc.2.1700109231366;
        Wed, 15 Nov 2023 20:33:51 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id e7-20020ac84907000000b004195faf1e2csm4050405qtq.97.2023.11.15.20.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:50 -0800 (PST)
Date: Wed, 15 Nov 2023 23:33:50 -0500
Message-ID: <f79bb72356ca062d3f3b6b00c3694d8f.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 17/23] security: Introduce inode_post_remove_acl hook
References: <20231107134012.682009-18-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-18-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_remove_acl hook.
> 
> At inode_remove_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_remove_acl, EVM re-calculates the file's HMAC with the passed
> POSIX ACL removed and other file metadata.
> 
> Other LSMs could similarly take some action after successful POSIX ACL
> removal.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  8 ++++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 28 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index d2dbea54a63a..6eb7c9cff1e5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2413,6 +2413,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>  	return evm_inode_remove_acl(idmap, dentry, acl_name);
>  }
>  
> +/**
> + * security_inode_post_remove_acl() - Update inode security after rm posix acls
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @acl_name: acl name
> + *
> + * Update inode security data after successfully removing posix acls on
> + * @dentry in @idmap. The posix acls are identified by @acl_name.
> + */
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +				    struct dentry *dentry, const char *acl_name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;

See previous comments regaring S_PRIVATE checks.

> +	call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
> +}
> +
>  /**
>   * security_inode_post_setxattr() - Update the inode after a setxattr operation
>   * @dentry: file
> -- 
> 2.34.1

--
paul-moore.com

