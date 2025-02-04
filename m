Return-Path: <linux-integrity+bounces-4716-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0C8A2701B
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 12:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BC57A4CEF
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E087520127B;
	Tue,  4 Feb 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V2AsqGoB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DKdUythL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wZjieH7r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Op07PxRq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4A1531C4
	for <linux-integrity@vger.kernel.org>; Tue,  4 Feb 2025 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667877; cv=none; b=iKrFi2EsZkP6kjCtLcYRGpkCGBrOUpoMy4ChsrvdMeJ46tfDotpjM5KkO2y5QwjSnnr3EM1E8t7nYRf7TOdf8tlbVg1q6fjX4IpXLWaa9SVbFDIfldG7PRCWg1avmCsPCJc53yWg1t4dD+tepzUC9LJCH2Xp7iPZjVYKqzuWpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667877; c=relaxed/simple;
	bh=tZg4GHSaH3JU0XAqMfYJ3W2G8wwQw+sA8c3yVW/V058=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi9sDo2d3nH1hmSqMNH0kBoKVkJNDp342ZzLxwvdae9lPohFjzm+wLwAqhifORWstR+6DyesTA8YVwVRLytdJ/bCZQyAjIyT1IH8ZXpxBkapCaE2ZBsF8rV8RATUtZIY2Z+yCDoWoLpC7HOPL0QXkLs+sGcZH9IjHWq7GFygAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V2AsqGoB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DKdUythL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wZjieH7r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Op07PxRq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C94581F365;
	Tue,  4 Feb 2025 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738667874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCWvqfjG0BtUUcUKLRbPGcFU/qOT5u/PDe3V66sMGro=;
	b=V2AsqGoBdQoD9CyvNZGreA6cs0wF3MAKS5B0H3DurKDJQfY99SBz0pXHgXeeWVmaelEc7M
	bGyrybZ2cgBpcd8wvB7IjBE2siOQIey38tqzsCFkvCSk5O7oqBKUSD1iyI8AXXX3YZvaYr
	I5w6trcDz8YGvjg4XI4DnvnDKF8Bq4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738667874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCWvqfjG0BtUUcUKLRbPGcFU/qOT5u/PDe3V66sMGro=;
	b=DKdUythLUCl3IQ/jEpNvzE6nGnF3PbujjLCaQld62utnEXov42OX3ZkSDbQCnPdejvi/kW
	d+/jBq4L/mijoFAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wZjieH7r;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Op07PxRq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738667873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCWvqfjG0BtUUcUKLRbPGcFU/qOT5u/PDe3V66sMGro=;
	b=wZjieH7rVYHZ399hValt6hVe7HXVoOdgtgAaHKGB537+oF3FGeoWIycNhyYrhlzPxIEkjQ
	WclnnCIiPcYF8mRTnk686t+iA1o/ZtIRo/82s8lSDEfdn0V6wyUsOHMMdE5ATuYNQJTGyW
	uawrkTz9on3SduJHlzcXIt67gy+9ZIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738667873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCWvqfjG0BtUUcUKLRbPGcFU/qOT5u/PDe3V66sMGro=;
	b=Op07PxRqNBXO+m4sgc+MbLnNT7w62fmZ2MlsDEhQa2jfIvXZsFeXD7uCT71X/d7R7KJW97
	9hSqtEqQ6eRsHbBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9FDB13795;
	Tue,  4 Feb 2025 11:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EhUrKGH3oWcgJwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 04 Feb 2025 11:17:53 +0000
Date: Tue, 4 Feb 2025 12:17:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 05/10] IMA: Read required policy from file
Message-ID: <20250204111748.GA1454574@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-6-pvorel@suse.cz>
 <3c7dee2c281867aa279c9d556e4aa62a7e865d36.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c7dee2c281867aa279c9d556e4aa62a7e865d36.camel@linux.ibm.com>
X-Rspamd-Queue-Id: C94581F365
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi MImi,

...
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > @@ -1,6 +1,7 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0-or-later
> >  # Copyright (c) 2021 Microsoft Corporation
> > +# Copyright (c) Linux Test Project, 2021-2025
> >  # Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >  #
> >  # Verify measurement of SELinux policy hash and state.
> > @@ -14,15 +15,12 @@ TST_CNT=2
> >  TST_SETUP="setup"
> >  TST_MIN_KVER="5.12"
> >  
> > -FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
> > -REQUIRED_POLICY="^measure.*$FUNC_CRITICAL_DATA"
> > +REQUIRED_POLICY_CONTENT='selinux.policy'

> The selinux.policy contains a specific critical data measurement rule:
> measure func=CRITICAL_DATA label=selinux.  However the test would work with the
> generic policy rule "measure func=CRITICAL_DATA", which can be specified on the . 
> boot command line via "ima_policy=critical_data".

> As long as being able to read the IMA policy is required, in addition to checking
> whether the specific critical data rule exists, check whether the generic rule exists
> before loading the specific one.

> Perhaps all that is needed is defining REQUIRED_BUILTIN_POLICY like:
> REQUIRED_BUILTIN_POLICY="critical_data"

Thanks for a hint, I'll retest ima_policy=critical_data and add it as an
alternative (as a separate patch). In a meanwhile I (hopefully) fixed all
mistakes in the commit messages and merged. Thanks a lot for your patient
review!

...

Kind regards,
Petr

