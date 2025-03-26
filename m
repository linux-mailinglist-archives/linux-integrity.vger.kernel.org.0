Return-Path: <linux-integrity+bounces-5442-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B5BA71887
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 15:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABE118920FD
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CD91EEA59;
	Wed, 26 Mar 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kVKckCvz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lJcrwkpd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lhTEV18N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="85SlvJWV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C801EB5D4
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999496; cv=none; b=hoPVGw/JyuLb3gF8elh0BPauh1a48KY2fQvKpUoSj4k3Xx2kyF/aNo5UesYPBy6qI9OLzSlwG7sLHUUnf7vd46uWpuvnSnPt1pDN4KRbYYNXiQPf3MALevdolkMvqUC1eKtirLbzN97fyFMTDBPuyGJefVs3iuyCJLJC0cB0WTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999496; c=relaxed/simple;
	bh=w/LJlRqg/ucJ1PTPapgmCKKLD4EnTKDdusOND4brjN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NAwir7SrIyqowoI3nPXIo7Wj6bCHrgfwkdfux8PcoPryI1wQWpKFxUc/WMxvwCxu/UOYBKFJMGAExPWhIcmt9NlLkvU8lc+foXQMmrDhAsl8bpydeUSZr8uk2nOgpCy5XTG+SqpJZyk6ZNwB7Ahr3Hhe+dWwm2Hds9teEk0VYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kVKckCvz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lJcrwkpd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lhTEV18N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=85SlvJWV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E609B1F395;
	Wed, 26 Mar 2025 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742999493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOicSyzfVMbHHC7eHpyo6OQBGSesLf5layaaEZRtN4Y=;
	b=kVKckCvzrDxWkJb2SCfa7MOz6ebJMZF+N3EzIWu3XVLvUgkF9h10ZfnobalW017hpxURmn
	fbb7EfCVRRIQIAxw/HDCc68LKeNcPAMuNKEHSxZb+4ABbTj1SaBVvdK+LtoW/RINbK5WxS
	N16jOaTq3MxeLjYobN1a3/29eQqN0b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742999493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOicSyzfVMbHHC7eHpyo6OQBGSesLf5layaaEZRtN4Y=;
	b=lJcrwkpdXBE4y/yJFmfu/p+oM4UDN8vQDsXhqpf3Ra7HDER3bSYQGG4MhonIKR4s4HF1ob
	zpRCr0K3KVWx6aAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lhTEV18N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=85SlvJWV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742999492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOicSyzfVMbHHC7eHpyo6OQBGSesLf5layaaEZRtN4Y=;
	b=lhTEV18NnqnnAzOOJMtVdZr5l6kynuP1PGjkSLJ/YUKCFkqyhWAPq/uC8pOh6h6FCdqeiR
	X4Sa0nSojj6Ze3Xejt2OQ7QTCkDTG2hu0kaBKQRLGlM3koRduqp6rBFAaVHHOLApPWOLnT
	GE8lDf725vbbpC2FFoR2Z24TtoZ7sA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742999492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOicSyzfVMbHHC7eHpyo6OQBGSesLf5layaaEZRtN4Y=;
	b=85SlvJWVL15DgpEhXbhwuzbXCjjkXtG9kYLvL+p7ea8iFvxWbb1M12tgnRhwYxtvuCxJWm
	MLBKCUlFM74za+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A135213927;
	Wed, 26 Mar 2025 14:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G3UTJsQP5GezSAAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 14:31:32 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>,  James Bottomley
 <James.Bottomley@HansenPartnership.com>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/13] ima: invalidate unsupported PCR banks
In-Reply-To: <a4bf93f0c64f4b329e022663afecf6edf0e22884.camel@linux.ibm.com>
	(Mimi Zohar's message of "Wed, 26 Mar 2025 10:18:41 -0400")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-4-nstange@suse.de>
	<e492df76d30b0b95f83b577499a25cdca2256407.camel@linux.ibm.com>
	<a4bf93f0c64f4b329e022663afecf6edf0e22884.camel@linux.ibm.com>
Date: Wed, 26 Mar 2025 15:31:32 +0100
Message-ID: <87semzoocb.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Score: -0.81
X-Spamd-Bar: /
X-Rspamd-Queue-Id: E609B1F395
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO

Mimi Zohar <zohar@linux.ibm.com> writes:

> On Wed, 2025-03-26 at 10:01 +0100, Nicolai Stange wrote:
>> Mimi Zohar <zohar@linux.ibm.com> writes:
>>=20
>> > > diff --git a/security/integrity/ima/ima_crypto.c b/security/integrit=
y/ima/ima_crypto.c
>> > > index 6f5696d999d0..a43080fb8edc 100644
>> > > --- a/security/integrity/ima/ima_crypto.c
>> > > +++ b/security/integrity/ima/ima_crypto.c
>> > > @@ -625,26 +625,43 @@ int ima_calc_field_array_hash(struct ima_field=
_data *field_data,
>> > >  	u16 alg_id;
>> > >  	int rc, i;
>> > >=20=20
>> > > +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>> > >  	rc =3D ima_calc_field_array_hash_tfm(field_data, entry, ima_sha1_i=
dx);
>> > >  	if (rc)
>> > >  		return rc;
>> > >=20=20
>> > >  	entry->digests[ima_sha1_idx].alg_id =3D TPM_ALG_SHA1;
>> > > +#endif
>> > >=20=20
>> > >  	for (i =3D 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
>> > > +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>> > >  		if (i =3D=3D ima_sha1_idx)
>> > >  			continue;
>> > > +#endif
>> > >=20=20
>> > >  		if (i < NR_BANKS(ima_tpm_chip)) {
>> > >  			alg_id =3D ima_tpm_chip->allocated_banks[i].alg_id;
>> > >  			entry->digests[i].alg_id =3D alg_id;
>> > >  		}
>> > >=20=20
>> > > -		/* for unmapped TPM algorithms digest is still a padded SHA1 */
>> > > +		/*
>> > > +		 * For unmapped TPM algorithms, the digest is still a
>> > > +		 * padded SHA1 if backwards-compatibility fallback PCR
>> > > +		 * extension is enabled. Otherwise fill with
>> > > +		 * 0xfes. This is the value to invalidate unsupported
>> > > +		 * PCR banks with. Also, a non-all-zeroes value serves
>> > > +		 * as an indicator to kexec measurement restoration
>> > > +		 * that the entry is not a violation and all its
>> > > +		 * template digests need to get recomputed.
>> > > +		 */
>> > >  		if (!ima_algo_array[i].tfm) {
>> > > +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>> > >  			memcpy(entry->digests[i].digest,
>> > >  			       entry->digests[ima_sha1_idx].digest,
>> > >  			       TPM_DIGEST_SIZE);
>>=20
>>                                ^
>> That's been here before, just for the record for the below.
>
> And it is correct.
>
>>=20
>> > > +#else
>> > > +			memset(entry->digests[i].digest, 0xfe, TPM_DIGEST_SIZE);
>> > > +#endif
>> >=20
>> > Using TPM_DIGEST_SIZE will result in a padded 0xfe value.
>>=20
>> Yes, but as the sysfs files for unsupported algos are gone, this will be
>> used only for extending the PCR banks. tpm[12]_pcr_extend()
>> (necessarily) truncate the digests to the correct size before sending
>> them to the TPM.
>>=20
>> But if you prefer I can absolutely replace TPM_DIGEST_SIZE by
>> hash_digest_size[ima_algo_array[i].algo].
>
> Unlike violations, which are the full digest size, a padded sha1 is exten=
ded
> into the unsupported algos TPM banks.  I assume you'd want it to be the f=
ull
> digest size like violations.

You are so right, thanks for spotting! What I wanted is
TPM_MAX_DIGEST_SIZE, not TPM_DIGEST_SIZE (=3D=3D 20).

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

