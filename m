Return-Path: <linux-integrity+bounces-5136-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E3DA5526E
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 18:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4886E188DFBD
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1941FC7F9;
	Thu,  6 Mar 2025 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="guU+MpGQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TjxKTK66";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="guU+MpGQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TjxKTK66"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D7210F4D
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280844; cv=none; b=mfddteuAQExztp8o8ands+dH/4slTUsR4t3mx1dd9KopKRV42TJGL5JrsSYCpwXPz40oyW3SQGzCPuFYRNXi+VmdEh+yrDhA3LD8zSz5wZyTUakomiGXPF7XTwseKLCLYNDTUPz65QSlUnkhiNZL3rDCC9rmP9tjRZhjoPO4BzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280844; c=relaxed/simple;
	bh=j4pDiqtQzir340esfyV6VSpMIeiT5uZ1mMQTHQViNlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxwtTsJ+s/SWxR4WiM6saOhBiqnwNPcwGbOOnKUtApXzdsNlWpKAT+mzrixT3+Bf11Sbw8tD6PvxzcVWgh/DZu4H38zop5rgJySzMLTiMckQ0+LHYk5oog/UYir93hJgpP0/bW6mVnQMK+S3d+1RnNkht+WAH0A1uQOFidBkZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=guU+MpGQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TjxKTK66; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=guU+MpGQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TjxKTK66; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B4231F385;
	Thu,  6 Mar 2025 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741280841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PSE8F28yWJgcLqnxdF9R3TUhrMAhG2STD0s3bHNEGFU=;
	b=guU+MpGQheUyPdkR1L0Mq43txQBlzpMwoKI3Tf/019uwRJuIqFGX97owjE3/N/G5954Okr
	c8tX5lmVXj8lo2SBDGaydGKC1yUhgyiw4N7hT6XLXk9VlWa3BeIwtBJGtAVQyjTLj7u0Ws
	pQx+FXxuOBG5YpZyMUu9+PNv+rIwt1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741280841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PSE8F28yWJgcLqnxdF9R3TUhrMAhG2STD0s3bHNEGFU=;
	b=TjxKTK66KSf5bPfBRyw4Cco49/JbxgkVLdmQjOX7ui5ZTyW9b9f+vx3OSFi5yrAMrKW6x9
	ZlEesHfbL9K4+yAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741280841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PSE8F28yWJgcLqnxdF9R3TUhrMAhG2STD0s3bHNEGFU=;
	b=guU+MpGQheUyPdkR1L0Mq43txQBlzpMwoKI3Tf/019uwRJuIqFGX97owjE3/N/G5954Okr
	c8tX5lmVXj8lo2SBDGaydGKC1yUhgyiw4N7hT6XLXk9VlWa3BeIwtBJGtAVQyjTLj7u0Ws
	pQx+FXxuOBG5YpZyMUu9+PNv+rIwt1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741280841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PSE8F28yWJgcLqnxdF9R3TUhrMAhG2STD0s3bHNEGFU=;
	b=TjxKTK66KSf5bPfBRyw4Cco49/JbxgkVLdmQjOX7ui5ZTyW9b9f+vx3OSFi5yrAMrKW6x9
	ZlEesHfbL9K4+yAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AA5613A61;
	Thu,  6 Mar 2025 17:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /23EAEnWyWcmNQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 06 Mar 2025 17:07:21 +0000
Date: Thu, 6 Mar 2025 18:07:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ima_violations.sh: force $LOG ToMToU violation
 earlier
Message-ID: <20250306170710.GA186319@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305145421.638857-1-zohar@linux.ibm.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.47 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_HAS_CURRENCY(1.00)[];
	NEURAL_HAM_LONG(-0.97)[-0.970];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -2.47
X-Spam-Flag: NO

Hi Mimi,

> Violation tests are dependent on searching the $LOG file, which may
> itself result in a ToMToU violation.  Preempt getting an additional
> violation during the tests by forcing the $LOG ToMToU violation
> earlier.

FYI I already merged this from v2 (modified, just swap TINFO message with exec):
https://github.com/linux-test-project/ltp/commit/fdd6da28cf8a2e6de5104e7332724dd5eee346b0

Kind regards,
Petr

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  testcases/kernel/security/integrity/ima/tests/ima_violations.sh | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 37d8d473c..22863fb72 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -30,6 +30,7 @@ setup()
>  	if [ ! -e "$LOG" ]; then
>  		tst_brk TCONF "log file not found, install auditd"
>  	fi
> +	exec 3< $LOG || tst_brk TBROK "failed to read log file"
>  	tst_res TINFO "using log $LOG"
>  }

