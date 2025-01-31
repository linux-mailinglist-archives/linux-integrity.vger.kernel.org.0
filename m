Return-Path: <linux-integrity+bounces-4684-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF9A241E3
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 18:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E20B188ACB5
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20BC1EE7D6;
	Fri, 31 Jan 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zm05Y1Dz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JNwRn0E9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zm05Y1Dz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JNwRn0E9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0078B136351
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738344494; cv=none; b=UrUJSXoq2ifIp+MExAAF+A95omrcnbeqpsohFZXlsjLbLBPgRyCiuV1WgjR86D1L8Ad34qqmhxR04KzGRpql+AYfIEj6d+XynXlfsBRZCFARC/+JRJc9KXBWQJV4Bnmvx5W0I+oQf/4/rs568hXHTaXVKXoKd0kP71YvCkLm84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738344494; c=relaxed/simple;
	bh=ZnAQgl2RTfJ4s7mPt9FPkT6/OsE8hB4yegfHuZ6mlEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJTQqYEJriSGx+M2mRhcCQRb9eMh5UdA/gKTdRd6Z4wWPPDl3MnO6vk38fSa84UXQtH8gqrUpJzqRl118d7WfgX7X7niQs9pah40KddE8s/zQ88DP9AnYBHW91+905XKZDptW4WMjk2MEzX8JZ5HqAtZjhxAt5+xrjCgsnm3tJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zm05Y1Dz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JNwRn0E9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zm05Y1Dz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JNwRn0E9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 119D72119A;
	Fri, 31 Jan 2025 17:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738344491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFweyumVl0UFGap8tnMoIOL9WPNpFZ2SOHLM95wAIac=;
	b=Zm05Y1Dzkf9OnUhhO6otojFCI/+WM2p3tEj7kFOzJTZJiPq+dqZIb6yL0l6WdIZc5osF53
	6GPt9xOIDy/jVVyBxv4Kfr/4/XENN9vqL89eN/Ud2eFRZA+eqoyOaf1X5e/FUuojOM+GOZ
	Jpai7GlSRbyCqMZA/m4kpURfdXT4nNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738344491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFweyumVl0UFGap8tnMoIOL9WPNpFZ2SOHLM95wAIac=;
	b=JNwRn0E9Xdakcuz9+luXxp0GaqWyvRlPrLPYHx0HbsetKz8oe8KB51JNHEyCDoC2jaVT78
	2CxOqFfe2J1HKtAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738344491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFweyumVl0UFGap8tnMoIOL9WPNpFZ2SOHLM95wAIac=;
	b=Zm05Y1Dzkf9OnUhhO6otojFCI/+WM2p3tEj7kFOzJTZJiPq+dqZIb6yL0l6WdIZc5osF53
	6GPt9xOIDy/jVVyBxv4Kfr/4/XENN9vqL89eN/Ud2eFRZA+eqoyOaf1X5e/FUuojOM+GOZ
	Jpai7GlSRbyCqMZA/m4kpURfdXT4nNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738344491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFweyumVl0UFGap8tnMoIOL9WPNpFZ2SOHLM95wAIac=;
	b=JNwRn0E9Xdakcuz9+luXxp0GaqWyvRlPrLPYHx0HbsetKz8oe8KB51JNHEyCDoC2jaVT78
	2CxOqFfe2J1HKtAg==
Date: Fri, 31 Jan 2025 18:28:09 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z50IKdYe42_n2B0b@kitsune.suse.cz>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
 <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, Jan 31, 2025 at 07:12:06PM +0200, Jarkko Sakkinen wrote:
> On Fri Jan 31, 2025 at 3:02 PM EET, Michal Suchánek wrote:
> > It looks like the timeout_b is used exclusively as the ready timeout *),
> > with various sources of the value depending on chip type.
> >
> > Then increasing it should not cause any problem other than the kernel
> > waiting longer when the TPM chip is really stuck.
> >
> > * There is one instance of use of timeout_b for TPM_STS_VALID in
> > st33zp24_pm_resume.
> 
> Possible for you to give a shot for patch and try it out for a while?
> I'm fine with 2x, or even 4x in this case.

I will see what I can do. It will definitely take a while.

How would you like to multiply it?

At the sime the timeout_b is assigned, or at the time it's used?

Any specific patch that you have in mind?

Thanks

Michal

