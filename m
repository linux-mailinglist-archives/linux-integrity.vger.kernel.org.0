Return-Path: <linux-integrity+bounces-2398-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2198C58BD
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FD81C21CFC
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D4217EB94;
	Tue, 14 May 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="sb+/5ww3";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gQL+LVF0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707E317EB87;
	Tue, 14 May 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700638; cv=none; b=nz7gzSgusrkbQV/k7GwzNHVd3dUN+UgeW+FHZ51F7W8xYmgA6PlLJ76nlzyZUSBidVDLNVZsM4N9uM01M1o+110lF3kCMqDEhg0CX4a0nXseTikrP/KI+fLJddFhEhYE4FSDoVm7b+6ULEjUN4aGFWUT1fy1nwwRV4cz8J9pGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700638; c=relaxed/simple;
	bh=oUjih/AMFlsT/gup7ocbxKvtp4ZtJPqGdadAC/AAB1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7XO2b+hQNU1lG3Va6lAucHheU0Bn3/OliPd9AIQCaYsE8vaMPeeY3b1TxgKDtuf7dYBA2cVcbpJ8Cql98chv8YC58qcFjkMURYGib/+c2m5oP1NijC8zRALga04wmasDiPY+8be1Y9oATkhJXm9VvzzjPeDYymJLegaFH/PLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=sb+/5ww3; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gQL+LVF0; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715700636;
	bh=oUjih/AMFlsT/gup7ocbxKvtp4ZtJPqGdadAC/AAB1o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=sb+/5ww30zyArrEXkwVDDa9cO5/IaGqihnMobXWIMXSA3lJsXqP2aMfn9+Ci15zlq
	 7IQip2vXFpdKYBioIyRTuYG5GjgowJw0bLmbP+U0gvTe3v2uFCoAN6ukZjLgnVK8hc
	 sizsMaJluYIKJKkbkGmy5iOP2FPvEAkhr5z93fgo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 33E3F12868FD;
	Tue, 14 May 2024 11:30:36 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id iKTN0KGAPddb; Tue, 14 May 2024 11:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715700635;
	bh=oUjih/AMFlsT/gup7ocbxKvtp4ZtJPqGdadAC/AAB1o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gQL+LVF0s8I9cQcflaPdODe24MzQjF9NRS3Em3B3XBCc4eL5+0wRFFVNAYdohF/Vz
	 YMCepLjDyl35JV5XDydO8sHdv8bbBS0bLGkPCh00QlKdBpPvhMbG2sHF4iF0SqSf/D
	 ZhpLdMTaWGCCBlQBgajYfgr6nsJxtJkW30AGi++I=
Received: from [172.21.4.27] (unknown [50.204.89.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 668651286A24;
	Tue, 14 May 2024 11:30:35 -0400 (EDT)
Message-ID: <3bfcacf38d4f5ab5c8008f2d7df539012940222e.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ignat Korchagin <ignat@cloudflare.com>, Jarkko Sakkinen
 <jarkko@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 serge@hallyn.com,  linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Date: Tue, 14 May 2024 09:30:34 -0600
In-Reply-To: <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
References: <20240503221634.44274-1-ignat@cloudflare.com>
	 <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
	 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
	 <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
	 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
	 <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-05-14 at 14:11 +0100, Ignat Korchagin wrote:
>   * if someone steals one of the disks - we don't want them to see it
> has encrypted data (no LUKS header)

What is the use case that makes this important?  In usual operation
over the network, the fact that we're setting up encryption is easily
identifiable to any packet sniffer (DHE key exchanges are fairly easy
to fingerprint), but security relies on the fact that even knowing that
we're setting up encryption, the attacker can't gain access to it.  The
fact that we are setting up encryption isn't seen as a useful thing to
conceal, so why is it important for your encrypted disk use case?

James


