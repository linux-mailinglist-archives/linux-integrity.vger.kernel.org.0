Return-Path: <linux-integrity+bounces-5559-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9A1A794DA
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 20:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD6016CD0C
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46481C5F07;
	Wed,  2 Apr 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="NiCNAVF6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F511E4A4;
	Wed,  2 Apr 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617560; cv=none; b=tRQxpZcpCcccCRvPTNsLrUerFQexRqIm0FmoWN95NHHFXXDTxiN13uQMJdk39xlY8TLu9mr+OhUqLyDUrHH5S0vtZcfWb8HcL/7C1JTJktX13aSMUk+Re4Lvs6fLqW20aHrm1I/wztTw7jg0hBwi6G51EBGLPfzsjVJBO2mMgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617560; c=relaxed/simple;
	bh=0n6pbPbBFXO6F6NC6Z8YzjeEVwNH4KpdqQGNkLICOSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6oB1G2Va2k1G8WOuF6eAxpq0Se69eBtT51CrkLA7Oo7vd7eMEiIt+l89gl/schnorjc+nY7d6CzQ5G5xWve9bniDtNJpUt+PH3hS8RqRTI2uB73uE0Azc1B/4r1AL4ROZBMtBdRS6cKvSDbnoaM3Ii1qRmfXrmccArakXwsZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=NiCNAVF6; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bFVTcaoOHvzB77kRb/8KCMv+VqWoJTJ1wosVmH/V6QY=; b=NiCNAVF68Pb2JNgYYfkMpVbvxG
	CuACbSWFHjMoKQczDbAhaPGBZq/siPTkUG6e7E8SbEzmYZ0uBvrl3YbCvQ7PN/WWGW8FNwtPlFtDI
	doG+XLolNz6FjMvTQvH9Rkei5k7Qzm/UytZ6Li8wgA1WVhbkSgU99pXqeYpXpTGTngvdWYhKu2ieF
	Om0qLwvMKz2kKDXb/n0hCqttoZLi1sVpRq8pXmttHzrnX9mqWcdnA/KoRHwOOUcmEVI+m+abdwavL
	QPPotbDfAN1ParlfI3WbMkZhq+0zOhJnynj1/ZCCii7+MQeqQhPIDnsRUdBITX1J2Woaoi9qKHHHe
	MJnJvVWQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1u029k-00BzfB-2S;
	Wed, 02 Apr 2025 18:45:40 +0100
Date: Wed, 2 Apr 2025 18:45:40 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Michal Suchanek <msuchanek@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-13xOebA3LvQQ-8@earth.li>
References: <20250402172134.7751-1-msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250402172134.7751-1-msuchanek@suse.de>

On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
>With some Infineon chips the timeouts in tpm_tis_send_data (both B and
>C) can reach up to about 2250 ms.
>
>Extend the timeout duration to accommodate this.

The problem here is the bump of timeout_c is going to interact poorly 
with the Infineon errata workaround, as now we'll wait 4s instead of 
200ms to detect the stuck status change.

(Also shouldn't timeout_c already end up as 750ms, as it's 
max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C), and TIS_SHORT_TIMEOUT is 750 vs 
200 for TPM2_TIMEOUT_C? That doesn't seem to be borne out by your logs, 
nor my results.)

>Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
>Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>---
>An alternative would be to add an entry to vendor_timeout_overrides but
>I do not know how to determine the chip IDs to put into this table.
>---
> drivers/char/tpm/tpm_tis_core.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>index 970d02c337c7..1ff565be2175 100644
>--- a/drivers/char/tpm/tpm_tis_core.h
>+++ b/drivers/char/tpm/tpm_tis_core.h
>@@ -54,7 +54,7 @@ enum tis_int_flags {
> enum tis_defaults {
> 	TIS_MEM_LEN = 0x5000,
> 	TIS_SHORT_TIMEOUT = 750,	/* ms */
>-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
>+	TIS_LONG_TIMEOUT = 4000,	/* 2 sec */
> 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
> 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
> };
>@@ -64,7 +64,7 @@ enum tis_defaults {
>  */
> #define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
> #define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
>-#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
>+#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_C)
> #define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
>
> #define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
>-- 
>2.47.1
>

J.

-- 
... "Tom's root boot is the Linux world equivalent of a 'get out of jail
     free' card. The man is a *hero*." -- Simon Brooke, ucol.

