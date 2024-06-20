Return-Path: <linux-integrity+bounces-2879-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1890FA33
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 02:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A302824EE
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323CEBE;
	Thu, 20 Jun 2024 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6JPtoD9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A0803;
	Thu, 20 Jun 2024 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718842777; cv=none; b=OcMp5rQ+iySU1pJmIkQwyC6SB9ahrzGPMm/m+nt0d6I8+U/fvkeP6OV8PuHVUc28Zxx0dl6u6O70fRrn7rS5xQncyXdTOKCY4y+cDvoNtDJvo2jj/qIy/NxJZCmSmD/4qPkBnQC9uNm9qIfyvJN8cXzNcsHWe1eQssXP5joo0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718842777; c=relaxed/simple;
	bh=aAxvRmyU6eGzufg6jqOySxqXJ+23+A+mbhwHxG6OZWY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GAfXDc3+KctCHfaudp4FA1CC1pXfDMkI3QPZ+cePUDrS9Y/OvmHkC0IsZYht7+rKM3T43wfMjlJ4uDoEpFcYy4mbKnv6/h2CbEyxpdFycXdA4T4dUHN/4VP4rK++R6dxILbo5YV+Em4kv9vsUUQX8aaJz4YY/p6oQ/BSmoiS0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6JPtoD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06195C2BBFC;
	Thu, 20 Jun 2024 00:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718842777;
	bh=aAxvRmyU6eGzufg6jqOySxqXJ+23+A+mbhwHxG6OZWY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=b6JPtoD9839CTXgCWKTMiqQ4aFO6kRGKNrv+ALiiuMeJIVS/Sgyasm8ce1kfBRxfT
	 7eY8tyRcZHSHB51o3cRdNaX3GznSOzPdZ/NLz4IYqc8xPw8gcXZhv/8+wrAIL+tov5
	 QELTZkYnCQafGGS1j2dMdaZV+HxdzPsspEhFSjn0XAdzXv/QeamCCAhMx331pHgpIl
	 D9FMt7pXOB/ZFZPkA9BqOwvr5SoIkHdNo2L/A4u7/I6xOaLh5eVjJhDH3FqKZiQhUu
	 SeeY5FOA6RtZCkl0Ho9PlhKX5kObiX4KCHTzmL9fnUlEAmqc0ALWE19tzPnpsN/zJu
	 Gb3XGDJYhQ/lg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Jun 2024 03:19:33 +0300
Message-Id: <D24EWT5ESVET.2K1K93ONMJ1R5@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] KEYS: encrypted: add missing
 MODULE_DESCRIPTION()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>
X-Mailer: aerc 0.17.0
References: <20240606-md-trusted-v3-0-42716f15e66e@quicinc.com>
 <20240606-md-trusted-v3-2-42716f15e66e@quicinc.com>
In-Reply-To: <20240606-md-trusted-v3-2-42716f15e66e@quicinc.com>

On Fri Jun 7, 2024 at 4:47 AM EEST, Jeff Johnson wrote:
> During kbuild, with W=3D1, modpost will warn when a module doesn't have
> a MODULE_DESCRIPTION(). The encrypted-keys module does not have a
> MODULE_DESCRIPTION().  But currently, even with an allmodconfig
> configuration, this module is built-in, and as a result, kbuild does
> not currently warn about the missing MODULE_DESCRIPTION().
>
> However, just in case it is built as a module in the future, add the
> missing MODULE_DESCRIPTION() macro invocation.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/enc=
rypted-keys/encrypted.c
> index 8af2136069d2..831cb84fd75a 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -1040,4 +1040,5 @@ static void __exit cleanup_encrypted(void)
>  late_initcall(init_encrypted);
>  module_exit(cleanup_encrypted);
> =20
> +MODULE_DESCRIPTION("Encrypted key type");
>  MODULE_LICENSE("GPL");

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

