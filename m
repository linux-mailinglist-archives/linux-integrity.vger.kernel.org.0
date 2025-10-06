Return-Path: <linux-integrity+bounces-7387-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 065AFBBEC40
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 19:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82FF334A66B
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B6221F1A;
	Mon,  6 Oct 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="EmxmdXui"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F31E511;
	Mon,  6 Oct 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770140; cv=none; b=sNTzyVbbbE4GKBwR4SYOpTC/q4q0x3sK2opkgZ1a5igT84+0esj7Qmb8UVpQAvM8pdHl6nMq678PeoIa0MtloPd1GQESxRrXGlv76tcjWqTGIRwu1gsvQAA7xLAfn0R3b8ZWd+7XgZccZUuOQRIolnesQg8WqHmhVZBLBReJr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770140; c=relaxed/simple;
	bh=FbgypfBVoCihQT1Bpv7382CQ1pgmrhKThF2oi8F+Tr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXWZvi5zJ3gcoHqQr8gBClwMo66Y4C058uYpo4n7+dn3mFaWXOPo2A+5bOVYQEz5LZvzvNsuOjlwdfVerG4/invoDok9UB5Z5E9HiFTwfxadUD4HABAoTDX3TvWO+BNiP17gIxnRtDc7zw8iyIjLDQZExWbGyttvVqlFcDyT+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=EmxmdXui; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rlYLRvuiVU/hl7vTjDQy6QJsJ+NAQ0yKDWQ3yTyqNBA=; b=EmxmdXuiFFJuPs0vyL7SnNSIRT
	GoqrIpv7PmrBx4dmI1xH9Mb02AoYf2yBD3gAeBEHE1Gt3EWYGf/sSSB75Z1IxKaeTaQNy4VCeXaGT
	KjIoIZ5YrdD+SFk4Po9NNZduzGrcbLIxMoapJtBm9obShmZxJyqoP0mso/DKCq0jeaS/QKUgk4PtB
	35+ipg8yOdV5DySKXRGKzIquAmvBGgKfSTgjawf8aVuks/AGe6Baln4AUc6jLkPhXFVYwloOlp/JF
	EcYijj/DKM1K7Wt8MnnciEFyvvMKacxtrfUrmp+K34q9QsTWaVuM5K1b9wkbDVAU8LwHmt/dnMhSk
	bSKQuCsA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v5ob7-00FTuE-19;
	Mon, 06 Oct 2025 18:02:05 +0100
Date: Mon, 6 Oct 2025 18:02:05 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOP2DUj67yB0afUt@earth.li>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
 <aOOu1f1QWQNtkl6c@kernel.org>
 <aOPOZwp_inGui9Bx@kernel.org>
 <125ba81bb222cdffef05ef9868c68002efd61235.camel@HansenPartnership.com>
 <aOPzovsBYlH3ojTR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOPzovsBYlH3ojTR@kernel.org>

On Mon, Oct 06, 2025 at 07:51:46PM +0300, Jarkko Sakkinen wrote:
> My main issue preventing sending a new pull request is that weird list
> of core TPM2 features that is claimed "not to be required" with zero
> references. Especially it is contraditory claim that TPM2_CreatePrimary
> would be optional feature as the whole chip standard is based on three
> random seeds from which primary keys are templated and used as root
> keys for other keys.

My understanding here is that the main specification about what's 
"required" for TPMs to implement is from the PC Client Platform TPM 
Profile. There's no specific server PTP (though there is talk about 
creating one), so _most_ vendors just implement the PC Client PTP. It 
doesn't mean a TPM that doesn't do so isn't TPM compliant, just not PC 
Client PTP compliant.

Google have taken the approach in their Titan based TPM implementation 
to avoid implementing features they don't need, to reduce attack 
surface.

I'm not aware of anyone else who has done this.

J.

-- 
... You non-conformists are all alike.

