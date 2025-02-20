Return-Path: <linux-integrity+bounces-4939-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C67A3E3DA
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C408702DC6
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C221517C;
	Thu, 20 Feb 2025 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WE2wsBHh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pDmb5xtY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WE2wsBHh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pDmb5xtY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56A21507D
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076075; cv=none; b=KiFG7GHdfhEVE/twX44uGWgMw2IBGNoMERGi35TATEc3iMrTj6l4qIrEeh6lDrAObUtv5xk8RGxfnzLXm0uPfpndQEgvohYdMy59T30WdQVdmiY6Ja8VXr0u65Sr0rWsmdRLiFUe+ugbQI75XeWVOfUyO4kDMeEEC1iveiu0N1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076075; c=relaxed/simple;
	bh=i6rGVzw2biDphNU7VhsqzecLA0odGcBhSZM/RtioZ00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVSElkh23cOT9H0md7GWoxb9blzB4HPeK1I69CpmNwoN+sbQtlUUvPVxcZcCglY7c3eLvsDblg8DvpuspOO6FM6XnmP8TmHyS/l3ETRqGwUvE2owq5MWmzGSwKTeWEc0Ffp71gRn37z4eH9buO7bgVg15vcT0zCinyqtEqsFkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WE2wsBHh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pDmb5xtY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WE2wsBHh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pDmb5xtY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 210FF21181;
	Thu, 20 Feb 2025 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740076072;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6rGVzw2biDphNU7VhsqzecLA0odGcBhSZM/RtioZ00=;
	b=WE2wsBHhr5KmnRmYLbJOc5+QflRKBK3nEW37IQOlluxKWNSLPmF47wscgbxerYUbc3uoUt
	p/cMbCqmmVSKl3tuAc5jWsRvJFi85MtigwgbBeLPOTa59IMzvBW234xxSbGWt/m+h9M7+j
	eQs/KR0KW6s55HCaqKO1FMJA1uxGNng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740076072;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6rGVzw2biDphNU7VhsqzecLA0odGcBhSZM/RtioZ00=;
	b=pDmb5xtYf8eIMkIHG8dDwGyB/B3lcizc33BEr4lNx6fPuStaufuq4jrX7HxXSQ8JYY1OyQ
	5CDuBgqYc8igiWBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WE2wsBHh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pDmb5xtY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740076072;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6rGVzw2biDphNU7VhsqzecLA0odGcBhSZM/RtioZ00=;
	b=WE2wsBHhr5KmnRmYLbJOc5+QflRKBK3nEW37IQOlluxKWNSLPmF47wscgbxerYUbc3uoUt
	p/cMbCqmmVSKl3tuAc5jWsRvJFi85MtigwgbBeLPOTa59IMzvBW234xxSbGWt/m+h9M7+j
	eQs/KR0KW6s55HCaqKO1FMJA1uxGNng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740076072;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6rGVzw2biDphNU7VhsqzecLA0odGcBhSZM/RtioZ00=;
	b=pDmb5xtYf8eIMkIHG8dDwGyB/B3lcizc33BEr4lNx6fPuStaufuq4jrX7HxXSQ8JYY1OyQ
	5CDuBgqYc8igiWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB90D13A42;
	Thu, 20 Feb 2025 18:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zsChNCd0t2enKQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 18:27:51 +0000
Date: Thu, 20 Feb 2025 19:27:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima: limit the number of ToMToU integrity violations
Message-ID: <20250220182746.GC2709977@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
 <20250219162131.416719-3-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219162131.416719-3-zohar@linux.ibm.com>
X-Rspamd-Queue-Id: 210FF21181
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi Mimi,

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

