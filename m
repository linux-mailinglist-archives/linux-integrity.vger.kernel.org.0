Return-Path: <linux-integrity+bounces-9827-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cuzHJvkgO2pERQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9827-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2026 02:12:41 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB166BAAEE
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2026 02:12:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=LVvRIu8k;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9827-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9827-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70D003062F6B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2026 00:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B4930D402;
	Wed, 24 Jun 2026 00:12:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2130C60D
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2026 00:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782259956; cv=none; b=tkwYnSzTNatULNC7wQhExU5Qv/1tQbub0Jvj/SN9DmucCuvoRntW+H+RS5xCAulYwQ/9Pqrriod77leropfomCrtIXipDJWkiTPul2/6os5equaRUuKibUuAk/tDgAcz7mzG49EOnT1+/VbmRcMMe6KdZt61FFLzgrf1oneuWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782259956; c=relaxed/simple;
	bh=Sy2PS2sfg70bsWbRUrWVtcPFYfjxXLcEupysUZUB9j8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=CuBAURKlIg/X7o6Xoi86e1gN1OBRMb/GjmsB5k1yYY2mOj/ikqptSr9HL+p/VpL0mxVRWrLlxlCyZp26d9IpsfQ2tw4yHQq7ZCbnYzcY8e0xxqxOxYtf2MbCWr9UEra1lVNOdW/E/k1pfYGJDRtGWKUgnnYY5RdGZJYGxX2DbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LVvRIu8k; arc=none smtp.client-ip=209.85.222.182
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-915aa0a9293so164716585a.1
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jun 2026 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782259954; x=1782864754; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4NCFUP999Ds9RO+xlaZQifH2V/EVBrDecHJD/NPIfk=;
        b=LVvRIu8kICrDLGZshHGRd4MAaJsBRxTYDK/Ygj0Dqvv7+IYNrzu6ulGyc4QM3yRqTb
         s4PMF141a3D1pXMsTfcxSYrzGVg1dSgqwjybfw0seG+aklNEyuSluffGN4sEj/UEeQd/
         27SczJyBVdBSe/55sp4uVLYwtCPh5LloBIURMelh3x4kpXU56ZQC0qQVZvxhjaY2+566
         dij15g7fS3+ULaRo5TcpepMv8z63wfda5iVoIsMBSpaBcxMT8rS9LNmexYuhGT4tkO/d
         e0TQE3kZk/oZ063mwlXKOaXj/s6ZSI8XsWjP+MQDxTtsA/y5Z54BCZtXqRXlMGsFLUwK
         oqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782259954; x=1782864754;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4NCFUP999Ds9RO+xlaZQifH2V/EVBrDecHJD/NPIfk=;
        b=FZuBl+jkfvotIXCzT0YyFrHyduFK86FO+KcgH6pKPSevqsV6pgOzslF1/W5M8AmwHM
         +F42HgrExGICcPH1K6TGza12HJVT279zLnpemSvB1nOERqSu4m4JS6nrb9OLHte3SCX4
         ofsjjT8bMPP7oaEALY8Yc3K2IyJvuQHoYFJn2kmNbE78WmS4Z7FoVWHL2/VAkBms2F3E
         FGXi69Iom0Bh1ieEyWGu1IH/Umm1XTIEyjU2LZWocbryYDoC/xMdX+aL8A2WByJd1VRT
         h+xB+AyvvCB8qjiiNrwHv1QulMNWWwH6fCi9KCAet6+wSwLzjg5EeMNPVW5BQHFHeHuR
         cWug==
X-Forwarded-Encrypted: i=1; AFNElJ/NuqUPtqH2VMhzj7qPMLj99ShzNJxdae5BHLVaRHohZz63+90E8XOIggZiL/O7dZAyZLoIJQnzyZ83XpArF7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyBq5n1VhpBMnekG7kcapBw4tEZbMbeJr+e/2/c+VOz5EpzHr
	rv+PNFIvLpmra28JT8pXeYE+WDr9tY0L+ql9wO4IEEjP+pHNsYgcsAEOg5vBFeSFwLhykMiWpnV
	KJnvgaGTR
X-Gm-Gg: AfdE7ckZTwc55tGsFZ1oFrHhnyk5MmeORGCIbSD0BfU5rHClbZSvIt2kRec6HsgZo3B
	7gi0DL7Jjkon6fl0jVk2OMc3fYBuAx9fDyBdHODfNi2mGasS2ff0s0Jj2r03P3UstsSYsLdt9q2
	zNkjhbRS7Ac+7hQUjJitR+b4j1ze/IaqRndjwCuCRIQj/DkuALsHOl52GcjEeHhoyB56hLxFBzR
	o6VSkLPKnxXBBMykTT1CtxrFHBaZXmI+IJzBFmmMOn7dWWIKFv0FWC6B30z2ccOuOaiaC1G4h1L
	thfdOBA7A4dUVs5V7DJOnnk5SAakmNkAlKYgEqkcv2/yH/UHSGIKiVCjTWQEC5BRLMuutnS0bTX
	OeUGjcdHK6n9xtrJmnInSQ11NqeHI+DEQtlMknk3rYWTyKkGluq5+t4A80iGEbirTK27GYjZi86
	XBf39n1WqgyEA8dXswVEQM4HOMf2957cSTOA6TbTKVhTZQBnljacRv13SEZcHnEPpQTsWo
X-Received: by 2002:a05:620a:1990:b0:915:e8fc:1396 with SMTP id af79cd13be357-92600e7207cmr879162585a.13.1782259954066;
        Tue, 23 Jun 2026 17:12:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926005a2530sm401515985a.39.2026.06.23.17.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 17:12:33 -0700 (PDT)
Date: Tue, 23 Jun 2026 20:12:32 -0400
Message-ID: <75d39fd9847cca915d704235264ab474@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260623_1615/pstg-lib:20260623_1751/pstg-pwork:20260623_1615
From: Paul Moore <paul@paul-moore.com>
To: David Windsor <dwindsor@gmail.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, kpsingh@kernel.org, mattbobrowski@google.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, David Windsor <dwindsor@gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic  inode labeling
References: <20260618203411.73917-2-dwindsor@gmail.com>
In-Reply-To: <20260618203411.73917-2-dwindsor@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9827-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,iogearbox.net,linux.dev,etsalapatis.com,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_RECIPIENTS(0.00)[m:dwindsor@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernsec.org:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BB166BAAEE

On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> 
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> 
> The inode_init_security hook previously took the xattr array and count
> as two separate output parameters (struct xattr *xattrs, int
> *xattr_count), which BPF programs cannot write to. Pass the xattr state
> as a single context object (struct xattr_ctx) instead, and have
> bpf_init_inode_xattr() take that context directly. Update the existing
> in-tree callers of inode_init_security to take and forward the new
> xattr_ctx.
> 
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant.
> 
> Because we rely on the hook-specific ctx layout, the kfunc is
> restricted to lsm/inode_init_security. Restrict the xattr names that
> may be set via this kfunc to the bpf.* namespace.
> 
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c                | 106 +++++++++++++++++++++++++++++-
>  include/linux/bpf.h               |   1 +
>  include/linux/bpf_lsm.h           |   3 +
>  include/linux/evm.h               |   9 +--
>  include/linux/lsm_hook_defs.h     |   4 +-
>  include/linux/lsm_hooks.h         |  16 ++---
>  include/linux/security.h          |   5 ++
>  kernel/bpf/bpf_lsm.c              |  10 +++
>  kernel/bpf/trampoline.c           |   3 +
>  security/bpf/hooks.c              |   1 +
>  security/integrity/evm/evm_main.c |   8 ++-
>  security/security.c               |   7 +-
>  security/selinux/hooks.c          |   4 +-
>  security/smack/smack_lsm.c        |  27 ++++----
>  14 files changed, 166 insertions(+), 38 deletions(-)

I have a few specific comments below, inline with the patch, but I wanted
to make some general comments too.

The kfunc additions really don't belong in the VFS kfunc file, please
create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add the
kfunc code to this new file.

While moving the kfunc additions to a LSM kfunc file does sort of convert
the VFS changes into LSM changes, Christian's comment about splitting
this patch two patches, one with the LSM hook changes and one with the
BPF additions, is still reasonable and a good suggestion.  I would still
CC the VFS folks on these patches and I would encourage reviews from the
VFS folks as there is a VFS component here, albeit a somewhat small one.

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..7abc3f3d1a67 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -10,6 +10,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
> +#include <linux/lsm_hooks.h>
>  #include <linux/mm.h>
>  #include <linux/xattr.h>
>  
> @@ -374,6 +375,97 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
>  	return d_real_inode(dentry);
>  }
>  
> +static int bpf_xattrs_used(const struct xattr_ctx *ctx)
> +{
> +	const size_t prefix_len = sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> +	int i, n = 0;
> +
> +	for (i = 0; i < *ctx->xattr_count; i++) {
> +		const char *name = ctx->xattrs[i].name;
> +
> +		if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_len))
> +			n++;
> +	}
> +	return n;
> +}
> +
> +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> +				  const char *name__str,
> +				  const struct bpf_dynptr *value_p)
> +{
> +	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
> +	size_t name_len;
> +	void *xattr_value;
> +	struct xattr *xattr;
> +	struct xattr *xattrs;
> +	int *xattr_count;
> +	const void *value;
> +	u32 value_len;
> +
> +	if (!xattr_ctx || !name__str)
> +		return -EINVAL;
> +
> +	xattrs = xattr_ctx->xattrs;
> +	xattr_count = xattr_ctx->xattr_count;

I'm not sure why the "xattrs" and "xattrs_count" local variables are
necessary, especially since they only appear to be used in the sanity
check below.  I would suggest just using the values in the struct
directly.

> +	if (!xattrs || !xattr_count)
> +		return -EINVAL;
> +	if (bpf_xattrs_used(xattr_ctx) >= BPF_LSM_INODE_INIT_XATTRS)
> +		return -ENOSPC;
> +
> +	name_len = strlen(name__str);
> +	if (name_len == 0 || name_len > XATTR_NAME_MAX)
> +		return -EINVAL;
> +	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +		return -EPERM;
> +
> +	value_len = __bpf_dynptr_size(value_ptr);
> +	if (value_len == 0 || value_len > XATTR_SIZE_MAX)
> +		return -EINVAL;
> +
> +	value = __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	/* Combine xattr value + name into one allocation. */
> +	xattr_value = kmalloc(value_len + name_len + 1, GFP_KERNEL);
> +	if (!xattr_value)
> +		return -ENOMEM;
> +
> +	memcpy(xattr_value, value, value_len);
> +	memcpy(xattr_value + value_len, name__str, name_len);
> +	((char *)xattr_value)[value_len + name_len] = '\0';
> +
> +	xattr = lsm_get_xattr_slot(xattr_ctx);
> +	if (!xattr) {
> +		kfree(xattr_value);
> +		return -ENOSPC;
> +	}
> +
> +	xattr->value = xattr_value;
> +	xattr->name = (const char *)xattr_value + value_len;
> +	xattr->value_len = value_len;
> +
> +	return 0;
> +}
> +
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
> + * @xattr_ctx: inode_init_security xattr state from the hook context
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs.
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> +				     const char *name__str,
> +				     const struct bpf_dynptr *value_p)
> +{
> +	return __bpf_init_inode_xattr(xattr_ctx, name__str, value_p);
> +}

I'm sure there is a reason why you split the code out into
__bpf_init_inode_xattr() as opposed to just putting it directly in this
kfunc, can you help me understand?

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 153e9043058f..1f8e84e7dd7e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -68,6 +68,11 @@ struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
>  
> +struct xattr_ctx {
> +	struct xattr *xattrs;
> +	int *xattr_count;
> +};

I see the bots already pointed this out, and you acknowledged it, but
since I'm looking at this I felt obliged to remind you once again about
the rename to "struct lsm_xattrs" :)

Also, looking at this closer, is there a reason why the "xattr_count"
field is an integer pointer and not just an integer?  We're passing
the entire struct by reference to the individual LSMs so we shouldn't
need this to get an updated count in the caller and having it as a
regular integer should simplify things slightly (you could also
make it an unsigned int while you are it).
 
> @@ -315,6 +324,7 @@ BTF_ID(func, bpf_lsm_inode_create)
>  BTF_ID(func, bpf_lsm_inode_free_security)
>  BTF_ID(func, bpf_lsm_inode_getattr)
>  BTF_ID(func, bpf_lsm_inode_getxattr)
> +BTF_ID(func, bpf_lsm_inode_init_security)
>  BTF_ID(func, bpf_lsm_inode_mknod)
>  BTF_ID(func, bpf_lsm_inode_need_killpriv)
>  BTF_ID(func, bpf_lsm_inode_post_setxattr)
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 1a721fc4bef5..b41b02173e24 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
>  	}
>  	if (cnt >= BPF_MAX_TRAMP_LINKS)
>  		return -E2BIG;
> +	if (node->link->prog->aux->attach_limit &&
> +	    tr->progs_cnt[kind] >= node->link->prog->aux->attach_limit)
> +		return -E2BIG;

Re: Alexei's comments about this - if you look back at my previous
comments, my concern was around BPF LSMs using too many slots in the
xattr array and causing issues.  If the BPF folks want to do that check
in the kfunc located in the LSM framework I'm okay with that; the
important part is that the BPF LSMs don't use more space than they
previously requested.

> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf014..8f82a1352356 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1334,6 +1334,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  {
>  	struct lsm_static_call *scall;
>  	struct xattr *new_xattrs = NULL;
> +	struct xattr_ctx xattr_ctx;
>  	int ret = -EOPNOTSUPP, xattr_count = 0;

Since we have the xattr array/pointer and count in the new "lsm_xattrs"
struct, I think we can remove the "new_xattrs" and "xattr_count" local
variables in favor of the fields in the new struct.

>  	if (unlikely(IS_PRIVATE(inode)))
> @@ -1349,10 +1350,12 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  		if (!new_xattrs)
>  			return -ENOMEM;
>  	}
> +	xattr_ctx.xattrs = new_xattrs;
> +	xattr_ctx.xattr_count = &xattr_count;
>  
>  	lsm_for_each_hook(scall, inode_init_security) {
> -		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
> -						  &xattr_count);
> +		ret = scall->hl->hook.inode_init_security(inode, dir, qstr,
> +							  &xattr_ctx);
>  		if (ret && ret != -EOPNOTSUPP)
>  			goto out;
>  		/*

--
paul-moore.com

