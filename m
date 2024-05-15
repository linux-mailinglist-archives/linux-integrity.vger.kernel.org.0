Return-Path: <linux-integrity+bounces-2420-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B61C8C6612
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 14:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB861F23372
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D541757EA;
	Wed, 15 May 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWm0WQZG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214A58AC3;
	Wed, 15 May 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774600; cv=none; b=UQ1xti6rwQKDx9D10Qo7vqwHpXfhJu2pUyA+CvS4abwIluFCmf9XfM69z1bBqkxfFSCHJyae+cepjwDaDwcv3Q8yTN0u4u69TTQa9LxNAvmYg+nPhmyL69BM99EPf+Gg+ln9D7pn0HH+PCkOZQ5bU8fSXnAkowaExZ6pcngiIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774600; c=relaxed/simple;
	bh=kfxt6JsqCE1IzZSlDw/+iyGpDKdZQRGvvHfBK97525Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dGBzZG6F1mkO3RtxOipafTZCZPJLINTEEfMQa3VEsey6DTx2QPgWkyCiVUhcUSxqSERPsRidWWEhra38VncSpu0u6Ady1RXSk4aiMbWFOh2wdt+3LsEfaUHYcOYH7p+Q0ALAJrs32camPgi1hSVPH+wXWr/qTeevVy/QZHRiB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWm0WQZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F27BC4AF07;
	Wed, 15 May 2024 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715774599;
	bh=kfxt6JsqCE1IzZSlDw/+iyGpDKdZQRGvvHfBK97525Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tWm0WQZGtAjM8hMW47UD5kIiDpCVHnZyLFQ9wltS1Ljao2EyCXRroQV8DQooL3ub2
	 Sq1F+0qxhn0u7tfXKNXYBoXbmaEEQHU5MpbxT3kujk0r8CU7QRP0mlprMV51COSh9T
	 k7Muo8iDAC41WaqgvYYXMXgGEItOV9MI9ZhHgAa4NSPXcAiZu+nW9aBO35YIX6xAE2
	 UC7nz1kUYDJdxbFGYgAldS24sd4eiDGYa7dR0eXxr9++V37bW61z60um1vgdwRTvlN
	 M3UMbRejCh2dIlzH1luw0TtNALBQFK5MSV+rBTZSclsTm3FEMDFc9MucC3Z72zUvQQ
	 p5KWr2DOaS6QA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 May 2024 15:03:15 +0300
Message-Id: <D1A7BZNCNPW8.281BRWPJVW0JX@kernel.org>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 2/2] KEYS: implement derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ignat Korchagin"
 <ignat@cloudflare.com>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <20240503221634.44274-3-ignat@cloudflare.com>
 <D19QW70177QG.2YC9XL0FT7VME@kernel.org>
 <D19RM0OV7YUW.1ZEI72XQUREMQ@kernel.org>
 <CALrw=nEnqBCBQKhK9ACc7tbicqkXaDD+Bjc1d90xizMvbb--oA@mail.gmail.com>
 <D1A79NQ33IGG.OYIRO9S4YWZS@kernel.org>
In-Reply-To: <D1A79NQ33IGG.OYIRO9S4YWZS@kernel.org>

On Wed May 15, 2024 at 3:00 PM EEST, Jarkko Sakkinen wrote:
> I did as much clarification as I possibly can.
>
> Also, if you look at confidential computing platforms there's exactly
> two assets that they use lock into machine:
>
> - Binary
> - CPU material
>
> Only carved into stone immutable material for key derivation.
>
> You can use mm_struct->exe_file binary if that will work out for you.
> I'm done with this version.

Pretty good case for having SGX, TDX and SNP in something else than just
Xeon's and EPYC's ;-)

But yeah within time limits I have I've used more quota for this
than I should have.

I look at +1 (if there is one).

BR, Jarkko

