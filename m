Return-Path: <linux-integrity+bounces-6894-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCC7B32C95
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 01:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B48A012F9
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Aug 2025 23:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294A20B7F9;
	Sat, 23 Aug 2025 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/ODA8Yw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5E1552FD;
	Sat, 23 Aug 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755993033; cv=none; b=SRvMDTsptu0S3kVAdnE6cjEw5HSIW440DHSfpzsktrqR+0ec5gANYFRX6IRIzs3zpLvGuKSJLVLh6iILwvdiGLlC6cTHh7+TtP1o3nb0sXVmTyayhszRZ66ucd0aXbHwu6+vEOQaSuX3r2QhXuk3oJNNFdFi4frbNtGszQbgJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755993033; c=relaxed/simple;
	bh=LXwN3KeZCFiHlaQDR7yrqG11zW6dHkNGHO79myETYd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db/2cQu0a6fYXJofjYaw88Q2YdhHXriN+VdQpVLwEPYQe5wqr7zuTHfEsg2M5IO+Q8j9d9q9y84QglrwsetORY8GUEn+MUGo71PIuhcP4e8FxZoLAc0QjI6xIL46Ev/+Qw8iKP8jYy9OQofXGr2oc6htcjXrH3g6/nalQDtS+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/ODA8Yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58604C4CEE7;
	Sat, 23 Aug 2025 23:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755993032;
	bh=LXwN3KeZCFiHlaQDR7yrqG11zW6dHkNGHO79myETYd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/ODA8YwjD0oVge3fxiTksMwt2/AuKKJGZt3bayzxXbQ7NxXKtW7TBUWrwlEv0ARV
	 nWuebBWtQ7l71gwckk3RyzALXAh6q4r9kVz9wh+jHrVLF12CEn8hhREQErEaEv8t2F
	 /e9bAUoVFD4tarAemsu0sI/3lFsW5Awm9Hm3ceX1thZMfxg1J/EaTVF+xHXxgDo0z/
	 VKguTrRGjxU26IqQGcHjHj4FEcOAkR5s7Q+I39FrkoHpcvj8JXEneZgrqjTB/NVh9R
	 vyO62qr9PxEL/c6+/pVEGd7j0ixFntpZvR6j872yGEsU6dKXd5KihNCfV2Mf63iOsZ
	 km2XscGix6e2Q==
Date: Sun, 24 Aug 2025 02:50:29 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKpTxSIBjLhW4eTL@kernel.org>
References: <aKmyg0auI8jHuAmZ@kernel.org>
 <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>
 <aKpRjgkhz5C9YM-o@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKpRjgkhz5C9YM-o@kernel.org>

On Sun, Aug 24, 2025 at 02:41:06AM +0300, Jarkko Sakkinen wrote:
> doing "hybrid solutions". I'm only starting to learn of the 
> possible integration options. I.e. not even debating of anything,
> only learning.

I.e. I don't know what I'm doing, thus asking random questions :-)

I do know however that my implementation is somewhat solid piece of code
and with high odds best available implementation of TPM2 protocol
marshalling and unmarshalling, at least as per core architecture (needs
obviously still maturization, I wrote it all in three weeks).

It's also complex enough problem (as people have done somewhat unsuccessful
attempts for past decaede) that we don't want to solve it twice (i.e.
for TPM-RS and kernel). It's fully isolated from the context.

I've also talked with some companies and people working on e.g. keystores,
and they've fully grabbed the idea how something like this can be used
as interop layer (i.e. a keystore acting TPM2), which further supports
an import model for this code (while it can be installed through cargo
too).

It coverages TCG version 184 specs and my idea is that with a new vger
list future spec updates could be managed in controlled fashion, and
we can build a process for imports.

BR, Jarkko

