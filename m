Return-Path: <linux-integrity+bounces-2512-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33D8CB023
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 16:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A41F25387
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F37F7C2;
	Tue, 21 May 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hKdhyU7g";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hKdhyU7g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C677F490;
	Tue, 21 May 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300833; cv=none; b=YZSy/OvjNSeDQZ0r0Yw6ih0bL/QKuqpVxZLB1zVPI0n2MgJh2o4XU1MuAU22oz3FLCIAV4uei4N+xyhKIAuDmjsRLyPJQMKPLF04HeKiksslXt+YugfcTMgUbURLrNfVE9O0wxw9RUHPlnxVdJVCf88CeRBfKAT1hWB990YfqBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300833; c=relaxed/simple;
	bh=hICR39jC/rtypA7CGipOBlXUxk7CPTosvfiEBMKeYQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4lpm0ILzQ/itvsecp0sj0QGQbymeJ4Z7jXRAUtC6Va1pYEt7TtokcVUbyAqoJAa//E0cnhOubGCWrTN1scqbt3CZ+0MbxHdJx9OnKosEib2kiTw4lh3ZHitnaMOW8PFIltrKixwUtnCPNx9umq4WG7+q2K11tzSypjO1IFAbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=hKdhyU7g; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=hKdhyU7g; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716300830;
	bh=hICR39jC/rtypA7CGipOBlXUxk7CPTosvfiEBMKeYQw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=hKdhyU7guQxWzoC89oEBKj2f+GC6rmiQcrinFXd16Wa72r/f8ZpijL7AumuM8o+r6
	 Og6Y8bnl6anGdpFNoH/srSRXBP8lNd6d1EigenRaKa1QgzV+C4Jpr2J2t3yOM/ke3R
	 eKxGAdl6TMyrE2bhRs0yUat0EAx8B1iNvWirs7mA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E1D43128716B;
	Tue, 21 May 2024 10:13:50 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id kiRxAjhcGZ42; Tue, 21 May 2024 10:13:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716300830;
	bh=hICR39jC/rtypA7CGipOBlXUxk7CPTosvfiEBMKeYQw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=hKdhyU7guQxWzoC89oEBKj2f+GC6rmiQcrinFXd16Wa72r/f8ZpijL7AumuM8o+r6
	 Og6Y8bnl6anGdpFNoH/srSRXBP8lNd6d1EigenRaKa1QgzV+C4Jpr2J2t3yOM/ke3R
	 eKxGAdl6TMyrE2bhRs0yUat0EAx8B1iNvWirs7mA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A89F412870E5;
	Tue, 21 May 2024 10:13:49 -0400 (EDT)
Message-ID: <854fa2e1634eb116b979dab499243e40917c637c.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: enable HMAC encryption for only x86-64 and aarch64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Tue, 21 May 2024 10:13:45 -0400
In-Reply-To: <D1FDMULT5YRK.GZOPJ9FZ325R@kernel.org>
References: <20240521130921.15028-1-jarkko@kernel.org>
	 <236606947b691049c650bdf82c37324084662147.camel@HansenPartnership.com>
	 <D1FDMULT5YRK.GZOPJ9FZ325R@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-05-21 at 17:02 +0300, Jarkko Sakkinen wrote:
> Secondly, it also roots to the null key if a parent is not given. So
> it covers all the basic features of the HMAC patch set.

I don't think that can work.  The key file would be wrapped to the
parent and the null seed (and hence the wrapping) changes with every
reboot.  If you want a permanent key, it has to be in one of the
accessible permanent hierarchies (storage ideally or endorsement).

The spec has a mechanism for deriving the key from a permanent handle
if the system doesn't have it in-place.  I do have patches to use that
because that's the way most sealed objects and keys are generated
today.  I'll post them (although there'll be a bit of fixing up to do).

Regards,

James


