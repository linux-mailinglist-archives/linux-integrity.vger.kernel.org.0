Return-Path: <linux-integrity+bounces-2878-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F68990FA2F
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 02:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5CB1F22109
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 00:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC361803;
	Thu, 20 Jun 2024 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPjMF0/i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96721C02;
	Thu, 20 Jun 2024 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718842753; cv=none; b=mULLm2AUHWtYwqReV56m6H9BQh9ueqvck0rc36oM8AFuNrdlAQpvTHjKHWxi7AKLbBtfz7Sl+1AowfdRi4+05eqE+ay3djSJ5pWxoMCf7eNVOdd8f7rvTeTEozVftEOCYQGqqACrGoPkXXpTFeHfF4qDIMaYBiRnvCoXaxZGRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718842753; c=relaxed/simple;
	bh=Rf67pFF+333ccM9oZKN4wF6guSKaFqEmVkrXWE9tz54=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P5noElvzdwHmM0WEwzaBxqJMLpIaLpMboZ80NLLYwJ4Sv3v+JDIANN9aAPhJ9AlBQOMuiAIiuGMw6hRcp83E9PH6FkdBjKYHxkyEc/rrh8a1KK0JsW70tTpTOGLcT7MMCK8ulxQvCX/yxAxCp2a6pUHB3+3XTqZojpjEv3t8IIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPjMF0/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A28C2BBFC;
	Thu, 20 Jun 2024 00:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718842753;
	bh=Rf67pFF+333ccM9oZKN4wF6guSKaFqEmVkrXWE9tz54=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GPjMF0/iN67qTJwfeGCRJv/uLpabn+1w6vrbhwDL0ZFEzG1iYAtCeKBq2WMo10mdG
	 RrkxVU2TqMkvlXQOHkrstfpYNvI2lhSswf4t2qmVnVQQZ6Q+Ufqg7Adkx9PV6l8jKo
	 +3zWQsxGvUVxmYKnLotFxs4O77HpponAWPC6Y5e9PufAOp1h6ycX9q5OZ6N/0mpRS3
	 yzxTFN9M6cf7z1fUNAOtkUnQ0VHp8VXvcyh4UwjGFWBJJjya6qW9ifQ3khuReWEOf3
	 9YxLp+9l2HI/v6y08c21NFZdIz3zRU4h1xpt/XG366A+VJ5VkKwGiEJqxaSLgAU9K+
	 YdwARf/a21k7A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Jun 2024 03:19:08 +0300
Message-Id: <D24EWHXV14EM.S0NQ3H51R892@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] KEYS: trusted: add missing MODULE_DESCRIPTION()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>
X-Mailer: aerc 0.17.0
References: <20240606-md-trusted-v3-0-42716f15e66e@quicinc.com>
 <20240606-md-trusted-v3-1-42716f15e66e@quicinc.com>
In-Reply-To: <20240606-md-trusted-v3-1-42716f15e66e@quicinc.com>

On Fri Jun 7, 2024 at 4:47 AM EEST, Jeff Johnson wrote:
> kbuild reports:
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-k=
eys/trusted.o
>
> Add the missing MODULE_DESCRIPTION() macro invocation.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  security/keys/trusted-keys/trusted_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
> index 5113aeae5628..e2d9644efde1 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -395,4 +395,5 @@ static void __exit cleanup_trusted(void)
>  late_initcall(init_trusted);
>  module_exit(cleanup_trusted);
> =20
> +MODULE_DESCRIPTION("Trusted Key type");
>  MODULE_LICENSE("GPL");

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

