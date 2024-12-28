Return-Path: <linux-integrity+bounces-4491-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6916C9FD9F8
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Dec 2024 11:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B71883AD2
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Dec 2024 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9D3126BF9;
	Sat, 28 Dec 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNrH/N/E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270F3594B;
	Sat, 28 Dec 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735381943; cv=none; b=nIxLSy8H9xsqoaYQKVJb1RGGNAnEel3MDcHj0UUBxEyXLjzf4Xb8TjlOKK+e14JRyqF1/M37PSzBekvJ97O8SHsj0MfcrxGw94HWolHaV8CtR81+WCgDuaVEDX4xMi27RGqalbmJ5l290z3exFPQ2BCLUHluZLv+c6u2f9g20pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735381943; c=relaxed/simple;
	bh=mm1sWeKZAyb0MvYGxuGF7X+sCDeRiAFP9LGLsggmROQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzhzIVFA1mVcLEf5JMYIqFXwZe/Lz9gz2X62ePp5Ds/KtEgnGNnNHOREdLwimQheHflOdMwi/1RhCbarFsiclcPexYsIOR29b/XfRxUulKsEwW36T0chC6AkWBi4/OZaTbPSGx6RMwdzkITK1S5LOlAZJU41U+fwNjVawmB0g94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNrH/N/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F6BC4CECD;
	Sat, 28 Dec 2024 10:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735381942;
	bh=mm1sWeKZAyb0MvYGxuGF7X+sCDeRiAFP9LGLsggmROQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNrH/N/EJRl0NBoWRfEwWQSCdUyDBbeZ9X4wMK7SBQ6sVl54hi5qti5Y5d9OjOTFR
	 camE8edecPRL5cTLW0N5eg1c8yVA0LtLfy4Ra5KUxly4iKfD2a1TsZEL9XGN8wRWYS
	 Y4Eoqp74VdbR+fIZP6Fl53HGMfExBZQfg6qCIQkR5zWUR7eMWQVvTeHzHcHRPTIzLL
	 16hiWxKh5Xx2aKCzFLY2rLFL9XylmhNiyJroSXplsNdPT5PvpR4RrkKNOx6VAgcdBo
	 FJ+rMx2b7ELDm/IBfxOFmlkvPL8JuRTpDdIRneyDO6/XAhuH6YomrHq+crU1MugFbZ
	 dVQK+eIrKtj6g==
Date: Sat, 28 Dec 2024 11:32:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lukas Wunner <lukas@wunner.de>, Peter Huewe <peterhuewe@gmx.de>, 
	Rob Herring <robh@kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: tpm: Add st,st33tphf2ei2c
Message-ID: <xtksjd5roaqe2nayug52taxhjrwszksoylge7cgvenbaldvlmm@kzijt3fk4mw5>
References: <20241226171124.83735-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241226171124.83735-1-marex@denx.de>

On Thu, Dec 26, 2024 at 06:10:52PM +0100, Marek Vasut wrote:
> Add the ST chip st33tphf2ei2c to the supported compatible strings of the
> TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
> Profile specification.
> 
> For reference, a databrief is available at:
> https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


