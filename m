Return-Path: <linux-integrity+bounces-6962-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8954FB3FDD2
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5204D3BCF20
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F9287511;
	Tue,  2 Sep 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0B2rK78"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50F272E5E;
	Tue,  2 Sep 2025 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812756; cv=none; b=rWy+VIZ4sJMcXNYbZtJwUdxJMkZnTUY55VtyiFZuC4K/zVI8YpahDpvy5SIdCtwA91SlXUMvc3mIjChMpc1/9XU4B6dpJAqE61ESrzanfghELAqhJaDOkkZ/dsAtEDkVTasE08ZFC0H/mlC/yA20jLzhxhdwmVKoCDgHPJxHjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812756; c=relaxed/simple;
	bh=lFJCmd2jOIW6QOSPlN+K2rpPXHFTVqIJon1oVvVmMSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MS7MH3mptb04pUSrOnoCmYOvVYLZPWG6TGV2oF2TzL0XCTA9AMMxdW99OOeot4Pak6Ojor5Rwc3bzOHn5cTbLRD0K78W9XrwPDa0j24ZK4e84/loLWO1Cp4ry5slzOweTugW+Zy9cxVoy07KNbnWHMhjLnnSU4ff7VuMxag/JPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0B2rK78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11A1C4CEF5;
	Tue,  2 Sep 2025 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756812755;
	bh=lFJCmd2jOIW6QOSPlN+K2rpPXHFTVqIJon1oVvVmMSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b0B2rK78oUsVkA0OC1ubyFjU77PLAf5tRYGA8/plpZS7HfzgY7uxG4ZHu1pIOHgpx
	 i40n4Mkrutj6cQ3MdoEwtCpW+pzvVf8WhgD/pDXuBUZyYr8sXEA+DJR1D9D4ksKWQe
	 2IbzsnaOq0DfD3W3dscWyp4scwgC3b9eJzoU6NV4YkvxHF/V4+KWbH+wnChzTqFF4E
	 ttK0/hjuBkD/hiFGLu/m4/zCisTKDHIgv/JYk+ACyp4ksQ047YWrnhIfNyEZHE2miZ
	 7p322dIkiMnpyLwrARawRhPXXnU8vP5QuVFzH3q5/8Ck+8eR+LJZ1pWF+1yArenyTF
	 aUjJWHJrgKn4Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org, 
 Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 davem@davemloft.net, linux-crypto@vger.kernel.org, peterhuewe@gmx.de, 
 jgg@ziepe.ca, linux-integrity@vger.kernel.org
In-Reply-To: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
Subject: Re: [PATCH v12 0/4] Add Loongson Security Engine chip driver
Message-Id: <175681275359.2293173.7663755797512449740.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 12:32:33 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Sat, 05 Jul 2025 15:20:41 +0800, Qunqin Zhao wrote:
> The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
> accelerator engines. Each engine have its own DMA buffer provided
> by the controller. The kernel cannot directly send commands to the
> engine and must first send them to the controller, which will
> forward them to the corresponding engine. Based on these engines,
> TPM2 have been implemented in the chip, then let's treat TPM2 itself
> as an engine.
> 
> [...]

Applied, thanks!

[1/4] mfd: Add support for Loongson Security Engine chip controller
      commit: e551fa3159e3050c26ff010c3b595b45d7eb071a
[2/4] crypto: loongson - add Loongson RNG driver support
      commit: 766b2d724c8df071031412eea902b566a0049c31
[3/4] tpm: Add a driver for Loongson TPM device
      commit: 5c83b07df9c5a6e063328c5b885de79f8e8f0263
[4/4] MAINTAINERS: Add entry for Loongson Security Engine drivers
      commit: 74fddd5fbab879a7d039d9fb49af923927a64811

--
Lee Jones [李琼斯]


