Return-Path: <linux-integrity+bounces-4954-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD6A3E6EB
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 22:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6B83BFD47
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF352641D0;
	Thu, 20 Feb 2025 21:43:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904572638BC
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087827; cv=none; b=CvxMH+eyYPTBiU7QhnDAf0QtDHqjK48HvXCEvBMlp7lwr2SPgWKxCpoY7R12F3oZAZQQcutfsZ4FoWh0ES4+5WjasUFPFVk7UOLZ4NZZNXbgv5fWHqzedfiq0VQI4daitxlniEdgaRG67iasNVd56h0JG/wJl6Rs8zag/llfR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087827; c=relaxed/simple;
	bh=mUDj1tsr9f5h9VrRdhRvPRBb9Ww00MH3XUEDBdJ0qec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIcAxRBij2VZp/vxLqt5IwXE+jPyXWemRbv/Mo9UeTiqSar1Mv4e1I4vVjstG1hnLSxMXHY7zVZ7mxW482+iZMpQaW5byIGIkdgxsCWmGO5Hz6oWmCoITV+Y6A+1eP8kA/Oj7zYQHaYz+pzWx/g3+YW4E05sfij5i2gZ/m6DAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EC6B1F387;
	Thu, 20 Feb 2025 21:43:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48FED13301;
	Thu, 20 Feb 2025 21:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2n6rCQiit2cYYAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 21:43:36 +0000
Date: Thu, 20 Feb 2025 22:43:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
Message-ID: <20250220214333.GA2726725@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
 <20250220191342.GA2716312@pevik>
 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
 <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 2EC6B1F387
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

> On Thu, 2025-02-20 at 15:22 -0500, Mimi Zohar wrote:
> > On Thu, 2025-02-20 at 20:13 +0100, Petr Vorel wrote:
> > > > On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > > > > Hi Mimi,

> > > > > > Kernel patch "ima: limit the number of ToMToU integrity violations"
> > > > > > prevents superfluous ToMToU violations.  Add corresponding LTP tests.

> > > > > > Link:
> > > > > > https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar@linux.ibm.com/
> > > > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

> > > > > Unfortunately tests fail on both mainline kernel and kernel with your patches.

> > > > The new LTP IMA violations patches should fail without the associated kernel
> > > > patches.

> > > > > Any hint what could be wrong?

> > > > Of course it's dependent on the IMA policy.  The tests assume being booted with the
> > > > IMA
> > > > TCB measurement policy or similar policy being loaded.  Can you share the IMA
> > > > policy?
> > > > e.g. cat /sys/kernel/security/ima/policy

> > > > thanks,

> > > > Mimi

> > > Now testing on kernel *with* your patches. First run always fails, regardless
> > > whether using ima_policy=tcb or
> > > /opt/ltp/testcases/data/ima_violations/violations.policy).

> > > Kind regards,
> > > Petr

> > I'm not seeing that on my test machine.  Could there be other things running on your
> > system causing violations.  In anycase, your original test was less exacting.  
> > Similarly,
> > instead of "-eq", try using "-qe" in the following test and removing the subsequent new
> > "gt" test.

> -> "-ge"

Sure, changing to -ge fixes the problem:
if [ $(($num_violations_new - $num_violations)) -ge $expected_violations ]; then

I guess we need "-ge" for older kernels (unless "fix" for stable).  Should we
accept "$expected_violations || $expected_violations + 1" for new kernels to
avoid problems like the one on my system.

I wonder if the problem was somehow caused by the fact that I built kernel. OTOH
it's build by OBS (official openSUSE build service).

I don't expect you'd have time to look into it, in case you're interested and
have time sending a links to rpm binary and src package.

https://download.opensuse.org/repositories/home:/pevik:/ima-limit-open-writers-ToMToU/standard/x86_64/kernel-default-6.14~rc3-1.1.gb6b4102.x86_64.rpm
https://download.opensuse.org/repositories/home:/pevik:/ima-limit-open-writers-ToMToU/standard/src/kernel-source-6.14~rc3-1.1.gb6b4102.src.rpm

Kind regards,
Petr

> > if [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then



