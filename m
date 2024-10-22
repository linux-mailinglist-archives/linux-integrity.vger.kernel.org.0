Return-Path: <linux-integrity+bounces-3893-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C39A976B
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Oct 2024 06:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB0B1C21524
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Oct 2024 04:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB3770FD;
	Tue, 22 Oct 2024 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP877oeT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7011862;
	Tue, 22 Oct 2024 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569821; cv=none; b=uLf/Yw49x55DuIX2vsEfAa20IW2tK58QifzppfL0IjsNff1PT4mjMqlF6i4lRokZvo2EeZjkWuUHGflF2wigSunCZ7ofwVxrh/4ov/GSorgCG3NH417F94EpKSWooIz5sSsZKPME3ZRacmBs6+mNx3E/09pKQBbNxearffdmQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569821; c=relaxed/simple;
	bh=RdQ7SzPxkuKuptpL/Apf1W0JG9I8LoGtTX1YA1crnY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUZlQxslYvtPEXGXVzGWh1njtAUnSy/r1FGTA+pZUu0BSe+rXAKceL2NVKnihvoRIjZLMV+YOJQmYSuPtPs1dhIRsBiPVb73hFUPhY+1tnaxMQh4HcyalhYP+8Feo0ZL+5FLCjpXvUZEE/Y1vhJz0Q6xG6icjdumZbq3ahlLlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP877oeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4F9C4CEC3;
	Tue, 22 Oct 2024 04:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729569820;
	bh=RdQ7SzPxkuKuptpL/Apf1W0JG9I8LoGtTX1YA1crnY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fP877oeTDpOxG3repd4W3K+Kev0m3rMoplYL6IQDtnAmFneYZjIa3hqOQLMyYFVqy
	 RD3fkPHFWF0z1DaSwWDxeCsXVyCfrFB/IiQjAUJlOjHaGGARYjYHkAPbXaiDEudRe+
	 Y/PRN+nN7U+1j575Zkh9YpkuXg6Z+EfkaUHCx7vRlEh0lfRVNm8UU9r58hbU+nDadf
	 R3cBD5+ge/JSErrIdrKt4r3oMJ7VpHsqUG+CdLeHslwp6KV0hqkAjLWc7Qhmi/WnGh
	 HqTSQ8cL4MxLwr1rCTLLiymWzCmUQ/VF2u/jEan9jC8w1GGIIDqU+vKWfedLNMs/6S
	 14JYybb1niyUA==
Date: Tue, 22 Oct 2024 04:03:37 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jett Rink <jettrink@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v6] tpm: Add new device/vendor ID 0x50666666
Message-ID: <ZxckGbxzpWDuXG_q@google.com>
References: <20240910191117.1001581-1-jettrink@chromium.org>
 <D43HINLZGMXS.FYJOK0SVQFQW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D43HINLZGMXS.FYJOK0SVQFQW@kernel.org>

Hi Jarkko,

On Wed, Sep 11, 2024 at 04:21:24PM +0300, Jarkko Sakkinen wrote:
> I applied this (will push later to my remote tree).

I failed to find the patch in [1].  Is it somehow overlooked?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=next

