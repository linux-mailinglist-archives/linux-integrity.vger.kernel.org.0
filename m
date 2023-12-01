Return-Path: <linux-integrity+bounces-323-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B3801442
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 21:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF97281C9B
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 20:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC756B8F;
	Fri,  1 Dec 2023 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZYnVwocG";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZYnVwocG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4700DDD;
	Fri,  1 Dec 2023 12:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701462220;
	bh=QC+Rtp8lKZuPTyPMvbCSPRQeYeLDkCiyHaoq5Mz817k=;
	h=Message-ID:Subject:From:To:Date:From;
	b=ZYnVwocGnXufP6Q0VEggER386uJ9nd9pQePqwFSTIYy8mu/kxys30cu9jJM2pvN62
	 2OGd5djqktosMhCU7jthi+BrQnwubT4QlA0FAifZYxDxNIS8Zla+FJLaf6XvGQLFYX
	 Osbu2cOC43/XyxH8mJY3p5MMKTXQwfmKUs0KAkSY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id BA91E1286CB9;
	Fri,  1 Dec 2023 15:23:40 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 0512nif9eGaY; Fri,  1 Dec 2023 15:23:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701462220;
	bh=QC+Rtp8lKZuPTyPMvbCSPRQeYeLDkCiyHaoq5Mz817k=;
	h=Message-ID:Subject:From:To:Date:From;
	b=ZYnVwocGnXufP6Q0VEggER386uJ9nd9pQePqwFSTIYy8mu/kxys30cu9jJM2pvN62
	 2OGd5djqktosMhCU7jthi+BrQnwubT4QlA0FAifZYxDxNIS8Zla+FJLaf6XvGQLFYX
	 Osbu2cOC43/XyxH8mJY3p5MMKTXQwfmKUs0KAkSY=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 179CD1286CB8;
	Fri,  1 Dec 2023 15:23:40 -0500 (EST)
Message-ID: <49b9916f60649ad66b87f29e9e87c9375b907975.camel@HansenPartnership.com>
Subject: Discussion about using NV indexes for kernel properties like
 localities and PCRs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ilias.apalodimas@linaro.org
Date: Fri, 01 Dec 2023 15:23:37 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

At Linux Plumbers Conference (https://lpc.events) there were several
discussions about some of the problems with TPMs in modern laptops,
like localities are very useful for key sealing policies (so they could
only be unwrapped by the kernel), but most laptops/servers can't use
them and also that 24 is too small a number of PCRs.  For the former,
instead of making the kernel operate in a different locality from the
user and using a TPM2_PolicyLocality, we could get the kernel to create
a well known NV PIN index with a random authorization only it knew and
seal policies to it with TPM2_PolicySecret, so that only the kernel
could construct the authorization to satisfy the policy.  The PCR
problem can be partly solved by using NV Extend indexes, which behave
very much like PCRs.

The flaw in both the above is that absent the ability to create
platform NV indexes (which is impossible in modern firmware because the
platform hierarchy gets locked out), anyone possessing the owner
password (which is defined to be empty) can delete and recreate the
index, causing the authorization to change for NV PIN and resetting the
PCR for NV Extend.  To mitigate this, we could block out a range of NV
indexes to be only accessible with the kernel (say 256 with handles of
the form 010f0ffXX - I chose this so as not to be too close to either
the beginning or end, but obviously the exact prefix is up for
discussion).  The kernel would then snoop TPM2_NV_DefineSpace and
TPM2_NV_UndefineSpace commands and trap and report an error for any
attempt to add or delete an index in this range.  We could then get the
kernel to create its PIN NV and say 127 NV Extend indexes, which
userspace would be able to extend, query and make policies on but not
delete.

I'm bringing this up for discussion now, in case anyone has a better
idea or wants to add nuances (like measuring the creation to a real PCR
and adding an event log to measured boot) before I (or someone else)
look into coding it up.

Regards,

James


