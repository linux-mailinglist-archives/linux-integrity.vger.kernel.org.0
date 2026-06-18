Return-Path: <linux-integrity+bounces-9808-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tzIfFI9hNGobWgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9808-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 23:22:23 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9210D6A2C09
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 23:22:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E4DY6Hnv;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9808-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9808-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCBF13035A98
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E18330678;
	Thu, 18 Jun 2026 21:22:17 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326830C359;
	Thu, 18 Jun 2026 21:22:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781817737; cv=none; b=sfSEr+u4CiC3rpkDZAE8HTz6tF/90iUqlWrLWsnfnSd9QmKhs4eX96crn95i1Kf4gZJc1ihCe/ZfSuR3vm4lgKkHnVaQaVPkFgsqLjg4QKq1pwpImhTiUoi/TQnvjdiZUTI61ImNauuXJB+um02325GXTquokXb1v8oOOt4TqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781817737; c=relaxed/simple;
	bh=rCNOvA5YBtDpCmK2jgwUlqFy5VSDondX3uCrplkg8gc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=u/31odDLzh4yxMYZCbJExj3aONkCro+feV7kwXJOVftbQK+KxEsivzFXjNdFfXq3TUAUtLv9K+8jjP9sdRR75YreCOhKNb7qrY2m5b+DhHqZQfC8ujYT3Dp8EhYb7SL/bKZKx8UZdIckPC6J0UzsWqt2Egsb2Pwkth2I2EEnCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4DY6Hnv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0461F000E9;
	Thu, 18 Jun 2026 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781817736;
	bh=hdssLllREJXnWREWWk3a/kG+iAD5fjAJEKBx+Dsp7+U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=E4DY6Hnv8w1t7dywI6sr+5Y4omZBVVo/LqwWTPpInARF2cPoqnuy2ahIto5spQU03
	 unOquMo+jpm5w70W8RNEIJtq/ZS935UoaYqpRHw3LAzfVKOUQnTZ7eHTs5ng6G0HlY
	 6E0VjLDP/g0o3rPx+Yah0SFqVwd0ITRS2RcGszYZ9pe+9biVxUuh63GGkPiPmled8r
	 TlEQsxA3vtvCjYwH/8ZAQrTOsA/AFc2F638LN18H072FY9O822Q8GFuNCN3PlguNlq
	 iVtC/Gnjf8sLAMQd1Xf+GDnhuC1zxWN//T5Wrdar522nVU65Ymai9xYo1VquxAr2rP
	 W7VAlIvkngxTA==
Content-Type: multipart/mixed; boundary="===============6240919309851150882=="
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9ec622a8a49be299cbbfd459e2fc10693bcd65c6dbf00c9e2645281564e5579@mail.kernel.org>
In-Reply-To: <20260618203411.73917-2-dwindsor@gmail.com>
References: <20260618203411.73917-2-dwindsor@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
From: bot+bpf-ci@kernel.org
To: dwindsor@gmail.com,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,kpsingh@kernel.org,mattbobrowski@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,zohar@linux.ibm.com,roberto.sassu@huawei.com,dmitry.kasatkin@gmail.com,eric.snowberg@oracle.com,stephen.smalley.work@gmail.com,omosnace@redhat.com,casey@schaufler-ca.com,shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-integrity@vger.kernel.org,selinux@vger.kernel.org,linux-kselftest@vger.kernel.org,dwindsor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Jun 2026 21:22:15 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-9808-lists,linux-integrity=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,meta.com];
	FORGED_RECIPIENTS(0.00)[m:dwindsor@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:step
 hensmalleywork@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,iogearbox.net,linux.dev,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9210D6A2C09

--===============6240919309851150882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..7abc3f3d1a67 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

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
> +

Paul Moore suggested in v2 renaming this to 'struct lsm_xattrs' to avoid
overloading the term 'ctx' in the LSM space. The struct was renamed from
'lsm_xattr_ctx' to 'xattr_ctx' in v3, but 'ctx' is still in the name. Was
there a reason to keep 'ctx' in the name, or would renaming to 'lsm_xattrs'
as Paul suggested be preferable?

>  /* Default (no) options for the capable function */
>  #define CAP_OPT_NONE 0x0
>  /* If capable should audit the security request */

[ ... ]

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 564071a92d7d..86a8e188b900 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -113,6 +113,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
>  }
>  #endif
>
> +BTF_ID_LIST_SINGLE(bpf_lsm_inode_init_security_btf_ids, func,
> +		   bpf_lsm_inode_init_security)
> +
>  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  			const struct bpf_prog *prog)
>  {
> @@ -137,6 +140,12 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  		return -EINVAL;
>  	}
>
> +	/* bpf reserves a fixed number of xattr slots for itself.
> +	 * Set the attach limit so the trampoline rejects excess attaches.
> +	 */

This isn't a bug, but a subsystem pattern flags this as potentially
concerning: the BPF subsystem comment-style rule for files under kernel/bpf/
requires multi-line comments to have the opening /* on its own line, with
comment text starting on the next line. The preferred form would be:

	/*
	 * bpf reserves a fixed number of xattr slots for itself.
	 * Set the attach limit so the trampoline rejects excess attaches.
	 */

> +	if (btf_id == bpf_lsm_inode_init_security_btf_ids[0])
> +		prog->aux->attach_limit = BPF_LSM_INODE_INIT_XATTRS;
> +
>  	return 0;
>  }
>

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27788616397
--===============6240919309851150882==--

