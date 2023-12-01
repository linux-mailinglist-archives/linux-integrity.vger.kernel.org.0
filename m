Return-Path: <linux-integrity+bounces-325-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB780163E
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 23:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62701B211CC
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 22:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE87619B6;
	Fri,  1 Dec 2023 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cE7EjIMa";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cE7EjIMa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334F5D50;
	Fri,  1 Dec 2023 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701469386;
	bh=nUN7+b2e8IPkx+X5/LPfQK9u3Kq3FHcbSecQ6OX3KFQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=cE7EjIMa22Eba+O3jJcqWtqoiq3ueZi8Yf5HjMWMDwQIp6RRNM/NojVDRngdDm0Jg
	 LdYb2bub6J5r9PNokLJHZPoRBHriu7ZAgNSVSr1H5mCsIixTntx7TfK2Hqsgh6zZgo
	 jDctRHzlCdPu2eqozROqkpf4ZtPkvu8wDIIUMeOQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D63301286D10;
	Fri,  1 Dec 2023 17:23:06 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 4e8dZqSh6xUG; Fri,  1 Dec 2023 17:23:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701469386;
	bh=nUN7+b2e8IPkx+X5/LPfQK9u3Kq3FHcbSecQ6OX3KFQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=cE7EjIMa22Eba+O3jJcqWtqoiq3ueZi8Yf5HjMWMDwQIp6RRNM/NojVDRngdDm0Jg
	 LdYb2bub6J5r9PNokLJHZPoRBHriu7ZAgNSVSr1H5mCsIixTntx7TfK2Hqsgh6zZgo
	 jDctRHzlCdPu2eqozROqkpf4ZtPkvu8wDIIUMeOQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 22BE01286D03;
	Fri,  1 Dec 2023 17:23:06 -0500 (EST)
Message-ID: <4d9bf547516c50617fe944590075c802492a0c04.camel@HansenPartnership.com>
Subject: Re: Discussion about using NV indexes for kernel properties like
 localities and PCRs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Lennart Poettering <lennart@poettering.net>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Matthew
 Garrett <mjg59@srcf.ucam.org>, ilias.apalodimas@linaro.org
Date: Fri, 01 Dec 2023 17:23:04 -0500
In-Reply-To: <ZWpRhUNj_M5Pxeif@gardel-login>
References: 
	<49b9916f60649ad66b87f29e9e87c9375b907975.camel@HansenPartnership.com>
	 <ZWpRhUNj_M5Pxeif@gardel-login>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2023-12-01 at 22:35 +0100, Lennart Poettering wrote:
> On Fr, 01.12.23 15:23, James Bottomley
> (James.Bottomley@HansenPartnership.com) wrote:
> 
> > At Linux Plumbers Conference (https://lpc.events) there were
> > several discussions about some of the problems with TPMs in modern
> > laptops, like localities are very useful for key sealing policies
> > (so they could only be unwrapped by the kernel), but most
> > laptops/servers can't use them and also that 24 is too small a
> > number of PCRs.  For the former, instead of making the kernel
> > operate in a different locality from the user and using a
> > TPM2_PolicyLocality, we could get the kernel to create
> > a well known NV PIN index with a random authorization only it knew
> > and seal policies to it with TPM2_PolicySecret, so that only the
> > kernel could construct the authorization to satisfy the policy. 
> > The PCR problem can be partly solved by using NV Extend indexes,
> > which behave very much like PCRs.
> > 
> > The flaw in both the above is that absent the ability to create
> > platform NV indexes (which is impossible in modern firmware because
> > the platform hierarchy gets locked out), anyone possessing the
> > owner password (which is defined to be empty) can delete and
> > recreate the index, causing the authorization to change for NV PIN
> > and resetting the PCR for NV Extend.  To mitigate this, we could
> > block out a range of NV indexes to be only accessible with the
> > kernel (say 256 with handles of the form 010f0ffXX - I chose this
> > so as not to be too close to either the beginning or end, but
> > obviously the exact prefix is up for discussion).  The kernel would
> > then snoop TPM2_NV_DefineSpace and TPM2_NV_UndefineSpace commands
> > and trap and report an error for any attempt to add or delete an
> > index in this range.  We could then get the kernel to create its
> > PIN NV and say 127 NV Extend indexes, which userspace would be able
> > to extend, query and make policies on but not delete.
> > 
> > I'm bringing this up for discussion now, in case anyone has a
> > better idea or wants to add nuances (like measuring the creation to
> > a real PCR and adding an event log to measured boot) before I (or
> > someone else) look into coding it up.
> 
> Why would that be necessary though? The "name" of an nvindex pins the
> access policy of the nvindex.

I assume you're talking about using TPM2_PolicyNameHash coupled with
TPM2_PolicyNV?  That pins to NV index value and name, but the problem
is that still doesn't necessarily solve the deletion problem (see
below).

>  And nvindexes are always created uninitialized, thus to to
> initialize one you just created (i.e. execute the first write to it)
> you must be able to fulfill the write policy set for it. But if you
> can do that, then why bother with deleting/recreating them in the
> first place?

Well, I wasn't really considering using a policy for the index, I was
thinking of using the index for other policies (like key release). 
However, even though you can have a policy for read and write, you
can't have a policy for delete unless you have access to the platform
hierarchy (which the problem statement above explained is getting
increasingly unlikely), so your index can still be reset by deleting
and recreating it (even if it is recreated with the same policy). 
You're right that such an index would be detectably uninitialized
unless whoever deleted it can also write to it.

>  And if you set a different access policy on them then the "name" of
> the nvindex would change, and it would become useless in all
> references from other objects/quotes/…

Right but to take a NV Extend index, you're saying I can delete it and
recreate it with exactly the same policy and attributes (so same name)
but then to prevent me placing malicious entries in it, the policy has
to be narrowly crafted to prevent malicious actors extending it
(because then policy can't tell the difference between that recreated
index and the original one).  I've thought about this, but haven't ever
really been able to come up with usable policies, because all such
policies end up requiring either a privileged locality to write from or
a shared secret between the TPM and the trusted writer.

> This logic is explicitly mentioned in that tpm book btw, it took me a
> while to grok how great that concept is, since it basically means you
> don't have to be concerned about removed/readded nvindexes at all.

Which TPM book is this?

James


