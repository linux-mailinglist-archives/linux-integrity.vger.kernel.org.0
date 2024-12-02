Return-Path: <linux-integrity+bounces-4268-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7819DFF2F
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 11:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D6D280C12
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7E1FBE9B;
	Mon,  2 Dec 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wF1y02NY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jbkhy5Ro";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wF1y02NY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jbkhy5Ro"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6141156C40
	for <linux-integrity@vger.kernel.org>; Mon,  2 Dec 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733136218; cv=none; b=nOb1ovAPbPWwmQPPyulvzVg1P6x6P14HVE8SP9CYGA1LsIknDhqo8ZiGc+2TTSmy9e7q3VFvOpMT7d2E9GErmnLHMHJZSZpBf2p759aHycFr0XZmBq3+9NXoqAq8i7MScTTQhngiR26v1VkLEqzRw9as7NtKFLoSA3QVsG3E2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733136218; c=relaxed/simple;
	bh=ad5L99Id2o/vm7zUQbK01RZMTJGPuSoIp06kasO1ax8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+KvpRiotsoTDM+C69/0nF9RtEKR9uPGubK1qCOKxMSwa5Yc2Q8uzszZ0a4RcCGUprqwYC/fQZaZ6PzBP0o/YQANJAleBnA5yCyQFpPGhwKdChYRNYV+lR2jh3Ytpet9VFQfg5mIP6h64p8fhVB1eviz1hY2gSLBhmhK/aRYYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wF1y02NY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jbkhy5Ro; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wF1y02NY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jbkhy5Ro; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 899E421172;
	Mon,  2 Dec 2024 10:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733136214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP3ActuHrZX8Ef5l8Rk4UAsidn6nTsjgDbCGQpOOjnc=;
	b=wF1y02NYnxqIdQEdvt01h4mbb4dUHW+wU56x3QlTvAFN8IBqWR4U2OGjiY/IWF8vGIeSAM
	mBmVeggmHpMH6YLUM91EBPtqE33X/EdAML0iIz72wBdAf9TOcVDkHvgchWyxlTnMUZ3U6x
	uRCzqwYLNZ6m+4Fyijy4KktdHlb9BCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733136214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP3ActuHrZX8Ef5l8Rk4UAsidn6nTsjgDbCGQpOOjnc=;
	b=jbkhy5Ro+83NvQRztM+AvBQAAynqe8hmdaUmkrAw8zWCV+qiYnGZT9I8Pj33id+SYLRyIm
	ms6fTJSHvXMulyAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wF1y02NY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jbkhy5Ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733136214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP3ActuHrZX8Ef5l8Rk4UAsidn6nTsjgDbCGQpOOjnc=;
	b=wF1y02NYnxqIdQEdvt01h4mbb4dUHW+wU56x3QlTvAFN8IBqWR4U2OGjiY/IWF8vGIeSAM
	mBmVeggmHpMH6YLUM91EBPtqE33X/EdAML0iIz72wBdAf9TOcVDkHvgchWyxlTnMUZ3U6x
	uRCzqwYLNZ6m+4Fyijy4KktdHlb9BCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733136214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uP3ActuHrZX8Ef5l8Rk4UAsidn6nTsjgDbCGQpOOjnc=;
	b=jbkhy5Ro+83NvQRztM+AvBQAAynqe8hmdaUmkrAw8zWCV+qiYnGZT9I8Pj33id+SYLRyIm
	ms6fTJSHvXMulyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7691B13A31;
	Mon,  2 Dec 2024 10:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CPCsHFaPTWebVAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 02 Dec 2024 10:43:34 +0000
Date: Mon, 2 Dec 2024 11:43:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Xiubo Li <xiubli@redhat.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH] doc: correct the build steps for
 open_posix_testsuite
Message-ID: <Z02PZRGzw5qM3z0w@yuki.lan>
References: <20241119101357.951813-1-xiubli@redhat.com>
 <Z0mXHSnqmstCIMrF@yuki.lan>
 <a32c6381-8779-4dc5-878b-a46bff6454d6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32c6381-8779-4dc5-878b-a46bff6454d6@redhat.com>
X-Rspamd-Queue-Id: 899E421172
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi!
> Wait.
> 
> I check it again. I think we should do it under 
> 'testcases/open_posix_testsuite/' too ? For me it doesn't work only do 
> this just before 'cd testcase/...'

Ah it's a bit more complicated that I remmebered. There are two ways how
to compile the open posix testsuite.

The top level configure script configures the open posix testsuite, but
you have to pass the --with-open-posix-testsuite flag to it.

Or you can run the open posix configure from the open posix directory.

-- 
Cyril Hrubis
chrubis@suse.cz

