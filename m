Return-Path: <linux-integrity+bounces-7446-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E3EBEB62F
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 21:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 353574E5955
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 19:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7912E2FDC38;
	Fri, 17 Oct 2025 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRm8HSWQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328D33F8A5;
	Fri, 17 Oct 2025 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729269; cv=none; b=CB7YqO9et1vfG4uyzbNvsHLo9RgSh7FO08W67d4rlaNT6TMYvo7uaIdAyjZYuVuXFKBYZOAd/K8PUOdFw8eGh83yU2Rez6YjFN2376IkfoldQV21G3JelMfgyNxrNLVEHyc5udGA+RBebRvLa0VmHcimmQIKdj9rtm2QOVUXpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729269; c=relaxed/simple;
	bh=mcoBV77KiMRh2mU/rmsiY4X9DXeBVgX4cPU+NVWl+tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4cc7xMFw4Km91t/mK3rdeflN+IiDRsCcrW5Uh4RuktNAFXrFsSs8pjqbakwo/WXA7S8Sw7YveWkAecZeU/OIOPevp/Zr0HOlfFRjQaaaCff0cQJuTr5N3regXVA/f2JyJZe/6MWD3UsHXK4bquAOxbwK4Fviksum5mvTh/f3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZRm8HSWQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=U5Ytw4RP5PrcMrnCeeRigKUwGeJ5Azr3SrQLjgFx4k4=; b=ZRm8HSWQtJOLBeP+ciSYefVzWA
	gtSH7khtTB5h2BtAsFx+OS/infp8XuI/eUjo56YQ66jFO53RvPKCRdvx8QmifOIUeoDaf0//KK+dQ
	lAGGFYNJyJSnib1bg3mpcDymylQXEbxbHCdKk8LjXdjFpa9wSsvLfq4PScaS9I37W9gpHLee3uNCa
	F+5ptiIjYikACvk1Pu/vNni04xP0VFDk71R587scN3LB5wpEF4+TH6G56SoBkNr2oC+MmuQA8Gf44
	klITQjxW0AHSCBNtMu4HpZEW8ZjBo1jHCJsmjMZ0UkuON+3yQ4xnLSMJDsGLwor24A+J4AB5CC3y0
	zpKkFTeA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9q76-00000008qBs-2RBQ;
	Fri, 17 Oct 2025 19:27:44 +0000
Message-ID: <7928c851-649d-47f4-a747-3314c0d45706@infradead.org>
Date: Fri, 17 Oct 2025 12:27:43 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: trusted-encrypted: fix htmldocs build error
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, zohar@linux.ibm.com,
 James.Bottomley@HansenPartnership.com, jarkko@kernel.org, corbet@lwn.net,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linux.dev, khalid@kernel.org
References: <20251017181135.354411-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251017181135.354411-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding patch signers.

Fixes: 95c46f40aac4 ("docs: trusted-encrypted: trusted-keys as protected keys")

although that might not matter if this patch is only in a -next tree.


On 10/17/25 11:11 AM, Gopi Krishna Menon wrote:
> Running "make htmldocs" generates the following build error and
> warning in trusted-encrypted.rst:
> 
> Documentation/security/keys/trusted-encrypted.rst:18: ERROR: Unexpected indentation.
> Documentation/security/keys/trusted-encrypted.rst:19: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Add a blank line before bullet list and fix the indentation of text to
> fix the build error and resolve the warning.
> 
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> 
> Tested by running "make htmldocs" before and after the change,
> ensuring that output renders correctly in browsers.
> 
>  Documentation/security/keys/trusted-encrypted.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 2bcaaa7d119b..eae6a36b1c9a 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -14,10 +14,11 @@ Trusted Keys as Protected key
>  =============================
>  It is the secure way of keeping the keys in the kernel key-ring as Trusted-Key,
>  such that:
> +
>  - Key-blob, an encrypted key-data, created to be stored, loaded and seen by
> -            userspace.
> +  userspace.
>  - Key-data, the plain-key text in the system memory, to be used by
> -            kernel space only.
> +  kernel space only.
>  
>  Though key-data is not accessible to the user-space in plain-text, but it is in
>  plain-text in system memory, when used in kernel space. Even though kernel-space

-- 
~Randy

