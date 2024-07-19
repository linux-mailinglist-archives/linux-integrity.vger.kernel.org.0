Return-Path: <linux-integrity+bounces-3192-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3E937243
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 04:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4205B1F21DAA
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 02:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6A2C6BB;
	Fri, 19 Jul 2024 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R2HdDESA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7CC2E9
	for <linux-integrity@vger.kernel.org>; Fri, 19 Jul 2024 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354887; cv=none; b=hHW8T6Jd/oBs05ccJWVRWWRTQdtUcKe3hSGmzN+a5YGqGttQ9H/kknUdWF1AO6lGQZ+XTyS2mqJlF0vLqfCK828g3qDVUwnIEo7FE/kk6/LpK7ELGB/HrmaYIzSh5Ygsw7FipVYAQFXn7BS4YVMNBIUyAPnhx1TiSnSvV99P3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354887; c=relaxed/simple;
	bh=N9VtmOA2CZ7AtDs1kaLuyO3Hz5gtcylTAyJD4LCqPCk=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=MYXu3ZeU5xYfeoB7Bs4TJCKD0tBiKV7/zWV9r0b/MhrprCXZrkaBgCntqxCQxQzBHNCO29j/3Zhi/HtvAt9hBkQM5Jg+b5O6nk9d9LiSUPR7HxOxdutJT6yoZ3IDVTeprYq6CqQ2f1QaZI6Nkjsbf+vam3FM5KWwheJd7pATv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R2HdDESA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-447f25e65f9so5054021cf.3
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2024 19:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354883; x=1721959683; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W46zMqk+puPVOWPgqC0n0Bh4/6AFufXxbQY/SLtmI2E=;
        b=R2HdDESAmjgRFeHWKE73JevgoERcf9q5LVUYYK4w2j/sUZ1FAgaN425Rn3KtmDvV5B
         eBP+YDY4Yi5wRMkrw0SzyljZSZQa12xvsGUdn7wb7tiVSCnYj/e/gU6XjRcOjdWsFxtN
         73AHi7JR6VQ8hRHNxfEhjAAtbgBdjZQWsmMVwn/Z7QKo6BSjKNZm/Pt7DwjT4US1pDY+
         4ROupCappdzpwgDBCRcsw9xW/Yx30Y729NbhfdjBc0m6rutbtuSq4xzTGl1QWHsKsfO0
         SSFeZId6/oYYDPYwOvXPsSefFkrcbJZjynarF6f1QisS+oSMgAuHMooL2ahMSRG5F05n
         KbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354883; x=1721959683;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W46zMqk+puPVOWPgqC0n0Bh4/6AFufXxbQY/SLtmI2E=;
        b=fuotONUqQbdSu8bWllAhz6A5EOeXhlZ/Qa1MmvkbEvKURYT07J4UsBQRgMWF2RGTyu
         xvIh440vJjToW3LzZ8gwaZg9E/coV/UNG2XfSjFZJwiTm/X7lmKoyNOIrC3cD8TvZ5wZ
         bUPVBNZ3Wsz9he2H2nyCjCwYXjH047ufaRApdSqTscQPgEWgvJcpQYvHCto8qs45jiQe
         Leqlcnp2dKQ7nO6aEjNGj/D8shCaiqBu1aKP7wCpT2tKRHBiM2HvXtCIGWcv3EJ4hU3M
         37BgBbT3Iz8266xlcJPGyEDkpFmn0EEH9P0bbuKoLcEwuDPtUIkRJqSVS3/i6g7MrAb9
         44SA==
X-Forwarded-Encrypted: i=1; AJvYcCW/reUuNm+MdNfOKCCAfbVKUSaPfsegQfe5diuoF2caXOeHni3SwqLnxPbx7NkDRd31QO5o7hGta1Wbdw/rD4ZHx6luPEXcLEyuZ3QlQWaV
X-Gm-Message-State: AOJu0YwbbNg5FTmtVxvgZZe25t1oo/TIklN8YLklgL2uTDzgUZ/+Ipi0
	2G/OT1JYGuXqc8wGaTRITn9MErGU2/nDZujr8artgoH4K6uX/zov9KGFytpVHQ==
X-Google-Smtp-Source: AGHT+IHAB/7v8AnbYBI4GnYhg3v3lb8gipVsrnzh20ocfsvMZ6KveEYeCa8g0OpsV/6jid0s4DZw3g==
X-Received: by 2002:ac8:5fd1:0:b0:447:f7cf:7022 with SMTP id d75a77b69052e-44f96ac4d5dmr34879841cf.40.1721354883337;
        Thu, 18 Jul 2024 19:08:03 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdc3004sm1809971cf.80.2024.07.18.19.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:03 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:02 -0400
Message-ID: <4334eeb3a58ec81c5148d47db5c83765@paul-moore.com>
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
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 4/20] lsm: Refactor return value of LSM hook  inode_listsecurity
References: <20240711111908.3817636-5-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-5-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook inode_listsecurity to 0 or a negative error code.
> 
> Before:
> - Hook inode_listsecurity returns number of bytes used/required on
>   success or a negative error code on failure.
> 
> After:
> - Hook inode_listsecurity returns 0 on success or a negative error
>   code on failure. An output parameter @bytes is introduced to hold
>   the number of bytes used/required on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  fs/nfs/nfs4proc.c             |  5 ++++-
>  fs/xattr.c                    |  5 ++++-
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  7 ++++---
>  net/socket.c                  |  9 +++++----
>  security/security.c           | 29 +++++++++++++++++++++++++----
>  security/selinux/hooks.c      |  8 +++++---
>  security/smack/smack_lsm.c    |  6 ++++--
>  8 files changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index a691fa10b3e9..6d75758ba3d5 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7848,10 +7848,13 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
>  static ssize_t
>  nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
>  {
> +	size_t bytes;
>  	int len = 0;
>  
>  	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
> -		len = security_inode_listsecurity(inode, list, list_len);
> +		len = security_inode_listsecurity(inode, list, list_len, &bytes);
> +		if (!len)
> +			len = bytes;
>  		if (len >= 0 && list_len && len > list_len)
>  			return -ERANGE;
>  	}

See my comments below.

> diff --git a/fs/xattr.c b/fs/xattr.c
> index f4e3bedf7272..ab7d7123a016 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -485,6 +485,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
>  {
>  	struct inode *inode = d_inode(dentry);
>  	ssize_t error;
> +	size_t bytes;
>  
>  	error = security_inode_listxattr(dentry);
>  	if (error)
> @@ -493,7 +494,9 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
>  	if (inode->i_op->listxattr) {
>  		error = inode->i_op->listxattr(dentry, list, size);
>  	} else {
> -		error = security_inode_listsecurity(inode, list, size);
> +		error = security_inode_listsecurity(inode, list, size, &bytes);
> +		if (!error)
> +			error = bytes;
>  		if (size && error > size)
>  			error = -ERANGE;

More on this below, but since the buffer length is fixed we are
already going to have to do a length comparison in the LSMs, why not
do the check and return -ERANGE there?

> diff --git a/net/socket.c b/net/socket.c
> index e416920e9399..43f0e3c9a6e0 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -571,12 +571,13 @@ static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
>  static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
>  				size_t size)
>  {
> -	ssize_t len;
> +	int err;
> +	size_t len;
>  	ssize_t used = 0;
>  
> -	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
> -	if (len < 0)
> -		return len;
> +	err = security_inode_listsecurity(d_inode(dentry), buffer, size, &len);
> +	if (err < 0)
> +		return err;
>  	used += len;
>  	if (buffer) {
>  		if (size < used)

It doesn't show in the patch/diff, but if the LSM hook handles the length
comparison we can simplify the -ERANGE code in sockfs_listxattr().

> diff --git a/security/security.c b/security/security.c
> index 614f14cbfff7..26eea8f4cd74 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2597,20 +2597,41 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
>   * @inode: inode
>   * @buffer: buffer
>   * @buffer_size: size of buffer
> + * @bytes: number of bytes used/required
>   *
>   * Copy the extended attribute names for the security labels associated with
>   * @inode into @buffer.  The maximum size of @buffer is specified by
>   * @buffer_size.  @buffer may be NULL to request the size of the buffer
>   * required.
>   *
> - * Return: Returns number of bytes used/required on success.
> + * Return: Returns 0 on success or a negative error code on failure.
>   */
>  int security_inode_listsecurity(struct inode *inode,
> -				char *buffer, size_t buffer_size)
> +				char *buffer, size_t buffer_size,
> +				size_t *bytes)
>  {
> +	int rc;
> +	size_t used;
> +	struct security_hook_list *hp;
> +
>  	if (unlikely(IS_PRIVATE(inode)))
> -		return 0;
> -	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
> +		return *bytes = 0;
> +
> +	used = 0;
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_listsecurity,
> +			     list) {
> +		rc = hp->hook.inode_listsecurity(inode, buffer, buffer_size,
> +						 &used);
> +		if (rc < 0)
> +			return rc;
> +		if (used != 0)
> +			break;
> +	}
> +
> +	*bytes = used;
> +
> +	return 0;
> +
>  }
>  EXPORT_SYMBOL(security_inode_listsecurity);

For reasons associated with the static_call work, we really need to
limit ourselves to the call_{int,void}_hook() macros on any new code.
The good news is that I think we can do that here as the existing
code isn't multi-LSM friendly.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 70792bba24d9..5dedd3917d57 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3481,16 +3481,18 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>  	return 0;
>  }
>  
> -static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
> +static int selinux_inode_listsecurity(struct inode *inode, char *buffer,
> +				      size_t buffer_size, size_t *bytes)
>  {
>  	const int len = sizeof(XATTR_NAME_SELINUX);
>  
>  	if (!selinux_initialized())
> -		return 0;
> +		return *bytes = 0;
>  
>  	if (buffer && len <= buffer_size)
>  		memcpy(buffer, XATTR_NAME_SELINUX, len);
> -	return len;
> +	*bytes = len;
> +	return 0;
>  }

Let's do something like below so we can catch -ERANGE in the LSMs
themselves.

  if (!selinux_initialized())
    return *bytes = 0;

  *bytes = sizeof(XATTR_NAME_SELINUX);
  if (len > buffer_size);
    return -ERANGE;
  if (buffer)
    memcpy(buffer, XATTR_NAME_SELINUX, *bytes);
  
  return 0;

>  static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e7a5f6fd9a2d..6f73906bf7ea 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1611,16 +1611,18 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
>   * @inode: the object
>   * @buffer: where they go
>   * @buffer_size: size of buffer
> + * @bytes: number of data bytes in buffer
>   */
>  static int smack_inode_listsecurity(struct inode *inode, char *buffer,
> -				    size_t buffer_size)
> +				    size_t buffer_size, size_t *bytes)
>  {
>  	int len = sizeof(XATTR_NAME_SMACK);
>  
>  	if (buffer != NULL && len <= buffer_size)
>  		memcpy(buffer, XATTR_NAME_SMACK, len);
>  
> -	return len;
> +	*bytes = len;
> +	return 0;
>  }

A similar approach could be used here.

--
paul-moore.com

