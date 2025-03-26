Return-Path: <linux-integrity+bounces-5434-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDABA71406
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 10:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E851898952
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126121AD403;
	Wed, 26 Mar 2025 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SK/madfa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6/f1qHXt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AO80ImJI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oBobONKO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381919E992
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982363; cv=none; b=LEvokaMvbf7M61w0OurFPOp25Ke51oR40nHsYwLe2RNffeO/s/bMbGzActYOMF3PZMneGd2H9vGMaMbVButlgAkyGvxiCVNCUDBrpl3lyb4O3tEg28Jb369U8TW65hk5aX6nQP4rm8IuaSTsl8EHD4HRKwW/yWXmn5u+6Z4UHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982363; c=relaxed/simple;
	bh=xrQALF0xZASC9lAzNDjlGBs1HM4EQBjOhLb9lRIB3q0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SfTCPzHZZUWQbwKfPuSJTboZF0rHEoRMPlD/7qCVMTS6NViq00mWqm0UhO6girX8pCa8ofx3acTW3FmGkss9lJr7Yxd9FFrQ9V/mU4rLOGi+Rrq58vK0inLa6A1sRFi3XdXw4Y/8fdtVggoiDojcemr3dq8rs+oAI4AODqCK7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SK/madfa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6/f1qHXt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AO80ImJI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oBobONKO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDF4E21179;
	Wed, 26 Mar 2025 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742982358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEWux97G+JgMR2PuanuTwss4e9Ijl0dgxvw3Gu2V5es=;
	b=SK/madfar9BpCWtIJ03hVqbDl6MPi+zZJJyTnFnLRCKTaC3yRlZeL72aZRJ6JXoYhfdesG
	rWSSShP6Vfdmf9xSl1JNwKmmF3jImPpQpiHkQ35vT38Bp6SFDUT33iuPkbSo9zACZQ8RJB
	IyTmt7v2oecwWHdLF9KZPqWvJI7ma6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742982358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEWux97G+JgMR2PuanuTwss4e9Ijl0dgxvw3Gu2V5es=;
	b=6/f1qHXtdxCLwH3Ea3F8ZDOJNecVF8rzvOrMm2xuLR1r3i8hd3CO1lr+rZ9Kq8KE7NEZTB
	f/Pe6yXwf9nzTuAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AO80ImJI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oBobONKO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742982357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEWux97G+JgMR2PuanuTwss4e9Ijl0dgxvw3Gu2V5es=;
	b=AO80ImJIaDXtTkLrSDBtnF2p/4ZftnNh3LGY3J0VLlJSurGzuW/Ei26aTteq3CwOB1LdR+
	vYEAcY8Spi/k8apowjVa1W/VlaKi31Y/b0Fcq+hmR+cdls+saCmDPR3oeOoiz6lSQV7f87
	5nqBILwnfzL+DMdFCtcoeXbaB1XNJuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742982357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEWux97G+JgMR2PuanuTwss4e9Ijl0dgxvw3Gu2V5es=;
	b=oBobONKOTS7L4WLiticidbETpD/OSDYPgaB3tzjLVWupUvMNltTcJlOcXfy4VLeQSkAbYw
	cIo/ehfo9FZg7+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 912D11374A;
	Wed, 26 Mar 2025 09:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7DSvIdXM42fnaQAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 09:45:57 +0000
From: Nicolai Stange <nstange@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Nicolai Stange <nstange@suse.de>,  Mimi Zohar <zohar@linux.ibm.com>,
  Roberto Sassu <roberto.sassu@huawei.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,  Eric Snowberg <eric.snowberg@oracle.com>,
  James Bottomley <James.Bottomley@hansenpartnership.com>,
  linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/13] tpm: enable bank selection for PCR extend
In-Reply-To: <Z-Bx_-EvcfCzWqr7@kernel.org> (Jarkko Sakkinen's message of "Sun,
	23 Mar 2025 22:41:35 +0200")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-8-nstange@suse.de>
	<Z-Bx_-EvcfCzWqr7@kernel.org>
Date: Wed, 26 Mar 2025 10:45:57 +0100
Message-ID: <87h63gp1ka.fsf@>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,linux.ibm.com,huawei.com,gmail.com,oracle.com,hansenpartnership.com,vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Spam-Flag: NO
X-Spamd-Bar: /
X-Rspamd-Queue-Id: DDF4E21179
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.81
X-Spam-Level: 

Jarkko Sakkinen <jarkko@kernel.org> writes:

> On Sun, Mar 23, 2025 at 03:09:05PM +0100, Nicolai Stange wrote:
>> The existing tpm_pcr_extend() extends all of a PCR's allocated banks with
>> the corresponding digest from the provided digests[] argument.
>
> Why not "just" tpm_pcr_extend(). We don't have a concept of
> "non-existing tpm_pcr_extend()".
>
> "tpm_pcr_extend() extends the allocated PCR banks ..."
>
> or something.

Right.


>>=20
>> An upcoming code change to IMA will introduce the need to skip over those
>
> Don't talk about upcoming code changes. Just explain why IMA depends on
> the change.

Ok.


>> banks it does not have a hash algorithm implementation available for.
>>=20
>> Introduce tpm_pcr_extend_sel() to support this.
>>=20
>> tpm_pcr_extend_sel() also expects a digests[] array, always being the
>> number of allocated PCR banks in size, just as it's the case for the
>> existing tpm_pcr_extend(). In addition to that however, it takes a
>> 'banks_skip_mask', and will skip the extension of any bank having its
>> corresponding bit set there.
>>=20
>> Signed-off-by: Nicolai Stange <nstange@suse.de>
>> ---
>>  drivers/char/tpm/tpm-interface.c | 29 +++++++++++++++++++++++++++--
>>  drivers/char/tpm/tpm.h           |  3 ++-
>>  drivers/char/tpm/tpm2-cmd.c      | 29 +++++++++++++++++++++++++++--
>>  include/linux/tpm.h              |  3 +++
>>  4 files changed, 59 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-int=
erface.c
>> index b1daa0d7b341..88b4496de1df 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -314,6 +314,26 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
>>   */
>>  int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>>  		   struct tpm_digest *digests)
>> +{
>> +	return tpm_pcr_extend_sel(chip, pcr_idx, digests, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(tpm_pcr_extend);
>
> I'd add just an extra argument to tpm_pcr_extend().

Perfect, will do.

Thanks!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

