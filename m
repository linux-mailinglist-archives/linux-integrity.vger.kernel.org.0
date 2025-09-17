Return-Path: <linux-integrity+bounces-7145-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B98B81231
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 19:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD1D7AA2B6
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FAA2FCBF4;
	Wed, 17 Sep 2025 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfNw0Eex"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB72F99A6;
	Wed, 17 Sep 2025 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129159; cv=none; b=lYUDOxbFXnxeioBIuIFvO6+44QzWbBX6K2cG4Hxn8nLmZwiy3RMmZ7adM3VpK/MgcspI8u4DdMG+ZlWwMXcfRA2F9VGGttdje0Ot4uAbaca9wIOXdoD0WLQO1L8r/EXK1cAJ4+PJOUExiebc1rKVlPM3rCGrND8gCBcvtbHGWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129159; c=relaxed/simple;
	bh=cjwB8xCDt/x0cjPMrecLsB4GTBSMS9dIXIQbUTwpVzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5c4kDZ6ha12TuX8K0pklfpRwgoJTP0b1yrRxdD22gldKYQT2hIWtOEb+vcI3kFdYFFrVwH7vxzd/8YGas81jAjNKLkI5caSvN/mWU+mh/uQ9j5SB5MVEOIXfCN+5f7Ic/Q1nmBUUON9lTYI+aN70PL0TwcoLZJwfeVmEuVpnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfNw0Eex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5461AC4CEE7;
	Wed, 17 Sep 2025 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758129157;
	bh=cjwB8xCDt/x0cjPMrecLsB4GTBSMS9dIXIQbUTwpVzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YfNw0EexKdDPmklIXZEzvlC/X7BhePBqzIxVGYlllmZyjulcFzli7HJNEj5zbBWo4
	 q9mnMO45HDDh3k+cQ/mVD8Q+uv5pRc0bR6kddgHHfg6hc66+rkUZEj9KBLx8d8z98m
	 ASh+Yv4uli8l970RoiQwpye2/6AXJbVtYDlsZHz7nd1wNLR7774NEmq9I8Jy7g36ru
	 51byqfp5DvLlsMWni7AneCPRHzdwigRzxCk71sxdqPZ6Nvf21pa1ba2ly3906sIQa1
	 SUVr+ZalK39KP7X4sChhjE9kWinj/f1CtzsE1TEWhXEQc4mjOVBvjmV2TtFMWyQhUY
	 GOwd1ZIfiXVoA==
Date: Wed, 17 Sep 2025 10:12:32 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, herbert@gondor.apana.org.au,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, davem@davemloft.net,
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [GIT PULL] Immutable branch between MFD, Char and Crypto due for
 the v6.18 merge window
Message-ID: <20250917171232.GA1457869@ax162>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250902124205.GL2163762@google.com>
 <20250912213256.GA3062565@ax162>
 <20250916075835.GB1637058@google.com>
 <20250916191658.GA1249009@ax162>
 <20250917093823.GG3893363@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917093823.GG3893363@google.com>

On Wed, Sep 17, 2025 at 10:38:23AM +0100, Lee Jones wrote:
> Ah, gotcha.  I thought you were saying that 07d8004d6fb9 ("tpm: add
> bufsiz parameter in the .send callback") was applied somewhere else.  In
> which case, I need to figure out why my build testing didn't catch it.

Maybe because this driver ultimately depends on CONFIG_LOONGARCH (i.e.,
no COMPILE_TEST)? I would argue most people don't do LoongArch builds.

> I'd be happy with a formal patch from you or I can create the patch and
> add your {Reported,Suggested}-by.  How would you like to proceed?

I sent a formal patch to make life a little easier for you :)

https://lore.kernel.org/20250917-tpm-loongson-add-bufsiz-v1-1-972a75c0aab2@kernel.org/

Cheers,
Nathan

