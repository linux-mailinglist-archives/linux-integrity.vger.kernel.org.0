Return-Path: <linux-integrity+bounces-2510-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464788CAF5C
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765B51C219EA
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A167C080;
	Tue, 21 May 2024 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CI+lUcaT";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CI+lUcaT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11B6BB56;
	Tue, 21 May 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297994; cv=none; b=VzXRVEeDfM1KrpSC4xktzx30u4AG/cbu9/2XmYbp5o2g+GuDJ6a43Tsp9oB/S7Oq1y0qOZVyZee2ue3hPDK9f8Nmf0fTKC1SaDIZCCno8GKKgNz5YAbTIAOc+SK7PgDvs21eq6n5xWBhlimhk3leUGH3ZJMu+IMiueiC6wWy6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297994; c=relaxed/simple;
	bh=CDs0kJ+gq9dScn7Lv07LkbmMN9kTpGqps3aarF3aDeY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XFyfnWIyFTqsw2KUNI3LLAfXtOd1Gix7iajE4111K3VFoDJfRklakSsCUQ5q4qfTNEO1HiDvuMa0vNvvAWPTEH3vHaba1RLwD7SfKA0WuaBQOe6DuSi7GVQ31BaEy+tteuEkkXCjEaqmJFyX6stqjwlRGb08b8i7uTCjDgo3GDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CI+lUcaT; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CI+lUcaT; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716297991;
	bh=CDs0kJ+gq9dScn7Lv07LkbmMN9kTpGqps3aarF3aDeY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CI+lUcaTUAWg4HwCm9yqLZ0TcbYqCn9GHgpo2Mcn1GdPByDs7X1vJf/eorBOX2mk3
	 k4HUC4OLH9SGrZ3kjKSegc0KafG7pKxZNaD+otEYAdJNboupsdqRlCHuuhn7IGp28H
	 YZDVQrW9hRDyAgRudT+bfSZzQnUO25zje+Ix5MUA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E89DB1286DFB;
	Tue, 21 May 2024 09:26:31 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id EGui8Ex8-1Ii; Tue, 21 May 2024 09:26:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716297991;
	bh=CDs0kJ+gq9dScn7Lv07LkbmMN9kTpGqps3aarF3aDeY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CI+lUcaTUAWg4HwCm9yqLZ0TcbYqCn9GHgpo2Mcn1GdPByDs7X1vJf/eorBOX2mk3
	 k4HUC4OLH9SGrZ3kjKSegc0KafG7pKxZNaD+otEYAdJNboupsdqRlCHuuhn7IGp28H
	 YZDVQrW9hRDyAgRudT+bfSZzQnUO25zje+Ix5MUA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BA3961286DC8;
	Tue, 21 May 2024 09:26:30 -0400 (EDT)
Message-ID: <236606947b691049c650bdf82c37324084662147.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: enable HMAC encryption for only x86-64 and aarch64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Tue, 21 May 2024 09:26:28 -0400
In-Reply-To: <20240521130921.15028-1-jarkko@kernel.org>
References: <20240521130921.15028-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-05-21 at 16:09 +0300, Jarkko Sakkinen wrote:
> Let's be more conservative and enable HMAC by default only for the
> platforms where it immediately makes sense, i.e. x86-64 and aarch64.
> This can be relaxed later on, and obviously the kconfig option can be
> set even if not default on a particular arch.
> 
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Closes:
> https://lore.kernel.org/linux-integrity/D1FCAPJSYLTS.R9VC1CXDCIHH@kernel.org/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index e63a6a17793c..19e61dcfcbbe 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -29,7 +29,7 @@ if TCG_TPM
>  
>  config TCG_TPM2_HMAC
>         bool "Use HMAC and encrypted transactions on the TPM bus"
> -       default y
> +       default X86_64 || ARM64

My first instinct is to say that devices in hostile environments (like
IoT) are likely in the most need of this.  However, it is an
experimental feature, so I would like to debug it first in the
environments where it's expected to work, which is desktop and laptop,
so I'm happy with this:

Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>

James


