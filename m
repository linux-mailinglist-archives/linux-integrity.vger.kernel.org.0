Return-Path: <linux-integrity+bounces-3609-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D7979AAF
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 07:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573F4B20B79
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 05:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7131C6A1;
	Mon, 16 Sep 2024 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgF5l6tt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72117C6C;
	Mon, 16 Sep 2024 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463769; cv=none; b=fouohTAxIhZFEsI2cpTYHlY5ssokwF4ZNdERg/L2nZtEkvuOK96R6+mC0lb4lKA+CRbmpV2ZOYecIYGcd0kk2U7VaybHPKw5voyoh2tMIHvrFESe/l3c38Zph9TvnJUfedzlVuyuN3FYTCi93Gy5fsHQLBQK29gANEP8ZZ1sdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463769; c=relaxed/simple;
	bh=vvZ8k9hQDToFD2OaOTfacHZqXgJx9ZtN2s+yDabkp6o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=qgAraAX0P84ZVPFiiQA21ModIz0N3jZl0cCzC4u8jf/V1q3D+1Hx/ZOAZ7ouoBQEa+Ek2/r4/nidcYO0Pfce5SIkPG5EYXJTUrv/XC9nHXpD55VkBU5LJv1OMp88uQhorw21v1eIchRndpI61fTy5vz+2gD49jGRqv+2eTEttX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgF5l6tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA98C4CEC4;
	Mon, 16 Sep 2024 05:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726463768;
	bh=vvZ8k9hQDToFD2OaOTfacHZqXgJx9ZtN2s+yDabkp6o=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=DgF5l6tt4B0ppnxeTZncFtw91SDoNMFoxngETAhM8VAdkUt7UObQMbredWJjpZce5
	 yIen9OXRrEc6KS/nqOohNv5bY2EtOq568H65kkFUDfbmhhv9wfO1reuKzoKq+pvd/n
	 Km8wyP0UwZ5E/MIAcPDnoxwFD+HdrQhU0VbKz2NawGj9FOlUVpMuCAAwdWf+0DVD0C
	 9Rcx9DWEJdBFypUp9N7AWWheafP+P5GMYcSYlx4xSTzwwCgzLIWy4jCfkSjqu89EXQ
	 Lr6DbjslUM3qLLeHz+rN7X19GWJZdcJND41O1IrThgI3B9zn5QxGem3/EO+/K6iEFT
	 zCBRtbRJmNgnQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Sep 2024 08:16:04 +0300
Message-Id: <D47GBS5ZGNPC.3IRSGEBQGJURI@kernel.org>
To: "Pengyu Ma" <mapengyu@gmail.com>
Cc: <linux-integrity@vger.kernel.org>,
 <James.Bottomley@hansenpartnership.com>, <roberto.sassu@huawei.com>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] tpm: lazy flush for the session null key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240915180448.2030115-1-jarkko@kernel.org>
 <CALSz7m0ehXM+dU3z0xYPLQkHbyfyMjoCOoMLdBgRcUu1pnT_ww@mail.gmail.com>
 <CALSz7m1WG7fZ9UuO0URgCZEDG7r_wB4Ev_4mOHJThH_d1Ed1nw@mail.gmail.com>
In-Reply-To: <CALSz7m1WG7fZ9UuO0URgCZEDG7r_wB4Ev_4mOHJThH_d1Ed1nw@mail.gmail.com>

On Mon Sep 16, 2024 at 5:33 AM EEST, Pengyu Ma wrote:
> After applied your patches, the boot time is ~15 seconds.
> Less than 20 sec, but still much more than 7 sec when disabling HMAC.

Great, and thank you for testing this. I did expect it to fully address
the issue but it is on the direct path. It took me few days to get my
testing environment right before moving forward [1], mainly to get
bpftrace included, thus the delay.

Do you mind if I add tested-by for the for this one?

Before the patch set the in-kernel TPM sequences were along the lines
of:

1. Load the null key.
2. Load the auth session.
3. Do stuff with overhead from encryption.
4. Save the session.
5. Save the null key.

With the changes:

1. Load the session.
2. Do stuff with overhead from encryption.
3. Save the session.

Each swapped session gets an increasing count. If the count grows over
treshold measured by the difference of the count in the latest loaded
session and the session currently being saved, then TPM throws out=20
a context gap error. It has a limited resolution for this.

As long as /dev/tpm0 is not opened by any process, there is only one
session open (or at least fixed pre-determined number moving forward).
This means that context gap error cannot occur, as the only session
saved is the auth session.

I'll implement a patch on top of this, which does exactly this: track
the number of open /dev/tpm{rm0}. Only when the device is open, the
auth session is flushed.

With this change the sequence reduces to:

1. Do stuff with overhead from encryption.

Since the results are promising (thanks to you), I create a new version
of this patch set with this additional fix. There's no chance to reach
the same exact boot-up time as without encryption but I think we might
be able to reach a reasonable cost.

[1] https://codeberg.org/jarkko/linux-tpmdd-test

BR, Jarkko

