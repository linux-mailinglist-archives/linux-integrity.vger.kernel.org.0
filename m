Return-Path: <linux-integrity+bounces-3107-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD84930A99
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Jul 2024 17:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC2D1C20984
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Jul 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900941C62;
	Sun, 14 Jul 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSOUf8AC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B452F5B;
	Sun, 14 Jul 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720971828; cv=none; b=BBDwUAzYRi9RA0X1d5k7NmyRh6oLrnIR9CYbhuJ7wJvzLiXrrHRGI2HEYEEb38CJf00XUK/7ZUHSgn/ns7aufzb0jfQSV7rjoWdmHpz2+scXd20I5Imh55WRWfULTV43aIF+eCLaSCTV1mDSVr6U6Fwx8WPmPO/vMWX9zmipzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720971828; c=relaxed/simple;
	bh=dWsGnWYI/CpKAaBJ+Mk/aGmNmbT6hDk+yjZuzwGnLAE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jREiFUK/oCxf0d/HF62LcpqUMCf5yhepF49yazu7Ah2rIwdLCNHKdcpJCnHOIiN5vQ/2dy5VMjmUK/t37/URHfsDn8tpIrtBrqUZ3aqCJ3U57BBSmeG0m+aklxYwq+4Aaezqfsv+aafqK5Vxz5Hvmjl5PPgJ3aiTfeoRUFMMVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSOUf8AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE69EC116B1;
	Sun, 14 Jul 2024 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720971828;
	bh=dWsGnWYI/CpKAaBJ+Mk/aGmNmbT6hDk+yjZuzwGnLAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSOUf8ACYJsKf3tiWm1pCsFdDfRUvEyPhmHJNikDOLpapzA/P2Bpj7mpP3t5/VW1c
	 045tmzkhtb0ruYT/Eb3NNR8XmseL5XASE176lpxGCpr7HWigkr6YfhnMCDw6BooelC
	 rCOYDIN56NS4f9JXHT3pqttacI+zP+hIRwUKF6q1WMmG/UcyHAjfmZBlK/+sH1m1t5
	 JcZEDrAk3Kif+h2cr6R4isrtJ1LVcyiPa6gWmXnS4oqx0NAbUlmuYOJ+xHmuD+Qr4K
	 +Ez2uekCLAEM8xT8haJhia+eo+uSEwlBJLXEDZxMRdOxqyj/4vUk0GyqRJDWncVgyJ
	 ZNhX/EFynX6Pg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jul 2024 18:43:44 +0300
Message-Id: <D2PDLHX51C3K.16A4U6XFXRE29@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Hao Ge" <hao.ge@linux.dev>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hao
 Ge" <gehao@kylinos.cn>
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
X-Mailer: aerc 0.18.0
References: <20240709023337.102509-1-hao.ge@linux.dev>
In-Reply-To: <20240709023337.102509-1-hao.ge@linux.dev>

On Tue Jul 9, 2024 at 5:33 AM EEST, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
>
> We shouldn't dereference "auth" until after we have checked that it is
> non-NULL.

Sorry for some latency in responses. I'm on holiday up until week 31 and
only look at emerging issues but not every day.

I do agree with the code change but the description contains no information
of the bug and how the fix resolves it. Could you please rewrite the
description?

I can only think this realizing with tpm_ibmvtpm and TCG_TPM2_HMAC
enabled because it was according to recent learnings a platform which
does not end up calling tpm2_sessions_init().

Since you bug report contains no bug report, I need to ask that did you
realize a regression in some platform? Fix will get eventually accepted
even if the bug was found by "looking at code" but the gist here is that
your bug description contains no description how you found the bug,
which it should.

When TCG_TPM2_HMAC is disable it should be safe because we have:

static inline int tpm_buf_check_hmac_response(struct tpm_chip *chip,
					      struct tpm_buf *buf,
					      int rc)
{
	return rc;
}

I also noticed that your fixes tag is incorrect as that null dereference
pre-existed on tpm_ibmvtpm before my fixes. It is not a new regression
introduced by my patches. So use git blame and check which commit
introduced that one.

Address these issues and send v2. Thank you!

BR, Jarkko

