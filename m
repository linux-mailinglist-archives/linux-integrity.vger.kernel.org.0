Return-Path: <linux-integrity+bounces-7531-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC96C11452
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 20:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503043B4B94
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9122D97A0;
	Mon, 27 Oct 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ62Njui"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD32DECB4;
	Mon, 27 Oct 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594683; cv=none; b=SwFqoLVdOsPVnUGT8Hk/OLcXnNOPj5B3QllxarTdYz95zctdHKNOyvQWYYnZ6by9eLwfAIGMlvkQGak+O1GOLXex1OujHI/AZ2CUiX1cohbIhO0+mrYwVFlYESPxJbAT4AC9PwSsueYII1FlaLl09gV56yzZ9/2Kw+vDcEZXU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594683; c=relaxed/simple;
	bh=Pk4X+7GFkmLsnGR/SwJNrClCir6ovgFLwHy360kWcBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd0s0KPMGUYGCqOC77IubU68oWXkPC1NBd16+kdZ8tnHanQwrTU+GqSsU5syWhlwvZ6PPWhgy1fqWG5yZj44iMcbztMtaA2fzhxRwYvJxKPPwYdPDHqnX/SCHkX4gYiEwu2WrHDdExjThFOQ6Tz4WkiQ+35olIn/UutOlf0xjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ62Njui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF68BC4CEF1;
	Mon, 27 Oct 2025 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761594683;
	bh=Pk4X+7GFkmLsnGR/SwJNrClCir6ovgFLwHy360kWcBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQ62Njuijfkcq9Yzi/L+qU6Gb1+aLtA7bFCHwa2oGLNiBe73pwQ9dd6k0LcgJmUeT
	 jvfTU93ykAt+iwV0YmENlCqN3dxzc18OR5d1jz+RGjI9zag6jVPbkHKaP+BDZSxcmy
	 Ih5yTXi44Gp0yGhrAv3s1ckPc5EkONGBmJMTqBANJ/tdjcN0Q5wEd9By4z/b3SFv3S
	 yszA2vYDGPQZSDsk7LTJwll3MCtr6fWm1ba5QXgcD1MewYRCyFpmCs6HeZ7DDxD/Pq
	 M1bFn+eBM/2WKzmHSgTdMD6aNTlWQQF1vYRdt/Xzi2A3PEnwNyDQmQGLQZ0eSrBHFi
	 +E2UDAHJB7b2g==
Date: Mon, 27 Oct 2025 21:51:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
Message-ID: <aP_NN3HwO4Hp0-9T@kernel.org>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>

On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM may write
> the current time epoch to its NV storage every 4 seconds if there are
> commands sent to it. The 60 seconds periodic update of the entropy pool
> that the hwrng kthread does triggers this, causing about 4 writes per
> requests. Makes 2 millions per year for a 24/7 device, and that is a lot
> for its backing NV storage.
> 
> It is therefore better to make the user intentionally enable this,
> providing a chance to read the warning.
> 
> [1] https://github.com/Microsoft/ms-tpm-20-ref
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Looking at DRBG_* from [1] I don't see anything you describe. If OPTEE
writes NVRAM,  then the implementation is broken.

Also AFAIK, it is pre-seeded per power cycle. There's nothing that even
distantly relates on using NVRAM.

[1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-4-Supporting-Routines-Code.pdf

BR, Jarkko

