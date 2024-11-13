Return-Path: <linux-integrity+bounces-4109-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28B9C7B94
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 19:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BEE1F21D7F
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2139F204095;
	Wed, 13 Nov 2024 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghOcCk2u"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADC1E0B7C
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523751; cv=none; b=nmrqFeUyW5zU9Fk5a2uZA4m5A6m68UqpW4kA/Zdz+83w9tMkneDY4NlHrp8Zw/NR/HgOQ9Q9KREOK4QqKdyaTaH24swPOj8GjHfGb0M+dCzS5afSV0IxFZVCbj7Oe2StwNFcKjA000cNU57ifHbRTi6VPD61GZX9zBfGoA/fM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523751; c=relaxed/simple;
	bh=8QocpOPFV62/ifKqG1CF1w48IIeaek4YobAmrUtYhNE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=PHCqnBtjrtAeVsBC1CiyJJL06GuFJgd1oqGg36yMM0tkiVOyvlwd72j3nTR4oxMar+tSqnco6qyYN2ZlXFvMayJTENZQ1jR9nRDw0TU4wAATsX9RJwLj0jKymwUEi+MB9BL+CUdpDG3/Bk65RzRqJvRmXaUgj823OxqLmpjFZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghOcCk2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F06C4CEC3;
	Wed, 13 Nov 2024 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731523750;
	bh=8QocpOPFV62/ifKqG1CF1w48IIeaek4YobAmrUtYhNE=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=ghOcCk2ukqK1I2ZfLKBw2jk19vZTYGibbPZDC19HVOpS5fJ2HBfAhrR4tfO5hD+Sl
	 eNF+qy1HdRSr3Pu8INCs3KcYNVsoCG4CuEBlcX1UHnP8t9rSXi1kW8YJErN/3tqmT+
	 MBI4MsgRdZXYaz6RAWMdVPqQigGJKikPGkE+JGeefYddhcS5MJl2iFlrU7EahW+n+8
	 1ZxIwdGOq3X5OlqQa39U5ucryUFRLLNxktfSxd4MpnbGcUHhgiQNPRlqlsqV+V5nNt
	 xDSI7ILM5UYYc8HqvZpp3L7d1TrTgiXLkUNxVQWyau+oGP14VQsX1CRNk/a1dIAVpK
	 XxxICjGan12mA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Nov 2024 20:49:06 +0200
Message-Id: <D5L9XVNXYQR1.2EBNEZRV0QVUI@kernel.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
In-Reply-To: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>

On Wed Nov 13, 2024 at 4:44 PM EET, Christoph Anton Mitterer wrote:
> Hey.
>
> Forwarding myself from:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1087331
>
> Since 6.11.7 (might have also happened with .6, which I've skipped, but
> wasn't the case at least in 6.11.5).
>
> I get:
> Nov 11 17:50:20 heisenberg kernel: tpm tpm0: A TPM error (2306) occurred =
attempting to create NULL primary

Yep, I found the reason. My fix causes this. I sent a fix.

The problem still persists related to TPM bus encryption not working
with hibernate in 6.11.5 but the message was shown only once in the
log (and thus you did not notice it).

That can be worked around e.g. with kernel command-line flag that
would disable TPM bus encryption but it is out-of-scope as far as
I'm concerned.

Please test my fix and I can take it to PR.

BR, Jarkko

