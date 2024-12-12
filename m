Return-Path: <linux-integrity+bounces-4366-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E689EEA94
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 16:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D858188BF61
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42C213E97;
	Thu, 12 Dec 2024 15:11:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDAD21504F
	for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016308; cv=none; b=SVMSsuFvSOgE5qkP9NGnDPQJyAc6AX6D7KwIdSH0dby1OywnmAFSyI9iruyQ3+4fpR1mNQd4t+/pQ2zokDkjSnoJlXVP/ZkP3YGhmDzBIsSrodDJqf/0d9seYJwEMWTnoQnqiDj7qxezQ+o+SffB4tIewdeU0ZgO1j6tsKlfc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016308; c=relaxed/simple;
	bh=Y0dZJBA24or8dxJ3MZRAIlN1RczNp0lMfZvBjFsoBAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKlpsMwdOSc8AW+wcLSa6uA9d1ruoMTyjLPXY4vLopTF1K+CWeKUAQ3Pxrf7mG16ZD7jTcJX4CbY0Gr21jUWoTQyvWVF+3d7jCZO2jQcu2ZY24CEUIRI2Qwu/b5nsAUqJuXlbNPkLhSPAfW4A3eYJKK/Lbfo1E8Hz8nFCKVlBs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4318F1F383;
	Thu, 12 Dec 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A10C13508;
	Thu, 12 Dec 2024 15:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2MH2CTD9Wme2fQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 12 Dec 2024 15:11:44 +0000
Date: Thu, 12 Dec 2024 16:11:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH 2/3] ima_setup.sh: Allow to load predefined policy
Message-ID: <20241212151142.GA1483471@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-3-pvorel@suse.cz>
 <710315f59b9378d76d226e209fee698f6bc11c06.camel@linux.ibm.com>
 <20241211194836.GE443680@pevik>
 <3da6e0fade05a3087848bc86a55d771901dbf701.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3da6e0fade05a3087848bc86a55d771901dbf701.camel@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 4318F1F383
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

> On Wed, 2024-12-11 at 20:48 +0100, Petr Vorel wrote:
> > Hi Mimi, all,

> > > On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> > > > environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
> > > > if available. This should be used only if tooling running LTP tests
> > > > allows to reboot afterwards (because policy may be writable only once,
> > > > e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
> > > > other).

> > > Thanks, Petr.  Allowing the policy to be updated only if permitted is a good
> > > idea.  Even with the LTP_IMA_LOAD_POLICY=1 environment variable, the policy
> > > might not be loaded.  For example, when secure boot is enabled and the kernel is
> > > configured with CONFIG_IMA_ARCH_POLICY enabled, an "appraise func=POLICY_CHECK
> > > appraise_type=imasig" rule is loaded, requiring the IMA policy itself to be
> > > signed.

> > Yes, it's an attempt, which can fail for various reasons. I'll add this example
> > of failure to load the policy to the commit message and to the docs.

> > I'd like to detect if policy got updated to avoid wasting time with SUT reboot
> > when policy was not updated. But this probably will not be always possible
> > (e.g. (CONFIG_IMA_READ_POLICY not set).

> Why do you actually need to be able to read the policy, after updating it?
You're right that's not needed for detecting the update.
But it's needed for tests which would like to detect whether policy contain
required items. Because without CONFIG_IMA_READ_POLICY when tests fails due old
kernel or unsuitable policy we have no way to detect. And TBROK is here false
positive which needs to be resolved by testers. But that's IMHO unsolvable.

> Either the policy update succeeded or failed.  For example in the signed policy
> case, writing a valid policy rule via 'cat' on a system requiring the policy to
> be signed always fails.

> > > On failure to load a policy, the ima_conditionals.sh and ima_policy.sh tests say
> > > "TINFO: SELinux enabled in enforcing mode, this may affect test results".  We
> > > should stop blaming SELinux. :)

> > This info was added for LTP shell tests, which got often affected by
> > SELinux/Apparmor. Because IMA is written in LTP shell API it gets this.
> > Error message is printed on TBROK, TFAIL, TWARN. Is this the only part where you
> > would like to avoid the message? Or do you want to remove SELinux/Apparmor
> > warning from all IMA tests?

> You have a better feel than me as to whether SELinux/Apparmor could interfere
> with these tests.  Unless we have some reason to blame SELinux/Apparmor, I would
> remove it.

+1, I'll remove it for IMA in v2.

Kind regards,
Petr

> Mimi 

