Return-Path: <linux-integrity+bounces-9861-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Ex+CneORGqHwwoAu9opvQ
	(envelope-from <linux-integrity+bounces-9861-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 05:50:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E6F6E98C8
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 05:50:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="asBx/pvW";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9861-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9861-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0901302284D
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 03:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6927BF79;
	Wed,  1 Jul 2026 03:50:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FB209F43;
	Wed,  1 Jul 2026 03:50:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877812; cv=none; b=TspWHt3qdZa+a+/anaytyJnXax8MuDSX4sWUqyEWGxO0wwIm9lysy33/MI3+iF4EP7DLRW29RuUb+cBiHPplbvJmH3gpGTx6Z61hqBwbY3pvHj+EdRjvlh+w6e4AfvNy8mBipg75Tk87ZDhuA8lploryhe1fC2/xRs5yFIMkB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877812; c=relaxed/simple;
	bh=8vKfOGoaCFSCpkU2ReLrQ4eVeWJVwRdXqRYCnYJNNeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk92NMdvxssnpS7Qf2R3zPk0qt378lTEu3Y9yvD1pQ5x9QeCP7FN9F4vZMSTWR1YVEcl+l4A7K1HMLS+XO0n4iV5xvOl/VmA2RorWDwVEibHyqORmh4VE0Cib3VzDHxacsLj7bOSW0dIFJWfyC6LslJX5d+b2QwcDTHSmFfbdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asBx/pvW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 34D621F000E9;
	Wed,  1 Jul 2026 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782877810;
	bh=T2hTvlYeEHmVWblghsmcULzurIVmIm0KteC2foXWL4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=asBx/pvWNrFnZYBspRkbA/I6pxY5wRW0Lvrd7tA0d6v7MXkJDjynYVi+iPqtGDH2H
	 omMweFN3sHn5Uzygl0ckOSfEENZ1y4tk+wuno/wawIL/eMUwv8EHKjc0iXqjU/+Sfn
	 7bUt5qrgAlQMDKusfJ+TQUegRmfcz7CutCLGc2mbud98u5klDsr+hjS+PGWnYVGn4y
	 JS+rXzClMk0a1KlwkP3DUUgIQ8wwKrSmJ0P7G96OOwsMn8iZ9SOTnY7JWVcMPVMdwj
	 JStvyC80x133tJVhaYjzdJn9o2RqtVa22FiYcCRd1S33nvLklNjxWez82dvJ586v9r
	 CH9YzC9mNmEEQ==
Date: Wed, 1 Jul 2026 06:50:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org, pratyush@kernel.org,
	Markus.Elfring@web.de, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in
 machine_kexec_prepare
Message-ID: <akSOb1_1tcJvFyda@kernel.org>
References: <20260701025732.66330-2-ltao@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701025732.66330-2-ltao@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ltao@redhat.com,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kexec@lists.infradead.org,m:bhe@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:linux-integrity@vger.kernel.org,m:pratyush@kernel.org,m:Markus.Elfring@web.de,m:kernel-janitors@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9861-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,web.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3E6F6E98C8

On Wed, Jul 01, 2026 at 02:57:33PM +1200, Tao Liu wrote:
> A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare,
> where image->segment[i].buf might be NULL and copied unchecked.
> 
> The NULL buf comes from security/integrity/ima/ima_kexec.c:
> ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> but kbuf.buffer is NULL

This should have a proper call sequence. Now the root cause is
obfuscated.

> 
> Fix this by simply adding a check before copy.
> 
> Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
> 
> v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
> link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
> link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
> 
> ---
>  arch/riscv/kernel/machine_kexec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index 2306ce3e5f22..afc68f6a4aa1 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
>  		if (image->segment[i].memsz <= sizeof(fdt))
>  			continue;
>  
> +		/*
> +		 * Some segments (e.g. IMA) reserve space but have no buffer
> +		 * loaded yet. Skip them as they cannot contain an FDT.
> +		 */

This is destined to rot over time. It also adds up also potentially to
the backporting effort while backporting to stable kernes. And most
importantly. Please, don't document every other null check.

> +		if (image->segment[i].buf == NULL)

if (!image->segments[i].buf)

> +			continue;
> +
>  		if (image->file_mode)
>  			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
>  		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
> -- 
> 2.54.0
> 
> 

BR, Jarkko

