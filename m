Return-Path: <linux-integrity+bounces-5239-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB91A5D5DB
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 07:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8461189183D
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 06:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C510C19CCFA;
	Wed, 12 Mar 2025 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6nauwB5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931582F43;
	Wed, 12 Mar 2025 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759504; cv=none; b=XAwe8eoYyHQcWpj7MS0oFxkr6xzGCSFMJTPisQ51oPwaqlsMkFWnPUX6hciIad/kB3+lNoiO/7gKkiMFe9MHeUWEq+AVFuU3SAvs++rK/rRWcE+23flVvb+X3Ooe76jRvyphCk/g9q5wdETT5M2y7lmhN6k4v7xwOw5ziTuwLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759504; c=relaxed/simple;
	bh=tTPJy5dbtZoiQ5S+mA09sM3UbyaOYXFq6tULwTF/oms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG3Pyu/Fi3uFM3y2I4rC/GPfAl4sCqHpa2jbn9L1h5AH7LT2hrv1e8wMI1oSHe2ZdfW9uymQHc1ol3ZGNX7l0zl4HLx05PeVCg8RCgj38hk93HW6xcw+fKFsL2jdd4c+qRFxSwCEgu5rDr+8xWz/WfZh228zDSiMVMfaI0/z7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6nauwB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FF3C4CEEB;
	Wed, 12 Mar 2025 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741759504;
	bh=tTPJy5dbtZoiQ5S+mA09sM3UbyaOYXFq6tULwTF/oms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6nauwB5Yh9QHZb0W+YCfce97rMcWUiBa9TdK1Z4jW1gK64sNnIdd4BGxql1UuXvT
	 LhOnof7SZisXcApApmBmdHf4/9R0Mz4jXeThOp81Ovfm6f5cKQBMKOBVx0VYUhmgFw
	 kfl3XKuVx5oBSM8mWKIEh8UcO9usW8jNsPVVywu7fbFD38PqrM09JqJoJMz2BZYVcr
	 bH9q6st8AzDxfbT3IzP0uiHdOp0oW3/RMQZuM/73tC5UPi1S/BK2zq9LFavCUtgkeT
	 ztyJIJLSnBOIApCSfZzxIAk6gh9h1dnNbeQc63r/RSkHzXbehq1tbWA+DvVNwbHkFK
	 hB8sg2bKT08BQ==
Date: Wed, 12 Mar 2025 08:05:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Stuart Yoder <stuart.yoder@arm.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, lenb@kernel.org, rafael@kernel.org,
	jgg@ziepe.ca, peterhuewe@gmx.de, sudeep.holla@arm.com,
	linux-integrity@vger.kernel.org,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: Build error on -next due to tpm_crb.c changes?
Message-ID: <Z9EkDKi8XrwD-i_0@kernel.org>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
 <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>
 <92bc0a65-608f-4307-bb1c-16d8836d42e5@arm.com>
 <77fb9077-f598-4308-8862-6d09b23688bb@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77fb9077-f598-4308-8862-6d09b23688bb@leemhuis.info>

On Tue, Mar 11, 2025 at 05:51:17PM +0100, Thorsten Leemhuis wrote:
> On 11.03.25 16:53, Stuart Yoder wrote:
> > On 3/11/25 10:21 AM, Thorsten Leemhuis wrote:
> >> On 05.03.25 18:36, Stuart Yoder wrote:
> > [...]
> > So, it should not be possible on one had have
> > CONFIG_TCG_ARM_CRB_FFA being true when building tpm_crb.c
> > and false resulting in the tpm_crb_ffa.o not being
> > picked up in the build.
> 
> Many thx for the answer. Maybe Fedora's way to prepare the .config files
> (which my package builds use to be close to Fedora's official packages)
> is doing something odd/wrong. Will take a closer look and report back.

I don't have bandwidth for analysing the kconfig issue (except pointing
out those obvious issues that I spotted).

> Ciao, Thorsten

BR, Jarkko

