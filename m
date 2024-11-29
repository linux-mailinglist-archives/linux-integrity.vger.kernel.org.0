Return-Path: <linux-integrity+bounces-4254-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C9C9DC218
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Nov 2024 11:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62945B22C5C
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Nov 2024 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52918189BB5;
	Fri, 29 Nov 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h70cE5i3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RfnZEXkh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h70cE5i3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RfnZEXkh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5418A6AE
	for <linux-integrity@vger.kernel.org>; Fri, 29 Nov 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876052; cv=none; b=XLKIo7ZPdyZgjRq8y09a50IrNi19TDs4KFGyXbYZBY2rvOGCjbBa1E78MPvnNjox2Wsg1+k3RXe/Wvz0WLPrJwDk9mk9HmpKFj4soatnwYyWT8KMijsh0tLd0XVOOmaWpOciLHmBSHXmE2gzrjX728z3EKYPE4TfHivycrS8gIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876052; c=relaxed/simple;
	bh=nnMRgCcMsy0XVCvYyqZ2LeORJjiOxK20yBclBAgOTQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFuxFJV9KotWlp6u3jB9jB0VDZYCFqQOTFRkUZEiUYGXuwHANwETzXDi+WQdENBKjFs0SrCfbqFDUipNnFu3f3pbje4NhZGCBqQnPEJ2kZKasiMviKAycujWkyEQOHS5IqJdD1Y4YqI3/rZKrakUXxi4j9PjUEHwvmxnHNY2sLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h70cE5i3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RfnZEXkh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h70cE5i3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RfnZEXkh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88DA021187;
	Fri, 29 Nov 2024 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732876048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vT+YEN7lAe1lu8HQ11yAJLbXlTjEL9RoTyHP977Rchc=;
	b=h70cE5i3KQPyu95w8mkjG7tzHBOVH9G2Y3oeAa+r7cCkKrEtfU0azdwJ+QnFrjIHKdgacl
	6P7vW0HHWCljnjMlVoI0Km3HO7dDUp/xSUmaiedoviBs2hRHdinskbDpDsuxeMXbBveaZo
	nNsOXIpDtiSFF+vQroPXLh/sIPP4TK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732876048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vT+YEN7lAe1lu8HQ11yAJLbXlTjEL9RoTyHP977Rchc=;
	b=RfnZEXkhhgIQis2BMUeaH86IMl1GgZL1htlkePRCxRRinpKojRYdmLSeuYNqK0Ll6a0V10
	yhtsDQkfmDQNJLCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732876048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vT+YEN7lAe1lu8HQ11yAJLbXlTjEL9RoTyHP977Rchc=;
	b=h70cE5i3KQPyu95w8mkjG7tzHBOVH9G2Y3oeAa+r7cCkKrEtfU0azdwJ+QnFrjIHKdgacl
	6P7vW0HHWCljnjMlVoI0Km3HO7dDUp/xSUmaiedoviBs2hRHdinskbDpDsuxeMXbBveaZo
	nNsOXIpDtiSFF+vQroPXLh/sIPP4TK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732876048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vT+YEN7lAe1lu8HQ11yAJLbXlTjEL9RoTyHP977Rchc=;
	b=RfnZEXkhhgIQis2BMUeaH86IMl1GgZL1htlkePRCxRRinpKojRYdmLSeuYNqK0Ll6a0V10
	yhtsDQkfmDQNJLCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73E70133F3;
	Fri, 29 Nov 2024 10:27:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QNE6GxCXSWcmZAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 29 Nov 2024 10:27:28 +0000
Date: Fri, 29 Nov 2024 11:27:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: xiubli@redhat.com
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH] doc: correct the build steps for
 open_posix_testsuite
Message-ID: <Z0mXHSnqmstCIMrF@yuki.lan>
References: <20241119101357.951813-1-xiubli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119101357.951813-1-xiubli@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi!
> './configure' is needed just before generating the Makefiles.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  doc/users/quick_start.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
> index 1581b1f0c..e80c1c244 100644
> --- a/doc/users/quick_start.rst
> +++ b/doc/users/quick_start.rst
> @@ -54,6 +54,7 @@ generated first:
>  .. code-block:: console
>  
>     $ cd testcases/open_posix_testsuite/
> +   $ ./configure

That should be before the 'cd testcase/...' otherwise good catch, this
is clearly missing there.

>     $ make generate-makefiles
>     $ cd conformance/interfaces/foo
>     $ make
> -- 
> 2.46.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

