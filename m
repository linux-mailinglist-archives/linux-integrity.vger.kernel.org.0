Return-Path: <linux-integrity+bounces-4123-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1779C94A9
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 22:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F90280F8F
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 21:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C8313A86C;
	Thu, 14 Nov 2024 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OMb+nu3C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FlODHk+S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OMb+nu3C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FlODHk+S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624876026
	for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2024 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620920; cv=none; b=Uci4RKZxrMW826L1DAGWM9sVqxDHWqiEb7M1rfLEIIS3vcJWIUMQxcVsW3OvCoPzqWoPg/jLnXQcTpGQIhzRB14sIO8bZMLO8LNf7CiXvVEvVX/vu5pbVG5Y2Zn681r0aFKUc7iNCdcEgVuDH8SNdT1Ob9YEoa7HaRQXFJKZ34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620920; c=relaxed/simple;
	bh=4mVEZ+0NkYei1upz3kW4GKt5ABYxjv/pFWp3dgsBNcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV02exnQuQJl6xt0winv3DXcGJOTI5Q1iIGi3GkNKg4AZllm7cfYgMNFrTmO0ddbrdZ4JDQNOg0jF256f9U5UHNhMB2LbLrgtJAteWqBAL5eWLm7x9rpCO48QdG0RuHm5/ga4qXdTuA52E+wGL3E4w/OyidIA7PiHS1VaKn4Rho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OMb+nu3C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FlODHk+S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OMb+nu3C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FlODHk+S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C8021F7B9;
	Thu, 14 Nov 2024 21:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731620916;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mVEZ+0NkYei1upz3kW4GKt5ABYxjv/pFWp3dgsBNcA=;
	b=OMb+nu3C3oU6Tm+hyfC34m4u4R21tVeLrwH4oDem6fndCBK6piKshpservMv42YGfbmqKm
	Dy21eOuUwFnKpE9SzHOf8TEoC5TBpKR+x00vWpCylX6ncX3WO+lNP//zjTtAXeIegJxVR7
	FuGMt4xGS+jW6/hmQLQJhAVLkA4uPAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731620916;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mVEZ+0NkYei1upz3kW4GKt5ABYxjv/pFWp3dgsBNcA=;
	b=FlODHk+SkdUTh7eeWuBkH3stY0OHdmUSzdZuuf5nc5tQKyMY+8+NKmwayoagY/5hB2IVMH
	a8pxYTj7hGu9YSDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731620916;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mVEZ+0NkYei1upz3kW4GKt5ABYxjv/pFWp3dgsBNcA=;
	b=OMb+nu3C3oU6Tm+hyfC34m4u4R21tVeLrwH4oDem6fndCBK6piKshpservMv42YGfbmqKm
	Dy21eOuUwFnKpE9SzHOf8TEoC5TBpKR+x00vWpCylX6ncX3WO+lNP//zjTtAXeIegJxVR7
	FuGMt4xGS+jW6/hmQLQJhAVLkA4uPAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731620916;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mVEZ+0NkYei1upz3kW4GKt5ABYxjv/pFWp3dgsBNcA=;
	b=FlODHk+SkdUTh7eeWuBkH3stY0OHdmUSzdZuuf5nc5tQKyMY+8+NKmwayoagY/5hB2IVMH
	a8pxYTj7hGu9YSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E23013794;
	Thu, 14 Nov 2024 21:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X9mYODJwNmeKfQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 21:48:34 +0000
Date: Thu, 14 Nov 2024 22:48:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ima_boot_aggregate: TBROK on fread() failure
Message-ID: <20241114214828.GA1099745@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241101143726.1278291-1-pvorel@suse.cz>
 <20241101143726.1278291-2-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101143726.1278291-2-pvorel@suse.cz>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SINGLE_SHORT_PART(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

Hi all,

both patches merged.

Kind regards,
Petr

