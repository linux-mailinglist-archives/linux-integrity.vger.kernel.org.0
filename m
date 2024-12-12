Return-Path: <linux-integrity+bounces-4359-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01AF9EE142
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 09:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D617D16136F
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7DA17E918;
	Thu, 12 Dec 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ES+Sl2bA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F92mETQy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ES+Sl2bA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F92mETQy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E659C259496
	for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992229; cv=none; b=f42t41L57STk4+ZpKixS1GBnq7b27qyYUGr9gfcg1kE0/VhXSpK2xcOEp3A/2JNL6RAXbNjmzTnnlnJOaSHT257+HbFjpVJWej366j4+OOrvsvGbZx+3RBDAUHyDYscAuBjua371IRsYzC9shxMt4oNUsBMUjogav2MjBh/O5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992229; c=relaxed/simple;
	bh=NkeoeouqUUw3Ci/tp/lucSrFw7eV8sdxet8Wm++Cfyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaaTYgQDibBIb02EBpk2XT2yqLDFQZcI3zZNYA+WdHWLQNh0uDNPE1Z1LwG4IM5ys1nlYAxKJZOpy4Z/3NAFr8cWHTpvV2Ls68XvYQeqIFkZrKNYpzwM/PBQwCzU4ki0xgEv3v3u3aU90Vanw7DJeZ2/uhCFnBuuBFq41QVKob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ES+Sl2bA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F92mETQy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ES+Sl2bA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F92mETQy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 000C71F38E;
	Thu, 12 Dec 2024 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733992226;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkeoeouqUUw3Ci/tp/lucSrFw7eV8sdxet8Wm++Cfyo=;
	b=ES+Sl2bAqYwphsg/lbBDaMGUDaBWrcjpZiBOyPM/u7BDULVe6a8w303fHIvTRtnkKJXRwy
	iS7eAH3CqX6gKOQ7zB+sDXqKa8aS9UMgDsP2OZ70FPepdLR+r+tb0nD9HgNL18x5Dw15J9
	j0mAT77iVSAUHhNsEhvHQQAWLGyvrlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733992226;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkeoeouqUUw3Ci/tp/lucSrFw7eV8sdxet8Wm++Cfyo=;
	b=F92mETQy90eZLVGijQF5Qd5wIxOq0l23y14UkfwJPSzW8QQe6G/t0msaCucCGpI1TLVaQk
	vYcPx3S+hzfwJeDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733992226;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkeoeouqUUw3Ci/tp/lucSrFw7eV8sdxet8Wm++Cfyo=;
	b=ES+Sl2bAqYwphsg/lbBDaMGUDaBWrcjpZiBOyPM/u7BDULVe6a8w303fHIvTRtnkKJXRwy
	iS7eAH3CqX6gKOQ7zB+sDXqKa8aS9UMgDsP2OZ70FPepdLR+r+tb0nD9HgNL18x5Dw15J9
	j0mAT77iVSAUHhNsEhvHQQAWLGyvrlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733992226;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkeoeouqUUw3Ci/tp/lucSrFw7eV8sdxet8Wm++Cfyo=;
	b=F92mETQy90eZLVGijQF5Qd5wIxOq0l23y14UkfwJPSzW8QQe6G/t0msaCucCGpI1TLVaQk
	vYcPx3S+hzfwJeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E86D213508;
	Thu, 12 Dec 2024 08:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mm5EOCGfWme0egAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 12 Dec 2024 08:30:25 +0000
Date: Thu, 12 Dec 2024 09:30:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 3/3] ima_{kexec,keys,selinux}: Set minimal kernel version
Message-ID: <20241212083024.GA1463264@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-4-pvorel@suse.cz>
 <b6464e2c5c0195ffd882e6cc484b2f12e7383349.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6464e2c5c0195ffd882e6cc484b2f12e7383349.camel@linux.ibm.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

Hi Mimi,

> On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> > The functionality IMHO was not backported to the enterprise kernels.

> > This helps to avoid false positive in ima_kexec.sh:
> > ima_kexec 1 TWARN: policy not readable, it might not contain required
> > policy '^measure.*func=KEXEC_CMDLINE'
> > ima_kexec 1 TBROK: unable to find a correct measurement

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Looks good.

> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks a lot, this patch merged.

Kind regards,
Petr

