Return-Path: <linux-integrity+bounces-7533-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEDCC1151C
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 21:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411D1563480
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 20:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA832862C;
	Mon, 27 Oct 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uckktL7X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB9320A2E;
	Mon, 27 Oct 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595581; cv=none; b=fF3GmoUXBSFMHN3f9JwUhz6JVxpgSROwSmSfdjdj0IVXQdM6NTBcYc9fyZ5NuNt4+s11goN1/73wiMMUwSWFuzHz3ItJUeHDJqFJqqqv5rb6z9/PSDO5Jepsmn/UwjUpLoKRuAKQZAqBhG7pBQtgAmOpmcuDjBDbiEm20NZqaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595581; c=relaxed/simple;
	bh=AS4A3yG1EZYgF0DFdyBvb2iJ2YPcmntcwsJpf1BrUNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9tmrhq5yzWhXvTjDDVTyORp6NagLod2CVQoGJXGrBI/wErK4yY9slxKWnR/AOUUjo/p6oCUnS573md53uHIoo04NDXgJSeD88yTlQuNesqJ2BTyyFtVb+R6yVD6lxU2Q/IrApSeSnSGa6fwDC9CioJ7xaf//BuhFLYNPIV54MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uckktL7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FB3C116D0;
	Mon, 27 Oct 2025 20:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595581;
	bh=AS4A3yG1EZYgF0DFdyBvb2iJ2YPcmntcwsJpf1BrUNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uckktL7XWrBV/ryxMshYnEJ3OR2qI/s7XAAirbxpoxlQunFgMHRcEA3+5rRgh0C7o
	 AGY4oH7dKrsMJH3lnr/SzbRj79gg8ugKeB2s1tfNH/ue2Il0fI7LYN+KVJ8qKMUYL3
	 NFvRZ4cVSM55Eo4sJ9PuLOoinqsFLFEjWogVQFHcz/D1nvNZOvEqsTV6NjB4NFT/gk
	 WH/Uy/VXnqwNDfVdRZBiTWvdJ8ZHE9bMNJ3YzVugf33tVTDlRM3hqsY9ScLcBP/of5
	 WitCWCNFmH8q8Lt4MNE0PNgMUpTzuVipcJjn2x3sdbKSB6SzchL3963WLPtrjjt2kh
	 lHYjcmZie+ZKw==
Date: Mon, 27 Oct 2025 22:06:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, Prachotan.Bathi@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_crb: Add idle support for the Arm FF-A start
 method
Message-ID: <aP_QuU3QMAYl4yoG@kernel.org>
References: <20251024174200.1974090-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024174200.1974090-1-stuart.yoder@arm.com>

On Fri, Oct 24, 2025 at 12:42:00PM -0500, Stuart Yoder wrote:
> According to the CRB over FF-A specification [1], a TPM that implements
> the ABI must comply with the TCG PTP specification. This requires support
> for the Idle and Ready states.
> 
> This patch implements CRB control area requests for goIdle and
> cmdReady on FF-A based TPMs.
> 
> The FF-A message used to notify the TPM of CRB updates includes a
> locality parameter, which provides a hint to the TPM about which
> locality modified the CRB.  This patch adds a locality parameter
> to __crb_go_idle() and __crb_cmd_ready() to support this.
> 
> [1] https://developer.arm.com/documentation/den0138/latest/
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>

A version of this went already to rc2.

BR, Jarkko

