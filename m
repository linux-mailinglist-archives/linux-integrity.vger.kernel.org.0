Return-Path: <linux-integrity+bounces-5061-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1CA4DE84
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 13:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70475188647E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596E20299D;
	Tue,  4 Mar 2025 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tAVuru5k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bPWNnAOI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tAVuru5k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bPWNnAOI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2DA78F33
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093074; cv=none; b=krbP+7+XasnFKOqYszIQJD/YZ1WB4ei9ArqeYE3SWXOenWvLEFdHDlanrdHxvAC9AqH1fyyxythLiE8spX5znpdBfKN4VmCClcZwOuMXkLgVXRSODoV8AHKslgPstLBBO/xUmxykne7wez9AfhHWvMq9Oxi6SsMnId0Bmn+fcN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093074; c=relaxed/simple;
	bh=NstmyUVcdcq5yPTWuwMu2zI2CAu6Y1EHFnJC1nAzUQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieDHvdHZYfezupsBTzAxslM4GEZ91VZ2R6pDOyltU0wGf9RpUM9o3cKVpHLzQSUXztaAgix36PV+FXnFhRHr/sAomsMGpYcudRCDCLv7lZCVQVQX4Zbp9aNDp1ieLw6RfHjSm7t+4kM/OdnQO4DZNIpA8g6d+d/6wm2zsQUwlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tAVuru5k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bPWNnAOI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tAVuru5k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bPWNnAOI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 127F921190;
	Tue,  4 Mar 2025 12:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741093071;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87zAOwEdaCcmKqN1c4wbkJqYWFYitpjRDie2jchQ710=;
	b=tAVuru5krXb+Xk2l10WLjHGMJKouBox6M4ZM9tIXRNc34yry28/Y5bGeYOn5fRMTl6KGZQ
	ci3vJV01UY90jd8DR94JNEqnu1bs8IMLRJWMfiFxYqxVMQP4XZJINnvaXhJ6Z4moVOW9Wg
	HdWq9xqCiurA9nTB3brJqDYGYwPKLFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741093071;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87zAOwEdaCcmKqN1c4wbkJqYWFYitpjRDie2jchQ710=;
	b=bPWNnAOIV44TBVxZSAPcVOu8Zq9+qH+oABRpbq/NwUH6yALxoetGPDLYl3rRKe9kq4rDpM
	fc58oKH02QmhyVBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741093071;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87zAOwEdaCcmKqN1c4wbkJqYWFYitpjRDie2jchQ710=;
	b=tAVuru5krXb+Xk2l10WLjHGMJKouBox6M4ZM9tIXRNc34yry28/Y5bGeYOn5fRMTl6KGZQ
	ci3vJV01UY90jd8DR94JNEqnu1bs8IMLRJWMfiFxYqxVMQP4XZJINnvaXhJ6Z4moVOW9Wg
	HdWq9xqCiurA9nTB3brJqDYGYwPKLFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741093071;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87zAOwEdaCcmKqN1c4wbkJqYWFYitpjRDie2jchQ710=;
	b=bPWNnAOIV44TBVxZSAPcVOu8Zq9+qH+oABRpbq/NwUH6yALxoetGPDLYl3rRKe9kq4rDpM
	fc58oKH02QmhyVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9B1B1393C;
	Tue,  4 Mar 2025 12:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xRFtM874xmc1FAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 04 Mar 2025 12:57:50 +0000
Date: Tue, 4 Mar 2025 13:57:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ima_violations.sh: force $LOG ToMToU violation
 earlier
Message-ID: <20250304125749.GA81126@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304115331.524842-1-zohar@linux.ibm.com>
X-Spam-Score: -6.24
X-Spamd-Result: default: False [-6.24 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_HAS_CURRENCY(1.00)[];
	NEURAL_HAM_LONG(-0.75)[-0.753];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.954];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

> Violation tests are dependent on searching the $LOG file, which may
> itself result in a ToMToU violation.  Preempt getting an additional
> violation during the tests by forcing the $LOG ToMToU violation
> earlier.

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

If you don't mind, I would reverse the order to get info about which log is
used:

	tst_res TINFO "using log $LOG"
	exec 3< $LOG || tst_brk TBROK "failed to read log file"

Or, if it's needed to for some reason to run it before (no idea why, but I might
miss something), I would merge it as:

	exec 3< $LOG || tst_brk TBROK "failed to read $LOG"
	tst_res TINFO "using log $LOG"

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

