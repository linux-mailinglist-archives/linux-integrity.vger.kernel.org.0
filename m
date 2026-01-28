Return-Path: <linux-integrity+bounces-8353-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAzeIMFyemme6gEAu9opvQ
	(envelope-from <linux-integrity+bounces-8353-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 21:34:09 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B93D9A89ED
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 21:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37D86305BD6E
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 20:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124B23ED5B;
	Wed, 28 Jan 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qTfV831y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBAPJCWQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qTfV831y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBAPJCWQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E049374187
	for <linux-integrity@vger.kernel.org>; Wed, 28 Jan 2026 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632304; cv=none; b=PX/8vkWs6/qeNlaX0b2qOuQBs+o+evQA2zUtqHr6m2RPuobeDRlNeq3muyCGrRHR4yB/Do1ZGi8vXAJ7xYBa+cWeQJO6Qk1bduCGIdUPDeqO6yqFF8MTbP9v88HGHWxTSQr5HAOS8A3CLTpMbQvyVCvyKHb+loYDqZ2kUsHMb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632304; c=relaxed/simple;
	bh=lnktyH+W2ekE7nho6n79QngMRGR2PdL8nesukS87yW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti4jcajZEVJn++6MFSK8BBS5aKWKaumwxn95uFsBuwP/0pQL9J6bJ11F3QUSC5B7/wX7lk0+s9c/IyCbFYYn0JAi2DK329vjhap5m5ugVfZoqeGzVTRkbY8yyIbPn6w1v7Mn8eiYQRy7rcc4XUm6bAFjZfbvWbM/zxCHGOJd3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qTfV831y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBAPJCWQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qTfV831y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBAPJCWQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F8D733D88;
	Wed, 28 Jan 2026 20:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769632301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnktyH+W2ekE7nho6n79QngMRGR2PdL8nesukS87yW4=;
	b=qTfV831yZMBHGA2SV/Xto20QW7TvYbxm3KH+bDH88i9u7/xiTQOtiIZc/WQWCxOzfDRTw9
	xLk7Kqqby8PKKNB4OpXMf7bHkWCsg5Y1KiHoHK3fF2WJKDXzA8wjT0D92VbtCWIUynUupZ
	nYaZ6DIcAPbTJ4DeOypwMqLSyZtjsXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769632301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnktyH+W2ekE7nho6n79QngMRGR2PdL8nesukS87yW4=;
	b=TBAPJCWQDGBZ0Ken86wJaUVbqOrLr4AXStoa+nP5WJxAiXJtT/0uV240uSuskjkmZ8j5Zu
	FA2iZHw/HH5fz9Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769632301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnktyH+W2ekE7nho6n79QngMRGR2PdL8nesukS87yW4=;
	b=qTfV831yZMBHGA2SV/Xto20QW7TvYbxm3KH+bDH88i9u7/xiTQOtiIZc/WQWCxOzfDRTw9
	xLk7Kqqby8PKKNB4OpXMf7bHkWCsg5Y1KiHoHK3fF2WJKDXzA8wjT0D92VbtCWIUynUupZ
	nYaZ6DIcAPbTJ4DeOypwMqLSyZtjsXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769632301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnktyH+W2ekE7nho6n79QngMRGR2PdL8nesukS87yW4=;
	b=TBAPJCWQDGBZ0Ken86wJaUVbqOrLr4AXStoa+nP5WJxAiXJtT/0uV240uSuskjkmZ8j5Zu
	FA2iZHw/HH5fz9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AB733EA61;
	Wed, 28 Jan 2026 20:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MWbVGCxyemnGWgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 20:31:40 +0000
Date: Wed, 28 Jan 2026 21:31:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
	Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH] ima_setup.sh: Fix signed policy requirement check
Message-ID: <20260128203133.GA55393@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260128125852.37411-1-pvorel@suse.cz>
 <daf396f955b3aec1802fc99a464b94a947a7c1d0.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf396f955b3aec1802fc99a464b94a947a7c1d0.camel@linux.ibm.com>
X-Spam-Score: -7.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8353-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DMARC_NA(0.00)[suse.cz];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvorel@suse.cz,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[pvorel@suse.cz];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: B93D9A89ED
X-Rspamd-Action: no action

Hi Mimi,

...
> > ---
> > FYI Fix needed before the release.

> Thanks, Petr!

> Tested-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks a lot for testing, I really appreciate that!
Merged.

Kind regards,
Petr

