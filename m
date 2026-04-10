Return-Path: <linux-integrity+bounces-9154-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFxRBKSd2GlkgAgAu9opvQ
	(envelope-from <linux-integrity+bounces-9154-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 08:50:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C22F3D2F56
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 08:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1268C3001F8B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75E387378;
	Fri, 10 Apr 2026 06:50:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9C29BDBB;
	Fri, 10 Apr 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803804; cv=none; b=GwbRQh+SmUi7sP/41+BbvnyaCWs+lcdvw0f6aC4Rwvt86kaF1iM4j82SwabpeRMh7qloVxFMVpmp/Y0uuxgaGx5ca1KyxPmXj/DLtIs5G6pybOSkr/mJ/D3S/kWuYvetwZxUask9p1PGQbI39hkmTpSHKtvjRxIMV5J8qkOWyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803804; c=relaxed/simple;
	bh=xcF/XOUPuCAayd5VPrmXhsFgMhAA5rDdOjfh27QUs0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVpOc4VYzXkdOGVsFRNVxKhEBnB7nsSBrtUQMszSb+COduEA3o4i5H7MN47gmkrvjzlIYHFAO0vLNMT71Wdz8xMo53eCQR8dwysHJTpppNp9k6+gGUxuRLnd85UYxwpXX004tD8RcEtAIVFF6PP3gTQkis+HUA1Hl0U447yuG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af789.dynamic.kabel-deutschland.de [95.90.247.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A5F064C2C37D5B;
	Fri, 10 Apr 2026 08:49:20 +0200 (CEST)
Message-ID: <2f9f7dcf-7cea-46f8-8887-ac2495e12863@molgen.mpg.de>
Date: Fri, 10 Apr 2026 08:49:19 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tpm: restore timeout for key creation commands
To: Baoli Zhang <baoli.zhang@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Serge Hallyn <serge@hallyn.com>,
 Lili Li <lili.li@intel.com>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260410014940.3557934-1-baoli.zhang@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260410014940.3557934-1-baoli.zhang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,hallyn.com,intel.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9154-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 1C22F3D2F56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Baoli,


Thank you for your patch. Some formalities:

Am 10.04.26 um 03:49 schrieb Baoli.Zhang:
> After the per-command duration map was introduced, TPM2 key creation
> commands (`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) were limited to
> 30 seconds.
> 
> On some platforms this is not sufficient and key creation can time out.
> Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
> inadvertently reduced these command timeouts from 300 seconds to 30
> seconds. Restore them to 300 seconds to avoid spurious failures.

Please document such a platform.

> Fixes: 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
> 
> Signed-off-by: Baoli.Zhang <baoli.zhang@linux.intel.com>

It’d be great if you remove the dot from your name:

     git config --global user.name "Baoli Zhang"

> Co-developed-by: lili.li <lili.li@intel.com>

Same here. Maybe spell it Lili Li?

     git commit --amend --author="BaoliZhang 
<baoli.zhang@linux.intel.com>" -s

> ---
>   drivers/char/tpm/tpm2-cmd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 3a77be7ebf4aa..430022f695f24 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -71,9 +71,9 @@ static const struct {
>   	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
>   	{TPM2_CC_GET_CAPABILITY, 750},
>   	{TPM2_CC_NV_READ, 2000},
> -	{TPM2_CC_CREATE_PRIMARY, 30000},
> -	{TPM2_CC_CREATE, 30000},
> -	{TPM2_CC_CREATE_LOADED, 30000},
> +	{TPM2_CC_CREATE_PRIMARY, 300000},
> +	{TPM2_CC_CREATE, 300000},
> +	{TPM2_CC_CREATE_LOADED, 300000},
>   };
>   
>   /**


