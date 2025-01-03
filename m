Return-Path: <linux-integrity+bounces-4507-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4121CA008FB
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 12:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D147A1981
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F121EE028;
	Fri,  3 Jan 2025 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3c5lyE3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3IQdQoCP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3c5lyE3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3IQdQoCP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD91B87FA
	for <linux-integrity@vger.kernel.org>; Fri,  3 Jan 2025 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735905477; cv=none; b=aKxz03rBOj3VC23Z7KwIB0grC+/XIOxbBgOq9dlTTqf/o3K3xLnNxKR8kIxtiWxFScPsPdrudHJxrKkBQ1ve6C0gtsBqw72PtmhEaY9ut5Cr8u7FxpYOhATQkk9POmNNxPkUtt/A+Nt5uaV+Qo2tyBqADWcKErq5/679BxZRSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735905477; c=relaxed/simple;
	bh=GgHaTZ7q7yccp8DFsqgAciSefLxzOMs3cbe1fTCO52o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/6rhG1/j+VBU0CGfqLVrcZCY1hvBfCa8yjj1WxOLR/mU4GLt6+gbQcHSchJKkxEHO0DQv/iv/atk8M28XRiYprJ2ljD6XXcA8fisa+FU+mtyyXTQWWoNwZuOdmyI61y183gC866PNWlMuOeIwpAeVDpQLF1z4SfadEDtnqVNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3c5lyE3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3IQdQoCP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3c5lyE3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3IQdQoCP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83A821F394;
	Fri,  3 Jan 2025 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735905473;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgHaTZ7q7yccp8DFsqgAciSefLxzOMs3cbe1fTCO52o=;
	b=3c5lyE3kn3BbeEA0fgMxApXt5p90nO/9zUWYJs5sTDsI5jVQZuorm+zao6lgRCAQkOvJcg
	hxotTfiGUMU2iXlqg8PjN3qIGCAVfmeiIGXlEgmS2Y0Xri2uCE2d3ZGCxeiBovNzuKxD8O
	hEFz0zjx34vS1INRP/z8ZelqAZYPN10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735905473;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgHaTZ7q7yccp8DFsqgAciSefLxzOMs3cbe1fTCO52o=;
	b=3IQdQoCPfy3axChVybp40e+DrDSJ/iX3F5ZhcWxHo+jZBDaaZXefvbpWqoaNohPCNRcEPW
	LaAAzWOSwugHnhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735905473;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgHaTZ7q7yccp8DFsqgAciSefLxzOMs3cbe1fTCO52o=;
	b=3c5lyE3kn3BbeEA0fgMxApXt5p90nO/9zUWYJs5sTDsI5jVQZuorm+zao6lgRCAQkOvJcg
	hxotTfiGUMU2iXlqg8PjN3qIGCAVfmeiIGXlEgmS2Y0Xri2uCE2d3ZGCxeiBovNzuKxD8O
	hEFz0zjx34vS1INRP/z8ZelqAZYPN10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735905473;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgHaTZ7q7yccp8DFsqgAciSefLxzOMs3cbe1fTCO52o=;
	b=3IQdQoCPfy3axChVybp40e+DrDSJ/iX3F5ZhcWxHo+jZBDaaZXefvbpWqoaNohPCNRcEPW
	LaAAzWOSwugHnhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F16F134E4;
	Fri,  3 Jan 2025 11:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CRC8EMHQd2dINQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 03 Jan 2025 11:57:53 +0000
Date: Fri, 3 Jan 2025 12:57:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/8] IMA: Add TCB policy as an example for
 ima_measurements.sh
Message-ID: <20250103115743.GA211314@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-2-pvorel@suse.cz>
 <fa7b251e0b7966e9d32117996f4ae8390bc4f6cc.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa7b251e0b7966e9d32117996f4ae8390bc4f6cc.camel@linux.ibm.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

> Hi Petr,

> On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > Taken from IMA docs [1], removed dont_measure fsmagic=0x1021994 (tmpfs)
> > as suggested by Mimi.

> > [1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> After thinking about it some more, anyone interested in constraining the
> "measure func=FILE_CHECK" rules based on LSM labels to avoid integrity
> violations would need to reboot the system anyway. [1]

> For this reason, please include the new dont_measure tmpfs rule as proposed in
> "[PATCH] ima: limit the builtin 'tcb' dont_measure tmpfs policy rule". [2]

Sure, I'll add in v3:

dont_measure fsmagic=0x1021994 func=FILE_CHECK

Kind regards,
Petr

> [1] Integrity violations -
> https://ima-doc.readthedocs.io/en/latest/event-log-format.html#template-data-hash

> [2]
> https://lore.kernel.org/linux-integrity/20241230142333.1309623-2-zohar@linux.ibm.com/

> thanks,

> Mimi

