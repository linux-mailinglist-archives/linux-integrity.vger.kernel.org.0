Return-Path: <linux-integrity+bounces-3127-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C08932619
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 14:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21E5281C04
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B141448ED;
	Tue, 16 Jul 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol19+DJR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5831CA9F;
	Tue, 16 Jul 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131406; cv=none; b=Y2MtzzxRDk8BHMV4IRB8ZjLjUQCE4HurFQrUzVregVVDPJYmxqdQV1Ob6MeuB0PmPs3fYYFHUHVmmu8ycNRoHfpRYHyq6yk/eVfWI1uqSmQzsNBjXfyc9ToBr1YDvpEK3UzqOdtnzuJiL9PPusWh7RzQ7eztKrVOsWuQCyJzNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131406; c=relaxed/simple;
	bh=okxaPDd2p8TsGaCnqoBMAzm1NCcs6cq9e5B0R8f6rkQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Fvkuvea0s0flwOJuOa5ELeD39yDShyt6jZoIphhAQhCADcZlRf7knTUERQqNTd9ZYtYtVVQU2LvjopMNpZZDvJPeN6wJMbK/py5ccWWeCykigbsibfsWfnTtJKqAX8cXYxHSGKoD5HtybTZSpcS/zsou29zUUhMYBs/5+RZufzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol19+DJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D219CC116B1;
	Tue, 16 Jul 2024 12:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721131405;
	bh=okxaPDd2p8TsGaCnqoBMAzm1NCcs6cq9e5B0R8f6rkQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ol19+DJRFJz1j+ylXrsrZ9xroVdVfztonkGm7V0pRG3SrKj99StfjlaR5VgRJ4IT6
	 kMHgG7m7gdw159o9ULlpC8O0aTQjJG3VksBCSrl5dJoAwD+BUkFbyv+SOVVnS8wnpl
	 MohrWIziKDQLKGOkEWejQQ2Gly9/WQdD61wi6Dmi2vGp8mTiPr2+1vpd98iZ56C6ZK
	 QAZxXYmShFc+U2q8YgAcKVIibRnJrHfjBS6kNjDks08h1GPzTgMKz4KzS/mlToHabw
	 51VM5MSZ0iaC3zbXWlpHu8p5Tca7LTPzd/8/5g2EV+AS65HHrwS2/6j6VQ9dMoWz1D
	 FqloYx6tMbKnw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 15:03:22 +0300
Message-Id: <D2QY5V31UW1B.17OJ91QRTTE67@kernel.org>
Cc: <keyrings@vger.kernel.org>
Subject: Re: [PATCH 5/6] KEYS: trusted: implement counter/timer policy
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-6-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524130459.21510-6-James.Bottomley@HansenPartnership.com>

On Fri May 24, 2024 at 4:04 PM EEST, James Bottomley wrote:
> This is actually a generic policy allowing a range of comparisons
> against any value set in the TPM Clock, which includes things like the
> reset count, a monotonic millisecond count and the restart count.  The
> most useful comparison is against the millisecond count for expiring
> keys.  However, you have to remember that currently Linux doesn't try
> to sync the epoch timer with the TPM, so the expiration is actually
> measured in how long the TPM itself has been powered on ... the TPM
> timer doesn't count while the system is powered down.  The millisecond
> counter is a u64 quantity found at offset 8 in the timer structure,
> and the <=3D comparision operand is 9, so a policy set to expire after th=
e
> TPM has been up for 100 seconds would look like
>
> 0000016d00000000000f424000080009

These random magic hex numbers confuse and do not bring any clarity.

Also, please learn to use multiple paragraph when you write text.
>
> Where 0x16d is the counter timer policy code and 0xf4240 is 100 000 in
> hex.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Skip because enough stuff to address in the head.

BR, Jarkko

