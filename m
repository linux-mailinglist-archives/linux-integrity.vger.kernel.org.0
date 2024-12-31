Return-Path: <linux-integrity+bounces-4501-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93DC9FEEA8
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 11:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A663A1621A5
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404B18C32C;
	Tue, 31 Dec 2024 10:01:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167A1850B5
	for <linux-integrity@vger.kernel.org>; Tue, 31 Dec 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735639270; cv=none; b=E/Q4c8/3WQoEPuYRkuJpAq6P1wcsMW7CMhW+zNcnTeHwEUKWN7aHUDo2+XdORNyH7zXapgT1VmyzTEqtROT1oQPNbtaTXCEG5ic9HN2/dbvVmetBpVuqHFw/lAJxmsT79lG9jObLykpJkROS7xL12IGKT9xNuxILmtvrEeSRRfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735639270; c=relaxed/simple;
	bh=f6LpIBgbRbLJvoE+vXdsPNz3yqqaQgjb6ZB6MtGdNKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkRlDjgmDM51o+MBGKpcR6q/fyLd6aZKmLTe8K4BUAlTHUwMyoLAs/dZXLixFLxi32hrXLgo8uc0LeLtb9zo0jQvReiYnX3/hMi7klJsa6w+4Qzf7N6/WKmPnzqczG0Mm3BhbiyUq5KMFcIrZAvifT81ARn51MeVBafUco4Btzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE0411F37C;
	Tue, 31 Dec 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A359513A30;
	Tue, 31 Dec 2024 10:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MClyJuLAc2dzEQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 31 Dec 2024 10:01:06 +0000
Date: Tue, 31 Dec 2024 11:00:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 2/8] ima_setup.sh: Allow to load predefined policy
Message-ID: <20241231100057.GB36475@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-3-pvorel@suse.cz>
 <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: CE0411F37C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

> Hi Petr,

> On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> [snip]

> > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -1,7 +1,7 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0-or-later
> >  # Copyright (c) 2009 IBM Corporation
> > -# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
> > +# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
> >  # Author: Mimi Zohar <zohar@linux.ibm.com>

> >  TST_TESTFUNC="test"
> > @@ -72,14 +72,20 @@ require_policy_readable()
> >  	fi
> >  }

> > -require_policy_writable()
> > +check_policy_writable()
> >  {
> > -	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> > -
> > -	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
> > -	# CONFIG_IMA_READ_POLICY
> > +	[ -f $IMA_POLICY ] || return 1
> > +	# workaround for kernels < v4.18 without fix
> > +	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> >  	echo "" 2> log > $IMA_POLICY
> > -	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
> > +	grep -q "Device or resource busy" log && return 1
> > +	return 0
> > +}
> > +
> > +require_policy_writable()
> > +{
> > +	check_policy_writable || tst_brk TCONF \
> > +		"IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> >  }

> >  check_ima_policy_content()
> > @@ -158,6 +164,34 @@ print_ima_config()
> >  	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
> >  }

> > +load_ima_policy()
> > +{
> > +	local policy="$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
> > +
> > +	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$policy" -a -f "$policy" ]; then
> > +		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=1 to load policy for this test"
> > +		return
> > +	fi
> > +
> > +	if [ -z "$policy" -o ! -f "$policy" ]; then
> > +		tst_res TINFO "no policy for this test"
> > +		LTP_IMA_LOAD_POLICY=
> > +		return
> > +	fi
> > +
> > +	tst_res TINFO "trying to load '$policy' policy:"
> > +	cat $policy
> > +	if ! check_policy_writable; then
> > +		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
> > +		LTP_IMA_LOAD_POLICY=
> > +		return
> > +	fi
> > +
> > +	cat "$policy" 2> log > $IMA_POLICY
> > +	if grep -q "Device or resource busy" log; then
> > +		tst_brk TBROK "Loading policy failed"
> > +	fi

> To write to the IMA securityfs policy file, check_policy_writable() used "echo",
> while here it's using "cat".  "cat" fails when signed policies are required.
> Perhaps add something like:
> +
> +       if grep -q "write error: Permission denied" log; then
> +               tst_brk TBROK "Loading unsigned policy failed"
> +       fi

+1, I'll add this extra check to v3.

I suppose echo "" > /sys/kernel/security/ima/policy does not need this check.

Do I understand correctly you talk about policy containing func=POLICY_CHECK [1]?
Maybe there could be a test based on example [2].

echo /home/user/tmpfile > /sys/kernel/security/ima/policy
cp tmpfile /sys/kernel/security/ima/policy
cat tmpfile > /sys/kernel/security/ima/policy

Kind regards,
Petr

[1] https://ima-doc.readthedocs.io/en/latest/policy-syntax.html#func-policy-check
[2] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#runtime-custom-policy

> > +}

> Mimi


