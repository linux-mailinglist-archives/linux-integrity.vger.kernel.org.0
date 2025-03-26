Return-Path: <linux-integrity+bounces-5433-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B22A713EB
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 10:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7011720F9
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC0F1A5B87;
	Wed, 26 Mar 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WnarsT1J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ct6QOskY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WnarsT1J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ct6QOskY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539015381A
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982068; cv=none; b=dMEIEzDC+p6UM4bnTD79yFWM8QWNwFEQQHjvGjwKhTdgO/ksrh8Xp/u48sj3ddhGlbg7PAlGbsgnZacFo9XKb1mgGsXrOTPvMq9i0DUHZpekfODFam9wjAng2aO59MIWPIxnVuCKShr7S5cDLjW/oPrSZCx1xhC5DjLtQYpr/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982068; c=relaxed/simple;
	bh=/7lSSy7WrPIvgvtMsd8Z/i5e0RTzrYrd6/yP9NCp93Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EONuDKNUdLB9JPYj1k9AH9UGNcC8TCYGalKj030Kpucn4zSdheSUQcSxhnOWpbz0l44Nu76pIPykp6/fAGia6kuuwxuGgxlJhGoIBl/KAQeZoXVsMBmK4ySc5aJwTHZu4rJuwQmwkqHwiqMG+xGbx+58e3X3LmnJt0sezQwu7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WnarsT1J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ct6QOskY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WnarsT1J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ct6QOskY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DFC421179;
	Wed, 26 Mar 2025 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742982064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OV6Y+bvAQ4j6dj4kHxXjpT3o9nRIcJRh1yhwfpE15/k=;
	b=WnarsT1JLYUFR/FzJ2DLUop9vqDnefw/Ntm+IdS2b618IONGIFJrDdU7bj1MIdTY4NcU0N
	M7RlmnFm3qzbmpWDMCqXUy5UQthvNLAqrzMnUs9dsvSYlRBBloFQgkAnHJn0QLULPpOYu/
	2z8WBW7Cn78Mel+ONnGyMUj1pQlPkTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742982064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OV6Y+bvAQ4j6dj4kHxXjpT3o9nRIcJRh1yhwfpE15/k=;
	b=ct6QOskYUQQV+w6xDWd0/Y/DaddcTn6hpWCaIg2GW2yFrFiERzpvmZf3kUdzyVQivGiJ+S
	LCFf4DqthP5sTvDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WnarsT1J;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ct6QOskY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742982064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OV6Y+bvAQ4j6dj4kHxXjpT3o9nRIcJRh1yhwfpE15/k=;
	b=WnarsT1JLYUFR/FzJ2DLUop9vqDnefw/Ntm+IdS2b618IONGIFJrDdU7bj1MIdTY4NcU0N
	M7RlmnFm3qzbmpWDMCqXUy5UQthvNLAqrzMnUs9dsvSYlRBBloFQgkAnHJn0QLULPpOYu/
	2z8WBW7Cn78Mel+ONnGyMUj1pQlPkTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742982064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OV6Y+bvAQ4j6dj4kHxXjpT3o9nRIcJRh1yhwfpE15/k=;
	b=ct6QOskYUQQV+w6xDWd0/Y/DaddcTn6hpWCaIg2GW2yFrFiERzpvmZf3kUdzyVQivGiJ+S
	LCFf4DqthP5sTvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F196C1374A;
	Wed, 26 Mar 2025 09:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tp+jOa/L42d9aAAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 09:41:03 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>,  James Bottomley
 <James.Bottomley@HansenPartnership.com>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/13] tpm: enable bank selection for PCR extend
In-Reply-To: <4021363dd955236ad55b5d0c26bcf788fa782d79.camel@linux.ibm.com>
	(Mimi Zohar's message of "Tue, 25 Mar 2025 21:18:38 -0400")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-8-nstange@suse.de>
	<4021363dd955236ad55b5d0c26bcf788fa782d79.camel@linux.ibm.com>
Date: Wed, 26 Mar 2025 10:41:03 +0100
Message-ID: <87tt7gp1sg.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	INVALID_MSGID(1.70)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,huawei.com,gmail.com,oracle.com,kernel.org,HansenPartnership.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 4DFC421179
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.81
X-Spam-Level: 

Mimi Zohar <zohar@linux.ibm.com> writes:

> On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
>
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index dfdcbd009720..23ded8ea47dc 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -226,16 +226,34 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_i=
dx,
>>   * @chip:	TPM chip to use.
>>   * @pcr_idx:	index of the PCR.
>>   * @digests:	list of pcr banks and corresponding digest values to exten=
d.
>> + * @banks_skip_mask:	pcr banks to skip
>>   *
>>   * Return: Same as with tpm_transmit_cmd.
>>   */
>>  int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>> -		    struct tpm_digest *digests)
>> +		    struct tpm_digest *digests,
>> +		    unsigned long banks_skip_mask)
>>  {
>>  	struct tpm_buf buf;
>> +	unsigned long skip_mask;
>> +	u32 banks_count;
>>  	int rc;
>>  	int i;
>>=20=20
>> +	banks_count =3D 0;
>> +	skip_mask =3D banks_skip_mask;
>> +	for (i =3D 0; i < chip->nr_allocated_banks; i++) {
>> +		const bool skip_bank =3D skip_mask & 1;
>> +
>> +		skip_mask >>=3D 1;
>> +		if (skip_bank)
>> +			continue;
>> +		banks_count++;
>> +	}
>
> Setting ima_unsupported_pcr_banks_mask used BIT(i).  Testing the bit shou=
ld be
> as straight forward here and below.

I opted for not to using BIT(i) here because in theory
->nr_allocated_banks could be > BITS_PER_LONG. Not in practice though,
but I felt it would improve code readabily if there aren't any implict
assumptions. Also I'm not sure static checkers wouldn't complain about
for (i =3D 0; i < a; i++) {  1ul << i; }

Anyway, I'm realizing now that the code above is effectively just a
popcnt implementation on the lower bits of ~banks_skip_mask.

IMO it would be perhaps even better to do

	unsigned long skipped_banks_count, banks_count;

	skipped_banks_count =3D 0;
	skip_mask =3D banks_skip_mask;
	for (i =3D 0; skip_mask && i < chip->nr_allocated_banks; i++) {
        	skipped_banks_count +=3D skip_mask & 1;
                skip_mask >>=3D 1;
	}
        banks_count =3D chip->nr_allocated_banks - skipped_banks_count;

instead. That way it's almost a nop in the common case of a clear
banks_skip_mask, plus there are no conditionals in the body.


> The first TPM extend after boot is the boot_aggregate.  Afterwards the nu=
mber of
> banks being extended should always be the same.  Do we really need to re-
> calculate the number of banks needing to be extended each time?
>

Otherwise the number of banks to skip would have to get stored somewhere
and passed around, IIUC. I don't think that's worth it, the total number
of allocated banks is expected to be relatively small and
banks_skip_mask is zero in the common case anyway.

Thanks!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

