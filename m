Return-Path: <linux-integrity+bounces-6553-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08904AEA555
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 20:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB84916C8CF
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D942ED166;
	Thu, 26 Jun 2025 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU+X3+6F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9E2ED14B;
	Thu, 26 Jun 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962312; cv=none; b=Dt21mNOYau7Qp+E+/fVYY0OmsWjU0nJhZA0DC8RhzdzkJ7ONoDD1+rRGKCdxpsQbPLWGvlDIboM1vS56y08PvB3JuFs/jSynS9+gii9+Ut1FFEYwvF3n44+DDq0lHJpuvaEY5gM3AXkLGc8o4ulmHl1bo2fZPE8Wy0zE+nvPA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962312; c=relaxed/simple;
	bh=Pnn9NA6mkXrRF9hQBs3X8XnGQwuVPw0s4N02XxLYa+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tex48HLdnjQlANgB2TO5vrVwjbv8EfjuE2+ifPkLumPWVpGD9YzzhK56WWjA50AG1U9UKdsynqA46e2AByKrCKdTcYAKlwuzFoCVVoosoWXY4VuznWKSrPhvfdD2F1BomVg4MsDeDKG++jV59KSMq6wgj/uiZTlQ4nlaiEaEKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU+X3+6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4338AC4CEEB;
	Thu, 26 Jun 2025 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962311;
	bh=Pnn9NA6mkXrRF9hQBs3X8XnGQwuVPw0s4N02XxLYa+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QU+X3+6FKTQq15l5UXmL13/IEnbERmM6bzgXI6R5qtgatD9Tn1uU7eQu8vBc1yrWQ
	 /KMuVj9/9URdy58lQkyEwzel7SHp8Pmfba5kqZhAem3/ToTMPr9KVjHtNj/sCU+Fh2
	 bd91Fe4Qe9W3V67BXcCwGJNAYWmwqDB7G8KIacfHL3cP5kYARzRqMtq4jWVZE6BHv/
	 DdI62XkT3HNr/PY2yYkC7DCcN/nMswRswlZHLrz0l1y9rGCnFHnfCkh+K99PXrHn4R
	 /eMsbAqsvuDLifKgxBweGAzlXuyWSvW4A9CAD5OiAnO9CCv2telAxsXnxqe7WGG7Mb
	 jpXbtmXs5v1Vg==
Date: Thu, 26 Jun 2025 21:25:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sudeep Holla <sudeep.holla@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm_crb_ffa: Remove unused export
Message-ID: <aF2Qgx4Y0T583H3E@kernel.org>
References: <20250626105423.1043485-1-jarkko@kernel.org>
 <aF0pcV9TNsiOYXVM@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0pcV9TNsiOYXVM@e129823.arm.com>

On Thu, Jun 26, 2025 at 12:05:21PM +0100, Yeoreum Yun wrote:
> [...]
> 
> Look good to me. Feel free to add:
> 
> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> Thanks!
> 
> --
> Sincerely,
> Yeoreum Yun

Thanks!

BR, Jarkko

