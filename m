Return-Path: <linux-integrity+bounces-4924-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BBEA3D4CF
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 10:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A2C7A8ECB
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A21F03D9;
	Thu, 20 Feb 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecUmiWhB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2B1F03D2;
	Thu, 20 Feb 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043892; cv=none; b=BgA6ABv0kOHDNclIU0nYhaWS9ipq/D+//vu7MqPGAXZiRh4RYNRt6tiQj4rN+9aOvP+SBkSeWl0sd1WWidClgSDFE4S/q9yIFDZuIAGpcBxvsVBeZ9+dD632RaoQgj0SHz0s2n8ADCGO7wFL3p6NAGuWUfPm9+hHwHpyz+GWmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043892; c=relaxed/simple;
	bh=ZKDliYiJAyWPwVHYoDQwmy8GedESgFshgP23qwEziT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0nBBET9QdMhd5CfidfCKjyTY/CUFUL4nf2yWCExouB1L04WQSxw1NVloa62m7ocCtF88wSrr66qJR7+/xUrPoeluRdYTCGr6rhBp36fHoYDyfsZhU8fJQityYXXExFZ8H6R2E8jMGLApxs0pCLhHoh2ISo6P2upiX0yp3txx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecUmiWhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79D3C4CEEA;
	Thu, 20 Feb 2025 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740043892;
	bh=ZKDliYiJAyWPwVHYoDQwmy8GedESgFshgP23qwEziT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecUmiWhByCMtNKUYHn1pEAIpFi5Q1aGwvYeiCEiAZ5wR3xm0ozcu63KhMvwHeWWa4
	 2U+/PTJLI7J6NOn8JbptMfl98onLFBZeYBLcLgeI6tLTsxvfBqr2MQccIriqE41fc7
	 bkusMWs9Q3kPvR3EotlyGCvBT4WH+xo2V/yGiQwjPFwB7ywy02Ztb06Fmyx2u/Sosb
	 e03W6pz+yHSQ6QLAnonJ4kgFjoFWQ4V5K94HoYr40FeNrvJZ2N/bUaieS6OvSPaJDr
	 JwsQ9JYanR9CaAFJ7rqPWR2xvhuJUbmjImXEmKFCNSOg4EYG3W0ZsIDi82o3zONrnu
	 3wjU3p8MsUMOw==
Date: Thu, 20 Feb 2025 11:31:27 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] tpm_crb: implement driver compliant to CRB over
 FF-A
Message-ID: <Z7b2bwjzWbYE_Qjc@kernel.org>
References: <20250219201014.174344-1-stuart.yoder@arm.com>
 <20250219201014.174344-2-stuart.yoder@arm.com>
 <Z7b11Kahh7JXDq9E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7b11Kahh7JXDq9E@kernel.org>

On Thu, Feb 20, 2025 at 11:28:58AM +0200, Jarkko Sakkinen wrote:
> On Wed, Feb 19, 2025 at 02:10:10PM -0600, Stuart Yoder wrote:
> > The Arm specification TPM Service CRB over FF-A specification
> > defines the FF-A messages to interact with a CRB-based TPM
> > implemented as an FF-A secure partition.
> > 
> > Spec URL:
> > https://developer.arm.com/documentation/den0138/latest/
> > 
> > This driver is probed when a TPM Secure Partition is
> > discovered by the FF-A subsystem. It exposes APIs
> > used by the TPM CRB driver to send notifications to
> > the TPM.
> > 
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> 
> Cutting hairs now but as I cannot test this and this is 1/5:
> can this patch be run without 2/5-4/5?
> 
> The policy is that every patch should leave kernel tree to
> a state where it compiles and runs.

The root reason for this is that wrong ordered patch sets
commited to Git add difficulty to bisection in the long-term.

BR, Jarkko

