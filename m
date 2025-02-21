Return-Path: <linux-integrity+bounces-4958-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F030A3EE83
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 09:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A778A19C5A76
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFF11D95A9;
	Fri, 21 Feb 2025 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uQpaUFH/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RC9wmSh8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eUd0dNxW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ozr8y+AC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC21FBCBA
	for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125892; cv=none; b=eGExV9ldrVrPTA1zm5r19W0ZuhWqjgxVqg35hbJCfL/qja2QGRtRvIUKEF930bov101s8pZM+yRJ6QtRLtwFO0AjTtpOT86v+NzG3JXFF28Q0/1w23Fm5egwtNhZM2RCMmc1sQ2Be1/FP0WTyB8jn2GGuF+T8dBMMWhslF5Acfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125892; c=relaxed/simple;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JInbQTJZ2/cqysAYI4aE+gV5uTzs12QAS76LEYTHS2nGNQSPACtv/OiL64VkyF0dZiy8GnPJZVsv6BV9HhA0lpM1VGSXLH9aq5Z0GnY0+QWytFyEYYKTEjlwwK2asvugb4zikPAwO8Xt5HDluiPhd+/M7aSqN7Tc2z50kEJJXAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uQpaUFH/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RC9wmSh8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eUd0dNxW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ozr8y+AC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E75891F385;
	Fri, 21 Feb 2025 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740125888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	b=uQpaUFH/tR3TRJUsxfYMWbOkCZAjZHrB9pLcmZZLIkGvjE+JkqqJmHBWqBn3V6IDq9BZnz
	Vg7vSoy0HS454ui8Ta16XNydfUvs4x4MtFXte8YE9D2bZ3OQ0u1aihDu2kH39AHdyaFHdy
	FQT3fqZUSmtwwGUzef+eUgxkmrCjxlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740125888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	b=RC9wmSh8zn72h1R1V9Jl3vDCDCn9jWOcrvpy5MehXzwsmprc65CSId4N80tCYepmAixI21
	DiNOCe3u+ka0HuAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eUd0dNxW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ozr8y+AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740125887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	b=eUd0dNxWykYpKiZSFfesOmAcMtQkKBzPUlaYGYQTg7jD8qiYUZnCGPUUMmxlLX95f65G31
	C5WgDVbzUT2n3Ew4E/bTr3CvAsbaI24JleEERKnSljl9vdwzQA/EIeOtQoQc/i09ze2ZBd
	Jzle4JcF39OlQyEW5h6sUCq6qZ5YITE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740125887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIUeMi24we3zPSf+XSLnf0c2RGLUCpOHtvU8SCUc04E=;
	b=Ozr8y+ACG70yETr2qIEL5GVAbGi/LKoaxZH0UGy1wV/x9MoSNU7oGw84ICZRaPbcb7RMSQ
	ecp8HjsBd3BzGECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B562B13888;
	Fri, 21 Feb 2025 08:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MZ3aKr82uGc7DgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 08:18:07 +0000
Date: Fri, 21 Feb 2025 09:18:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 1/2] ima: limit the number of open-writers integrity
 violations
Message-ID: <20250221081806.GB2739743@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
 <20250219162131.416719-2-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219162131.416719-2-zohar@linux.ibm.com>
X-Rspamd-Queue-Id: E75891F385
X-Spam-Score: -3.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

