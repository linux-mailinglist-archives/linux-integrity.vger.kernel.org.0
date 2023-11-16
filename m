Return-Path: <linux-integrity+bounces-67-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA907EDAE9
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 05:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EA8280F9A
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 04:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C9ED314;
	Thu, 16 Nov 2023 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Be2nyhJV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497F81BF
	for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2023 20:33:50 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77784edc2edso20792485a.1
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2023 20:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109228; x=1700714028; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bndky/isFZdPv4y+9HMU+8QO0OsZEFaDO/mxDCye0C0=;
        b=Be2nyhJV8JByTCu9BsElBdGHDrrhMuIfyJI/dW5Ptt4EUKql5kjRdkX35r7Ph+ocBB
         /LY1ZvqLo1a6v3v/Mji8zsoeKxpSQeJaWYTwmZTLARnwOL+UqNKskMYW81yULkInncEW
         y/PVI9i7A2a/GmitESvrxjUERfNuMYi4JjrntU7AwykluwNteWHkgFBBJsCpSOCPMjbE
         Wy9K70Nl1QZaIPNNbUGKu4zdspq8PzlFWKrViqaq3xAsJ7X5SePmlVcXHUWZl176RH3U
         JEEv8/hCNT7+uizusuOj0/z6OHBcVfKgfMlYBpnKTxfuQO8eXa/2j+IP9b+ViTfn8PHX
         NsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109228; x=1700714028;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bndky/isFZdPv4y+9HMU+8QO0OsZEFaDO/mxDCye0C0=;
        b=oyzbKZOzgvJW4uTItZHk6KeM5N8x8JPX02yTHo84APS/ec81eHU/GSGasihc12hUnq
         kyC7w1g3b6RxL55kn8RgFNxBh2g/r4rEqRhvYisQ+gVgIe/rbEmSvFOTuYAov43BMwwK
         m22i1dajuAjcIsuNy4GceeSUwWWjcYzv/BAyrGy/Jkfkohg+Kw0vLUjFM48E5PAgAtf+
         g11ovr7MjOuN267lI7Z/gElX578fgy/jM/E4EqtxW9jzfzvnWeuG4Cc53TLkIpvFFYAL
         zrog55dkjB+/yAc75e2ELoAWHLJUZ3X9c3khBuGYm9ytRakX+Hyh3h4QO/hIBvzFDVYc
         fDqg==
X-Gm-Message-State: AOJu0YwxSgmjjFD0Jqe41wRPoJ6uMjq8hnrlUlxu2oXvNBfQGI17v+OW
	SMZex3ci159A8Zzfd35Vg2TV
X-Google-Smtp-Source: AGHT+IGCdgvNrhLjs0RBnM3O7h6Ri70uA7en86HSqfGY/HAxnYl36rBdMYafIeqWPJt4yM0F6QD9XA==
X-Received: by 2002:a05:620a:4156:b0:775:cf5f:8a57 with SMTP id k22-20020a05620a415600b00775cf5f8a57mr8673614qko.7.1700109228335;
        Wed, 15 Nov 2023 20:33:48 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a005a00b0077263636a95sm4006757qkt.93.2023.11.15.20.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:47 -0800 (PST)
Date: Wed, 15 Nov 2023 23:33:47 -0500
Message-ID: <4f8c441e02222f063242adfbf4d733e1.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 13/23] security: Introduce file_pre_free_security hook
References: <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the file_pre_free_security hook.
> 
> IMA calculates at file close the new digest of the file content and writes
> it to security.ima, so that appraisal at next file access succeeds.
> 
> LSMs could also take some action before the last reference of a file is
> released.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/file_table.c               |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  4 ++++
>  security/security.c           | 11 +++++++++++
>  4 files changed, 17 insertions(+)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index de4a2915bfd4..64ed74555e64 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -385,6 +385,7 @@ static void __fput(struct file *file)
>  	eventpoll_release(file);
>  	locks_remove_file(file);
>  
> +	security_file_pre_free(file);

I worry that security_file_pre_free() is a misleading name as "free"
tends to imply memory management tasks, which isn't the main focus of
this hook.  What do you think of security_file_release() or
security_file_put() instead?

>  	ima_file_free(file);
>  	if (unlikely(file->f_flags & FASYNC)) {
>  		if (file->f_op->fasync)

--
paul-moore.com

