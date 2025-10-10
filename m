Return-Path: <linux-integrity+bounces-7404-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCBABCB951
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 05:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AC61A63799
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 03:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1641B4F08;
	Fri, 10 Oct 2025 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig7lrz4V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433B3FB31;
	Fri, 10 Oct 2025 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760068527; cv=none; b=GWAjp7oG2nHP1JqTiwmVigXeWMRnarUtgxFPdJq9rhbag6Vj7XzkbqqQaORrkv1y5yKlz4ws0daUcveYxhYdkPtrT1k4vddmapZY/URGlTEMUiBJ9QFJHHEarvZZJR8Fd5T/iTmmSc+bkbYtrnuAlw3biU5SazGyvepPtiXYjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760068527; c=relaxed/simple;
	bh=ufhck0o4QgqzQ7L7qpUMOnhUD5keIumwoxtpt5n66W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3PJP37Pb9eHXl7hRwfaq523exvAPkknQB0Qb+Dazog/m45PEX6Um3wdn7CzyESdhs0VNNiH56CBWBiR1DOFVLQ/zhw9EAszZn0uzjM5pkfljYq0HhXKY8snd2kVaEhWLqRI0JkcbnLXRGfN/0z8gwLMI3wocwknPgESYtqjEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig7lrz4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A45C4CEF1;
	Fri, 10 Oct 2025 03:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760068526;
	bh=ufhck0o4QgqzQ7L7qpUMOnhUD5keIumwoxtpt5n66W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ig7lrz4VEJ7pnbOTIIe/5uo3qNC6zfNd2mu2aJqmz/AFzpMDlLnZA5h+yGglRgBDK
	 CDSbTc9iIbyWWS4NRUaVIgv+7BQz9zrawr237KPF8SPXQVjXRxH0bneXHo4t5/oJCI
	 RmClnA+G69leKQomw2hJ/Wotu1mgcz94rKhI9ju0WDViMWH9WsZ0Kf6JV5RPddIHQS
	 hGKbfP9fZo8VjsrkfTvesRTCIKT6d7r+sZh5cWbVJwXYvu7DljIyPCad2g9A4XsLK/
	 cIctFKUMzSL+JJAgcaBVcby/PNEZToFA8utl+j8TjRsuLWnXKbqUueWOEn/gXCvh/2
	 rruF/2SLoZBBA==
Date: Fri, 10 Oct 2025 06:55:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Use designated initializers for
 match_table_t structs
Message-ID: <aOiDqjEyowUkegbd@kernel.org>
References: <20251009115817.368170-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009115817.368170-2-thorsten.blum@linux.dev>

On Thu, Oct 09, 2025 at 01:58:17PM +0200, Thorsten Blum wrote:
> Use designated initializers for 'key_format_tokens' and 'key_tokens' to
> allow struct fields to be reordered more easily and to improve
> readability.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  security/keys/encrypted-keys/encrypted.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index aef438d18da8..76a6dab2f4d2 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -62,17 +62,17 @@ enum {
>  };
>  
>  static const match_table_t key_format_tokens = {
> -	{Opt_default, "default"},
> -	{Opt_ecryptfs, "ecryptfs"},
> -	{Opt_enc32, "enc32"},
> -	{Opt_error, NULL}
> +	{ .token = Opt_default, .pattern = "default"},
> +	{ .token = Opt_ecryptfs, .pattern = "ecryptfs"},
> +	{ .token = Opt_enc32, .pattern = "enc32"},
> +	{ .token = Opt_error, .pattern = NULL}
>  };
>  
>  static const match_table_t key_tokens = {
> -	{Opt_new, "new"},
> -	{Opt_load, "load"},
> -	{Opt_update, "update"},
> -	{Opt_err, NULL}
> +	{ .token = Opt_new, .pattern = "new"},
> +	{ .token = Opt_load, .pattern = "load"},
> +	{ .token = Opt_update, .pattern = "update"},
> +	{ .token = Opt_err, .pattern = NULL}
>  };
>  
>  static bool user_decrypted_data = IS_ENABLED(CONFIG_USER_DECRYPTED_DATA);
> -- 
> 2.51.0
> 

For me this look like a "convert tuple alike initializations into struct
alike initializations" type of change :-)

In a context the change would make sense. E.g., if an optional field was
required.

BR, Jarkko

