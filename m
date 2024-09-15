Return-Path: <linux-integrity+bounces-3607-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5170979812
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 20:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D801F2121B
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F31C68A7;
	Sun, 15 Sep 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzDbRkCx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99E17C91;
	Sun, 15 Sep 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423974; cv=none; b=Pxp6giCOc0ohvTe51J/CNC+q6OcdjepESUsWYV1NVl+jlsyrPO9ubDjPtFNR0jiBCPO7h49m1Leu9pw1WsN1DhBDChsqk35wNvx8z2+YXU+VpO9NV3I5uq/SJQA4riSXJOafYMGWCV8eogkid1BBDwGyZPxxaMMSPWR2yiB0GI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423974; c=relaxed/simple;
	bh=zXJSMhDJvF8KX1pUeO8bKX2FXlDPqGfTCpebMUz6I48=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HmcY6mQeHz0jZkl3taSjvwg/pheTUh/wESgMjmxmOovbOqW32N47nmGy0pd9Z+3s+WVhZFXaemJDeOan1DIYSmte/1PgZWZgledsS7TP+LUr73c7TltSOGJngPJ2FyyTCzBrddY5JURrVy08D3ZJDzcbKFeq0Rs7YRqHhk4BrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzDbRkCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB90C4CEC3;
	Sun, 15 Sep 2024 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726423973;
	bh=zXJSMhDJvF8KX1pUeO8bKX2FXlDPqGfTCpebMUz6I48=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KzDbRkCxSkReK5yxmQDmJspOmysePm8rzQBcPkyekqCXFQJX0fUdBi/ZBC4rfX7i2
	 smrfa5IFNaebERxd8qUkrgpj4JN1NH+vD+yalbxMHfDk72p1sQkXgu8qSqtO2JBAtg
	 kBojmUpd2Ol5UQLKydrhedEZ9KRwWxATHkTqhN0LcQ0lpGor4bxXvG1vyTPnB9BI6S
	 Hg9YQDSOHC6nhNq5bURIGpomhp9vQgYE3erXxJbJ3xNOvg2zOgtKVGCc+9qoliaDaT
	 PRmTOkBqLcgM5gd9tysi+Ahlv2xnmitmpOwjck8WY/WCiT317Or3aPJMYqjFpOPHto
	 ZM5j4QQ8dN2og==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 21:12:49 +0300
Message-Id: <D4727YOJY8KZ.L6RKMRBKRCSN@kernel.org>
Cc: <James.Bottomley@HansenPartnership.com>, <roberto.sassu@huawei.com>,
 <mapengyu@gmail.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] tpm: lazy flush for the session null key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240915180448.2030115-1-jarkko@kernel.org>
In-Reply-To: <20240915180448.2030115-1-jarkko@kernel.org>

On Sun Sep 15, 2024 at 9:04 PM EEST, Jarkko Sakkinen wrote:
> There is no load and flush the null key for every transaction. It only
> needs to be flushed when user space accesses TPM. This postpones the
> flush up to that point.
>
> The goal is to take the first step addressing [1]. Other performance
> improvements are needed too but this is the most obvious one and
> easiest to address.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
>
> Jarkko Sakkinen (4):
>   tpm: remove file header documentation from tpm2-sessions.c
>   tpm: address tpm2_create_null_primary() return value
>   tpm: address tpm2_create_primary() failure
>   tpm: flush the session null key only when required
>
>  drivers/char/tpm/tpm-chip.c       |  13 ++++
>  drivers/char/tpm/tpm-dev-common.c |   7 ++
>  drivers/char/tpm/tpm-interface.c  |   9 ++-
>  drivers/char/tpm/tpm2-cmd.c       |   3 +
>  drivers/char/tpm/tpm2-sessions.c  | 115 ++++++++++--------------------
>  include/linux/tpm.h               |   2 +
>  6 files changed, 68 insertions(+), 81 deletions(-)

I did not take any benchmarks yet but I did run this through
run-tests.sh in [1] to make sure that it does not break anything.

Looking at pseude-code of ContextSave from [2] fixing this is
orthogonal from any possible context gap issues as null key
is just plain transient object.

I would fix the obvious first and then look what can be done
to sessions (e.g. global LRU tracking of sessions or similar
approach). I don't expect over the top performance improvement
with this patch set.

[1] https://codeberg.org/jarkko/linux-tpmdd-test
[2] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-=
3-Commands-Code.pdf

BR, Jarkko

