Return-Path: <linux-integrity+bounces-5307-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B7A67139
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 11:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE5A3B7BA0
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920362080DB;
	Tue, 18 Mar 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M9VN8PW+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eZXlKSKu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F7NYgtTx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JnfNmivV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171A206F18
	for <linux-integrity@vger.kernel.org>; Tue, 18 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293601; cv=none; b=YmAeEwsMnbqkSuWFFX9lcDBNOLbxGnQrccnXkmL9Sm92KSNsfF+rY05jyayYPcQob74h54eWwNEaVJgtuXuVM+geC2S4KLKYegbnmHIWGMlHfdsYuo4EPSIzesKZIaB6yik9I1XHXN5KJeUbgGesctrTXY/+Kjs+a+HxseGlQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293601; c=relaxed/simple;
	bh=d443GZHLIjyOHbwUIJXFj/9ONIblaesMaI+S/z2lvJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWcz2tsCnCeaYIVQgz8nfu6cZ8wB9C7qYNB3gyjl1rQoZWGD+xdJ2YyOVj0BQKf6GfrLz2unZs1/Vu6pyFc/BOj/6JqRoIw3AAGYSzNT05t3MF9sTCNUgW0LzYfAlaCG+KTovdsM38Ky2scelxPx8mE5wdRzZImCYMxGlq8OZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M9VN8PW+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eZXlKSKu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F7NYgtTx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JnfNmivV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1AC81F855;
	Tue, 18 Mar 2025 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742293594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0I3UsFYcaS2dm2ZcPh5elewe1bTBvCDoMwY2kyHX3c=;
	b=M9VN8PW+acb5kR2M6xBE94BR+t0UUUDNbZ7Xn8L8ZxsZybqqhPyqV1POVVoZLPd4A/qwt1
	ta/9dDYjxDORCg/o9W2lbWoIbWdhRKXDOZihyiuGaxgWlykMl/Bx9ZyzMmjSzQlvx0qo2a
	EOJKwuCb7oPKtggOl4iT6GlaPa9l2bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742293594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0I3UsFYcaS2dm2ZcPh5elewe1bTBvCDoMwY2kyHX3c=;
	b=eZXlKSKurBrmNfQmPj1rw2RQjDK6Di7cPfCe21DTlfz1hA72C9zQN2m1LKHzRCWzM2n2yN
	fW06rojRUF0l3YAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742293593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0I3UsFYcaS2dm2ZcPh5elewe1bTBvCDoMwY2kyHX3c=;
	b=F7NYgtTxFAXa5IpbkrwIRehanFn3z3V1i1lQcc6lt7ubbeSRloW620yJL0LKxjuonBPvqV
	/ZL4SKK2QuFZZqHbUEo1yEqjVEB9RKDp8lvlnFGGNR9BHAw9Hi0WT9wEj3vUFnVqigdQT4
	9rMqqpPmCsn9cUEcGx8c13WvMNV/fck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742293593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0I3UsFYcaS2dm2ZcPh5elewe1bTBvCDoMwY2kyHX3c=;
	b=JnfNmivV14h/Ot5Bkw17pqyKA9rRmx/StTcJ7sodZICiw0NkyXSILu4Bi01wdzuGXXE4bp
	SFcCzx+4LcRUb0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4BDD1379A;
	Tue, 18 Mar 2025 10:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gl7aKllK2WeVNgAAD6G6ig
	(envelope-from <nstange@suse.de>); Tue, 18 Mar 2025 10:26:33 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,
  linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 6/7] ima: invalidate unsupported PCR banks once
 at first use
In-Reply-To: <34ebd15aae07402d19279ef4286197112c4afc01.camel@linux.ibm.com>
	(Mimi Zohar's message of "Mon, 17 Mar 2025 21:46:43 -0400")
References: <20250313173339.3815589-1-nstange@suse.de>
	<20250313173339.3815589-7-nstange@suse.de>
	<34ebd15aae07402d19279ef4286197112c4afc01.camel@linux.ibm.com>
Date: Tue, 18 Mar 2025 11:26:33 +0100
Message-ID: <87zfhik52e.fsf@>
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
X-Spamd-Result: default: False [-0.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	INVALID_MSGID(1.70)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,huawei.com,gmail.com,oracle.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -0.60
X-Spam-Flag: NO

Mimi Zohar <zohar@linux.ibm.com> writes:

> On Thu, 2025-03-13 at 18:33 +0100, Nicolai Stange wrote:
>> Normally IMA would extend a template hash of each bank's associated
>> algorithm into a PCR. However, if a bank's hash algorithm is unavailable
>> to the kernel at IMA init time, it would fallback to extending padded
>> SHA1 hashes instead.
>>=20
>> That is, if e.g. SHA-256 was missing at IMA init, it would extend padded
>> SHA1 template hashes into a PCR's SHA-256 bank.
>>=20
>> The ima_measurement command (marked as experimental) from ima-evm-utils
>> would accordingly try both variants when attempting to verify a measurem=
ent
>> list against PCRs. keylime OTOH doesn't seem to -- it expects the templa=
te
>> hash type to match the PCR bank algorithm. I would argue that for the
>> latter case, the fallback scheme could potentially cause hard to debug
>> verification failures.
>>=20
>> There's another problem with the fallback scheme: right now, SHA-1
>> availability is a hard requirement for IMA, and it would be good for a
>> number of reasons to get rid of that. However, if SHA-1 is not available=
 to
>> the kernel, it can hardly provide padded SHA-1 template hashes for PCR
>> banks with unsupported algos.
>>=20
>> There are several more or less reasonable alternatives possible, among
>> them are:
>> a.) Instead of padded SHA-1, use padded/truncated ima_hash template
>>     hashes.
>> b.) Record every event as a violation, i.e. extend unsupported banks
>>     with 0xffs.
>> c.) Don't extend unsupported banks at all.
>> d.) Invalidate unsupported banks only once (e.g. with 0xffs) at first
>>     use.
>>=20
>> a.) would make verification from tools like ima_measurement nearly
>>     impossible, as it would have to guess or somehow determine ima_hash.
>> b.) would still put an significant and unnecessary burden on tools like
>>     ima_measurement, because it would then have to exercise three
>>     possible variants on the measurement list:
>>     - the template hash matches the bank algorithm,
>>     - the template hash is padded SHA-1,
>>     - the template hash is all-ones.
>> c.) is a security risk, because the bank would validate an empty
>>     measurement list.
>>=20
>> AFAICS, d.) is the best option to proceed, as it allows for determining
>> from the PCR bank value in O(1) whether the bank had been maintained by
>> IMA or not and also, it would not validate any measurement list (except
>> one with a single violation entry at the head).
>

Hi Mimi,

> What a pleasure reviewing your patch set.  Nicely organized.  Well writte=
n patch
> descriptions.

thank you :)

> Currently with the SHA1 hash algorithm, whether it is being extended into=
 the
> TPM or not, the measurement list is complete.  Relying on the ima_hash in=
 the
> current kernel and the subsequent kexec'ed kernel should be fine, assumin=
g if
> they're different hash algorithms both TPM banks are enabled.  Otherwise,=
 the
> measurement lists will be incomplete.

Yes. However with your comment I'm now realizing there's an issue if the
set of supported hash algorithms differs between the previous and the
next, kexeced kernel -- something I admittedly hadn't thought of before.

The current behavior as implemented in this RFC is that an unsupported
PCR bank would get invalidated *once* upon first use, i.e. extended once
with e.g. all 0xFEs. (Note that the actual patch implements invalidation
with all 0xFFs, for the choice of the exact invalidation value see
below). The idea is that
a.) tools could easily recognize this by comparing the PCR bank value
    against constant HASH(00 .. 00 | fe ... fe)
b.) and they would fail to verify any non-trivial event log against such
    a PCR bank if they did not do that comparison ahead.

In order to implement this invalidate-once logic, there's that
ima_extended_pcrs_mask you asked about in reply to [3/7], the
preparatory patch for [4/7] ("ima: track the set of PCRs ever
extended"). As the set of PCRs ever to be found in any policy rule
cannot be predicted, their unsupported banks cannot get invalidated once
at __init. Hence this inalidate-at-first-extend logic, which needs that
tracking of PCRs ever extended as maintained in ima_extended_pcrs_mask.

Upon kexec, the current patchset attempts to restore the
ima_extended_pcrs_mask from the previous kernel by walking through the
measurement list, setting a bit for each PCR found in any event.

Now consider the following:
- some hash algorithm is supported by the initially booted kernel,
- but not in the subsequently kexeced one.

The initially booted kernel would not invalidate the given hash
algorithm's bank for any PCR, and the kexeced one would neither, because
it would restore the ima_extended_pcrs_mask from the initially booted
one. However, the kexeced kernel would also not extend any further
events into the now unsupported PCR banks then. That means that these
PCR banks would happily verify a measurement list truncated to the point
before the kexec, which is of course bad.


I can see two ways around this:
a.) Give up on the invalidate-once scheme, unconditionally invalidate
    unsupported banks (with 0xfe .. fe) for every new measurement list
    entry.

b.) Make the kexeced kernel to read back PCR banks it doesn't support
    from the TPM at __init and see if they had been invalidated by the
    previous kernel. Set the bit in ima_extended_pcrs_mask *only* if so.
    That is, invalidate unsupported and not yet invalidated PCR banks
    upon first use.

    Also, make it read PCR banks it does support and refrain from
    further extending any found to have been invalidated before (for all
    PCRs mentioned in the measurement list). That is, leave previously
    invalidated PCR banks alone.

Going with a.) would mean that verifiers would not be able to recognize
in O(1) anymore that some bank was unsupported and had not been
maintained by the kernel. It would still be possible to figure in linear
time whether neither of the kernels in a kexec chain covered by a single
measurement list did support a given PCR bank hash.

For implementing b.), one would have to store a table of precomputed
HASH(00 .. 00 | fe .. fe) values for every recognized hash possible in
.rodata for comparison purposes, i.e. for every entry in
tpm2_hash_map[5] at least -- after all, the whole point is to deal with
hashes for which no implementation is available to the kernel, so these
values cannot get computed dynamically at runtime.

With that, if the initially booted kernel did not support some hash
algorithm, it would be recognizable by verifiers in O(1) time.

If the initially booted kernel did support a given hash, but a
subsequent kernel in the kexec chain would not, the PCR would get
invalidated by the latter. This sitatuation cannot be detected at all
(with reasonable effort) from the final PCR hash bank value alone and
verification against it would fail then. Perhaps it's noteworthy that
this is true with any possible scheme, including the currently
implemented one extending with padded SHA1 into unsupported banks.


I think that the decision about what to do now boils down to whether
there's any value in verifiers being able to tell that a PCR bank had
been unsupported and not been maintained rather than to simply fail its
verification if attempted.

If it is not important, or linear time + the additional implementation
complexity burden at the verifier side is acceptable, the much simpler
a.) would do.

Otherwise I could give implementing b.) a try and see how bad the
resulting code would get.

What do you think?


> This patch set introduces a new definition of integrity violation. Previo=
usly it
> was limited to open-writers and ToMToU integrity violations.  Now it coul=
d also
> mean no kernel hash algorithm available.  Unfortunately some attestation
> services simply ignore integrity violations.

Yeah, there's indeed an ambiguity. I think the right thing to do is to
make measurement lists unverifiable against unsupported banks and would
propose to use 0xfe ... fe for the associated invalidations instead of
the 0xff .. ff used for violation events already.

Thanks a lot!

Nicolai


>>=20
>> So implement d.). As it potentially breaks existing userspace, i.e.
>> the current implementation of ima_measurement, put it behind a Kconfig
>> option, "IMA_COMPAT_FALLBACK_TPM_EXTEND". If set to "y", the original
>> behavior of extending with padded SHA-1 is retained. Otherwise the new
>> scheme to invalidate unsupported PCR banks once upon their first extensi=
on
>> from IMA is implemented instead. As ima_measurement is marked as
>> experimental and I find it unlikely that other existing tools depend on
>> the padded SHA-1 fallback scheme, make the IMA_COMPAT_FALLBACK_TPM_EXTEND
>> Kconfig option default to "n".
>>=20
>> For IMA_COMPAT_FALLBACK_TPM_EXTEND=3Dn,
>> - make ima_calc_field_array_hash() to fill the digests corresponding to
>>   banks with unsupported hash algorithms with 0xffs,
>> - make ima_pcr_extend() to extend these into the unsupported PCR banks o=
nly
>>   upon the PCR's first usage, skip them on subsequent updates and
>> - let ima_init_ima_crypto() help it with that by populating the new
>>   ima_unsupported_tpm_banks_mask with one bit set for each bank with
>>   an unavailable hash algorithm at init.
>>=20
>> [1] https://github.com/linux-integrity/ima-evm-utils
>>=20
>> Signed-off-by: Nicolai Stange <nstange@suse.de>
>> ---

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

