Return-Path: <linux-integrity+bounces-2049-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9B8A2237
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 01:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26041F223DD
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Apr 2024 23:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9943847A73;
	Thu, 11 Apr 2024 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hJxr1GBM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F5/H220/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hJxr1GBM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F5/H220/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4347A6A
	for <linux-integrity@vger.kernel.org>; Thu, 11 Apr 2024 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877684; cv=none; b=un2+GZX0KM5IwzNHk6GeUlqTuq0a9TUQSR6F9OctfLPrFK/YcTmjp899NOwrdON1DeKrebtOCoakp9Cs7zu8NxNLurR1qQ25dGTpJHXqu/WxXRyBY9Zu01FHXerF/mVX4lPYhOB5RgIFyrjLGra0wUkR1quysGe2AEAOGu1/rAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877684; c=relaxed/simple;
	bh=zfl7E7J+WvCe99CQvaLOc5NEIwf7qph0WRmWSe/8j6Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fyZSrTUboQ3rn/uSVVGl+Hr2XEGEnot/+vCiLDz9wnOgr/IVju2271fjwcjKW31Kw8nEuLJ5Hwv6Yc6+pYkPIUzwUE8mmiFKhsGeOSAvMVUWsn5cVpLov9EGg3aWfw74Rihh+xJBTfF1y3Y2s2xcB1iNwZCcXGwZiozf585aaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hJxr1GBM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F5/H220/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hJxr1GBM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F5/H220/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A21CD5D6EB;
	Thu, 11 Apr 2024 23:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712877680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fm3cLHCUKumy9xLrwq0HBPkDKhJTVIgX4GRH0NzDXdA=;
	b=hJxr1GBM7veal8Ec4l/pFIJc+PMm+2fNVsLA5KI308sfIN/Lwy/c/3vlya50vAAYDII0sE
	B54f2DzLu9Q/53EzFmK0k9GJgzosT2hAThK80TxHcPZg0ZSX1+h7JRlefQsnok+q6QS3wq
	qDOvwxljWAn2z7eIvZQzz4TS6MKFjmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712877680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fm3cLHCUKumy9xLrwq0HBPkDKhJTVIgX4GRH0NzDXdA=;
	b=F5/H220/goVSzD/0iGGGCWPHX/zxXZ83ubzB7hi2rj7P0lesa1mjr7xP6mciuuCnLWgiJZ
	ltMzTa2L/zq7XFCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hJxr1GBM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="F5/H220/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712877680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fm3cLHCUKumy9xLrwq0HBPkDKhJTVIgX4GRH0NzDXdA=;
	b=hJxr1GBM7veal8Ec4l/pFIJc+PMm+2fNVsLA5KI308sfIN/Lwy/c/3vlya50vAAYDII0sE
	B54f2DzLu9Q/53EzFmK0k9GJgzosT2hAThK80TxHcPZg0ZSX1+h7JRlefQsnok+q6QS3wq
	qDOvwxljWAn2z7eIvZQzz4TS6MKFjmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712877680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fm3cLHCUKumy9xLrwq0HBPkDKhJTVIgX4GRH0NzDXdA=;
	b=F5/H220/goVSzD/0iGGGCWPHX/zxXZ83ubzB7hi2rj7P0lesa1mjr7xP6mciuuCnLWgiJZ
	ltMzTa2L/zq7XFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1046E13685;
	Thu, 11 Apr 2024 23:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YVAWLm1wGGZlZQAAD6G6ig
	(envelope-from <wbrown@suse.de>); Thu, 11 Apr 2024 23:21:17 +0000
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.1\))
Subject: Re: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
From: William Brown <wbrown@suse.de>
In-Reply-To: <D0HNST37O7G8.3A722951U878Z@kernel.org>
Date: Fri, 12 Apr 2024 09:21:03 +1000
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-integrity@vger.kernel.org,
 peterhuewe@gmx.de,
 jgg@ziepe.ca,
 Takashi Iwai <tiwai@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1E92886-E7ED-4425-8A31-22FE196C5218@suse.de>
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
 <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
 <D0BFMGM02V7A.1HEWQ05350K07@kernel.org>
 <6857f043301a100ee93b3ea120a2d1d60e83efdb.camel@HansenPartnership.com>
 <D0HNST37O7G8.3A722951U878Z@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6.1.1)
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,vger.kernel.org,gmx.de,ziepe.ca,suse.de];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A21CD5D6EB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01



> On 12 Apr 2024, at 08:50, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Thu Apr 4, 2024 at 6:49 PM EEST, James Bottomley wrote:
>> On Thu, 2024-04-04 at 18:09 +0300, Jarkko Sakkinen wrote:
>>> [...]
>>> Emphasis that I might have forgotten something but this is what I =
can
>>> remember right now.
>>=20
>> What you forgot is that I did originally proposed session degapping =
in
>> the kernel resource manager but it was rather complex, so you made me
>> take it out for lack of a use case.  It dates back to when we used =
the
>> old sourceforge tpmdd list which seems to have caused message loss, =
so
>> I'm not sure how complete this thread is:
>=20
> I might be forgetting some detail to contxt gap but since kernel =
flushes
> every single object per transaction contextCounter should be updated =
all
> the time and thus there should not be too large gap that would cause
> emitting this error.
>=20
> I quickly reviewed section 30.5 for architecture specificaton to check
> if I got it right and it says that: "On receiving this error, the
> management software either would explicitly flush old session contexts
> or would load the old session contexts to update their associated
> counter values.."

The issue is that we *are* flushing session contexts and this error is =
still occurring.

>=20
> You could cause the error even with kernel RM if e,g. a process with
> access to /dev/tpm0 purposely populates the chip with objects that it
> does not flush so it is then inevitable over time...
>=20
> I still think that kernel RM should not do any pro-active handling to
> this albeit I have to admit I did not remember what I said about the
> topic back then :-)
>=20
>>=20
>> =
https://lore.kernel.org/lkml/1484772489.2396.2.camel@HansenPartnership.com=
/
>>=20
>> If I compare it to the fragment on sourceforge, you can see a bit =
more
>> of it (but sourceforge has lost the patch):
>>=20
>> =
https://sourceforge.net/p/tpmdd/mailman/tpmdd-devel/thread/201702090906.v1=
996c6a015552%40wind.enjellic.com/#msg35656470
>>=20
>> The reality is that unless you context save a session, you don't need
>> degapping and pretty much every TSS based use of sessions doesn't =
need
>> to save them, so people who construct TPM based systems rarely run =
into
>> this.  The exception is the tpm2-tools CLI project, which encourages
>> the context saving of sessions and thus can cause this.  We kept
>> tripping across this in the Keylime, but the eventual solution was to
>> dump the tpm2-tools dependency and do a direct TSS connection in the
>> Keylime agent.
>=20
> If someone is interested to deal with this error in tpm2-tools (or =
what
> ever that stacks name is), e.g. Android TPM stack does address the
> error.
>=20
> I agree with you tho that properly implemented application wisely you
> should never encounter the error...
>=20
>> James
>=20
> BR, Jarkko

--=20
Sincerely,

William Brown

Senior Software Engineer,
Identity and Access Management
SUSE Labs, Australia


