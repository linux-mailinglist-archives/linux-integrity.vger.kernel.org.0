Return-Path: <linux-integrity+bounces-9388-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nOM8IeYa82kLxQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9388-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 11:03:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE649F971
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 11:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5700F300681C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA26219EB;
	Thu, 30 Apr 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yVwMzFIh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O3/C3SEe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g7XGpBs7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RP8m4pIj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619040DFA4
	for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539805; cv=none; b=eBG1U9C2JkyDH8mc77QO5Wz/I2pPahOq1Cb4sA8jLXimt/bFBKoMAZbrcyslAdlreT2iQMDbH+Lm+/4gLHkunZamKXAcmbJqMZxBOThNHEAjkiw2m4GzoeFDuAQGKiauiAv/HCOvpDYhcJ8PFWJ4xAF4eNpdfGWHCLKAmstESDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539805; c=relaxed/simple;
	bh=wNVmsq8FP+E1BSnOh5czhMvXvVm2pfwcKCybLMZg4nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9kW21ePA+BGwJSeu2cScvfrl40jTctdZDjFHf4TmhorKHJ1HQhw2LgSIa/Nx13lua/YQmr4HH6VGklBSppwwYyjuU+E+pFhr+rKnXO1xZdVntIT9giznFsLpD1nHrOA2doelvcALsMr4k6kHZSsrixxRCcWD77SyG2prKoK4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yVwMzFIh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O3/C3SEe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g7XGpBs7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RP8m4pIj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC9616A7CD;
	Thu, 30 Apr 2026 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777539802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wuWeK+49G8+gltjgEPrQvgzUIRCbjLPmBVFt1uvHX0U=;
	b=yVwMzFIhX0Ow1kF6JjM60N1k5m2YM670YIKKyIcZxCTPVOaZ8CObLYr/KQ/0QJBntF1yV5
	uXaE2VHzdLHnAAUMwfbd9kFw4v2aA09XKFhzdJEyCEOF/YNfyYvzjum16hkuVjdv/jWlRG
	42+2QxL0g94kZ7AicepDS8vlZ+gGnIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777539802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wuWeK+49G8+gltjgEPrQvgzUIRCbjLPmBVFt1uvHX0U=;
	b=O3/C3SEeLJgaGO5xh12XADFX1ijvd9C9J82gw28bNPrRKTXqzHAiLfDLwuOB4+2ycJ97wS
	j8Ua1wYuG6tiXLBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g7XGpBs7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RP8m4pIj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777539798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wuWeK+49G8+gltjgEPrQvgzUIRCbjLPmBVFt1uvHX0U=;
	b=g7XGpBs7JMOvXquiahV237RjXaZqDaPKS+dbINuH10LQ1RcN884g6b7QVIxeABoZ51+Xil
	XH0qZMzzgsD+iFlwQS3rwlXHbaFwgT2XUkFtwuaTbvlSonncIiOn2ETnZpCxkQeOWzh8Sh
	ekI1xWD79mAi8G0Z04lMGWHLpIPzAK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777539798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wuWeK+49G8+gltjgEPrQvgzUIRCbjLPmBVFt1uvHX0U=;
	b=RP8m4pIjkUcWQHOYC+6dbUgXlo3IcP30HBwPf3+NkFUvI6DDxXidQ7ee2/FXSqmMvQlg8x
	1lV4O+Syu9Yb2WDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB02C593B0;
	Thu, 30 Apr 2026 09:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4tD5J9Ya82lmKQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Thu, 30 Apr 2026 09:03:18 +0000
Date: Thu, 30 Apr 2026 11:03:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Avinesh Kumar <avinesh.kumar@suse.com>,
	Wei Gao <wegao@suse.com>, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org, Martin Doucha <mdoucha@suse.cz>
Subject: Re: [PATCH 1/2] ima_violations.sh: Wait for ima_mmap to exit
Message-ID: <afMa06pb1En8apsu@yuki.lan>
References: <20260428161034.947614-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428161034.947614-1-pvorel@suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 63BE649F971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9388-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DMARC_NA(0.00)[suse.cz];
	RSPAMD_URIBL_FAIL(0.00)[suse.cz:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrubis@suse.cz,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,yuki.lan:mid]

Hi!
>  test3()
>  {
> +	local pid
> +
>  	tst_res TINFO "verify open_writers using mmapped files"
>  
>  	local search="open_writers"
> @@ -168,6 +170,7 @@ test3()
>  	echo 'testing testing' > $FILE
>  
>  	ima_mmap -f $FILE &
> +	pid=$!
>  	# wait for violations appear in logs
>  	tst_sleep 1s
>  
> @@ -177,7 +180,10 @@ test3()
>  	validate $num_violations $count $search
>  
>  	# wait for ima_mmap to exit, so we can umount
> -	tst_sleep 2s
> +	wait $pid

You can simplify this just by doing 'wait' that will wait for all
background jobs (we have only one here).

Either way:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +	if [ $? -ne 0 ]; then
> +		tst_brk TBROK "failed to execute ima_mmap"
> +	fi
>  }
>  
>  test4()
> -- 
> 2.54.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

