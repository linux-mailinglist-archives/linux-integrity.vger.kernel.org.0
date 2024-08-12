Return-Path: <linux-integrity+bounces-3310-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C964294E61A
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Aug 2024 07:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D293F1C207BF
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Aug 2024 05:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228CF5FBB7;
	Mon, 12 Aug 2024 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uLwgQWe5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CLohDBdD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uLwgQWe5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CLohDBdD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721A4D8CE
	for <linux-integrity@vger.kernel.org>; Mon, 12 Aug 2024 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723439826; cv=none; b=FyrA6nV0pfgodc1o2ResrmgLXZ3MEjH6uzfMxSzxjH2jWMi5ljX+tIyFib3VOvLyvKPWB8WAm0zbcYESfsTHmdy0aYkY2MG2soGEFTsJdM9cOWnVzYcjWWJvJrrV4s5Y4mUwMJnhI155mftThbU15sGmQGLZwyIAfkbtpwNBlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723439826; c=relaxed/simple;
	bh=AsbNvrlkkHQrO07PvuGculnUcPhbQtVrYbU8G8vuBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr1lUivbFPGA2LXK8hP+oBBcjreWGcvh2kFA75aIrQay8P0z1K6YpWM/wj0DZhpOWs/Ln5/+PO4CEIN31eqj59bOkqJFhJKW0GZwzdbSTZCzxC8YY2iYW/0dPVLyeJKRhrY/e3M8qFcOD+kvLjbHvkbTOKZH88RIJP68KqFT7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uLwgQWe5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CLohDBdD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uLwgQWe5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CLohDBdD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95BCE222E1;
	Mon, 12 Aug 2024 05:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723439821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdBBIUVWpfUrsxbuH/2vU7qo4vzTNlY8/0INw+jh7PQ=;
	b=uLwgQWe5cLVJMLl4sl9+/d0B6qL2KItmiOPeT+bIlnJICxMoE8fLXaWmzbbIKHe4z8A+Mk
	5awBoRJiluwAMZRjjFM0AIpxlyNx5KXfzsCrMAVOIXIKBMooMCcmYUMwm4supqpLfuLY83
	DHYV9Vgew4ctAcwGq42NPsrMzfbYMus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723439821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdBBIUVWpfUrsxbuH/2vU7qo4vzTNlY8/0INw+jh7PQ=;
	b=CLohDBdD0kyfeEM/9V4E1Zp5IqN/BQ4mhJgoM2iE1rL3ZS5O9Ne0Naq9Mj3Z558rI++8JY
	IxGqfCLGEwh866CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uLwgQWe5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CLohDBdD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723439821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdBBIUVWpfUrsxbuH/2vU7qo4vzTNlY8/0INw+jh7PQ=;
	b=uLwgQWe5cLVJMLl4sl9+/d0B6qL2KItmiOPeT+bIlnJICxMoE8fLXaWmzbbIKHe4z8A+Mk
	5awBoRJiluwAMZRjjFM0AIpxlyNx5KXfzsCrMAVOIXIKBMooMCcmYUMwm4supqpLfuLY83
	DHYV9Vgew4ctAcwGq42NPsrMzfbYMus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723439821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdBBIUVWpfUrsxbuH/2vU7qo4vzTNlY8/0INw+jh7PQ=;
	b=CLohDBdD0kyfeEM/9V4E1Zp5IqN/BQ4mhJgoM2iE1rL3ZS5O9Ne0Naq9Mj3Z558rI++8JY
	IxGqfCLGEwh866CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71828137BA;
	Mon, 12 Aug 2024 05:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vpc2Gs2auWbAaAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 12 Aug 2024 05:17:01 +0000
Date: Mon, 12 Aug 2024 07:16:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
	Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [ima-evm-utils PATCH] Add copies of the license text
Message-ID: <20240812051656.GA385161@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240808212349.246633-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808212349.246633-1-zohar@linux.ibm.com>
X-Spam-Score: -3.71
X-Rspamd-Queue-Id: 95BCE222E1
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,huawei.com,gmail.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

Hi Mimi, Peter,

> Add copies of the license texts so they're distributed in the tar files
> for offline viewing.

> The GNU license associated with the the SPDX License Identifier GPL-2.0
> and GPL-2.0-or-later is the same.  Restore the COPYING file from
> https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.

> Add the GNU license associated with the SPDX License Identifier
> LGPL-2.0-or-later as COPYING.LGPL from
> https://www.gnu.org/licenses/old-licenses/lgpl-2.0.txt.

> Note: While removing the file specific licenses and replacing them with
> the SPDX License Identifier, the special exception for linking with the
> OpenSSL library (WITH cryptsetup-OpenSSL-exception) was removed.  With
> the relicensing of OpenSSL 3 or later to the Apache 2 license, the
> special exception is no longer necessary.

Thanks for restoring these files!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Fixes: 6adc50f68202 ("Change license to LGPL-2.0-or-later and GPL-2.0-or-later")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  COPYING      | 339 ++++++++++++++++++++++++++++++++++++
>  COPYING.LGPL | 481 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  LICENSES.txt |   4 +
>  3 files changed, 824 insertions(+)
>  create mode 100644 COPYING
>  create mode 100644 COPYING.LGPL
...

