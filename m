Return-Path: <linux-integrity+bounces-6378-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD4DAD0707
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jun 2025 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28431178284
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jun 2025 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF84289E35;
	Fri,  6 Jun 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqZiNuPL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3562289E2E;
	Fri,  6 Jun 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228829; cv=none; b=B35OUCpNotuEFPqncWolLeP/5KFY/gmhzIMhdQDLtM0ipF+yZ1sUY/dvTBqaBQdAePfenxRX0EyKPew/J7Vwm6WVZ67Znul4p5N38WBHAkrlJD93lst9JXVdmP09i7mwCID1cntW+MVQlrIUK7245xWte0TJ/CgXJx6QG/AU1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228829; c=relaxed/simple;
	bh=THcPoC12IS1aNiP83TwV4A0pYFP1HxQtv158X0rPetw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er/HxwhSNYG2azKMuU56MyJPT31EefX8Ax5BiEVO55kuBUlvd1mdk8EDU2aaiBtBuOH8x2TrufzkxQkqSu49MvDnq/Df1Nyv9TuhksLM9qbe0WxL4MsaSkIdL7GGNpZVncyLiAbPSlzJEgtwtCloINMKvKmH1o8mBH5TEwVnz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqZiNuPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3404C4CEEB;
	Fri,  6 Jun 2025 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749228829;
	bh=THcPoC12IS1aNiP83TwV4A0pYFP1HxQtv158X0rPetw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqZiNuPL2J1wV7m7uAqxjXFSAFfsrDOzIPFasQyZgFA5XXVdkxOwZqRd6Hei5VHUx
	 aDJnLxclyH4xzOUZzHn5zrY395DoP3a6oEf3GLs/TlNSPBkqge9UydXzB0BqURQ/YO
	 fk0f1vkcdj3fhB6dkSpL0ueIHnM5LiHR5eJ0NK1oQG5sOeE7d3/e3KSG/qXhFqLaGR
	 vwbDGsalBTRcGy3X0WPvAvSS8xdisSE5+BOJOE2Vs/d48Dv11U56EKKFNgyPUsWuzV
	 tWt/SjKMUG4DQVyxD70myUO9W5qxMNJ6B1I9O8252BAz2rvRJBnzTk12Hs4m6cMhSi
	 cCU04D8sETx3A==
Date: Fri, 6 Jun 2025 19:53:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: tpm_crb_ffa: maunally register tpm_crb_ffa
 driver when it's built-in
Message-ID: <aEMdGXXBSym7cXmK@kernel.org>
References: <20250606105754.1202649-1-yeoreum.yun@arm.com>
 <20250606105754.1202649-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606105754.1202649-3-yeoreum.yun@arm.com>

On Fri, Jun 06, 2025 at 11:57:54AM +0100, Yeoreum Yun wrote:
> To integrate tpm_event_log with IMA subsystem,
> tpm_crb and tpm_crb_ffa driver should be built as built-in
> (CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y).
> 
> However, this could make failure for ima_init() gets tpm chip when
> each initcall function deployed like:
> 
> 0000000000000888 l       .initcall6.init	0000000000000000 crb_acpi_driver_init
> 000000000000088c l       .initcall6.init	0000000000000000 tpm_crb_ffa_driver_init

The only failure I see is the patch 1/2 which changes init call level,
and leaves kernel Git to a broken state.

It breaks the famous "zero regressions policy".

BR, Jarkko
 

