Return-Path: <linux-integrity+bounces-324-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6E80159E
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 22:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F185CB20F92
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 21:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45459157;
	Fri,  1 Dec 2023 21:41:56 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 13:41:47 PST
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9F310EA;
	Fri,  1 Dec 2023 13:41:47 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 097EAE80538;
	Fri,  1 Dec 2023 22:35:03 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 09CE31601CC; Fri,  1 Dec 2023 22:35:01 +0100 (CET)
Date: Fri, 1 Dec 2023 22:35:01 +0100
From: Lennart Poettering <lennart@poettering.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>, ilias.apalodimas@linaro.org
Subject: Re: Discussion about using NV indexes for kernel properties like
 localities and PCRs
Message-ID: <ZWpRhUNj_M5Pxeif@gardel-login>
References: <49b9916f60649ad66b87f29e9e87c9375b907975.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49b9916f60649ad66b87f29e9e87c9375b907975.camel@HansenPartnership.com>

On Fr, 01.12.23 15:23, James Bottomley (James.Bottomley@HansenPartnership.com) wrote:

> At Linux Plumbers Conference (https://lpc.events) there were several
> discussions about some of the problems with TPMs in modern laptops,
> like localities are very useful for key sealing policies (so they could
> only be unwrapped by the kernel), but most laptops/servers can't use
> them and also that 24 is too small a number of PCRs.  For the former,
> instead of making the kernel operate in a different locality from the
> user and using a TPM2_PolicyLocality, we could get the kernel to create
> a well known NV PIN index with a random authorization only it knew and
> seal policies to it with TPM2_PolicySecret, so that only the kernel
> could construct the authorization to satisfy the policy.  The PCR
> problem can be partly solved by using NV Extend indexes, which behave
> very much like PCRs.
>
> The flaw in both the above is that absent the ability to create
> platform NV indexes (which is impossible in modern firmware because the
> platform hierarchy gets locked out), anyone possessing the owner
> password (which is defined to be empty) can delete and recreate the
> index, causing the authorization to change for NV PIN and resetting the
> PCR for NV Extend.  To mitigate this, we could block out a range of NV
> indexes to be only accessible with the kernel (say 256 with handles of
> the form 010f0ffXX - I chose this so as not to be too close to either
> the beginning or end, but obviously the exact prefix is up for
> discussion).  The kernel would then snoop TPM2_NV_DefineSpace and
> TPM2_NV_UndefineSpace commands and trap and report an error for any
> attempt to add or delete an index in this range.  We could then get the
> kernel to create its PIN NV and say 127 NV Extend indexes, which
> userspace would be able to extend, query and make policies on but not
> delete.
>
> I'm bringing this up for discussion now, in case anyone has a better
> idea or wants to add nuances (like measuring the creation to a real PCR
> and adding an event log to measured boot) before I (or someone else)
> look into coding it up.

Why would that be necessary though? The "name" of an nvindex pins the
access policy of the nvindex. And nvindexes are always created
uninitialized, thus to to initialize one you just created
(i.e. execute the first write to it) you must be able to fulfill the
write policy set for it. But if you can do that, then why bother with
deleting/recreating them in the first place? And if you set a
different access policy on them then the "name" of the nvindex would
change, and it would become useless in all references from other
objects/quotes/…

This logic is explicitly mentioned in that tpm book btw, it took me a
while to grok how great that concept is, since it basically means you
don't have to be concerned about removed/readded nvindexes at all.

Lennart

--
Lennart Poettering, Berlin

