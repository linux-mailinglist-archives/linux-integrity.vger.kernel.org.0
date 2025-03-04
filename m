Return-Path: <linux-integrity+bounces-5074-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C451A4EA6C
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 19:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0328F7A3AE9
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D122E3368;
	Tue,  4 Mar 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xeNCDDs3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="se7dNW2W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xeNCDDs3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="se7dNW2W"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818527BF70
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110228; cv=none; b=hrXqVSnHVrT2e1V3T1JfrMEiDOQd2bkA7fu5a8l2FFBRehnKEKFjOkaHV/ZKNZWS6y5ibM2tp+cyU7ldD2KqciJlaITl1+UKTd5Y3M6bmj3UfhaAAVO1VKq3AUvl9l+607j5KlDSGJhMKe8wJjo/oDvxt8dIA7Kf4XEiZ20ZRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110228; c=relaxed/simple;
	bh=wRz8PDlQEnBAoGjSE8WiVs13vPxJ6QgfY5BP20z9I0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N55F0KiXxV/9tytsIib9F+dYRySXCfVFOzMDjVY5xiE9qhEZVUBDAghzUXWPSFGNfHEMhTaAPz0hTQQhi3SatSw3ahxkjVR+cRE95GitKvSsQ3YM0zHNjeeLePpYnpNFrEMj5hMdvyj7z9KIzJ8fhQFatR6lagg6VCEF8kr7uD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xeNCDDs3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=se7dNW2W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xeNCDDs3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=se7dNW2W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B2FD1F456;
	Tue,  4 Mar 2025 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741110224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eB0kFmZ1ba8iiUIFBYCBKE7udjSI3kpPf37ki3Fbwcg=;
	b=xeNCDDs3HlYQ6d+5/EwiLmJJtvSCTsyMRXHwCailt4BuaEOCIhgIcc9znNsoIF9eUbY+JN
	zrulqkQJxqwO8R4CMhSTyVO7Bo1jymMYV9bRACvn7ZbR4xVr7HFIw06z2CuCnmkYKf9dB3
	lf7CcJOmuLFKpOW840NtnqaLmuJBWtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741110224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eB0kFmZ1ba8iiUIFBYCBKE7udjSI3kpPf37ki3Fbwcg=;
	b=se7dNW2WMHrH4vZem2bva8uQZCU7wIvDcSelRa+vHK3MO7wOWGKqKywKUi0ibhBz65vbcH
	UzoU9BVFfoFjGGBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741110224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eB0kFmZ1ba8iiUIFBYCBKE7udjSI3kpPf37ki3Fbwcg=;
	b=xeNCDDs3HlYQ6d+5/EwiLmJJtvSCTsyMRXHwCailt4BuaEOCIhgIcc9znNsoIF9eUbY+JN
	zrulqkQJxqwO8R4CMhSTyVO7Bo1jymMYV9bRACvn7ZbR4xVr7HFIw06z2CuCnmkYKf9dB3
	lf7CcJOmuLFKpOW840NtnqaLmuJBWtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741110224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eB0kFmZ1ba8iiUIFBYCBKE7udjSI3kpPf37ki3Fbwcg=;
	b=se7dNW2WMHrH4vZem2bva8uQZCU7wIvDcSelRa+vHK3MO7wOWGKqKywKUi0ibhBz65vbcH
	UzoU9BVFfoFjGGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF99213967;
	Tue,  4 Mar 2025 17:43:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CtpuNc87x2dccAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 04 Mar 2025 17:43:43 +0000
Date: Tue, 4 Mar 2025 18:43:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ima_violations.sh: Update validate() to support
 multiple violations
Message-ID: <20250304174342.GA97130@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
 <20250304115331.524842-2-zohar@linux.ibm.com>
 <20250304133101.GC81126@pevik>
 <678478de87319625e591e8e956a57b31c700bbd2.camel@linux.ibm.com>
 <54cf5311ec5e0debd6dfd63669e8d01883c0ba23.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cf5311ec5e0debd6dfd63669e8d01883c0ba23.camel@linux.ibm.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

> On Tue, 2025-03-04 at 09:44 -0500, Mimi Zohar wrote:
> > On Tue, 2025-03-04 at 14:31 +0100, Petr Vorel wrote:
> > > Hi Mimi,

> > > > Add support for the number of expected violations.  Include the
> > > > expected number of violations in the output.

> > > Unfortunately this works only on fixed kernel (e.g. the one with v1 of your
> > > "ima: limit both open-writers and ToMToU violations" kernel patchset [1]
> > > (I haven't built v2 [2], but it's really just
> > > s/IMA_LIMIT_VIOLATIONS/IMA_EMITTED_OPENWRITERS/ => it will work)

> > > Testing on any other kernel it fails on first testing after reboot:

> > Hi Petr,

> > I only tested by specifying the "ima_policy=tcb" on the boot command line.  This
> > failure happens when loading the test specific policy rules.  If setup() is
> > called before loading the test specific policy rules, forcing the $LOG file
> > violation at setup() would be too early.

> Sorry, that doesn't seem to be the case.

> With the changes to validate(), even the original tests will only work on a new
> kernel.  I'll rework the patch set, so at least the original tests will continue
> to work.

+1, thank you!

Kind regards,
Petr

> Mimi

