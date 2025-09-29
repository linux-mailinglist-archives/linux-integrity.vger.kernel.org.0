Return-Path: <linux-integrity+bounces-7303-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48396BAA953
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 22:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F593B5001
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC624A067;
	Mon, 29 Sep 2025 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLk01Vaj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D523909F;
	Mon, 29 Sep 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176653; cv=none; b=g4qaGEogiPi6PmjxA7RJ1IZvy2KV1tl7paBwVa9OeGz4R+PiEagGsgnzxfyrtH4WAz5CgnlZLr/+L27PCJ4t9YBbCGT3HgetymZx5Nz11GWkX2SoCm3sdspO5pW321hsdpYtOout4j9/oU/kOtTavFuRaH4d79DysgttS0odlAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176653; c=relaxed/simple;
	bh=ntVVSRJe7xFB3ImV9tdZ7v/rIwVimpg1Y35zss1w76g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj7OEAbuGw4bkZ17FYMY3QpHe2D/MatimCw1j/83xfxh56+ogO21IB/guoLyX11ROBAqyHcEgcGoXNn0cc9o8smWZJv/zAAyacaK4AsNKYVsjkrpBdxwIjl9hJBqDrMGE+HdGDn86g+gRwxl/q+kjEV+SWnhfJcotKt/1rojEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLk01Vaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AB9C4CEF4;
	Mon, 29 Sep 2025 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759176651;
	bh=ntVVSRJe7xFB3ImV9tdZ7v/rIwVimpg1Y35zss1w76g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLk01VajFHUHQlEfH1ihiHa5zIkdJA48mp128SNYfahQVKsS9Mu+mMWvXNuSDYa9i
	 K6Ja88og/YUF8qW7XJz4SrmVJrPPwMlBM5Pdi8NXyv8jsEIuj5eReokY0BEJOko7SD
	 8Nwg+vE+LPiEcUOcI0Tbl22umxhZROWGTUYjsonwukwMU2UA9EMjnnxlfUHQjVsxFS
	 qt/265/fuDPyTLkZcYPXOed96+DEGxlmXJsTvU/4dBOnu5YVkWbKzN5rJTpDiNcaSD
	 RL97Nv6CNojkuQTWpw6OhG786MJQWJAUzRROfIK8D4bhSaqIrgETSyyHgfFPrGIru7
	 ed9Tvu2iIqBlQ==
Date: Mon, 29 Sep 2025 23:10:47 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com, ross.philipson@oracle.com,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/10]  tpm: Decouple Trenchboot dependencies
Message-ID: <aNrnxxPv6IuykrYH@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-1-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:22PM +0300, Jarkko Sakkinen wrote:
> Overview
> ========
> 
> Decouple TPM driver features relevant for Trenchboot and make tpm-buf
> robust and decoupled entity from the rest of driver. By doing this, code
> can be easily linked to the early boot code.
> 
> Backlog
> =======
> 
> Parts of tpm_tis should separated and decouple from the driver code so that
> the slices of code can be compiled into early boot code. Since by other
> means the series already has most of the gaps filled it's better to resolve
> this issue before landing the series.

I.e. goal is that redundancy is mostly in the glue not in replicated
code that we want to fix regressions at one place.

These patches address end-to-end efficient building and parsing of
PCR extends with super-relaxed mm-requirements (stack will do), and
tpm_tis is the final piece.

BR, Jarkko

