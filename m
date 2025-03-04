Return-Path: <linux-integrity+bounces-5054-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D87A4D6E0
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 09:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D2A1887C88
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD97D1EB9E2;
	Tue,  4 Mar 2025 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eyomk95g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d4N7lkTu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eyomk95g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d4N7lkTu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764118A6A9
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077917; cv=none; b=mW+cGy+akW7XNfV3QQE71RTHaq8A6UxDvnfdxLU6XMorkbd/O/74XkwDdp/dKmwZEj73U9G13oi5R/37RGsVOTq1sfTGOVQIzaq5wnxZO11a4K55Ilc3YW2oUWEqZxxmnFmrUWvmHFIdm/nkFvy0u9Yj7PSVrDodjrObhAyO6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077917; c=relaxed/simple;
	bh=b/LDE4AI8vhOh7qsdBbSR26740lnDNUXn6Sm6ICV7t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfR7WhLuDkqyI/Bdms+mRJOxMoo2ph+bzy0sKNdO2AQFNhTOfZ94reZ92+NLlKUPAEp0F5ivHfItY+q3mTqe0U5SfRUQDtHyDUX9GkB4YFIzMAmEMgEJ88QrLcRc7QvyMQib5OEZ8/U0krNgggXyKlzUc7o4YYQ7ZGAGsEdfb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eyomk95g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d4N7lkTu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eyomk95g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d4N7lkTu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EEAC1F387;
	Tue,  4 Mar 2025 08:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741077913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/LDE4AI8vhOh7qsdBbSR26740lnDNUXn6Sm6ICV7t8=;
	b=Eyomk95ghPk6i1penPig36SYB52hLx2JZ4HtQHeqhfuE2JNOf2068iLWqASVOpV71L/hxF
	UM96sIwh0cPVnZSeDsIYeXKIotQdctgDeqAP9twefJTsyJPKikEo+iK75twzNGgAz9KVhR
	FuOKKfHSickZsmj1kwBH9oIMyw1lpLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741077913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/LDE4AI8vhOh7qsdBbSR26740lnDNUXn6Sm6ICV7t8=;
	b=d4N7lkTu4p+VsHVurtfu44l0rWePvxeWH8vY3xEQl2W90yTAVXoVgVc9jE8zTC5TaaHKnT
	HfGIGRlfPn9o+yDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Eyomk95g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d4N7lkTu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741077913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/LDE4AI8vhOh7qsdBbSR26740lnDNUXn6Sm6ICV7t8=;
	b=Eyomk95ghPk6i1penPig36SYB52hLx2JZ4HtQHeqhfuE2JNOf2068iLWqASVOpV71L/hxF
	UM96sIwh0cPVnZSeDsIYeXKIotQdctgDeqAP9twefJTsyJPKikEo+iK75twzNGgAz9KVhR
	FuOKKfHSickZsmj1kwBH9oIMyw1lpLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741077913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/LDE4AI8vhOh7qsdBbSR26740lnDNUXn6Sm6ICV7t8=;
	b=d4N7lkTu4p+VsHVurtfu44l0rWePvxeWH8vY3xEQl2W90yTAVXoVgVc9jE8zTC5TaaHKnT
	HfGIGRlfPn9o+yDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4A0D1393C;
	Tue,  4 Mar 2025 08:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QHqTKpi9xmciPwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 04 Mar 2025 08:45:12 +0000
Date: Tue, 4 Mar 2025 09:45:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima_kexec.sh: Detect kernel image from BOOT_IMAGE from
 /proc/cmdline
Message-ID: <20250304084510.GA59205@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250224171137.2893480-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224171137.2893480-1-pvorel@suse.cz>
X-Rspamd-Queue-Id: 2EEAC1F387
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi all,

> Default value was suitable only for x86_64. This helps to use other
> archs on distros which set $BOOT_IMAGE.

FYI merged.

Kind regards,
Petr

