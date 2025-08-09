Return-Path: <linux-integrity+bounces-6789-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61812B1F42E
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 12:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764DF18C2741
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE02571C2;
	Sat,  9 Aug 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9opte3N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E31F2BBB;
	Sat,  9 Aug 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754735873; cv=none; b=pJWFhaSaSpqxk45aN+fvCBLChzcxCqSrsminJQP9SKG9diW8C3V++5ymxFqT9zgjRJuBpZzvcBt05Y8Ab4EM/qF2l303OFXZLpHYzZ2tOfvLaG0llS+ilcB8MouwKusakSNW9o7xCaHpuSsHEPNepmuHwCBbQ5KZt+PvnHFGyWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754735873; c=relaxed/simple;
	bh=zY+Mbp/vFQgswJcSFUKAGN3Zbairo6pF7DPIzdp5+Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHdeH0WOVsSklGFnpJgJx+pMNSrD+pLs0Bi10KkAba1BVGj+HM8b/F1Ro40k4JSUJunWtEJtCoI4pg+OrAzsfiDZNZFNDfY32S3rNgSndyiiHTfxPyD8sKT57IBNR5BCVvbB6sC1CsboYU4+ypYMmINiSzZ9vOayeVePZH6ZE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9opte3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BC9C4CEE7;
	Sat,  9 Aug 2025 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754735873;
	bh=zY+Mbp/vFQgswJcSFUKAGN3Zbairo6pF7DPIzdp5+Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9opte3NX0dXCK4XlI7v7BLZOseECSof9maiLkidaf61jHaGbMUhm0qxOUfoP0EmW
	 RqGpW7dh1ne+465Lymu6WEYGTy14mDEt79ASRs2LaHVi+e+DkMIeanenKF1o4P3ZVD
	 r/NFgb4TFTroW0OD2DYFl8NTsbQWjsO0EKSq67Y4qiWjdvhE9wS7y8vjzx5NJ2+GSJ
	 RNCutxHfgoP45AJdIAPx9h9Ul57hqw+t9i7vKaBsGBLOpmF/65OU1gh5EMUoLN74Ii
	 nD8XuYJlaPaDoDOZZJ3ktfUPiSMHu8LQceZBWZr6igs705e46VpErtcj7I6R2Fb4XZ
	 vO3AgSo1rqEdA==
Date: Sat, 9 Aug 2025 13:37:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] KEYS: trusted_tpm1: Compare HMAC values in constant
 time
Message-ID: <aJck_YVdFqZoRk--@kernel.org>
References: <20250731212354.105044-1-ebiggers@kernel.org>
 <20250731212354.105044-2-ebiggers@kernel.org>
 <aJIKu7uD-nYQERKW@kernel.org>
 <20250805173227.GD1286@sol>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805173227.GD1286@sol>

On Tue, Aug 05, 2025 at 10:32:27AM -0700, Eric Biggers wrote:
> On Tue, Aug 05, 2025 at 04:44:27PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jul 31, 2025 at 02:23:52PM -0700, Eric Biggers wrote:
> > > To prevent timing attacks, HMAC value comparison needs to be constant
> > > time.  Replace the memcmp() with the correct function, crypto_memneq().
> > > 
> > > Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > 
> > Was crypto_memneq() available at the time?
> 
> No.  The Fixes commit is still correct, though, as it's the commit that
> introduced the memcmp().  Technically it was still a bug at that time,
> even if there wasn't a helper function available yet.

Add a remark to the commit message.

> 
> - Eric

BR, Jarkko

