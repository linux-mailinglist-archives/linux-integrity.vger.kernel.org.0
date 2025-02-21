Return-Path: <linux-integrity+bounces-4957-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15ADA3EE9C
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 09:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EDD7AD7A3
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA635979;
	Fri, 21 Feb 2025 08:16:29 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02E1F427D
	for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125789; cv=none; b=fMb6jd3iNbCqln79J/qjiSwCLImrgu2wmntHrm98Gap0qs5+aXkJmDhW9BefTotp2zd6jLnS6NjYy42RuCmAyLZCiuwLjp9zm7OxvkFv6I8yU1Qz1L8p8UxL60xHKASzIpX79M5BDC+oBX34MGmIVadpz9GEZ0udwRKuO1HswD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125789; c=relaxed/simple;
	bh=8QUd1x958H5SnW9kNRPfHv4ws/ngPgIaVwzeGD2FSoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsj5O1x8FC4RdyKb6vG7osR9dR0p0/134T5OxjenLtabi+x04VZr1aesQrZANzf2KgwiD/hDW0luylDrOD1AiZYY56oNd+RPEB/rTGBLixuNkXASP9Jgfh6PdKJq718hgL25u7l9QeGyvk9IG7q3XIKoPf8Trf7azcJ7kspeFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 385581F385;
	Fri, 21 Feb 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CE6713888;
	Fri, 21 Feb 2025 08:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xUmWAVk2uGewDQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 08:16:25 +0000
Date: Fri, 21 Feb 2025 09:16:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
Message-ID: <20250221081623.GA2739743@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
 <20250220191342.GA2716312@pevik>
 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
 <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
 <20250220214333.GA2726725@pevik>
 <cd07d8052fbfa0cde426b4b07fde0c70e6aa046f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd07d8052fbfa0cde426b4b07fde0c70e6aa046f.camel@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 385581F385
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

> On Thu, 2025-02-20 at 22:43 +0100, Petr Vorel wrote:
> > > On Thu, 2025-02-20 at 15:22 -0500, Mimi Zohar wrote:
> > > > On Thu, 2025-02-20 at 20:13 +0100, Petr Vorel wrote:
> > > > > > On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > > > > > > Hi Mimi,

> > > > > > > > Kernel patch "ima: limit the number of ToMToU integrity violations"
> > > > > > > > prevents superfluous ToMToU violations.  Add corresponding LTP tests.

> > > > > > > > Link:
> > > > > > > > https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar@linux.ibm.com/
> > > > > > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

> > > > > > > Unfortunately tests fail on both mainline kernel and kernel with your patches.

> > > > > > The new LTP IMA violations patches should fail without the associated kernel
> > > > > > patches.

> > > > > > > Any hint what could be wrong?

> > > > > > Of course it's dependent on the IMA policy.  The tests assume being booted with
> > > > > > the
> > > > > > IMA
> > > > > > TCB measurement policy or similar policy being loaded.  Can you share the IMA
> > > > > > policy?
> > > > > > e.g. cat /sys/kernel/security/ima/policy

> > > > > > thanks,

> > > > > > Mimi

> > > > > Now testing on kernel *with* your patches. First run always fails, regardless
> > > > > whether using ima_policy=tcb or
> > > > > /opt/ltp/testcases/data/ima_violations/violations.policy).

> > > > > Kind regards,
> > > > > Petr

> > > > I'm not seeing that on my test machine.  Could there be other things running on your
> > > > system causing violations.  In anycase, your original test was less exacting.  
> > > > Similarly,
> > > > instead of "-eq", try using "-qe" in the following test and removing the subsequent
> > > > new
> > > > "gt" test.

> > > -> "-ge"

> > Sure, changing to -ge fixes the problem:
> > if [ $(($num_violations_new - $num_violations)) -ge $expected_violations ]; then

> > I guess we need "-ge" for older kernels (unless "fix" for stable).  Should we
> > accept "$expected_violations || $expected_violations + 1" for new kernels to
> > avoid problems like the one on my system.

> The problem is that we don't control what else is running on the system.  So there could
> be other violations independent of these tests.  I'll have to think about it some more and
> get back to you.  (There's no rush to do anything with these LTP IMA violation tests.)

OK, thank you. The worse scenario would be to use less precise variant "-ge".

> > I wonder if the problem was somehow caused by the fact that I built kernel. OTOH
> > it's build by OBS (official openSUSE build service).

> As long as you weren't building the kernel and running the tests at the same, I doubt it
> would be the problem.

Understand, just something on openSUSE Tumbleweed system.

Kind regards,
Petr

> > I don't expect you'd have time to look into it, in case you're interested and
> > have time sending a links to rpm binary and src package.

> Ok.

> > https://download.opensuse.org/repositories/home:/pevik:/ima-limit-open-writers-ToMToU/standard/x86_64/kernel-default-6.14~rc3-1.1.gb6b4102.x86_64.rpm
> > https://download.opensuse.org/repositories/home:/pevik:/ima-limit-open-writers-ToMToU/standard/src/kernel-source-6.14~rc3-1.1.gb6b4102.src.rpm


> thanks,

> Mimi

