Return-Path: <linux-integrity+bounces-6859-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0093B2845B
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A981D5E382C
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3182E5D1F;
	Fri, 15 Aug 2025 16:48:43 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339B2E5D2A;
	Fri, 15 Aug 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276523; cv=none; b=PBEPiJTkwhvoTw80PaAK0D6mI1P7uiAl/W+TSbHnQCap1mMam3SABgw/UBZhATPPOycd7CrT3jnoZ+ekuYzlip8yJcc5BimFDH3IRxQzcE/W1UcRfeaSSyVcTBK5bPj24i/93OOdTr6V5958hNfiGr2EU2TtUyTs1h8/oWwSXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276523; c=relaxed/simple;
	bh=Jx25eL5AwH+8t2BvKxysBZMJgaSoE/lJB5CQzo6yEgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgOCmIp4ImkUc7TQHUl9U2jg8ntPVKVZbf4/f2ubGF0uVMHKKsciBv8iAieMBhiIb7ByFvWU5bdCeoin9rgs5mh3rlSOl835ufG9aecQXFpZXa3GqN3PyUWvMqHslLWGCiKxXiXEG0I1VYRbIzJMQjyMKTmGBpCUcUjelztRfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [100.72.154.47] (unknown [185.109.152.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4D35B60213AC6;
	Fri, 15 Aug 2025 18:48:05 +0200 (CEST)
Message-ID: <f65c230b-7d90-482f-b3c6-592aa7b6d0a2@molgen.mpg.de>
Date: Fri, 15 Aug 2025 18:48:02 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] integrity: Select CRYPTO from
 INTEGRITY_ASYMMETRIC_KEYS
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, linux-crypto@vger.kernel.org
References: <20250815021733.25689-1-ebiggers@kernel.org>
 <20250815021733.25689-2-ebiggers@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250815021733.25689-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Eric,


Thank you for your patch.

Am 15.08.25 um 04:17 schrieb Eric Biggers:
> Select CRYPTO from INTEGRITY_ASYMMETRIC_KEYS, since
> INTEGRITY_ASYMMETRIC_KEYS selects several options that depend on CRYPTO.
> 
> This unblocks the removal of the CRYPTO selection from SIGNATURE.
> SIGNATURE (lib/digsig.c) itself will no longer need CRYPTO, but
> INTEGRITY_ASYMMETRIC_KEYS was depending on it indirectly via the chain
> SIGNATURE => INTEGRITY_SIGNATURE => INTEGRITY_ASYMMETRIC_KEYS.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   security/integrity/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 3c45f4f3455fb..916d4f2bfc441 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -34,10 +34,11 @@ config INTEGRITY_ASYMMETRIC_KEYS
>   	bool "Enable asymmetric keys support"
>   	depends on INTEGRITY_SIGNATURE
>   	default n
>   	select ASYMMETRIC_KEY_TYPE
>   	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +	select CRYPTO
>   	select CRYPTO_RSA
>   	select X509_CERTIFICATE_PARSER
>   	help
>   	  This option enables digital signature verification using
>   	  asymmetric keys.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

