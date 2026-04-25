Return-Path: <linux-integrity+bounces-9337-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UmvMMnHN7Gk2cwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9337-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 16:19:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B00A466923
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B763005769
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7350393DE3;
	Sat, 25 Apr 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqaFM3DB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F9392C28;
	Sat, 25 Apr 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777126765; cv=none; b=g54vdmRnOlWlYPGMdJHWwVYbw4BUFjxPT7eouE6/hL6nW3Uk2cDkLUgkZDKXfVwjgc88nW36yWQ96tKl2VpUBpe0sCelkO376MeIVtyYJ2XlI9WjjcFKWhe1U3kqlLQ3Hwb9OoUdOkm/xh0c1ajpZRzra+ZBPs5MOjL+m0ZzWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777126765; c=relaxed/simple;
	bh=ZmsK2POVH2Z4YyUaXKtECdBvyDUFXk5uggawnQxeVQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkCJdX41C27fjE+7L6khKNawJp6zar/KIDglphwjjyyEFpDXr6CEoqcu/iKDeVEsmzCXK96y0vGdG1DwAXgDp0veegmaTDezXJbz3Y+imQcCQuqE/+77NBhKGyIzZIxS8UM0vcW91dXdClGQe5qXxd0gaeXrv/5XZUxBZevGAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqaFM3DB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F1FC2BCB0;
	Sat, 25 Apr 2026 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777126765;
	bh=ZmsK2POVH2Z4YyUaXKtECdBvyDUFXk5uggawnQxeVQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqaFM3DB8C2ytMYZMb6+p2eO6CaGG597R8Sg00ja0PzZg8Luxl5fdzHGkl88YEqyg
	 Fu6mM8hP/Biv7Y7x8iGJ9BbRZpKGvBs4bBPUcTOr7xaFUS5OabJVGGJLu/OdHcfhGP
	 5qdY/BWhPScC73EtTA1KRYufLM47XwG/zgxhCOVXhuoAsoeH5fVkdIE7Pa2ALYpMYY
	 mibvG6F9/7bvZK5lix1eSetpkwF4d+L95aow4kkxbP6F5uy1sT33e7HLAIX9LvoPk5
	 nXbMzt+VMCaGYgILGP5NZG+/knO+BJ88WDWYV8LxFG9zrxOwf4/Xnncv4FZWWeCGXp
	 XWoSF8dlq4Y/Q==
Date: Sat, 25 Apr 2026 17:19:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [RFC PATCH v3 4/4] Revert "firmware: arm_ffa: Change initcall
 level of ffa_init() to rootfs_initcall"
Message-ID: <aezNaZEcXlEklNoj@kernel.org>
References: <cover.1777036497.git.noodles@meta.com>
 <2e7b4dc552b45ddf14cc43bc449cbebb4ade0027.1777036497.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e7b4dc552b45ddf14cc43bc449cbebb4ade0027.1777036497.git.noodles@meta.com>
X-Rspamd-Queue-Id: 1B00A466923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9337-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,ziepe.ca,kernel.org,arm.com,meta.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 02:24:42PM +0100, Jonathan McDowell wrote:
> From: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> This reverts commit 0e0546eabcd6c19765a8dbf5b5db3723e7b0ea75, which was
> added to address ordering issues with the IMA LSM initialisation where
> the TPM would not be fully ready by the time IMA wanted it. This has
> been resolved within IMA by retrying setup during late_initcall_sync if
> the TPM is not available at first.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index f2f94d4d533e..01547c5c0e38 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -2106,7 +2106,7 @@ static int __init ffa_init(void)
>  	kfree(drv_info);
>  	return ret;
>  }
> -rootfs_initcall(ffa_init);
> +module_init(ffa_init);
>  
>  static void __exit ffa_exit(void)
>  {
> -- 
> 2.53.0
> 

LGTM (for both tpm patches).

However, I'll hold on any further comments/tags up until I've sorted 7.1 PRs
(just so that I have full focus).

BR, Jarkko

