Return-Path: <linux-integrity+bounces-4502-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5169FEEF0
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 11:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FD01882BF0
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758031ACEC1;
	Tue, 31 Dec 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OtC3EiCR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZczI/I6x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OtC3EiCR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZczI/I6x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D419CC3C
	for <linux-integrity@vger.kernel.org>; Tue, 31 Dec 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735641655; cv=none; b=jnL/qIMzhGZIBAGXSub1Eh4S/tDg0elpXSsrno8o5aW53VeiC7WKaAr/Y+0FeDUG5IzEu3xA3M+Q3wFIv1acUGzdUymlIYw1CaxYRbGy0+ts5t4BzJH3UIGV1CSnNqb3FThTSO4MgB5quwVKlCImVvk8y0kqFlaKaIiklGTHwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735641655; c=relaxed/simple;
	bh=Vl26ClvLjtVuRXZOXDCYqPEC4hZv7s3FgzrrH9wCto4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg08106qwUCGj1srV764Bn2u+6WFrJHcbP69r2eA0HUPVV4z57YaNpoNCT1/cKbmjyiyXR5vcxurU95RPpX9jBn/dlCSw/CqE8RpANk/eSNGiuGbSSMyDZ4SyR5iDYOrcUZD8H/0ND3ASjM2I8N5fDFg8azVxSVyN/bFZc7sFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OtC3EiCR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZczI/I6x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OtC3EiCR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZczI/I6x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4497721108;
	Tue, 31 Dec 2024 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735641651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+MAFqoMV229k/3h+WdL4IBeCWh7p4xDF7lhmaw2cLE=;
	b=OtC3EiCRH5irYLgusSfwnoa1k0K6iKMqkFYYFbPwurvWARwnW7LfOGHcrn1BGl3zEFR7G0
	AoCoXcq8S5CerpKYg6VXWe6+9D2DjV7aoWzaxoTpJwyZjxkRVMNe+0BgLoFtMlLn1HNNe3
	wbr4tc5rR5EsPzHBpklU8MrjR4OAXMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735641651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+MAFqoMV229k/3h+WdL4IBeCWh7p4xDF7lhmaw2cLE=;
	b=ZczI/I6x683/70uNdI1yU9l/sy9uSN/crZAVxKuHNxVtytXWVMp0npJHCJDDaxuqiMwS7r
	0Sn90/uA5nZqlYDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OtC3EiCR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ZczI/I6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735641651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+MAFqoMV229k/3h+WdL4IBeCWh7p4xDF7lhmaw2cLE=;
	b=OtC3EiCRH5irYLgusSfwnoa1k0K6iKMqkFYYFbPwurvWARwnW7LfOGHcrn1BGl3zEFR7G0
	AoCoXcq8S5CerpKYg6VXWe6+9D2DjV7aoWzaxoTpJwyZjxkRVMNe+0BgLoFtMlLn1HNNe3
	wbr4tc5rR5EsPzHBpklU8MrjR4OAXMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735641651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+MAFqoMV229k/3h+WdL4IBeCWh7p4xDF7lhmaw2cLE=;
	b=ZczI/I6x683/70uNdI1yU9l/sy9uSN/crZAVxKuHNxVtytXWVMp0npJHCJDDaxuqiMwS7r
	0Sn90/uA5nZqlYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BEFA13A67;
	Tue, 31 Dec 2024 10:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QtsoBTPKc2d2GQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 31 Dec 2024 10:40:51 +0000
Date: Tue, 31 Dec 2024 11:40:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 6/8] IMA: Add example policy for ima_violations.sh
Message-ID: <20241231104039.GC36475@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-7-pvorel@suse.cz>
 <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
X-Rspamd-Queue-Id: 4497721108
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

> Hi Petr,

> On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  .../integrity/ima/datafiles/ima_violations/violations.policy     | 1 +
> >  1 file changed, 1 insertion(+)
> >  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy

> > diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> > new file mode 100644
> > index 0000000000..5734c7617f
> > --- /dev/null
> > +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> > @@ -0,0 +1 @@
> > +func=FILE_CHECK

> "[PATCH v2 1/8] IMA: Add TCB policy as an example for ima_measurements.sh"
> contains two rules to measure files opened by root on file open.

> measure func=FILE_CHECK mask=^MAY_READ euid=0
> measure func=FILE_CHECK mask=^MAY_READ uid=0

My bad of course "func=FILE_CHECK" is not enough. Thanks for providing a correct
example policy (required part of 'tcb' policy).

> If the 'tcb' or equivalent policy is loaded, there is no need to load another
> policy rule. 

Yes, I'll fix the next commit to avoid loading example policy when
ima_policy=tcb.

Kind regards,
Petr

> Thanks,

> Mimi

