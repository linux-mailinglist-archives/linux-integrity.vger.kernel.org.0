Return-Path: <linux-integrity+bounces-5515-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71477A759CE
	for <lists+linux-integrity@lfdr.de>; Sun, 30 Mar 2025 13:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257F116955B
	for <lists+linux-integrity@lfdr.de>; Sun, 30 Mar 2025 11:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377A91C3C18;
	Sun, 30 Mar 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBDi3Zuo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8F4A05;
	Sun, 30 Mar 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743333750; cv=none; b=aU4qFeem6DXWXCtSm7+f+03jxpThDlnSbkO1411zPVjgTFj4gLjjdrokyBYj2Zgop9Q2m+I4oGc5PCEYF06dj1zR1UjThxikcM/crvnIiK29Xaykmkj9yc3YHcyEcZqm1913jeBZtuaHjlTKo5y/vqE1c+iUghAJWY9G0hl1IW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743333750; c=relaxed/simple;
	bh=T0DpB9/suD9fTKqh8YvjxyZJgSWoES3eA5qVKpYKXy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdJtM/sGk1zeL51fN5lYdVzyKdb8NaSH7OMQh6fDqQ1F7PdssrpaqMQ9ILw28y4s/7LnPbbOklZ/zGCBEqLhnjavM/tHb80S8KLlXWaUuTy47szboyAISZI+KD2/uPYFMKNkMpgbxtW8TDsDo1I7wQRGLF+fB/fZFQvl+oItqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBDi3Zuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F1FC4CEDD;
	Sun, 30 Mar 2025 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743333749;
	bh=T0DpB9/suD9fTKqh8YvjxyZJgSWoES3eA5qVKpYKXy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBDi3ZuoTSSWiOY/FSw+aHTgd5aoVrskRXch5VZh+POaptgxlD3XdjndnXR8wqnmN
	 rwB0HxZ/Np7avUmrXCfsmO9b3MwZl58o2pqUXLeCJs5Dk+TsbQASzAwkZG7NMkR2zO
	 d4cqI29tzpler96rUrjk+s4nTRTJd1TcLEQ4sao06AHjlR0RrTs2nkqDUgMT5tqjRA
	 uMhu2Od/QE5fNgvYqGPj7UAmoiUWaE5r5VS+iNq5Ykp8qwH5EYHY4MrzELMC+wvRgg
	 +gYX0a2oZsmqstWBtV0pLnBTismpwrspU3txKPOQk9NViCnZ7MgohDCH11mmnKPNs2
	 vGEoSz8xr3Y9Q==
Date: Sun, 30 Mar 2025 14:22:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v2] KEYS: Add a list for unreferenced keys
Message-ID: <Z-kpcCGR8TjEufcK@kernel.org>
References: <20250330111649.13547-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330111649.13547-1-jarkko@kernel.org>

On Sun, Mar 30, 2025 at 02:16:49PM +0300, Jarkko Sakkinen wrote:
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 7198cd2ac3a3..b34b4cba6ce7 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -22,6 +22,7 @@ DEFINE_SPINLOCK(key_serial_lock);
>  
>  struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
>  DEFINE_SPINLOCK(key_user_lock);
> +LIST_HEAD(key_graveyard);
>  
>  unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
>  unsigned int key_quota_root_maxbytes = 25000000; /* root's key space quota */
> @@ -658,8 +659,10 @@ void key_put(struct key *key)
>  				key->user->qnbytes -= key->quotalen;
>  				spin_unlock_irqrestore(&key->user->lock, flags);
>  			}
> -			smp_mb(); /* key->user before FINAL_PUT set. */
> -			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> +			spin_lock(&key_serial_lock);

	kdebug("unrefd key %d", key->serial);

Now this message gets spuriously deleted so maybe better just carry it
(just noticed)?

> +			rb_erase(&key->serial_node, &key_serial_tree);
> +			list_add_tail(&key->graveyard_link, &key_graveyard);
> +			spin_unlock(&key_serial_lock);
>  			schedule_work(&key_gc_work);
>  		}
>  	}
> -- 
> 2.39.5
> 
> 

BR, Jarkko

