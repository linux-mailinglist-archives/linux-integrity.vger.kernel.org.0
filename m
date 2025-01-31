Return-Path: <linux-integrity+bounces-4674-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD1A23B6A
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 10:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E4C37A1091
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9BA166F0C;
	Fri, 31 Jan 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nXz5HlNk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zgU7Whk6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hGBVy8fe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Qq7RuSS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C114B092
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738315590; cv=none; b=LHCHOJFQY18MUzNtRm1o9WiO3TqMusIZaOqryyvY6mb0Y2Jx5N04ZO9OVH/5vXER/yKfB8xFD6ht3RpKONFYQQnuYoUC7B3YlvhL+kVveT2nyzMsnMhnHbVaenPS4fWXzjfWrw3g++EgT4pHZBIssf5FmjTJP9ctLrN58TW+kxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738315590; c=relaxed/simple;
	bh=6VXpURCd4JsIXcJzDDVWwTwAk7axS3HE1ZSaSzeufTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTCdrUMj2rH/8vlaIDq/q2JIZP7gXUYTr0UhLkU3qu0qiJT5hGtgKcIv/vHoScZB+ZmOB5u1OiaSiueYyXdWxpRMoSlpkMWpauBnurnwiPN9n5G80NH8BbMvvymI9AHPctIrHaI9IgJiQoG7FsBKgWB4UG+BQXC5czg1q0Rt7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nXz5HlNk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zgU7Whk6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hGBVy8fe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Qq7RuSS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA9631F38E;
	Fri, 31 Jan 2025 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738315587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLwDXM4QsqjnYzrt6MoAZiFEkuYmPSVvjGBWXQ0037c=;
	b=nXz5HlNkS2eCFiw9ZRXRt1BSxh5brMRLkqxwbJ2ySv1grXzaYfND+hjB3zWag045ObXfm7
	hged1hd3aaLUs9JXBmS3V9Us8q86sj3cXLqqxea/5fW3pxqj0yh5UeKOe2BU+6m0/MnLTe
	s7h4tXQyA4zyLzWSv8m4o/fN0L4BT7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738315587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLwDXM4QsqjnYzrt6MoAZiFEkuYmPSVvjGBWXQ0037c=;
	b=zgU7Whk6BJY/j+0/eBEzpmt8Ef4elloPIWlf82CZS7bSpwHx5HaAZsGH94O2q34cZ5+oMv
	YU5Gg1ZIBMIkUuAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hGBVy8fe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5Qq7RuSS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738315586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLwDXM4QsqjnYzrt6MoAZiFEkuYmPSVvjGBWXQ0037c=;
	b=hGBVy8feFsaTF3aHPBr/ba6a5M28a9pU2EMd3zzLQDWeRhX463IIffcUROR9l7jDe5z184
	2feJ+2azoavH7hEvrcI/rq0kEkXjEl/Q8t1x7ec8cazeQ7mZfC1bgcjzvGuDXDmKV4OsFY
	uzSHpTE0hK36nGLXyZxpRJUqmyY6R+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738315586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLwDXM4QsqjnYzrt6MoAZiFEkuYmPSVvjGBWXQ0037c=;
	b=5Qq7RuSSmn4mjgOdjg3VvtHApX6jDdDslTxy3LaUVx3UPfYTUeqAlG2UktCcDYX4mB4rtS
	g/a1Tcg1wjyayzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B07051364B;
	Fri, 31 Jan 2025 09:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B68TKkKXnGd5HAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 31 Jan 2025 09:26:26 +0000
Date: Fri, 31 Jan 2025 10:26:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH v3 10/10] tst_test.sh: IMA: Allow to disable LSM
 warnings and use it for IMA
Message-ID: <Z5yXNjKBRwj2ed4s@rei.lan>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-11-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114112915.610297-11-pvorel@suse.cz>
X-Rspamd-Queue-Id: CA9631F38E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi!
Maybe a bit more description wouldn't hurt here. E.g. that we are
printing a hint on a failure that selinux or apparmor may have caused
the failure and we want a knob to disable it and use it for IMA.`

Otherwise it looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

