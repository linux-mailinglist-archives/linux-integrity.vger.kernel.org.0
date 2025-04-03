Return-Path: <linux-integrity+bounces-5583-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D1A7A9AB
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 20:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237A9175705
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6900A19ABDE;
	Thu,  3 Apr 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoVO9pIi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F533DB;
	Thu,  3 Apr 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705927; cv=none; b=rsrNVpCzXO80glrW8RLC46rJMiaTTfqDRyPivk0Gz/lxq7OjOja2+eQBv+pHesYiCMkJnfFQSYU1eWv6JMVyn3VvJQi1PRTaFmajwrhKoajA/IFQsqxXOEFjUD8nF77bx9mIL4Yq4Rinrd1a94AJsXpkCewNWvbfdquONHdicZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705927; c=relaxed/simple;
	bh=9dNL4pCAgs9jbTVHrEb3W0UBUnJOcvasmy+RkmrFufw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htIdgYa0l8qphVbaTMYd3p7qpWZrzJCT3qfqtrS7pCqnQAzPr+hoRk01VSpQzXTKXqn8SZ4HMJ4G5l/qK4EdqB7Xlqa4dLqdRwhtgo3tojFV588+ECCYn45g10kGzunuLxGV2Y4UOuhsU1A8PbTS1yjknUgenMQzWMnAqTA/elA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoVO9pIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127B0C4CEE3;
	Thu,  3 Apr 2025 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743705926;
	bh=9dNL4pCAgs9jbTVHrEb3W0UBUnJOcvasmy+RkmrFufw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EoVO9pIiR9TUooL4uFUE02EkUiUdq607X5Aa6FNRZCnS145l/SrDPOU/U5QSsCvQB
	 xyzb8MyRxlF27aBcsgN8Htgu+hbNIMBW5blkh7z8IRaH051cdOa/SHF5xGzJ7xdYOv
	 v2bTGFJShBsgODHXvBlW66eB4QoNd7iMIDNVJ8/o1SBRnw0Y+D6Q0YH63SG1uzfDHB
	 6LMUY0t4GNsbv2d94BGLCCLFZHAINBeaJnJBEDtzWawp1RXOxNbRDVbMXtk3dZ7JmC
	 UUaX7fsvNc4F5+2UtALuZVp9+J6XKpzZlUY42Wdx2NMuZ5i0bLhceY9lUKUz/o3bIZ
	 bn4DzaSh1x8Rg==
Date: Thu, 3 Apr 2025 21:45:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Michal Suchanek <msuchanek@suse.de>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-7XQYP7_tXYR2Ik@kernel.org>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-13xOebA3LvQQ-8@earth.li>

On Wed, Apr 02, 2025 at 06:45:40PM +0100, Jonathan McDowell wrote:
> On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
> > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > C) can reach up to about 2250 ms.
> > 
> > Extend the timeout duration to accommodate this.
> 
> The problem here is the bump of timeout_c is going to interact poorly with
> the Infineon errata workaround, as now we'll wait 4s instead of 200ms to
> detect the stuck status change.
> 
> (Also shouldn't timeout_c already end up as 750ms, as it's
> max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C), and TIS_SHORT_TIMEOUT is 750 vs 200
> for TPM2_TIMEOUT_C? That doesn't seem to be borne out by your logs, nor my
> results.)

Just noticed that the commit did not end up having fixes etc. tags:

https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=de9e33df7762abbfc2a1568291f2c3a3154c6a9d

Should we forward to stable?

BR, Jarkko

