Return-Path: <linux-integrity+bounces-6892-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6C2B32C84
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 01:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B057C1BA46DF
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Aug 2025 23:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3049241C89;
	Sat, 23 Aug 2025 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APGOPSgG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D1134CB;
	Sat, 23 Aug 2025 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755990729; cv=none; b=OIVpO/MUGjsNeIvZpUtHLll9IDKkCUrdLIDvTN3l9UrprI12UqoPDuOAuSir4454/M8CwU8L4107B5tiZEPSxq5a298XrXbcCVmO0ELS4HhUUDWnUUas5MexVdn49lGP4tjg1dcjdUmVcyTeEhkLBwZVeY2TUWAcDZnQgCm5NdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755990729; c=relaxed/simple;
	bh=wdLkxf1Rwv2Emepju/OygGVnKZe5gCqSLLa0yfd9Ta8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W36q/3CG3ZjhjAkbtZHLK5FYShcrIvrFyF0Anmp9G3gMLjWfYtaMovSc8T9gV18SySaWkX0YNYvBZTQnqlFzY4lqrBhRH5Ehdb4ylNRFgbGgzmKEmphJEr7dqq8kS1LzcrJEd3l5GQ24tImWP4ROgkVOTnFQeHchG3nSPYbNk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APGOPSgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF498C4CEE7;
	Sat, 23 Aug 2025 23:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755990729;
	bh=wdLkxf1Rwv2Emepju/OygGVnKZe5gCqSLLa0yfd9Ta8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APGOPSgG2E+Rmoh1ZA74PnV72a+lCpYcm2wD2yc3A0uKB6rzW4IK0uP7AdMXnMvCc
	 wZG+T/qbZFy8TUB5zQoLUAaEovl4YdJsIhKSkyx9qJvBzEtP4o6uHvg4q59yG2SncU
	 h4fhFfAjQJfQvrhJ03zU6YhmQqOGacijbl43JkTapip9At3TOhsYNEcUzTw9DCbg9i
	 AVu7kypNh2YGBL5awxwlK2e20ejxOvWsFSSGuj6cpWqASAt1snvJHnBcBdF1tyjuT/
	 MxrwcN+YLrGaEE8kSEmX18S87KmPhjGy/4Rejkb7jYdCdlPFMcacvEul4tVbWIJtAF
	 1bkovYtD9prmA==
Date: Sun, 24 Aug 2025 02:12:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKpKxaJyZsSMfy_o@kernel.org>
References: <aKmyg0auI8jHuAmZ@kernel.org>
 <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>
 <aKpJbIEZss_l-8wb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKpJbIEZss_l-8wb@kernel.org>

On Sun, Aug 24, 2025 at 02:06:24AM +0300, Jarkko Sakkinen wrote:
> Hi,
> 
> Would it be possible to response in plain text?

Is highlighted at lore [1]:

"[not found]   <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>"

Also it is quite cluttered to read your response in mutt, as you can
probably see from my earlier response :-)

Not disregarding the response but it is right now quite convoluted.

See [2] for more information.

[1] https://lore.kernel.org/rust-for-linux/aKpJbIEZss_l-8wb@kernel.org/T/#t
[2] https://www.kernel.org/doc/html/latest/process/email-clients.html

BR, Jarkko

