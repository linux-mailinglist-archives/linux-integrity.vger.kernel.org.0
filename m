Return-Path: <linux-integrity+bounces-6864-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFBFB28555
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 19:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BB71CE7D0F
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB6F31771F;
	Fri, 15 Aug 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyHh6HdA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181B3176F0;
	Fri, 15 Aug 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279948; cv=none; b=K5SjmsXvKDd+EnMlzJ5YJyccPsYal2uzVKNzhXPVbopLT/irOgB22T2uL40cgidjBalioCK1DrmYGdb+P1BIyI9YKVHhUuA5Xi1aE9ri6x3AOuOkzCCYS1mc0bgVjdUts4xBs/6OCbkD07f83p1AQ7LTZG0fhnrb5WD95v9P9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279948; c=relaxed/simple;
	bh=RFd0Pxe6serwGZVd/58Lm2Mj1V6BHx7Q2HMp1dP5e5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlN6OcNNfVxMDS69pkmxBgBt+4UuVKgxAA9RfbXQqQ7xx/rX+fhJ2lSOEk0XP2tdUap7RGzPizh5wcBUsaMRMIY/cilSexgr4/nw7z5UyZT1+M2pP3Y86a7s8ioIcYqBQNPtn+imldCb8DWmy5hQ6B+NpPBh62sSSSbJhqdgj8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyHh6HdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC16C4CEEB;
	Fri, 15 Aug 2025 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755279948;
	bh=RFd0Pxe6serwGZVd/58Lm2Mj1V6BHx7Q2HMp1dP5e5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyHh6HdAFWr4CR1jmYCyz1aGmnVgOG76Q9dmz2iFigrwNo/vD80nb/zGdFr4scefh
	 C8FoASKKLKfOC5JJ6f1l1evLyNhnGBFel9wFM1aUD2U+m28CmojT6liVdbeAuU9Z+1
	 LZMC3vISHXCNktG5Cl0LgRm3ra89CMhudRcPkOPqoC2TsVqpt8sRuKzHPPqAU48J2D
	 qeePlCNPXbQyfrc34ABMcwQMPcbMysBgCTl6W0oIZC3la0xDk0xJAVRTHiKwbC+Iw4
	 +EgnM2cRe5jig7AdORFxfjuD+YZtxLOsx/+5HNGlZZJalW6EEhn9jZ/IldF6u3Rlk5
	 HYiQw4W/ug7Ag==
Date: Fri, 15 Aug 2025 20:45:44 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chris Fenner <cfenn@google.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
Message-ID: <aJ9ySGv0JZ0DiNgf@kernel.org>
References: <20250814162252.3504279-1-cfenn@google.com>
 <aJ8iNLwlf4PAC0h1@kernel.org>
 <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com>
 <aJ9fy_sO6tza9qLF@iki.fi>
 <CAMigqh2=Kmnv_rrT-gBtESSXtnMrxU=VJdrYE6_9NGhKBN+ZrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMigqh2=Kmnv_rrT-gBtESSXtnMrxU=VJdrYE6_9NGhKBN+ZrA@mail.gmail.com>

On Fri, Aug 15, 2025 at 10:06:36AM -0700, Chris Fenner wrote:
> On Fri, Aug 15, 2025 at 9:27 AM Jarkko Sakkinen <jarkko.sakkinen@iki.fi> wrote:
> 
> > I'll with shoot another proposal. Let's delete null primary creation
> > code and add a parameter 'tpm.integrity_handle', which will refers to
> > persistent primary handle:
> 
> I'm not yet sure I understand which handle you mean, or what you're
> proposing to do with it. Could you elaborate?

Primary key persistent handle.

In tpm2_start_auth_session() there's

	/* salt key handle */
	tpm_buf_append_u32(&buf, null_key);

Which would become

	/* salt key handle */
	tpm_buf_append_u32(&buf, integrity_handle);

And in beginning of exported functions from tpm2-sessions.c:

	if (!integrity_handle)
		return 0;

And delete from same file:

	1. tpm2_create_*()
	2. tpm2_load_null()

That way the feature makes sense and does not disturb the user who don't
want it as PCRs and random numbers will be integrity proteced agains an
unambiguous key that can be certified.

> 
> Thanks
> Chris

BR, Jarkko

