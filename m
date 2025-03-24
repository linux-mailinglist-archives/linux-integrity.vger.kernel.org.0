Return-Path: <linux-integrity+bounces-5413-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A62A6E716
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 00:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FACD3A890C
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 23:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674706125;
	Mon, 24 Mar 2025 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oV/47jb/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlbFHfeE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oV/47jb/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zlbFHfeE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6BC4A0C
	for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742857272; cv=none; b=Z8sBstEguSGfEuhrTxFe43XsYQc2dkRqmDP3ipagNiZiG41eDI0Ipc/9GDl+rtqnBKs8ij5uNoO/4iThSscAOBNSF5m8cd0hfwhSMoEkps0T1yJhjcmYob1b5T5ARSUdjlwwjMQPdSiv0REe6f1Wm9buQ55v0VCplEwZSGszMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742857272; c=relaxed/simple;
	bh=quQX76uP0rkL70L/EwehQCtqJJYbLDV6FCu5uAsgxLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYuCFmZAfevsi/OjwP0aRd0q2NIIuFf3DMWTZYp6g3wuOd1Va44OgiTkRK208vPaIWFidif3Wcgd24P1e48KjxwGg/+CLwx3ACXPJ0esuCFhmzPJ2gYAPbg/4qsgk7H9icMIftM4cQARHMJT4+fhdORGtRRRNsQZ6443zH1vl+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oV/47jb/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlbFHfeE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oV/47jb/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zlbFHfeE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 304171F391;
	Mon, 24 Mar 2025 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742857267;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xqHehvxVyrSZML/2aBDHxHV6HdJ7pp4IVrt6vbMzzY=;
	b=oV/47jb/tgQyel3tvts8gNTK98hCiPvJGw39m0Gq9oz2h1PdpbGvxIzKmSi9zAtmSMoHN7
	DsSKExeNMa1TnqZAoVbkKk2XO4mOS+slE+7Y+yajgfP1FaIj5OemDlG+3In+h5gl1ikZAe
	6pt6M+bHVFC9v51Wm2BDkb2z4mjwvEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742857267;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xqHehvxVyrSZML/2aBDHxHV6HdJ7pp4IVrt6vbMzzY=;
	b=zlbFHfeElmTF5xH9dfNG0vSpGd514wuLEnhATmk6766cnMGP6OYObtJ0qJDbXdfatMdPmE
	QUJzAvc/LjxuGtCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="oV/47jb/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zlbFHfeE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742857267;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xqHehvxVyrSZML/2aBDHxHV6HdJ7pp4IVrt6vbMzzY=;
	b=oV/47jb/tgQyel3tvts8gNTK98hCiPvJGw39m0Gq9oz2h1PdpbGvxIzKmSi9zAtmSMoHN7
	DsSKExeNMa1TnqZAoVbkKk2XO4mOS+slE+7Y+yajgfP1FaIj5OemDlG+3In+h5gl1ikZAe
	6pt6M+bHVFC9v51Wm2BDkb2z4mjwvEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742857267;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xqHehvxVyrSZML/2aBDHxHV6HdJ7pp4IVrt6vbMzzY=;
	b=zlbFHfeElmTF5xH9dfNG0vSpGd514wuLEnhATmk6766cnMGP6OYObtJ0qJDbXdfatMdPmE
	QUJzAvc/LjxuGtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 127EA137AC;
	Mon, 24 Mar 2025 23:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gpGXADPk4WeDYgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 24 Mar 2025 23:01:07 +0000
Date: Tue, 25 Mar 2025 00:01:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH] ima_violations.sh: Fix condition evaluation
Message-ID: <20250324230105.GA272772@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250314124242.459072-1-pvorel@suse.cz>
 <CAEemH2ejo61V9v=BXRt+cVL-roNLFuyKpY2MC_dYW+iJJ3ZrAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEemH2ejo61V9v=BXRt+cVL-roNLFuyKpY2MC_dYW+iJJ3ZrAQ@mail.gmail.com>
X-Rspamd-Queue-Id: 304171F391
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi Li,

> On Fri, Mar 14, 2025 at 8:43 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Evaluation "-gt 0" needs to be together with expectation of empty
> > $expected_violations. Therefore use [ ... -a ... ] comparator to avoid
> > -eq comparison against empty $expected_violations.

> >     # LTPROOT=/opt/ltp PATH="/opt/ltp/testcases/bin:$PATH"
> > LTP_IMA_LOAD_POLICY=1 ima_keys.sh
> >     ima_keys 1 TINFO: /proc/cmdline:
> > BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc3-1.gb6b4102-default security=apparmor
> > ignore_loglevel ima_policy=tcb

> >     # LTPROOT=/opt/ltp PATH="/opt/ltp/testcases/bin:$PATH"
> > ima_violations.sh
> >     ...
> >     /opt/ltp/testcases/bin/ima_violations.sh: line 95: [: 0: unary
> > operator expected
> >     ima_violations 1 TFAIL: open_writers violation not added
> >     ima_violations 2 TINFO: verify ToMToU violation
> >     /opt/ltp/testcases/bin/ima_violations.sh: line 95: [: 0: unary
> > operator expected
> >     ima_violations 2 TFAIL: ToMToU violation not added
> >     ima_violations 3 TINFO: verify open_writers using mmapped files
> >     tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
> >     tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default
> > #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
> >     tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> >     tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option
> > detected which might slow the execution
> >     tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
> >     ima_mmap.c:38: TINFO: sleep 3s
> >     /opt/ltp/testcases/bin/ima_violations.sh: line 95: [: 0: unary
> > operator expected
> >     ima_violations 3 TFAIL: open_writers violation not added

> > NOTE: This does not fix ima_violations.sh fails after caused by user
> > defined policy loaded by ima_keys.sh (via LTP_IMA_LOAD_POLICY=1).

> > Fixes: 726ed71905 ("ima_violations.sh: Update validate() to support
> > multiple violations")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>


> Reviewed-by: Li Wang <liwang@redhat.com>

thanks for your review, merged!

Kind regards,
Petr

> ---
> >  .../kernel/security/integrity/ima/tests/ima_violations.sh      | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)

> > diff --git
> > a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > index 63346e9489..c6b929a233 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > @@ -90,8 +90,7 @@ validate()
> >         for i in $(seq 1 $max_attempt); do
> >                 read num_violations_new < $IMA_VIOLATIONS
> >                 count2="$(get_count $search)"
> > -               if [ -z "$expected_violations" ] && \
> > -                  [ $(($num_violations_new - $num_violations)) -gt 0 ] ||
> > \
> > +               if [ -z "$expected_violations" -a $(($num_violations_new -
> > $num_violations)) -gt 0 ] || \
> >                    [ $(($num_violations_new - $num_violations)) -eq
> > $expected_violations ]; then
> >                         [ -z "$expected_violations" ] &&
> > expected_violations=1
> >                         if [ $count2 -gt $count ]; then
> > --
> > 2.47.2


> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp

