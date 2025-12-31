Return-Path: <linux-integrity+bounces-8146-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90864CEB0D9
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Dec 2025 03:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37C933007485
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Dec 2025 02:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B962E36F1;
	Wed, 31 Dec 2025 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdGGgFZC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FE1F95C;
	Wed, 31 Dec 2025 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147953; cv=none; b=N4c0aYaSX7GDpytvLY6u5wPrCN/acuLtSsLynryLfm9KjiRZbiJ7zoE/cNJeFFSCz14PohQSv/rfdBOGLFRQxgT0CvKKQRAhGyfHzLiLYUvl4EGprDSzlIHHauvqgK2iZkZYRY/bUw8qajhtmzx1wtNW5rJgeE3Bpj4KqPZvTVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147953; c=relaxed/simple;
	bh=tHQ9S/Ivz/LfPTqBZFEnLr38RdRE/dlYpzYs3nse1z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8M7epp4wIlBRkRF4SJnehF3GN/rXYeOY/4Hi8yMogPQZQ0e7hSfRQZhudLFU6/FiVrPAYzChWq3jO0EFA0Hw9CQK/RSyXapCpQZDF8sf7+4/Wtfi/l3aXPh3omlUHsXarf9Pj2gbY4q0dnn/fsOpq2oGqc2cYrz24bTCW/L3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdGGgFZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F93C116C6;
	Wed, 31 Dec 2025 02:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767147952;
	bh=tHQ9S/Ivz/LfPTqBZFEnLr38RdRE/dlYpzYs3nse1z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdGGgFZClh2nVp6l3AT5LqKFhdRpWp8h4QNR4p2fmgnIUnunNb/++SvKBNNHBnPKl
	 Fn+yMvxjM1Tt5sYhj8/hthKJnQcF8nynRDqb43T1yUjTwlXRArALigWPV1MblX0Rjn
	 7br+oPvjsqvuE13FA3Ql+6D0lQZIDTaoaL2/4826fmdgbGfGTezNVn/2CwBfq+I9C6
	 v2/UbE0yF1YP0S6rfJXg8EZi9NwWzhHUH42NQLqQEwI3Seb+d2WDbk1Dmn0Z2LA084
	 xwwquYCjJwnfDc3LhW3yB70YjDFD/L35QlPwmSGmZxv2v7wSPkeA1C9XfVZUlRCrIC
	 dNKebNoT4loOA==
Date: Wed, 31 Dec 2025 10:25:45 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peter Huewe <peterhuewe@gmx.de>, Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: tpm: Add st,st33tphf2ei2c
Message-ID: <aVSJqQHcvettOKeZ@dragon>
References: <20251230014047.149677-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230014047.149677-1-marek.vasut@mailbox.org>

On Tue, Dec 30, 2025 at 02:40:34AM +0100, Marek Vasut wrote:
> Add the ST chip st33tphf2ei2c to the supported compatible strings of the
> TPM TIS I2C schema. The chip is compliant with the TCG PC Client TPM
> Profile specification.
> 
> For reference, a databrief is available at:
> https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

Applied both, thanks!

