Return-Path: <linux-integrity+bounces-8120-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7425CCCF2C1
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06D8E3005023
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F732FF143;
	Fri, 19 Dec 2025 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="MbUfGVrR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D572FE057;
	Fri, 19 Dec 2025 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766137340; cv=none; b=QvexbMttSQ7evEGpNrqIkPNU41H6Brtacw/o+kVgrGWymshO4TxvV96IxsXdfNhGSNIJHZ6KvuxRGC8PFMKD13W3+V7ivljUMIFfThJRX7z8vXTUvH2LPvgvhG+AGjHzrtsusIy31QqCoZSwf0gA9vs9ngBRz3ujHGy/vXmzgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766137340; c=relaxed/simple;
	bh=xVV9fdohq2ubL6//lM4dcaJsEWJ6R8p2wMpuHyhJunw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMCb+vz6GodCK1SlEwdLBX4TxH8rTbggZrQZ4VS+C9sV7P2WPdD0lqZHNCHyKqfg8+r6UzQ7KQb2B3Y8JMgjgevHu9pRyGfHYaWx3lOiW53vu+X4gZ/vCO/nevIu15dZyEqiilwbBshYomFBycUFWZkX2OpDy3HumBW19q29mgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=MbUfGVrR; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=o7XQ6clI2ABs8GcR3UzPQb45JVC8G0epQtluzmYrpEw=; b=MbUfGVrRfbr8Ptf8nszPPtAdDQ
	fwhII4hDcMIOmfPH3uCjl9954jmpOECh4KYEqN7udSdtzCKNQWqJHAU7tApqz1HMppsLK8+mdzXI/
	iL4+OsUOa4ZlacMLk8n+BvFeVA1IRVKVhpSnVRWZzGnRAndCSG4Vxk6uVFV3ab76dcQ6oxl9RNvok
	SrTj5b+p+EzxKtcWjQ9HhPWb6If/0JGfLt5LBnGbP4zCkaOaYpaG6LnVS1beiyPUc9w8ZBRXFxgxG
	8uiZZqaf95L+NmgAezN0G6OER2GVjVNtyOGyGEoo/TD4JQN/+a95xWVDRx1+zaDcrEj/P+8HSPDhU
	EzQBGV3g==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vWWzv-00EkOk-2Z;
	Fri, 19 Dec 2025 09:42:07 +0000
Date: Fri, 19 Dec 2025 09:42:07 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v8 04/12] tpm: Change tpm_get_random() opportunistic
Message-ID: <aUUd760l89lrNOs-@earth.li>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-5-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251216092147.2326606-5-jarkko@kernel.org>

On Tue, Dec 16, 2025 at 11:21:38AM +0200, Jarkko Sakkinen wrote:
>hwrng framework does not have a requirement that the all bytes requested
>need to be provided. By enforcing such a requirement internally, TPM driver
>can cause unpredictability in latency, as a single tpm_get_random() call
>can result multiple TPM commands.
>
>Especially, when TCG_TPM2_HMAC is enabled, extra roundtrips could have
>significant effect to the system latency.
>
>Thus, send TPM command only once and return bytes received instead of
>committing to the number of requested bytes.

Function comment for tpm_get_random needs updated as well, as it 
currently says "until all of the @max bytes have been received", which 
is no longer true with this patch. With that:

Reviewed-by: Jonathan McDowell <noodles@meta.com>

>Cc: David S. Miller <davem@davemloft.net>
>Cc: Herbert Xu <herbert@gondor.apana.org.au>
>Cc: Eric Biggers <ebiggers@kernel.org>
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
>v7:
>- Given that hwrng is now only caller for tpm_get_random(), remove the
>  wait parameter.
>v4:
>- Fixed grammar mistakes.
>---
> drivers/char/tpm/tpm-interface.c | 28 +++++-----------------------
> 1 file changed, 5 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>index d157be738612..677dcef05dfb 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -626,10 +626,6 @@ static int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>  */
> int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
> {
>-	u32 num_bytes = max;
>-	u8 *out_ptr = out;
>-	int retries = 5;
>-	int total = 0;
> 	int rc;
>
> 	if (!out || !max || max > TPM_MAX_RNG_DATA)
>@@ -646,28 +642,14 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
> 		rc = tpm2_start_auth_session(chip);
> 		if (rc)
> 			return rc;
>-	}
>-
>-	do {
>-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
>-			rc = tpm2_get_random(chip, out_ptr, num_bytes);
>-		else
>-			rc = tpm1_get_random(chip, out_ptr, num_bytes);
>-
>-		if (rc < 0)
>-			goto err;
>-
>-		out_ptr += rc;
>-		total += rc;
>-		num_bytes -= rc;
>-	} while (retries-- && total < max);
>
>-	tpm_put_ops(chip);
>-	return total ? total : -EIO;
>+		rc = tpm2_get_random(chip, out, max);
>+	} else {
>+		rc = tpm1_get_random(chip, out, max);
>+	}
>
>-err:
> 	tpm_put_ops(chip);
>-	return rc;
>+	return rc != 0 ? rc : -EIO;
> }
> EXPORT_SYMBOL_GPL(tpm_get_random);
>
>-- 
>2.39.5
>
>

J.

-- 
... We are talking one charming motherf**king pig.

