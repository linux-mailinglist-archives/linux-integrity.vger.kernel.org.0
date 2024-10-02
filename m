Return-Path: <linux-integrity+bounces-3727-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D5B98E1AA
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 19:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4681C22949
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34DE1D151E;
	Wed,  2 Oct 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lH9kKzFE";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lH9kKzFE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F8195FEC;
	Wed,  2 Oct 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890298; cv=none; b=qAfuNfGdqgKcO7IoZeIRVHnViGzpoQMZiDilogI4RBR/XlPTmIwyQ2pHpGMcUycwblqaT/gautiGmkmCJoIKV9MADRVFnuxpbl4fdZLdqRZufPQX1KkBUoi1+wvOYGGca3KioXQ5G4Hc9qUAd0OlPplkVEd9rlyJf/LCszshMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890298; c=relaxed/simple;
	bh=ESoRXUooJTMamRkxow067zD8y6e7jzs0/6QiT9wMpdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQ4uLoMQoln2N4g4gla1p93lqssxdUSXrN1+1k6uFGP6VLEfs3Iayy1Qppry3ju2/mbjqbpN+oAe+OE9RBY9zEKg8kWkJu99a4laKMplKQiUiMdy8/071LfI0Bk3z/jEXPoNehrqW+jpX1+N2Bo1GS36gLF6+moLEkCkjDaYQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lH9kKzFE; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lH9kKzFE; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727890296;
	bh=ESoRXUooJTMamRkxow067zD8y6e7jzs0/6QiT9wMpdI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=lH9kKzFEmaCbLh8S2QBhZfzUNUuaJpYBeNF1udpFMLG1tO27RRav0uOeNZHXBfDoD
	 kNshH9EDyvsDfDiOb7bC0NipfHu5ASS08VSPdKaJPPtC+Gfgub3aFp9arehUUsN0bf
	 T4EHrXJaLvuVnIsKsp/G7p4Hnjp/VW+LLECMolCQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 369711287199;
	Wed, 02 Oct 2024 13:31:36 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id gYCRXyJuUpwg; Wed,  2 Oct 2024 13:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727890296;
	bh=ESoRXUooJTMamRkxow067zD8y6e7jzs0/6QiT9wMpdI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=lH9kKzFEmaCbLh8S2QBhZfzUNUuaJpYBeNF1udpFMLG1tO27RRav0uOeNZHXBfDoD
	 kNshH9EDyvsDfDiOb7bC0NipfHu5ASS08VSPdKaJPPtC+Gfgub3aFp9arehUUsN0bf
	 T4EHrXJaLvuVnIsKsp/G7p4Hnjp/VW+LLECMolCQ=
Received: from [10.106.168.49] (unknown [167.220.104.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C58AE128715F;
	Wed, 02 Oct 2024 13:31:35 -0400 (EDT)
Message-ID: <a9b94fad8f0d8023ce2459fa11494ff8e83d0b65.camel@HansenPartnership.com>
Subject: Re: Problems with TPM timeouts
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org, 
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-kernel@vger.kernel.org
Date: Wed, 02 Oct 2024 10:31:34 -0700
In-Reply-To: <Zv1810ZfEBEhybmg@earth.li>
References: <Zv1810ZfEBEhybmg@earth.li>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-10-02 at 18:03 +0100, Jonathan McDowell wrote:
[...]
> First, I've seen James' post extending the TPM timeouts back in 2018
> (
> https://lore.kernel.org/linux-integrity/1531329074.3260.9.camel@Hansen
> Partnership.com/), which doesn't seem to have been picked up. Was an
> alternative resolution found, or are you still using this, James?

No, because I've got a newer laptop.  The problem was seen on a 2015
XPS-13 with a Nuvoton TPM that was software upgraded to 2.0 (and had
several other problems because of this).  I assumed, based on the lack
of reports from others, that this was a problem specific to my TPM and
so didn't push it.

The annoying thing for me was that the TPM didn't seem to recover. 
Once it started giving timeouts it carried on timing out until machine
reset, which really caused problems because all my keys are TPM
resident.

Is yours a permanent problem like mine, or is it transient (TPM
recovers and comes back)?

Regards,

James


