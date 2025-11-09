Return-Path: <linux-integrity+bounces-7612-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8FC43893
	for <lists+linux-integrity@lfdr.de>; Sun, 09 Nov 2025 05:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28D844E28F7
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Nov 2025 04:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FE016CD33;
	Sun,  9 Nov 2025 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcgJkQkW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515063CB;
	Sun,  9 Nov 2025 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762663821; cv=none; b=pbNQwS7kVAXcKuOTMiK7liRwsFE18nx8emBnlKLLkD2NcNjqDDRwDqQQQqLDG6QjEH6NQ+7H4Vqb04XnDQGa1QMZ4WPvy/FyDTzMl+k+ItQKkN5NyR335acHErIbg9Bt5rZ+JL6zRFza121eNbcjn9LE1ZNKuFjP41M25kX3PlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762663821; c=relaxed/simple;
	bh=RqrTWyEAyenzg8uGzLFZMH/QGWsjkPO/81EAXIlE4WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COj8KGFFMi3yawR04UomYaahvLqWfHk5cSNg5CT7t2PpeR7VSFXqDTGNc07bzWLx7DMiOCJ2JgVQR1q36yu+ekoIEoPIxBX0tTlNvBjKckiTetbfhLRWmou9AGyvHtQ+XIgwRMGugvCEZPy2nb8n2gnr04GLy8fn67czJ6EFnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcgJkQkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAE1C4CEFB;
	Sun,  9 Nov 2025 04:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762663820;
	bh=RqrTWyEAyenzg8uGzLFZMH/QGWsjkPO/81EAXIlE4WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcgJkQkWOUHhGI8OCKCtPyWDspxpydPp0kmHnXRjiVKSfS6kwR9KWsLjGljpvC5Kn
	 yBUQWiloP1gNcteR/73zoCJukUdl0KX5B0sg0gbUCp3AgbfbrHCrdReGqzJZnRmiky
	 YmweWbuE5yaT/+tBYb+dFT4vwpjO+J5OjHfXG1UAYlBwp1+CSU3/1BGRDLiG3CKTcl
	 h0OFaC75eDe33GczNR5ciV7SSgJfSTcKVjHqAkwdws/2P84LFf/c/ndcafllsS4IyM
	 ZwEzdwfPQFA9SFuBpuDv0JD1dY2FwDf4kFIbKzUUaa60y0agG8Sp8PGpTEQwyVSyWq
	 tfrO7Sa1hOFFQ==
Date: Sun, 9 Nov 2025 06:50:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Integrity <linux-integrity@vger.kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: tpm: tpm-security: Demote "Null Primary
 Key Certification in Userspace" section
Message-ID: <aRAdiUB9otJk5i9U@kernel.org>
References: <20251104131312.23791-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104131312.23791-1-bagasdotme@gmail.com>

On Tue, Nov 04, 2025 at 08:13:12PM +0700, Bagas Sanjaya wrote:
> The last section heading in TPM security docs is formatted as title
> heading instead. As such, it shows up as TPM toctree entry. Demote it
> to section heading as appropriate.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/security/tpm/tpm-security.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/security/tpm/tpm-security.rst b/Documentation/security/tpm/tpm-security.rst
> index 4f633f2510336b..bf73bbe66db2fa 100644
> --- a/Documentation/security/tpm/tpm-security.rst
> +++ b/Documentation/security/tpm/tpm-security.rst
> @@ -153,7 +153,7 @@ protect key sealing and parameter decryption to protect key unsealing
>  and random number generation.
>  
>  Null Primary Key Certification in Userspace
> -===========================================
> +-------------------------------------------
>  
>  Every TPM comes shipped with a couple of X.509 certificates for the
>  primary endorsement key.  This document assumes that the Elliptic
> 
> base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
> -- 
> An old man doll... just what I always wanted! - Clara
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Should I pick this?

BR, Jarkko

