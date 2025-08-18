Return-Path: <linux-integrity+bounces-6873-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAABBB2AFA3
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Aug 2025 19:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A8818A70FD
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Aug 2025 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6E30F7E1;
	Mon, 18 Aug 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk2hD5/Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386B257AD3;
	Mon, 18 Aug 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538976; cv=none; b=RW7aObO3b0QUee6DTr9yYi/Jz39hMc0a+UxMKhMaD4wCGuqqxkrTM6tv9BxjGNtBg8oG4c1xQK1XMutkpXdfrRlPvvkvE1rM+lx9oy/fvVHIqmEGIRHZVMXcLjgDTv4+FpBybB7eED91g9mf5VEv7w3Cs+vkxqSDastaKFcXd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538976; c=relaxed/simple;
	bh=POtnzVuu7StIyvbzEGfi+cQTdego30RYNaxXqHlh65A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFaPhjknQE9gl151ULyr1LfHBQrPWUFlr+CJcGJSYqXLGClK6fPKUhWwJaR6QVJ6KBFP3844dNr2A4okvCNiw0+BJ6DCPEH+KHkZYkceoeovvSYpTjbfhdPX5PxRbqbQinZ4dWlseb9eD5ZLa0n32vRBoFZgUbQixb4ht4olwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk2hD5/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7182C4CEEB;
	Mon, 18 Aug 2025 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538976;
	bh=POtnzVuu7StIyvbzEGfi+cQTdego30RYNaxXqHlh65A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wk2hD5/YAUwyD/nQrN2mX6EvZwaZRCIc/hDgaBAWQ2hD+lN4YEG3xLNSpdJYYkLo0
	 EAIue/5hEt12jahxQZ+pjEQeDHTBY2YJARb55qc3vFMLFH529KEUajvnC5NjlVZbl2
	 8KsZFtnerTrJK2gXcfLBo37gJWkcWuvHlz/C03CXN/sLShJDpRqZatXy9/NiNIAviz
	 HXhvG2SUHgMk0neX3JBCCZfbOhwPHaxgKrDRxZ+yFv/p6GdS8GOXYaNQSPUK3w6sSd
	 jyxpy51xgnHIa06ScIgBG2DDNbeHC4ziXr08c1fKoyZ+H/J0+dXLXpxZWfnlSEJZwi
	 O6xzNRAaBfXOQ==
Date: Mon, 18 Aug 2025 20:42:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chris Fenner <cfenn@google.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
Message-ID: <aKNmHDVHV1DufJEd@kernel.org>
References: <20250814162252.3504279-1-cfenn@google.com>
 <aJ8iNLwlf4PAC0h1@kernel.org>
 <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com>
 <aJ9fy_sO6tza9qLF@iki.fi>
 <CAMigqh2=Kmnv_rrT-gBtESSXtnMrxU=VJdrYE6_9NGhKBN+ZrA@mail.gmail.com>
 <aJ9ySGv0JZ0DiNgf@kernel.org>
 <aJ9z4OlwvFdEA2Q_@kernel.org>
 <aJ91KX97WVOQ3nVk@kernel.org>
 <aJ92qt6oSYyRYPZG@iki.fi>
 <CAMigqh3yx7S2T=b-gTfdTG5BRs_JbHkXar4DT32AB3v_beNveA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMigqh3yx7S2T=b-gTfdTG5BRs_JbHkXar4DT32AB3v_beNveA@mail.gmail.com>

On Fri, Aug 15, 2025 at 11:09:07AM -0700, Chris Fenner wrote:
> > I'm happy to make patch next week for this change too. So probably this
> > where I align myself to. It's just the best average IMHO. Everyone gets
> > exactly what they want, right?
> 
> To be clear: I already have what I want (the ability to disable this
> feature because it seems broken to me), I'm just making
> recommendations as a TPM abyssal domain expert. I hope my feedback is
> of some use on this -- the work of dealing with interposer attackers
> is quite important and I appreciate the effort already put in by the
> team.

So, if the feature is locked into persistent handle, the net effect
meets the same goals. I'll pursue on a patch.

> 
> Thanks
> Chris

BR, Jarkko

