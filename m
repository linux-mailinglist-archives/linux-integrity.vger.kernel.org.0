Return-Path: <linux-integrity+bounces-4717-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C5EA2702D
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 12:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E681887337
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8036120ADD6;
	Tue,  4 Feb 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rAaVP6gj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BOBU5idl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rAaVP6gj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BOBU5idl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8485820969D
	for <linux-integrity@vger.kernel.org>; Tue,  4 Feb 2025 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668339; cv=none; b=OzYHNIzHKrgeL1RiNW83prYa2YkZ3mGalKDoBfCYjM8oCD9mkXPOflnKnG6uhn5IK9NxDDdyo/GLdyjLbISQYbrcyxDuOMhuOo5g87P7kYvqA4nASI9qiABAI+9R28y/piXqHgXzFV+KWxH94deWk5NBFknMJvZ8jXtjrxRThTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668339; c=relaxed/simple;
	bh=WcMcrP/ngv/m0VRSPnvgFaauvdF2sE2MShSutqWfX4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9/pQ0n4wqYAeB8M+jm558QinO/HbEj96HkRxyKdCO/fevBQfu2RjUfQLV7b0Z8093/jn9zkCXgiuv9Ujnc/G1CtebX0pWtVEBQ73QGATXmtSfuSUGiyxmNJmTyn18WIdvYk6LdWCttxL/6MeipruW4CuekJfxQga0QuEytEt1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rAaVP6gj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BOBU5idl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rAaVP6gj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BOBU5idl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DFE91F365;
	Tue,  4 Feb 2025 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738668335;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcMcrP/ngv/m0VRSPnvgFaauvdF2sE2MShSutqWfX4U=;
	b=rAaVP6gjDA+4a9AdDvFtupY1gFL7KK6BnlbC+WkUh5mHB7puialg/XR1XM++hc9tC6z2o4
	tE0vAZ7W7gOczHny8/36eR/3ysH//NRJTZZV3mN02PUVilhD/i1QiErNawcMsQg+f2rr5i
	o2PUd2xdAEfra7XBjRI9X5K+UvtCLkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738668335;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcMcrP/ngv/m0VRSPnvgFaauvdF2sE2MShSutqWfX4U=;
	b=BOBU5idlvlQ6FOimDC7rP74gXkTg4XPPInrnh794IXhovl/uviApYib/sQGoRBkIQ8jOnt
	M28Nj+qnISmkAWCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rAaVP6gj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BOBU5idl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738668335;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcMcrP/ngv/m0VRSPnvgFaauvdF2sE2MShSutqWfX4U=;
	b=rAaVP6gjDA+4a9AdDvFtupY1gFL7KK6BnlbC+WkUh5mHB7puialg/XR1XM++hc9tC6z2o4
	tE0vAZ7W7gOczHny8/36eR/3ysH//NRJTZZV3mN02PUVilhD/i1QiErNawcMsQg+f2rr5i
	o2PUd2xdAEfra7XBjRI9X5K+UvtCLkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738668335;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcMcrP/ngv/m0VRSPnvgFaauvdF2sE2MShSutqWfX4U=;
	b=BOBU5idlvlQ6FOimDC7rP74gXkTg4XPPInrnh794IXhovl/uviApYib/sQGoRBkIQ8jOnt
	M28Nj+qnISmkAWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62A6E1393E;
	Tue,  4 Feb 2025 11:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X4UUFy/5oWexKQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 04 Feb 2025 11:25:35 +0000
Date: Tue, 4 Feb 2025 12:25:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] IMA: measure.policy: limit dont_measure tmpfs policy to
 func=FILE_CHECK
Message-ID: <20250204112530.GB1454850@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250203210233.1407530-1-pvorel@suse.cz>
 <4e4fb197b7127f8d82705ec441e8a273cd237b7f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e4fb197b7127f8d82705ec441e8a273cd237b7f.camel@linux.ibm.com>
X-Rspamd-Queue-Id: 7DFE91F365
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi Mimi,

> On Mon, 2025-02-03 at 22:02 +0100, Petr Vorel wrote:
> > add func=FILE_CHECK to dont_measure tmpfs

> > Similarly to tcb.policy limit dont_measure tmpfs policy to func=FILE_CHECK.
> > This allows to do extra measurements, e.g. kexec boot command line, see
> > kernel commit

> > 7eef7c8bac9a ("ima: limit the builtin 'tcb' dont_measure tmpfs policy rule")

> > Also remove leading 0 from tmpfs magic (to match IMA docs and tcb.policy).

> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks, also this one merged.

Kind regards,
Petr

> > ---
> >  .../security/integrity/ima/datafiles/ima_policy/measure.policy  | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git
> > a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
> > b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
> > index 9976ddf2de..8abd05fb1a 100644
> > --- a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
> > +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
> > @@ -8,7 +8,7 @@ dont_measure fsmagic=0x62656572
> >  # DEBUGFS_MAGIC
> >  dont_measure fsmagic=0x64626720
> >  # TMPFS_MAGIC
> > -dont_measure fsmagic=0x01021994
> > +dont_measure fsmagic=0x1021994 func=FILE_CHECK
> >  # SECURITYFS_MAGIC
> >  dont_measure fsmagic=0x73636673
> >  measure func=FILE_MMAP mask=MAY_EXEC


