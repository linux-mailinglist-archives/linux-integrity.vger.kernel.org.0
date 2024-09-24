Return-Path: <linux-integrity+bounces-3681-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC59849AF
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0593FB25067
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CEE1AB6E8;
	Tue, 24 Sep 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tjE3pq7O";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tjE3pq7O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9C1AB6D3;
	Tue, 24 Sep 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195644; cv=none; b=pM8VqRu5GYBHckM4lrDaQdXi2KQE4IrFzagu0T7Ko9je/mXIcnmglG9WoLlghO40rAwfylCi30+VusigjbAdYXnBWjEGIN+a48ZDKjy8upKMN8xecGhXXsykHEdkv7iOYQ+Ov54CivQMa6GJs0pDCw5FXq4Bnk4iuWahsDOljX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195644; c=relaxed/simple;
	bh=laLIoKegSswEPFFUAqQ5sfOEuahPYTd8NgIBeCalqrY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLPW5fADrn3vRZcS/QL2buBW/3L6xPzqFTUeZZoBBdnnh89m5Kiti9TAixPP0OxV+N0JXVyg/KjBntHrMieL1/SQDb+OyK4SoI4qr1VJ/FWvRDQuA0NmGTzrJUd2ETAQeCctdPPfmiPNcvn9Sikm1uAhVghhrb8JOMBlTMDGMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tjE3pq7O; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tjE3pq7O; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727195641;
	bh=laLIoKegSswEPFFUAqQ5sfOEuahPYTd8NgIBeCalqrY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tjE3pq7O9MBgE7nrj/m1YsCSCe625my1jv0FW8KJbxVBrTCxldxPTYnfwtQQYikod
	 64HaHf5qvO5Ar5oMD3E9ivdLqwrAhUh9AyiShyiyI2KLoO74wb6RAGV4vl1xvHMyA9
	 pb0Is9sWEFsotEchlketetUpSWx1MkgT5BIYe2rc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 62F7E1287001;
	Tue, 24 Sep 2024 12:34:01 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id XQ74e3HiHm8S; Tue, 24 Sep 2024 12:34:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727195641;
	bh=laLIoKegSswEPFFUAqQ5sfOEuahPYTd8NgIBeCalqrY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tjE3pq7O9MBgE7nrj/m1YsCSCe625my1jv0FW8KJbxVBrTCxldxPTYnfwtQQYikod
	 64HaHf5qvO5Ar5oMD3E9ivdLqwrAhUh9AyiShyiyI2KLoO74wb6RAGV4vl1xvHMyA9
	 pb0Is9sWEFsotEchlketetUpSWx1MkgT5BIYe2rc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 179C91286D80;
	Tue, 24 Sep 2024 12:34:00 -0400 (EDT)
Message-ID: <19a242eeabaa72dcc159c9c24fb412e3f68f8e7e.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, mapengyu@gmail.com, Mimi Zohar
 <zohar@linux.ibm.com>,  David Howells <dhowells@redhat.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,  "Serge E. Hallyn"
 <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe
 <jgg@ziepe.ca>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2024 12:33:58 -0400
In-Reply-To: <D4ENNN25NKBE.87NXHTTEWZY@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
	 <c26a295d96b14173b5693c5933e92bbda84764cc.camel@HansenPartnership.com>
	 <D4ENNN25NKBE.87NXHTTEWZY@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-09-24 at 19:29 +0300, Jarkko Sakkinen wrote:
> On Tue Sep 24, 2024 at 4:48 PM EEST, James Bottomley wrote:
[...]
> > Patch 3 is completely unnecessary: the null key is only used to
> > salt the session and is not required to be resident while the
> > session is used (so can be flushed after session creation)
> > therefore keeping it around serves no purpose once the session is
> > created and simply clutters up the TPM volatile handle slots. (I
> > don't know of a case where we use all the slots in a kernel
> > operation, but since we don't need it lets not find out when we get
> > one).  So I advise dropping patch 3.
> 
> Let's go this through just to check I'm understanding.
> 
> Holding null key had radical effect on boot time: it cut it down by
> 5 secons down to 15 seconds:
> 
> https://lore.kernel.org/linux-integrity/CALSz7m1WG7fZ9UuO0URgCZEDG7r_wB4Ev_4mOHJThH_d1Ed1nw@mail.gmail.com/
> 
> Then in subsequent version I implemented lazy auth session and boot
> time went down to 9.7 seconds.
> 
> So is the point you're trying to make that since auth session is 
> already held as long as we can and they flushed in synchronous
> point too, I can just as well drop patch 3?

Yes, because the null key is only used in session generation which is
now lazy, it adds or subtracts nothing from the timings.  When you're
forced to flush the session, the null key goes too, so you again have
to restore it from the context.  When you can keep the session you
don't need the null key because you're not regenerating it.

> I think I reach your point but just want to check that I do it
> for the matching reasons. It is evolutionary cruft in the patch
> set :-)

Regards,

James


