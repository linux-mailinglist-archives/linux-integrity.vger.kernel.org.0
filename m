Return-Path: <linux-integrity+bounces-9796-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HM0HLr3tL2rcJAUAu9opvQ
	(envelope-from <linux-integrity+bounces-9796-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 14:19:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 168576861E9
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 14:19:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BDYTmmxp;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9796-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9796-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D285E30427D8
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4518F3E7BC2;
	Mon, 15 Jun 2026 12:15:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DA3E832A;
	Mon, 15 Jun 2026 12:15:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525720; cv=none; b=BJgBP/wCkkduyadjasbD1ucXMtX+Su//RUUcxL42czRZcixkosEIjsQxB4hu9Ef32G2Dk1xiHF/mj9xDwT0487ejziLI0gwB/AuMkAq6Nij4+y/chvx+eXuTSRERBNDxsBDCx2cjfu0L4m3cZwv/5B1M5k0R/ulsgU3WLIlb6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525720; c=relaxed/simple;
	bh=PwJZZ1o5H5JoUnR1ARzxJGygHZ4qCA/wRX0Bz9gk6oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZVRkbhNnhvJ81KXDD7bvRAxyeNh7Z06CD+2zQoqxNUyXfdTCNbviDbxM/zcNiB+kTt+hRhQGe4u3iG+QpapbP/w+4zHFzzaPC6e0eaoMBt4N69biHW5GckryKeZm3D4pCM18F0TT2Z4nbUunm5AbwbhuPC6nAa9QepW+Y6XjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDYTmmxp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5A90B1F000E9;
	Mon, 15 Jun 2026 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525718;
	bh=2jFG9QGRkDCh+2v0jpBIwm2x6kEARffuzaNPE7q2LyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BDYTmmxpKLnAW9t2CqaleTU1tFrPT20oj1kz7dTnxvdVojWHsA/1TVHt2d+GMHb7S
	 ID0lnzWXAZrlMGc6t8fas3UnggJJMTu883oQKX5Q3Qf6txUQNE2QqnIPk0hqE2B28Q
	 w8rwdPKz4rfMvAcFlVqkS8QlmfycQMonaaRZCcz7FsfYS/b8kMKP6plr/nNdqWOumA
	 zxN4aVw8MUK4sW19f5BVjEJjRvcysMNzUitc6Fsvbv+w0+lR8+P/28T0mmGwN03mEU
	 CkAngNQcJSNh/ZQh9oFnSU/HSpJexPol2rf15j84VEAObo98rVWv0og1poxfWeg9n4
	 ukAUZXM907fVg==
Date: Mon, 15 Jun 2026 15:15:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Jun <chenjun102@huawei.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_tis: add settle delay after releasing locality
Message-ID: <ai_s0-hSMomu1mOy@kernel.org>
References: <086949bcf2c10bead892b0b4befd98da370cd3ee.1781498837.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086949bcf2c10bead892b0b4befd98da370cd3ee.1781498837.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:chenjun102@huawei.com,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9796-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 168576861E9

On Mon, Jun 15, 2026 at 05:48:43AM +0100, Daniel Golle wrote:
> tpm_tis_core_init() releases locality 0 then immediately reclaims it via
> tpm_chip_start(); some TPMs (e.g. Nuvoton NPCT, TPM 2.0) need a few ms
> before granting it again, so probe fails with -1. This back-to-back
> release/request was added with the locality claim around TPM_INT_ENABLE.
> 
> Wait for the chip to settle after releasing the locality. A delay of
> TPM_TIMEOUT (5 ms) in __tpm_tis_relinquish_locality() is reliable; values
> below 3 ms are not.
> 
> Fixes: 0ef333f5ba7f ("tpm: add request_locality before write TPM_INT_ENABLE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 21d79ad3b164..6b90ff50c78d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -171,6 +171,8 @@ static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
>  {
>  	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>  
> +	tpm_msleep(TPM_TIMEOUT);
> +
>  	return 0;
>  }
>  
> -- 
> 2.54.0
> 

I think this is totally fine.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

