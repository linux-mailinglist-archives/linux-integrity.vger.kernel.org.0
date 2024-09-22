Return-Path: <linux-integrity+bounces-3659-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB1E97E2D5
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Sep 2024 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0272B20ED1
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Sep 2024 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751E29406;
	Sun, 22 Sep 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugcolgZT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0228F4;
	Sun, 22 Sep 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727027493; cv=none; b=KWjlJSrlWQsnOwNuR4EGZlU3q7K2JfFW94W2BDP6bTD2MNxA94tx+o7E29irNGYj0AkL8RhHuZLVBTzc/oIxFTSlaJuM7zi91iRkxCiE2S3xiWOnlXH1eZwQAyK3PadbkY1KeNfJxv03Ktp06dDm0LevaETV4gpCYEQm9cZHP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727027493; c=relaxed/simple;
	bh=jrKwbHXXO1kCrYfMrjaKi/Cs9E6R903V1bh7/PKaI3w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X8L+ecyMgUh+xZAYr6S7U9+OEO0E6jyyF8adUlTGKSdo3SN8HlP/jr4os6lxajylQz1OiNlwZsSE4nJHQsWJI/wuI+47yFUt4eC7W0tCO4rO67vnLd3yQjalS3DRmhMQO/2eBit83SzjqLR5vyjwa6sn7B32Y/QzDTybWqegIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugcolgZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A1CC4CEC3;
	Sun, 22 Sep 2024 17:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727027492;
	bh=jrKwbHXXO1kCrYfMrjaKi/Cs9E6R903V1bh7/PKaI3w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ugcolgZTzGEG3+CjpfJ/Qt1VI3ff4D5VnA1dC2+LT1B6p6Ba19Lmq/JiscFTElCVY
	 6rFVnYSviUBaLw4nZcnXb/1TX2YYSP1zwC5aRKBQYsYk1Fc+Ztv9TFY3l28DYRe6a9
	 Ge+5r3k0hOgoHM8A8B7SCsOy+PmN/QmgrPQMosPD+Ak3pw/GnwVo/tDzyuZrak+zii
	 sb1ObggvrnGvgEAMJKsYSPV0vHCMqC9bq/y62EoJ2QXiQT+6UOC2plT/8xZrPa5jzz
	 JMogbab8zAbvaiS9nlp0OfH37NaHcK2TAs3sWonzvQ9xma7/dCOQOiY7VwQ7Jspv0H
	 2t9J221NLNLYA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Sep 2024 20:51:28 +0300
Message-Id: <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
Cc: <James.Bottomley@HansenPartnership.com>, <roberto.sassu@huawei.com>,
 <mapengyu@gmail.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "David Howells"
 <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
In-Reply-To: <20240921120811.1264985-1-jarkko@kernel.org>

On Sat Sep 21, 2024 at 3:08 PM EEST, Jarkko Sakkinen wrote:
> This patch set aims to fix:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219229.
>
> The baseline for the series is the v6.11 tag.
>
> v4:
> https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@ke=
rnel.org/
> v3:
> https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@ke=
rnel.org/
> v2:
> https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@k=
ernel.org/
> v1:
> https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@k=
ernel.org/
>
> Jarkko Sakkinen (5):
>   tpm: Return on tpm2_create_null_primary() failure
>   tpm: Implement tpm2_load_null() rollback
>   tpm: flush the null key only when /dev/tpm0 is accessed
>   tpm: Allocate chip->auth in tpm2_start_auth_session()
>   tpm: flush the auth session only when /dev/tpm0 is open
>
>  drivers/char/tpm/tpm-chip.c       |  14 ++++
>  drivers/char/tpm/tpm-dev-common.c |   8 +++
>  drivers/char/tpm/tpm-interface.c  |  10 ++-
>  drivers/char/tpm/tpm2-cmd.c       |   3 +
>  drivers/char/tpm/tpm2-sessions.c  | 109 ++++++++++++++++++------------
>  include/linux/tpm.h               |   2 +
>  6 files changed, 102 insertions(+), 44 deletions(-)


Roberto, James, speaking of digest cache. This patch set has no aim to
fix those issues but I do believe that it should improve also that=20
feature.

If I don't get soon patch reviews for the patch set, I'll pick the 2nd
best option: disable bus encryption on all architectures including x86
and ARM64 (being by default on).

It's a force majeure situation. I know this would sort out the issue
but I really cannot send these as a pull request with zero reviewe-by's.

I expect this to be closed by tomorrow.

BR, Jarkko

