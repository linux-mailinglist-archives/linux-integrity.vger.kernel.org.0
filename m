Return-Path: <linux-integrity+bounces-2651-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7238CFE84
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 13:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044BC1F237AE
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C413A3EE;
	Mon, 27 May 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVIYnWm9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093713B2BC;
	Mon, 27 May 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807650; cv=none; b=lcQvcmPSj/Jg4rfZyV48EqDDwvzqChyH6jCQeftTVOTTvD9LxN1VfNOPazXO7QhACpViD1QHgpBOArsTD+duxcMflVwcsr63Q0fTpXZcquFIvVDMOvkuCS6mu2JNB0+PtTZ0KMvhWALOSyx+Th9s61lVF1nwk5JvfBvkqo7Gyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807650; c=relaxed/simple;
	bh=SCl5FIk5Id/nLQQw5/gf5Kfb9XND05Sm7vVtqyaXE0Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R5MhK0yZRhk//YNMNO0O/KYJM8bxBU/oPghUukINflA8YLoPjHvBP279e4BBYamTuwCooZlVfaRnwXzP9T5aryQdqzuU8LKP43pKdoAD2q3N1Tjw32EfcmREBhxmo8/k2MyDa9/n3wxbc8yyQ+swYaR1Lq5bXomIPvWVq3xBA3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVIYnWm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CFCC2BBFC;
	Mon, 27 May 2024 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807650;
	bh=SCl5FIk5Id/nLQQw5/gf5Kfb9XND05Sm7vVtqyaXE0Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mVIYnWm91n62JO71GIWwjjPrEFJvJ9UO/COzMgoLgkR9xLR6oY3y//mDlYvvua5f5
	 jv3Bv3Nu6MM2Gl+BhZuD1/Fe/Y7LyepDslaw5LVweEkIU0pUq1iJ1dTQA/2UuSbNNJ
	 wk2idr1rNHlsmrgwt0vovrsyyKUlfiv5WAWy98wHaMBpgP/cbh2qFFOZntkYfS+A2q
	 eUAZRNzCzMgzGKyCd1/ecE2bjhHVuENmMSOyB0/zgSYABC3cT7ttvTnbBsdyITFHVy
	 lNA5/QkjgyNb1u3dj9zKY/pizsINBNUtaEn0KaLpCHp/a3GYpFz8XrAv3kIeop8Aam
	 EyCSNgZCfxNSg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 14:00:45 +0300
Message-Id: <D1KDIOAFZ55T.3ECZ64CCUEER2@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <James.Bottomley@HansenPartnership.com>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "David Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>,
 "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Mario Limonciello" <mario.limonciello@amd.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Open code tpm_buf_parameters()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>
X-Mailer: aerc 0.17.0
References: <20240525154406.4811-1-jarkko@kernel.org>
 <17bbe39e-3c68-4e0b-9862-9658f684b19e@molgen.mpg.de>
In-Reply-To: <17bbe39e-3c68-4e0b-9862-9658f684b19e@molgen.mpg.de>

On Sun May 26, 2024 at 8:42 AM EEST, Paul Menzel wrote:
> Dear Jarkko,
>
>
> Thank you for your patch.
>
> Am 25.05.24 um 17:44 schrieb Jarkko Sakkinen:
> > With only single call site, this no sense, and it actually slipped out
>
> this *makes* no sense?

Thanks for the remark :-)

>
> > of the radar during the review. Open code and document the action
> > directly to the site, to make it more readable.
>
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul

In order not to have to recycle this, does this now make sense to you:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?id=3Db6b88cde77e7c30ab8f534d723ad9c4ec15b7753

Unless actual critical fixes for hmac, probably will save this to v6.11
but with some "real" fixes I'll piggy pack it to rcX.

BR, Jarkko

