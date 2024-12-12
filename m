Return-Path: <linux-integrity+bounces-4360-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB5C9EE203
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 09:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CD6280AC1
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C315720DD79;
	Thu, 12 Dec 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mwvmi/GW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UTq9jOaJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mwvmi/GW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UTq9jOaJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC1204C1D
	for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993752; cv=none; b=uLjeYZkJs+SJW7cHF6XErjuKJqUoqXABYpG4dZckmiFAdV0+ZX7lassvzsIEyWJEIO8//Avh7zqSJD2qP8nS1UsA1o2skZczFvB2s5+7IKCN/5Libk7/2bz9lSMLeidowJAxSrvrVYO20yHMcHBn2H2e3RtxJTkWMNMA7DxtsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993752; c=relaxed/simple;
	bh=wZ3+2caiN69Fg7Eu1IgN0xEP92pSasVP9RHcCmi8JKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjkaA9m+HLuqqgx2ahwjjB/WOzjlnoZuu1zlpRrFF41T24uA1MTI9vWKA04il6KG5MJhSRKS2zbk/X7OsZ5NO4c210WfCinY8Ddo4L4YZicN4W0j4LQaxau9N/YxuNfFiFHedyNYNENqw40k8pgS6WcRXRuxW8rLWyXcHBTPYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mwvmi/GW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UTq9jOaJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mwvmi/GW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UTq9jOaJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 151D82115A;
	Thu, 12 Dec 2024 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733993749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrtPA+BIFgv2K6AerFRpa+EPGrAqcK6lpoRO2IotLgk=;
	b=mwvmi/GWgS1f5hg63XepBJUizMxorHCVwGze2Yn7NxWHsPXouNMasuIhABW9kpQlNbAE+J
	eb/C1sysXqpk1gfQHfojWhsRKp/lyXTTmSbJmguGSrlchN8ZWC01eSfXMjF6A4rQph1tmx
	2uO/Hw2cdy35ZdZmWCS5xt1Ctzn+gyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733993749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrtPA+BIFgv2K6AerFRpa+EPGrAqcK6lpoRO2IotLgk=;
	b=UTq9jOaJTVzh63uy2f9NIXrY3hZRgN0rwx0egX6dJ88yUz3hiNYBwiVukd4fAlLQy+/8RV
	XCIAmrU3vcYmOyBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733993749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrtPA+BIFgv2K6AerFRpa+EPGrAqcK6lpoRO2IotLgk=;
	b=mwvmi/GWgS1f5hg63XepBJUizMxorHCVwGze2Yn7NxWHsPXouNMasuIhABW9kpQlNbAE+J
	eb/C1sysXqpk1gfQHfojWhsRKp/lyXTTmSbJmguGSrlchN8ZWC01eSfXMjF6A4rQph1tmx
	2uO/Hw2cdy35ZdZmWCS5xt1Ctzn+gyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733993749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrtPA+BIFgv2K6AerFRpa+EPGrAqcK6lpoRO2IotLgk=;
	b=UTq9jOaJTVzh63uy2f9NIXrY3hZRgN0rwx0egX6dJ88yUz3hiNYBwiVukd4fAlLQy+/8RV
	XCIAmrU3vcYmOyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0733013508;
	Thu, 12 Dec 2024 08:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MStxARWlWmeBBAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 12 Dec 2024 08:55:49 +0000
Date: Thu, 12 Dec 2024 09:55:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/3] ima: Add TCB policy as an example
Message-ID: <20241212085543.GB1463264@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-2-pvorel@suse.cz>
 <007bb56c0ed893e6b53d31efee1276e7bb91a557.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007bb56c0ed893e6b53d31efee1276e7bb91a557.camel@linux.ibm.com>
X-Spam-Score: -7.50
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

> Hi Petr,

> On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Except for the "dont_measure <tmpfs>" rule, the "dont_measure" rules are for
> pseudo filesystems.  Including a "dont_measure <tmpfs>" policy rule was suppose
> to be limited to the initramfs, and then replaced with an IMA custom policy. I
> would either re-order the rules so that the "dont_measure" rules are only before
> the two "func=FILE_CHECK" rules or perhaps remove the "dont_measure <tmpfs>"
> policy rule.  The kernel builtin "tcb" policy should be updated as described
> below.


> > ---
> >  .../ima/datafiles/ima_measurements/tcb.policy | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy

> > diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> > new file mode 100644
> > index 0000000000..280e6af87c
> > --- /dev/null
> > +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
> > @@ -0,0 +1,20 @@
> > +dont_measure fsmagic=0x9fa0
> > +dont_measure fsmagic=0x62656572
> > +dont_measure fsmagic=0x64626720
> > +dont_measure fsmagic=0x1021994
> > +dont_measure fsmagic=0x1cd1
> > +dont_measure fsmagic=0x42494e4d
> > +dont_measure fsmagic=0x73636673
> > +dont_measure fsmagic=0xf97cff8c
> > +dont_measure fsmagic=0x43415d53
> > +dont_measure fsmagic=0x27e0eb
> > +dont_measure fsmagic=0x63677270
> > +dont_measure fsmagic=0x6e736673
> > +dont_measure fsmagic=0xde5e81e4

> Limit the affect of "dont_measure" rules to just the "func=FILE_CHECK" rules, by
> moving them to before the "func=FILE_CHECK" rules.

> > +measure func=MMAP_CHECK mask=MAY_EXEC
> > +measure func=BPRM_CHECK mask=MAY_EXEC
> > +measure func=FILE_CHECK mask=^MAY_READ euid=0
> > +measure func=FILE_CHECK mask=^MAY_READ uid=0

> Move above two "func=FILE_CHECK" rules to the end.

> > +measure func=MODULE_CHECK
> > +measure func=FIRMWARE_CHECK
> > +measure func=POLICY_CHECK

Thanks for your comments. You probably mean ima_policy=tcb from [1], right?

dont_measure fsmagic=0x9fa0          # PROC_SUPER_MAGIC
dont_measure fsmagic=0x62656572      # SYSFS_MAGIC
dont_measure fsmagic=0x64626720      # DEBUGFS_MAGIC
dont_measure fsmagic=0x1021994       # TMPFS_MAGIC
dont_measure fsmagic=0x1cd1          # DEVPTS_SUPER_MAGIC
dont_measure fsmagic=0x42494e4d      # BINFMTFS_MAGIC
dont_measure fsmagic=0x73636673      # SECURITYFS_MAGIC
dont_measure fsmagic=0xf97cff8c      # SELINUX_MAGIC
dont_measure fsmagic=0x43415d53      # SMACK_MAGIC
dont_measure fsmagic=0x27e0eb        # CGROUP_SUPER_MAGIC
dont_measure fsmagic=0x63677270      # CGROUP2_SUPER_MAGIC
dont_measure fsmagic=0x6e736673      # NSFS_MAGIC
dont_measure fsmagic=0xde5e81e4      # EFIVARFS_MAGIC
measure func=MMAP_CHECK mask=MAY_EXEC
measure func=BPRM_CHECK mask=MAY_EXEC           # binary executed
measure func=FILE_CHECK mask=^MAY_READ euid=0
measure func=FILE_CHECK mask=^MAY_READ uid=0    # root opened r/o, r/w
measure func=MODULE_CHECK
measure func=FIRMWARE_CHECK
measure func=POLICY_CHECK

without: dont_measure fsmagic=0x1021994       # TMPFS_MAGIC
(I would remove the comments from final policy file)

Or if not, feel free to send a patch with optimal policy.

Kind regards,
Petr

[1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

> thanks,

> Mimi

