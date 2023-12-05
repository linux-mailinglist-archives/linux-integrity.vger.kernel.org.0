Return-Path: <linux-integrity+bounces-350-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A005805672
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Dec 2023 14:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056131F2159A
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Dec 2023 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE6D5E0BD;
	Tue,  5 Dec 2023 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MZ1WuRw+";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MZ1WuRw+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9B812C;
	Tue,  5 Dec 2023 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701784228;
	bh=mdJ+vSQNTFO/823tz5zaD4Y+dZocZEX7MxOvEQfVEzk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=MZ1WuRw+0yRCuyhMIZ5vSH1EJddh9O4QGi7w+aq0elI0tCBlhMGzcTJn7C7LiD3ne
	 bnV/xoqs1wAa410fsN6WjfNbtlI0lFgDqeKwHVFHzytJqUIEAoNxa4waLjURn8SsnF
	 4pjFzb2cdcZmjgwmwUZ2eEbRXHw7sqn0jR1RhXLo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id EEE881285D3B;
	Tue,  5 Dec 2023 08:50:28 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id C6S84hDoMYdz; Tue,  5 Dec 2023 08:50:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701784228;
	bh=mdJ+vSQNTFO/823tz5zaD4Y+dZocZEX7MxOvEQfVEzk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=MZ1WuRw+0yRCuyhMIZ5vSH1EJddh9O4QGi7w+aq0elI0tCBlhMGzcTJn7C7LiD3ne
	 bnV/xoqs1wAa410fsN6WjfNbtlI0lFgDqeKwHVFHzytJqUIEAoNxa4waLjURn8SsnF
	 4pjFzb2cdcZmjgwmwUZ2eEbRXHw7sqn0jR1RhXLo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 301671281E5C;
	Tue,  5 Dec 2023 08:50:28 -0500 (EST)
Message-ID: <d1f0921f7fba4b82523b94cd12fdae16350acffe.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, Ard
	Biesheuvel <ardb@kernel.org>
Date: Tue, 05 Dec 2023 08:50:26 -0500
In-Reply-To: <99abf64b-10af-4a24-ac12-117141798956@linux.ibm.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <1d8de077-9dd3-432e-90de-0a5b7dafcd75@linux.ibm.com>
	 <a56dfd99262b31db06713f6f0b6ff2ba58c2fa4b.camel@HansenPartnership.com>
	 <99abf64b-10af-4a24-ac12-117141798956@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2023-12-04 at 16:02 -0500, Stefan Berger wrote:
> On 12/4/23 14:24, James Bottomley wrote:
[...]
> > The actual threat to PCR extends from an interposer is silent
> > discards where the attacker seeks to fake the log after the fact to
> > match a quote they've discarded a suspicious event from.  Thus the
> > HMAC check
> 
> Well, it's not that simple to fake the log unless you are root and
> then all bets are off when it comes to sending commands to the TPM.

It's not just faking logs: if I can discard the true measurements and
insert my own, I can recover any object sealed to a PCR policy.  Even
if I can only discard the last few bad measurements and insert good
ones, I can still likely succeed.

If an attacker gains root, the TPM still can't be faked out.  As long
as the PCRs have accurate measurements, those measurements can be
quoted.  The theory is that the event that allowed the root exploit got
recorded before the exploit happened (of course there's a huge problem
of whether the right thing is being recorded) because post boot
computer hacking cannot violate causality.

The interposer at boot is a more interesting problem, but that's
documented.

James


