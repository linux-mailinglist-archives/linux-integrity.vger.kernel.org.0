Return-Path: <linux-integrity+bounces-4020-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE529BBED9
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 21:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8294282978
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 20:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A91F5847;
	Mon,  4 Nov 2024 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OQBg2D8+";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OQBg2D8+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B41CC177;
	Mon,  4 Nov 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752612; cv=none; b=DrJzW37a7xxUP0GCZzCmKtF+gJJYz/nv86oygtzdn+fpHsW7Xu1i7TbpMf0jX9QlsJhs6U4WWuiyIjOjVlQYgAPh0PpFJcDhFxcKw/sUttLbveH7qLfo0efTT2GQXwjvqSKe6Q9MWHWO/Mph6Pzz/OFKWhze5u2NJ+fdqscCKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752612; c=relaxed/simple;
	bh=MH95nwjtxh9CUiVs6j+VCHeyX3hYoAOyuTRvCrVcPIk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/1k/zAD9FKFl51Pfd4lOe8yN5eahsGwXVQRdm3eBamg1YUyZikQlHyngQhvV9aAZ6+zSIGHDMmF2ZZqnhlb3Ng5RjNS1EAKTy/LV9sr2KU60/ubcgZ2x7cPewoolKUeYchRNKZ1N52UP/s13FKIzODQ/XcJWS3NXMv/S7IOy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=OQBg2D8+; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=OQBg2D8+; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730752609;
	bh=MH95nwjtxh9CUiVs6j+VCHeyX3hYoAOyuTRvCrVcPIk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=OQBg2D8+GhKeQtgdiU+zAzcwIdPNY1fX+zK7EqAzSEkPKBUQyLGrr1gdY440S1bcI
	 oZ3G5g5JrPdc/nlqFWbiRSSz3R9NK6aAerGX/MTzIDPDTLVw6DJnpXlwl4DySafF2E
	 qVpzlBAO+KzIaAuPj2KpzCQ47XW6rI52yZKVrRos=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 608E612862C2;
	Mon, 04 Nov 2024 15:36:49 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WOB2EnTYZ0Ld; Mon,  4 Nov 2024 15:36:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730752609;
	bh=MH95nwjtxh9CUiVs6j+VCHeyX3hYoAOyuTRvCrVcPIk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=OQBg2D8+GhKeQtgdiU+zAzcwIdPNY1fX+zK7EqAzSEkPKBUQyLGrr1gdY440S1bcI
	 oZ3G5g5JrPdc/nlqFWbiRSSz3R9NK6aAerGX/MTzIDPDTLVw6DJnpXlwl4DySafF2E
	 qVpzlBAO+KzIaAuPj2KpzCQ47XW6rI52yZKVrRos=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5CBE1128623B;
	Mon, 04 Nov 2024 15:36:48 -0500 (EST)
Message-ID: <11eb20711f597b355c38abfce54ccff7f68fa5c9.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Ard Biesheuvel
	 <ardb@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org, Ross Philipson
 <ross.philipson@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, "open list:TPM
 DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  trenchboot-devel@googlegroups.com
Date: Mon, 04 Nov 2024 15:36:46 -0500
In-Reply-To: <102f7de4-a2d0-4315-9bce-6489504180fb@apertussolutions.com>
References: <20241102152226.2593598-1-jarkko@kernel.org>
	 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
	 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
	 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
	 <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
	 <97d4e1a0-d86e-48a9-ad31-7e53d6885a96@apertussolutions.com>
	 <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>
	 <7b324454-bc34-4cc4-bd12-99268a543508@apertussolutions.com>
	 <3bc70b659c1c86c0f08c6d91a6d894ce58825e04.camel@HansenPartnership.com>
	 <102f7de4-a2d0-4315-9bce-6489504180fb@apertussolutions.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-11-04 at 11:34 -0500, Daniel P. Smith wrote:
[...]
> In case the question comes up from those not familiar, the kexec does
> an GETSEC[SEXIT] which closes off access to Localities 1 and 2, thus 
> locking the DRTM PCR values. It brings the CPUs out of SMX mode so
> the target kernel does not require to have any knowledge about
> running in that mode.

So, to repeat the question: why a sysfs interface for setting the
default locality?  If I understand correctly from what you say above,
it can't be used in any kernel except the SL one, and that one could
run permanently in it, so there's no requirement at all for user space
to be able to change this, is there?

Regards,

James




