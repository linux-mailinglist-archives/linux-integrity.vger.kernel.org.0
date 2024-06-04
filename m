Return-Path: <linux-integrity+bounces-2781-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88498FB950
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 18:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C8C286583
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593D148847;
	Tue,  4 Jun 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta4+C5HW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C431487EA;
	Tue,  4 Jun 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519389; cv=none; b=RqYJcNe194xZOhN21ChSBdA+dekGbENWGHYH9DvTV0RM5aAwPLt3tk2a4FzVweIwoXUwRvmKQHqJmS3lx+d96qCkSbem6QnAdcuHIk2lb8GgJ6s/tk9hVLuWukHPaDmCOXOrTHIoqg3hMy2H0tQkafDl/NT8g6RK+2KsIAwYMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519389; c=relaxed/simple;
	bh=1p99fCGxODxrIiIt9XeDCfRuJ+kqg3lvOH++vIvpUAA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Dv8zeINuPD/Jwg1TtPuj6gM8BQ6Ax8keJJqlAXnmyb3tLsGSBTMRaqOTC2FsjJXaUel87LcVkFQS8DL9ZaEsrfZ8BXUha04vEGUCTQTiTffL5XDl6LiyRgtME2T5GAx8Wg8SMj4WcS4NCaYCh1mbCOzIQ+hp6htOIjVhrHlD+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta4+C5HW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AC6C2BBFC;
	Tue,  4 Jun 2024 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717519389;
	bh=1p99fCGxODxrIiIt9XeDCfRuJ+kqg3lvOH++vIvpUAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ta4+C5HWSlUb+AKDacytBH7eL9iXvO7U7HHIWIxf9ZCDJanoA1+wK78DEcNXhM2or
	 OYwVopQxjtOuuyrflAqE+Y2VhwqoTlNA0/kU3NvEaVAmrFJQykkeliBXj1QU5YxuzG
	 5G3sG8DyV2iWlmsMC1Un2WqLmt9jfGq/yAL87Oiexmto+J9mlJTTZw+qHtGvtEaI76
	 oimZpNV9FQrKwkGh0oRsvJfz8CkapqDxjfIcI95jPsGIAXQ6gUNcLB/NKs3EEk7VGg
	 5ZlRYtwAZim/glGC5L6QnVAWTMm5BjpXhNGuIqQrtV2zY2Oz11DQwO2mPEsCuF3rXD
	 4+gqXgF7z8qMA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 19:43:05 +0300
Message-Id: <D1RDT52OY7S6.J625EB7S0KVR@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: add missing MODULE_DESCRIPTION()
X-Mailer: aerc 0.17.0
References: <20240530-md-trusted-v2-1-151f0c7be272@quicinc.com>
In-Reply-To: <20240530-md-trusted-v2-1-151f0c7be272@quicinc.com>

On Thu May 30, 2024 at 5:43 PM EEST, Jeff Johnson wrote:
> kbuild reports:
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-k=
eys/trusted.o
>
> Add the missing MODULE_DESCRIPTION() macro invocation.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - reword commit text per Jarkko's guidance
> - Link to v1: https://lore.kernel.org/r/20240529-md-trusted-v1-1-56c9a0ae=
8e28@quicinc.com
> ---
>  security/keys/trusted-keys/trusted_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
> index 5113aeae5628..f4ab16d59663 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -395,4 +395,5 @@ static void __exit cleanup_trusted(void)
>  late_initcall(init_trusted);
>  module_exit(cleanup_trusted);
> =20
> +MODULE_DESCRIPTION("Trusted Key support");

First this should be just "Trusted key type".

Second: neither encrypted keys has the description.

So I'd consider also "Encrypted key type" for that one.

So this really needs two patches to be done properly.

BR, Jarkko

