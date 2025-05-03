Return-Path: <linux-integrity+bounces-6116-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB00AA8119
	for <lists+linux-integrity@lfdr.de>; Sat,  3 May 2025 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30240462564
	for <lists+linux-integrity@lfdr.de>; Sat,  3 May 2025 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F21E5B9A;
	Sat,  3 May 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTr0Sjcf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C8367;
	Sat,  3 May 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746283162; cv=none; b=XT7l5ihF2Jgz6Lfvi3SIS5TRLgeu+4TX71tbbs5JaPtb1iawtwXCfM/Yqo0NVjFQ6bc+sqPbg0uCf7Vo0bLKs4lceB5XEr0Lle7daU52foDh/sVIv9H+ZbVd3TqNzMi2PE2AvnCqrRS877+TPTI/GeN39mxdmfAuZ5Y/ipbAz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746283162; c=relaxed/simple;
	bh=Jr9HzCArpmz5liqhpXLnd+1v5ot8JBjFOX4E/k8pSis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjksMK/Nl9HUZWnEL1DkgtVWOflR3hI3C/tmQYiPGmTfSFrTnFtjN5KmEfF2RQPzVirZApGs6JGusugP65paZVGbUgGe1QvGyt/uk8Ai4ffFGrYDpg4glxYiiZmEsDta8ssr7AejQ4MTimJuAgT2cOLM4r/2QhlcWuDHMz1TXdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTr0Sjcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96100C4CEE3;
	Sat,  3 May 2025 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746283161;
	bh=Jr9HzCArpmz5liqhpXLnd+1v5ot8JBjFOX4E/k8pSis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTr0SjcfzhXo8r92rzo29xHJTs63RuGBhSar+SkuDRwLHDeAi0VZKk7+ZgpwqUFW8
	 p7/5e32srT9aD/0JRnfyHmsepXDCGJg9pvUd6lHh39qq1CgWMg4FBYLZq9oCA+Qklo
	 yqg0LN+h/yrQPTzo0IEmQ0v5Mu/+TrU0aFNvx2zKyzQyAMamUR9dFi0wrWgztb4tpf
	 1Pst1Up70ptz/Ki1YP5czDTwSPQAUIp4D8T3xw83KEGGyqTkEhqXlO2m4SOjOQ67P5
	 3qtyEmSBgychtj7+fW1LwO/+b2KJw3a/Uqo1sMKJzfRnDlzgdXhMnbZcXh/smTqFqm
	 hy3e2a1WL/btQ==
Date: Sat, 3 May 2025 17:39:16 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] KEYS: Reduce smp_mb() calls in key_put()
Message-ID: <aBYqlBoSq4FwiDKD@kernel.org>
References: <20250430152554.23646-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430152554.23646-1-jarkko@kernel.org>

On Wed, Apr 30, 2025 at 06:25:53PM +0300, Jarkko Sakkinen wrote:
> Rely only on the memory ordering of spin_unlock() when setting
> KEY_FLAG_FINAL_PUT under key->user->lock in key_put().
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  security/keys/key.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 7198cd2ac3a3..aecbd624612d 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -656,10 +656,12 @@ void key_put(struct key *key)
>  				spin_lock_irqsave(&key->user->lock, flags);
>  				key->user->qnkeys--;
>  				key->user->qnbytes -= key->quotalen;
> +				set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
>  				spin_unlock_irqrestore(&key->user->lock, flags);
> +			} else {
> +				set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> +				smp_mb(); /* key->user before FINAL_PUT set. */
>  			}
> -			smp_mb(); /* key->user before FINAL_PUT set. */
> -			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);

Oops, my bad (order swap), sorry. Should have been:
	
 				spin_unlock_irqrestore(&key->user->lock, flags);
			} else {
				smp_mb(); /* key->user before FINAL_PUT set. */
 			}
			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);

Should spin_lock()/unlock() be good enough or what good does smp_mb() do
in that branch? Just checking if I'm missing something before sending
fixed version.

BR, Jarkko

