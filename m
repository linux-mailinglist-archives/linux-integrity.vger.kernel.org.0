Return-Path: <linux-integrity+bounces-5432-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57E5A71340
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 10:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D06227A3B79
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D53A1A5B9E;
	Wed, 26 Mar 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="swEQG8bR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AH7IcVIk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="swEQG8bR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AH7IcVIk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269E142E67
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742979686; cv=none; b=YZIp0QZinchh+FwBb3lD6vpJ/Rlbkv+FIzTN26IQiywj7UqBCxps4UmO3k4VCzezxTAFrnWzdqyIl3p3YLeG3oU++j4yBl1HSdemwReN14MUOw8zlIDokRZZ9hmqF6053m8FPKfflKzocZh4ZlLzkgCvbXZdBAdN3yG469rpXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742979686; c=relaxed/simple;
	bh=GvKl7jpugVcN3/pxdz/7+0FqrWFa8Ws0dsqA2qmbQVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xv0fnXB4Z+TPPEq4VjnlyT04RPcCP72bc7emgs9i5p19JVro9gvEYUg8oS+sUA+596BKA3au1fiYYzuPdHWIyhKZmzE1OTDVJgC4X4oUM2tUSkgD21nwGpwogEXy8UyrWLu7eRCtVP9xdK4mbD4si59XqtSnuSEQjhcko1jAZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=swEQG8bR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AH7IcVIk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=swEQG8bR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AH7IcVIk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD90C21190;
	Wed, 26 Mar 2025 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742979681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylW/BXUk2jwYqPQasv5sIbA4BFFY0YjpvjQDWOk+Vsw=;
	b=swEQG8bRSNdHeUqtXuEf+Z/xylxfANYS7Yxq410YLpDDJfcfxa/iWdf+1c4Fm5EwTiHqMn
	wdXs3JQ8yljD0Rmd+qJ8y7upe4R5f5ct0u6M1axcRm1abyxMy0h1lrKJQwUaOrPG6EkPeE
	Y2kSvkSQJdBU7nkrWHeSGPYbY4aVkPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742979681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylW/BXUk2jwYqPQasv5sIbA4BFFY0YjpvjQDWOk+Vsw=;
	b=AH7IcVIk90P4gIPoCf9V/ktnM0Hi8Hz3Nsz4g0z7+I4hE7O483FEaCUa3mxV8QZvOTm6Py
	BV0ZqWlBHsUmvgAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=swEQG8bR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AH7IcVIk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742979681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylW/BXUk2jwYqPQasv5sIbA4BFFY0YjpvjQDWOk+Vsw=;
	b=swEQG8bRSNdHeUqtXuEf+Z/xylxfANYS7Yxq410YLpDDJfcfxa/iWdf+1c4Fm5EwTiHqMn
	wdXs3JQ8yljD0Rmd+qJ8y7upe4R5f5ct0u6M1axcRm1abyxMy0h1lrKJQwUaOrPG6EkPeE
	Y2kSvkSQJdBU7nkrWHeSGPYbY4aVkPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742979681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylW/BXUk2jwYqPQasv5sIbA4BFFY0YjpvjQDWOk+Vsw=;
	b=AH7IcVIk90P4gIPoCf9V/ktnM0Hi8Hz3Nsz4g0z7+I4hE7O483FEaCUa3mxV8QZvOTm6Py
	BV0ZqWlBHsUmvgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86AB213927;
	Wed, 26 Mar 2025 09:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fO+hH2HC42fvWwAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 09:01:21 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>,  James Bottomley
 <James.Bottomley@HansenPartnership.com>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/13] ima: invalidate unsupported PCR banks
In-Reply-To: <e492df76d30b0b95f83b577499a25cdca2256407.camel@linux.ibm.com>
	(Mimi Zohar's message of "Mon, 24 Mar 2025 11:05:54 -0400")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-4-nstange@suse.de>
	<e492df76d30b0b95f83b577499a25cdca2256407.camel@linux.ibm.com>
Date: Wed, 26 Mar 2025 10:01:17 +0100
Message-ID: <877c4cqi76.fsf@>
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
	FREEMAIL_CC(0.00)[suse.de,huawei.com,gmail.com,oracle.com,kernel.org,HansenPartnership.com,vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spamd-Bar: /
X-Rspamd-Queue-Id: CD90C21190
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.81
X-Spam-Level: 

Mimi Zohar <zohar@linux.ibm.com> writes:

>> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/im=
a/ima_crypto.c
>> index 6f5696d999d0..a43080fb8edc 100644
>> --- a/security/integrity/ima/ima_crypto.c
>> +++ b/security/integrity/ima/ima_crypto.c
>> @@ -625,26 +625,43 @@ int ima_calc_field_array_hash(struct ima_field_dat=
a *field_data,
>>  	u16 alg_id;
>>  	int rc, i;
>>=20=20
>> +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>>  	rc =3D ima_calc_field_array_hash_tfm(field_data, entry, ima_sha1_idx);
>>  	if (rc)
>>  		return rc;
>>=20=20
>>  	entry->digests[ima_sha1_idx].alg_id =3D TPM_ALG_SHA1;
>> +#endif
>>=20=20
>>  	for (i =3D 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
>> +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>>  		if (i =3D=3D ima_sha1_idx)
>>  			continue;
>> +#endif
>>=20=20
>>  		if (i < NR_BANKS(ima_tpm_chip)) {
>>  			alg_id =3D ima_tpm_chip->allocated_banks[i].alg_id;
>>  			entry->digests[i].alg_id =3D alg_id;
>>  		}
>>=20=20
>> -		/* for unmapped TPM algorithms digest is still a padded SHA1 */
>> +		/*
>> +		 * For unmapped TPM algorithms, the digest is still a
>> +		 * padded SHA1 if backwards-compatibility fallback PCR
>> +		 * extension is enabled. Otherwise fill with
>> +		 * 0xfes. This is the value to invalidate unsupported
>> +		 * PCR banks with. Also, a non-all-zeroes value serves
>> +		 * as an indicator to kexec measurement restoration
>> +		 * that the entry is not a violation and all its
>> +		 * template digests need to get recomputed.
>> +		 */
>>  		if (!ima_algo_array[i].tfm) {
>> +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>>  			memcpy(entry->digests[i].digest,
>>  			       entry->digests[ima_sha1_idx].digest,
>>  			       TPM_DIGEST_SIZE);

                               ^
That's been here before, just for the record for the below.

>> +#else
>> +			memset(entry->digests[i].digest, 0xfe, TPM_DIGEST_SIZE);
>> +#endif
>
> Using TPM_DIGEST_SIZE will result in a padded 0xfe value.

Yes, but as the sysfs files for unsupported algos are gone, this will be
used only for extending the PCR banks. tpm[12]_pcr_extend()
(necessarily) truncate the digests to the correct size before sending
them to the TPM.

But if you prefer I can absolutely replace TPM_DIGEST_SIZE by
hash_digest_size[ima_algo_array[i].algo].

Thanks,

Nicolai

>
>>  			continue;
>>  		}
>>=20=20
>

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

