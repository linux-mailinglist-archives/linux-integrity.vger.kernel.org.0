Return-Path: <linux-integrity+bounces-5343-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BA6A6A980
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 16:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E134840E3
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70C1E51FA;
	Thu, 20 Mar 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM7dm3My"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79F1DE4C5;
	Thu, 20 Mar 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483795; cv=none; b=W81D/UG5t2EjM3mSL7lnsESWHqfzgJjigXEU+AeYuL0mPHSpiip5lpH+hfE8jhvgnzHDG8H6obUuJgcaKuIrSafOIdVulHl5m/iRv3klADeZgfnEbFabOX6Y7WKo+Te3UU0b5rra3m+JoZe2pqK+A+sGRW+pTU09Ide3RudTv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483795; c=relaxed/simple;
	bh=3ISFEoedf+AsgYKpMB/pWOzZYb8aFav8C0G9rOCDxCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWGzupM6hvwhxwlcNsO0OgokTKgSn7miqtI/iMbOPCbLHhE/WRL1voX8BEBtg5kdXUHK5eIqafboMafY2TlLpj8uOMs3Y9EyXKO6/fuq9vTSgcquUhgVC31BqVjnzDtWLo4NTTun4Y+hMbUvU4JjYF7hXAHkoSpadp80j8Ma2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM7dm3My; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BB4C4CEDD;
	Thu, 20 Mar 2025 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742483794;
	bh=3ISFEoedf+AsgYKpMB/pWOzZYb8aFav8C0G9rOCDxCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZM7dm3MyW1u9kYmnpMqxZbxFqmooKpRDJaGCFC6WSQ75koW1s6RCSXzYTQSj3qFKN
	 LWK2New6mbyX+UphtaHktjHvLutibQ4P7boeCPjFVcXN0RP4d6xwdeszLrg7HVRxeQ
	 1a47qfrPK3VJFVuZivf5hnw5F+zpWmJBt9wRbV8OFdTu53liiSaSmySOm0jUdffMXQ
	 bqZAecPY0PTg1PDEfgzvj2Eq3rAGm9fIOs4k9v8M0coA4vfeImo4+y8uPycUpcPmQv
	 AuGTXu5s5DycnFUDEbOoQ3QaCZJ4mRmoy3Th2UvffwULb0IQC0axYtUdDzF5vgd0nH
	 KDUv7WRxVsUEA==
Date: Thu, 20 Mar 2025 17:16:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Bo Liu <liubo03@inspur.com>
Cc: dhowells@redhat.com, James.Bottomley@hansenpartnership.com,
	zohar@linux.ibm.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: dcp: Use kfree_sensitive() to fix
 Coccinelle warnings
Message-ID: <Z9wxT9SV4BmehzmT@kernel.org>
References: <20250320103557.7236-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320103557.7236-1-liubo03@inspur.com>

On Thu, Mar 20, 2025 at 06:35:57AM -0400, Bo Liu wrote:
> Replace memzero_explicit() and kfree() with kfree_sensitive() to fix
> warnings reported by Coccinelle:
> 
> WARNING opportunity for kfree_sensitive/kvfree_sensitive
> WARNING opportunity for kfree_sensitive/kvfree_sensitive

Even if you get the error from Coccinelle, you should still go trouble
why this warning happens. Otherwise, you are contributing a change that
you don't understand yourself.

> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  security/keys/trusted-keys/trusted_dcp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
> index 7b6eb655df0c..c967837e72ee 100644
> --- a/security/keys/trusted-keys/trusted_dcp.c
> +++ b/security/keys/trusted-keys/trusted_dcp.c
> @@ -233,8 +233,7 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
>  	ret = 0;
>  
>  out:
> -	memzero_explicit(plain_blob_key, AES_KEYSIZE_128);
> -	kfree(plain_blob_key);
> +	kfree_sensitive(plain_blob_key);
>  
>  	return ret;
>  }
> @@ -283,8 +282,7 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
>  	ret = 0;
>  out:
>  	if (plain_blob_key) {
> -		memzero_explicit(plain_blob_key, AES_KEYSIZE_128);
> -		kfree(plain_blob_key);
> +		kfree_sensitive(plain_blob_key);
>  	}
>  
>  	return ret;
> -- 
> 2.31.1
> 

Not gonna fly because you did not include KEYS-TRUSTED-DCP maintainer to
the CC list.

BR, Jarkko

