Return-Path: <linux-integrity+bounces-4124-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99319C968D
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2024 01:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A083B1F215D1
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2024 00:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271D3646;
	Fri, 15 Nov 2024 00:07:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49798645
	for <linux-integrity@vger.kernel.org>; Fri, 15 Nov 2024 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731629277; cv=pass; b=Nf17n2lUFZKWUfvwT1ZNrzgaReGhSwtZZx6W6hqM919O4q5ztJ6TvgBKagnQr0Pn8HPDlpo67+wZDYU15TzCKySYf6K8OqAiF2k5OUFyZ9By2LN5dVL84zXIoiA5KoZWjgOhWE/DEvWap2wwByTt1KbeojN0zrTYL8EGwd5l5JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731629277; c=relaxed/simple;
	bh=bzF6NTWWaczp5UjTRmWE1pFTGVv06z+Wtk1ySVOkYno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/oyRRPe282GLserSnHOokC8AqHMsTcHYva4AXV6yWhN76KeMiRDhjmap1wJLJrjiyFy+ujrS+LR4tXJeoWVReIbpFR1s64j0BqHzUD/FFgzYq2w0ZsAEEsPFhGyfzGDYSMAkAjjP9skwRlqKSCyDXbGC8OdTfl42hVrtJV9mI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 29FAF2C43CF;
	Thu, 14 Nov 2024 23:58:04 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-6.trex.outbound.svc.cluster.local [100.107.236.27])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 484332C43A4;
	Thu, 14 Nov 2024 23:58:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731628683; a=rsa-sha256;
	cv=none;
	b=xpl6sGkSwiYjVXECcXt+7KyQlkyvJ5Z50TUPFlytgNi/mDwa5Kobk0I7XN3simUimnO2Qq
	nbYqjAHG82gWCc3D4/Undkf8DkBGAOgYKBl4JtSH62SPNYQxxncI76ZZZ9YkOEP4MhZB4o
	ci3FV5WdNQGIfI2nOgY0zekDXqcQpJy+6F89DbhMxqpolwfS4EIu2U43gWEyhmXZaQ+6yR
	q7y5MwXJZtcB/9UcRtR7Ue7MsPUtYmFMLOPZhMqb5vyb+UaYNXYLtMT+oQJINRULb9xRBw
	GXXwnNZ6cDnrI5OnUPEqmH9kaLh3BDHVukkdSWakg4EnJtXhBfC+zXDWOJoMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731628683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzF6NTWWaczp5UjTRmWE1pFTGVv06z+Wtk1ySVOkYno=;
	b=dKbajuzA8xU2Idg8E9KayEXYr/e2JYJnwLRn4rtPHTn9vVOJiUy4Shnh9lBNIHvUxEQdsL
	FvXWzJ7xcDgZgmb+NGoxnXIMpUWs/4IwhO2CVwfIGbvsFQkoiN0MX8wdQJq+vR9F/wGalO
	pTpuajZlT9Q1qe0Kx9jYXzyP4fR0fc8oW7GAnpWQCIYTwW8RAM/rND8XCGvZYuP9kGQfbf
	K5K0/YQ4zd4nRCjGTfXXwb8TlTPL/zj5ANsjWxRhFZCYKveUTzmd2bITCYLkhMNTa9XVmb
	M0CLv3EYKPdRvcKXc1PLfiW8RlKHUwC7XoBAFDGYwAP6LXwmB1Ut9D3HEEzUPw==
ARC-Authentication-Results: i=1;
	rspamd-645676964-dzw7m;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Abaft-Descriptive: 196e5d20501fe304_1731628684051_632688747
X-MC-Loop-Signature: 1731628684051:525262220
X-MC-Ingress-Time: 1731628684050
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.236.27 (trex/7.0.2);
	Thu, 14 Nov 2024 23:58:04 +0000
Received: from p5b071105.dip0.t-ipconnect.de ([91.7.17.5]:63383 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tBjit-0000000GawD-00Qa;
	Thu, 14 Nov 2024 23:58:01 +0000
Message-ID: <094d2855e8abe017d5e5610687b7395fe12b5377.camel@scientia.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 15 Nov 2024 00:57:59 +0100
In-Reply-To: <D5LMRS83UP6W.22IBEK42G75GB@kernel.org>
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
	 <D5L9XVNXYQR1.2EBNEZRV0QVUI@kernel.org>
	 <10783d8ac0d407f85feb8e0de8eb7ccece8c8e57.camel@scientia.org>
	 <D5LMRS83UP6W.22IBEK42G75GB@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey Jarkko.


On Thu, 2024-11-14 at 06:52 +0200, Jarkko Sakkinen wrote:
> It was too obvious and I wanted to bring that to 6.12 :-) It was
> a mistake in my fix so was dead obvious.

Since that is out anyway rather soonish, there's no need from my side
to get the fix into stable.

> > ... I wondered whether that rings any bells on your side with
> > respect
> > to: https://bugzilla.kernel.org/show_bug.cgi?id=3D216998
>=20
> So here's my proposal:
>=20
> 1. I added myself to the CC list.

:-)


> 2. Please add any additional comments from your response that might
> be
> =C2=A0=C2=A0 missing as comment.

Right now I don't really have any... mostly because I had no clue on
how to further debug it (the only thing that I could think of would be
having a look at any serial console output, but the laptop has no true
serial port anymore, so best I could do would be to attach some
USB/RS232 adapter, and whether that even loads before the system does
something is questionable)

If you have any ideas on what I can do to give more information, don't
hesitate to tell.

But as I've said... it might just be a bug/missing implementation in
the firmware and nothing from the kernel side.
Cause it really seems as if the display and CPU fan don't even power up
after resume.

So,... I'm happy if you have ideas... but don't waste too much of your
time on this! :-)

btw: Fujitsu support wasn't really helpful on this matter, once they
read Linux they basically said not-interested.


> I look that as soon as I have time. First time I'm seeing this.
>=20
> For anything TPM you can go ahead and CC me also in future...=20

Sure thanks :-)


Cheers,
Chris

