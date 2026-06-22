Return-Path: <linux-integrity+bounces-9822-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gbYVNibMOWp6xgcAu9opvQ
	(envelope-from <linux-integrity+bounces-9822-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 01:58:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2826B2E20
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 01:58:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EArQ0biK;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9822-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9822-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC204300FC66
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jun 2026 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A213372B24;
	Mon, 22 Jun 2026 23:57:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D136A377
	for <linux-integrity@vger.kernel.org>; Mon, 22 Jun 2026 23:57:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172633; cv=none; b=U+i76ktR1uMdhvCwXYMG6eHwk+s1P30+ObxKFJ7O68e6s0u/24b8P0GsU6wSorzSgkHxyd2pL9s+YaeIJWdhJnZTy9KfVGugxhQPd/ayOq3+/T7keNd1xgFbs0eK9GQ4LgtYIYUw0Bt87gZSL8Y8vLlhMEq9LnVwRxgoPt/qrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172633; c=relaxed/simple;
	bh=APQyAu8u5IH9CVRpou0XR9SFmkwuafb3rUB0ZW/wfg4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AepcG++iaQ8/z6DWA2h7EdN2WQp7dlgW+drOl1hwfZErj5DVCO9MBhqu7FQNgvEg6K+rmeddlnN5jHpVdiz1eocrRf2s2jniZVIAb5Fz5jfAvLxaYrgo/oxoxG7qGp72yCyuXPDDRPqBbmJGJ1qQzci4EpdOfdiAZ1gcTfxbFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EArQ0biK; arc=none smtp.client-ip=209.85.210.49
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e94d272a86so1736749a34.2
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jun 2026 16:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782172631; x=1782777431; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Xre0hTc6txTQLEgTuWM5CYVELF8O6F2bFrxuzUUqLo=;
        b=EArQ0biKUGHv5IGKPM1wrGTSzDWbilnOwNZZdp0CTBtiNn7F4v0VTAKSBlLCaY5CtW
         sQvOaTp+TczJCRslPzHlMRGrCDt/2RFTelBqw7UJ9VB6/0BkGQnBbM+UYtLcN3EKVoqA
         Q8ZHAPMzPnIKhfHlWPVJEN616LmLJWpR7l/KVOM1sRhQR2LRjagawQDsiO9q+0BvcXKQ
         jYBhQyHG1kDIITD7AfXgtS2tO3bZzV8gYT+dXYd3lE428S7wfZ+HfKYwjON8szBiJZU+
         3SbZC+tFaX/+7L7J/8qf3MDpii7eznKLzPTuGgbNpZMSUPfocI/rGQV3LuK4OWnN99JE
         ndyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172631; x=1782777431;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Xre0hTc6txTQLEgTuWM5CYVELF8O6F2bFrxuzUUqLo=;
        b=g8HdO79ixOFlddsWI8puVBsnhdGbxQAk8jKYYv8Jro32m9vOyBW9n/312IXdbrohYu
         chp8wCVmkFm07ql/1QPnXH5GTQ6IRxvRee3g6F3VCgsbqNIMG3Gqc0iN7k+FpmdcMQst
         G/Jbnu6GA9fFNjYpdpblWFjX74dHCwnP8ydmNO+tLg1MXR85gTvZ2gQXw9cLRAgyDSzo
         DOY+YFYTjSI6XxeibNg6fg6L10J5RV4HTosuJxAKyjhryZO1rr9dQDOvtk9NMX69JE5z
         66Ro+iTFIWuMR/vDK7jK1zbv2um/Zw7Ia1Ev5UBTkh2hpy8FgDn/o4fpHwYEdLjx84kY
         RUsA==
X-Forwarded-Encrypted: i=1; AFNElJ/5TOdJFpXVr6trYKInAuF1MWxBpO4vsiAA5J+3EJoUS9OusO9242VzKb/Y0LStmFwI2BckwYuHhwO/cMyqxfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wxCneFf3eGPXcsI3U7flXMttr3bDM3oKXwKMNBr++NTjSwx2
	WrM5sGpk6oizSES4g6cvuCJprfeNpbSELL8x954JXkyKXwh9fB4BSvaD
X-Gm-Gg: AfdE7cmIRDFR+qIwP8PJPrSGTsYEMlsQDLrRlR+44rPNXQqYdAc/jbglVGQiMt6aKtw
	vJG0OjGbxGqk7el8wMTWiTsiRcOPULC+ipQGR24A9Y9rpKsN4FKOsbzhng9K0WySzILBAYSiqX+
	lfqi7SeSzetPt8UKhiyAbGpbOv9cumuUwPtj2FoZuE7xOmrvQOX9KkpyZdqNYFYJymGvhVYZSn4
	tr50TYObdU+ctSd/8D3EWu0Yyxir5u3Laa9pTOb0yQVwASCWMLZdw3uC3zbvtz6UC2P/LP15vao
	B10XAy5vcd5gLRe21x3c8s6mRSA5W1lxo6Qa93e0ehwIC3P3jOPeIi3FKz8qpcTtcnrvIM+z47T
	ZJgET+AeRHFmc8rImLY66nGui6fPj9CiyB8xwRDVV/oCUD4V8gwmIbR4YSkAlKHUaw963W6I4Lj
	kTNi/b4Nw6YSRz/t0jvAAFpKNT/geuvalN8rHIzKAE3arZUq7Jt1Z+vsxYr/IQerV1L8Z0y/EF+
	Zky3JU=
X-Received: by 2002:a05:6830:440c:b0:7e7:868:ded5 with SMTP id 46e09a7af769-7e9799211bdmr289228a34.18.1782172630489;
        Mon, 22 Jun 2026 16:57:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944008fe7sm7895698a34.6.2026.06.22.16.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 16:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 16:57:08 -0700
Message-Id: <DJFZGYZFMN73.1799LMXW49WZO@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <selinux@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>, <viro@zeniv.linux.org.uk>,
 <brauner@kernel.org>, <jack@suse.cz>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <kpsingh@kernel.org>, <mattbobrowski@google.com>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
 <dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
 <stephen.smalley.work@gmail.com>, <omosnace@redhat.com>,
 <casey@schaufler-ca.com>, <shuah@kernel.org>
X-Mailer: aerc
References: <20260618203411.73917-1-dwindsor@gmail.com>
 <20260618203411.73917-2-dwindsor@gmail.com>
In-Reply-To: <20260618203411.73917-2-dwindsor@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,linux-integrity@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,iogearbox.net,linux.dev,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dwindsor@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9822-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC2826B2E20

On Thu Jun 18, 2026 at 1:34 PM PDT, David Windsor wrote:
> +
> +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> +				  const char *name__str,
> +				  const struct bpf_dynptr *value_p)
> +{
> +	struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)value_p=
;
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
> +	xattrs =3D xattr_ctx->xattrs;
> +	xattr_count =3D xattr_ctx->xattr_count;
> +	if (!xattrs || !xattr_count)
> +		return -EINVAL;
> +	if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> +		return -ENOSPC;

This check is good to have, but it's enough. No need to duplicate it.
More below.

> +
> +	name_len =3D strlen(name__str);
> +	if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> +		return -EINVAL;
> +	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +		return -EPERM;
> +
> +	value_len =3D __bpf_dynptr_size(value_ptr);
> +	if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> +		return -EINVAL;
> +
> +	value =3D __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	/* Combine xattr value + name into one allocation. */
> +	xattr_value =3D kmalloc(value_len + name_len + 1, GFP_KERNEL);
> +	if (!xattr_value)
> +		return -ENOMEM;
> +
> +	memcpy(xattr_value, value, value_len);
> +	memcpy(xattr_value + value_len, name__str, name_len);
> +	((char *)xattr_value)[value_len + name_len] =3D '\0';
> +
> +	xattr =3D lsm_get_xattr_slot(xattr_ctx);
> +	if (!xattr) {
> +		kfree(xattr_value);
> +		return -ENOSPC;
> +	}
> +
> +	xattr->value =3D xattr_value;
> +	xattr->name =3D (const char *)xattr_value + value_len;
> +	xattr->value_len =3D value_len;
> +
> +	return 0;
> +}
> +
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_se=
curity
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
> +
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -385,13 +477,25 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE=
)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_init_inode_xattr, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
> =20
> +BTF_ID_LIST(bpf_lsm_inode_init_security_btf_ids)
> +BTF_ID(func, bpf_lsm_inode_init_security)
> +
> +BTF_ID_LIST(bpf_init_inode_xattr_btf_ids)
> +BTF_ID(func, bpf_init_inode_xattr)
> +
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
>  {
>  	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> -	    prog->type =3D=3D BPF_PROG_TYPE_LSM)
> +	    prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> +		/* bpf_init_inode_xattr only attaches to inode_init_security. */
> +		if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> +		    prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_security_btf_ids[=
0])
> +			return -EACCES;

This is unnecessary. Only one hook will have xattr_ctx type.
The normal verifier type enforcement will do its work.

>  		return 0;
> +	}
>  	return -EACCES;
>  }
> =20
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..f14bfcda78db 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1752,6 +1752,7 @@ struct bpf_prog_aux {
>  	u32 real_func_cnt; /* includes hidden progs, only used for JIT and free=
ing progs */
>  	u32 func_idx; /* 0 for non-func prog, the index in func array for func =
prog */
>  	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
> +	u32 attach_limit; /* max concurrent attachments (0 =3D unlimited) */

no need.

>  	u32 attach_st_ops_member_off;
>  	u32 ctx_arg_info_size;
>  	u32 max_rdonly_access;
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 143775a27a2a..b655c708818e 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -19,6 +19,9 @@
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
> =20
> +/* max bpf xattrs per inode */
> +#define BPF_LSM_INODE_INIT_XATTRS 4
> +
>  struct bpf_storage_blob {
>  	struct bpf_local_storage __rcu *storage;
>  };
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 913f4573b203..0aa151288b36 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -12,6 +12,8 @@
>  #include <linux/integrity.h>
>  #include <linux/xattr.h>
> =20
> +struct xattr_ctx;
> +
>  #ifdef CONFIG_EVM
>  extern int evm_set_key(void *key, size_t keylen);
>  extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
> @@ -21,8 +23,8 @@ extern enum integrity_status evm_verifyxattr(struct den=
try *dentry,
>  int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
>  		 const char *xattr_value, size_t xattr_value_len);
>  int evm_inode_init_security(struct inode *inode, struct inode *dir,
> -			    const struct qstr *qstr, struct xattr *xattrs,
> -			    int *xattr_count);
> +			    const struct qstr *qstr,
> +			    struct xattr_ctx *xattr_ctx);
>  extern bool evm_revalidate_status(const char *xattr_name);
>  extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
>  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
> @@ -63,8 +65,7 @@ static inline int evm_fix_hmac(struct dentry *dentry, c=
onst char *xattr_name,
> =20
>  static inline int evm_inode_init_security(struct inode *inode, struct in=
ode *dir,
>  					  const struct qstr *qstr,
> -					  struct xattr *xattrs,
> -					  int *xattr_count)
> +					  struct xattr_ctx *xattr_ctx)
>  {
>  	return 0;
>  }
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 65c9609ec207..f62780fbeb9e 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -116,8 +116,8 @@ LSM_HOOK(int, 0, inode_alloc_security, struct inode *=
inode)
>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_securi=
ty)
>  LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
> -	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
> -	 int *xattr_count)
> +	 struct inode *dir, const struct qstr *qstr,
> +	 struct xattr_ctx *xattr_ctx)
>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>  	 const struct qstr *name, const struct inode *context_inode)
>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index b4f8cad53ddb..710e48caaeba 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -200,20 +200,18 @@ extern struct lsm_static_calls_table static_calls_t=
able __ro_after_init;
> =20
>  /**
>   * lsm_get_xattr_slot - Return the next available slot and increment the=
 index
> - * @xattrs: array storing LSM-provided xattrs
> - * @xattr_count: number of already stored xattrs (updated)
> + * @ctx: xattr state shared by inode_init_security hooks
>   *
> - * Retrieve the first available slot in the @xattrs array to fill with a=
n xattr,
> - * and increment @xattr_count.
> + * Retrieve the first available slot in the @ctx->xattrs array to fill w=
ith an
> + * xattr, and increment @ctx->xattr_count.
>   *
> - * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
> + * Return: The slot to fill in @ctx->xattrs if non-NULL, NULL otherwise.
>   */
> -static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
> -					       int *xattr_count)
> +static inline struct xattr *lsm_get_xattr_slot(struct xattr_ctx *ctx)
>  {
> -	if (unlikely(!xattrs))
> +	if (unlikely(!ctx || !ctx->xattrs || !ctx->xattr_count))
>  		return NULL;
> -	return &xattrs[(*xattr_count)++];
> +	return &ctx->xattrs[(*ctx->xattr_count)++];
>  }
> =20
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 153e9043058f..1f8e84e7dd7e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -68,6 +68,11 @@ struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
> =20
> +struct xattr_ctx {
> +	struct xattr *xattrs;
> +	int *xattr_count;
> +};
> +
>  /* Default (no) options for the capable function */
>  #define CAP_OPT_NONE 0x0
>  /* If capable should audit the security request */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 564071a92d7d..86a8e188b900 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -113,6 +113,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *=
prog,
>  }
>  #endif
> =20
> +BTF_ID_LIST_SINGLE(bpf_lsm_inode_init_security_btf_ids, func,
> +		   bpf_lsm_inode_init_security)
> +
>  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  			const struct bpf_prog *prog)
>  {
> @@ -137,6 +140,12 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlo=
g,
>  		return -EINVAL;
>  	}
> =20
> +	/* bpf reserves a fixed number of xattr slots for itself.
> +	 * Set the attach limit so the trampoline rejects excess attaches.
> +	 */
> +	if (btf_id =3D=3D bpf_lsm_inode_init_security_btf_ids[0])
> +		prog->aux->attach_limit =3D BPF_LSM_INODE_INIT_XATTRS;
> +
>  	return 0;
>  }
> =20
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
> @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_trampol=
ine *tr,
>  	}
>  	if (cnt >=3D BPF_MAX_TRAMP_LINKS)
>  		return -E2BIG;
> +	if (node->link->prog->aux->attach_limit &&
> +	    tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limit)
> +		return -E2BIG;

No need. The check inside kfunc is enough.

>  	if (!hlist_unhashed(&node->tramp_hlist))
>  		/* prog already linked */
>  		return -EBUSY;
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 40efde233f3a..d7c44c5c0e30 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -30,6 +30,7 @@ static int __init bpf_lsm_init(void)
> =20
>  struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init =3D {
>  	.lbs_inode =3D sizeof(struct bpf_storage_blob),
> +	.lbs_xattr_count =3D BPF_LSM_INODE_INIT_XATTRS,
>  };
> =20
>  DEFINE_LSM(bpf) =3D {
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index b59e3f121b8a..e0a05162accc 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentry =
*src, const char *name)
>   * evm_inode_init_security - initializes security.evm HMAC value
>   */
>  int evm_inode_init_security(struct inode *inode, struct inode *dir,
> -			    const struct qstr *qstr, struct xattr *xattrs,
> -			    int *xattr_count)
> +			    const struct qstr *qstr,
> +			    struct xattr_ctx *xattr_ctx)

the rest looks good.
Pls split the patch. Introduce xattr_ctx first across the LSMs.
Then another patch with a new kfunc.

pw-bot: cr

