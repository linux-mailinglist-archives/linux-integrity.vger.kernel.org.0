Return-Path: <linux-integrity+bounces-5316-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F1A67879
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 16:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFBD168169
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5786320FAB9;
	Tue, 18 Mar 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zPaN5wO/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XHMzSVB3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zPaN5wO/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XHMzSVB3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500B20F097
	for <linux-integrity@vger.kernel.org>; Tue, 18 Mar 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313344; cv=none; b=r/bpEPo1hXYX6qYs/pdavGCIp6WqqZS9kWx/kssWoc19kuRhu8QKjxDHGQ2BcY8cVEkVqY+DUJTKt1wFLdOJKTIo3abNujznY7Zwii7t4sWO1oS0L3SYrOYxBkzJtoV3rJicD0/U1BbH6Fm0S4ZJJliFkIKq48kaRQAp9qdrPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313344; c=relaxed/simple;
	bh=qVOIdpc54DYM4ni1cvUqAxIkmMC4qyN3HWGKlzGY9ME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxNa/BfwvysC6y6fl/tKavlI4/rYcHznQuriC2ZRxaZwLLlSS8CEJ+vOBUM5tbZuEavnh3cTvU3O6fBZba3V9D7RD6BOND7mJQvzBNjFiXo0wcsOk/CK6to7BF2a1/912P917HkjYuqpy970Ewt+iuex94slFSpOd/dFr1TbqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zPaN5wO/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XHMzSVB3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zPaN5wO/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XHMzSVB3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BD4D21CDC;
	Tue, 18 Mar 2025 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742313336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADWvOQostfUFwzOiH4t6M1ZqezBa5R8tz/Ub9cZJV0Y=;
	b=zPaN5wO/cTIqWjVCNa6TZY77x76ekvDGTHjegohS9G1ngGHdN9wCK0aifyugsw3ICvOUs7
	vNr4aUtW9FsKr3isxju7Db6UANtDpHrzhbW3CE7TaQSiOxy0977yj1C5DAB9v5h4TgD29i
	ZnOL+O74XlOcayLiaDxm458qCqQilLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742313336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADWvOQostfUFwzOiH4t6M1ZqezBa5R8tz/Ub9cZJV0Y=;
	b=XHMzSVB3FtlAwS5FjY8SQgEgJdrjofL0MzcVujfv0czme4fHEq4rGcTJXWqwET5kCX9Qla
	zpmBPN2slsT4VdAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zPaN5wO/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XHMzSVB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742313336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADWvOQostfUFwzOiH4t6M1ZqezBa5R8tz/Ub9cZJV0Y=;
	b=zPaN5wO/cTIqWjVCNa6TZY77x76ekvDGTHjegohS9G1ngGHdN9wCK0aifyugsw3ICvOUs7
	vNr4aUtW9FsKr3isxju7Db6UANtDpHrzhbW3CE7TaQSiOxy0977yj1C5DAB9v5h4TgD29i
	ZnOL+O74XlOcayLiaDxm458qCqQilLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742313336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADWvOQostfUFwzOiH4t6M1ZqezBa5R8tz/Ub9cZJV0Y=;
	b=XHMzSVB3FtlAwS5FjY8SQgEgJdrjofL0MzcVujfv0czme4fHEq4rGcTJXWqwET5kCX9Qla
	zpmBPN2slsT4VdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D0851379A;
	Tue, 18 Mar 2025 15:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w2vmAXiX2WfUKwAAD6G6ig
	(envelope-from <nstange@suse.de>); Tue, 18 Mar 2025 15:55:36 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,
  linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 6/7] ima: invalidate unsupported PCR banks once
 at first use
In-Reply-To: <8305c89ec354320100ec272052c036300366a2af.camel@linux.ibm.com>
	(Mimi Zohar's message of "Tue, 18 Mar 2025 10:32:07 -0400")
References: <20250313173339.3815589-1-nstange@suse.de>
	<20250313173339.3815589-7-nstange@suse.de>
	<34ebd15aae07402d19279ef4286197112c4afc01.camel@linux.ibm.com>
	<8305c89ec354320100ec272052c036300366a2af.camel@linux.ibm.com>
Date: Tue, 18 Mar 2025 16:55:35 +0100
Message-ID: <87y0x2cozs.fsf@>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,huawei.com,gmail.com,oracle.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-Spam-Score: -0.81
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 4BD4D21CDC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO

Mimi Zohar <zohar@linux.ibm.com> writes:

> On Tue, 2025-03-18 at 11:26 +0100, Nicolai Stange wrote:
>> Mimi Zohar <zohar@linux.ibm.com> writes:
>>=20
>> > On Thu, 2025-03-13 at 18:33 +0100, Nicolai Stange wrote:
>> > > Normally IMA would extend a template hash of each bank's associated
>> > > algorithm into a PCR. However, if a bank's hash algorithm is unavail=
able
>> > > to the kernel at IMA init time, it would fallback to extending padded
>> > > SHA1 hashes instead.
>> > >=20
>> > > That is, if e.g. SHA-256 was missing at IMA init, it would extend pa=
dded
>> > > SHA1 template hashes into a PCR's SHA-256 bank.
>> > >=20
>> > > The ima_measurement command (marked as experimental) from ima-evm-ut=
ils
>> > > would accordingly try both variants when attempting to verify a meas=
urement
>> > > list against PCRs. keylime OTOH doesn't seem to -- it expects the te=
mplate
>> > > hash type to match the PCR bank algorithm. I would argue that for the
>> > > latter case, the fallback scheme could potentially cause hard to deb=
ug
>> > > verification failures.
>> > >=20
>> > > There's another problem with the fallback scheme: right now, SHA-1
>> > > availability is a hard requirement for IMA, and it would be good for=
 a
>> > > number of reasons to get rid of that. However, if SHA-1 is not avail=
able to
>> > > the kernel, it can hardly provide padded SHA-1 template hashes for P=
CR
>> > > banks with unsupported algos.
>> > >=20
>> > > There are several more or less reasonable alternatives possible, amo=
ng
>> > > them are:
>> > > a.) Instead of padded SHA-1, use padded/truncated ima_hash template
>> > >     hashes.
>> > > b.) Record every event as a violation, i.e. extend unsupported banks
>> > >     with 0xffs.
>> > > c.) Don't extend unsupported banks at all.
>> > > d.) Invalidate unsupported banks only once (e.g. with 0xffs) at first
>> > >     use.
>> > >=20
>> > > a.) would make verification from tools like ima_measurement nearly
>> > >     impossible, as it would have to guess or somehow determine ima_h=
ash.
>> > > b.) would still put an significant and unnecessary burden on tools l=
ike
>> > >     ima_measurement, because it would then have to exercise three
>> > >     possible variants on the measurement list:
>> > >     - the template hash matches the bank algorithm,
>> > >     - the template hash is padded SHA-1,
>> > >     - the template hash is all-ones.
>> > > c.) is a security risk, because the bank would validate an empty
>> > >     measurement list.
>> > >=20
>> > > AFAICS, d.) is the best option to proceed, as it allows for determin=
ing
>> > > from the PCR bank value in O(1) whether the bank had been maintained=
 by
>> > > IMA or not and also, it would not validate any measurement list (exc=
ept
>> > > one with a single violation entry at the head).
>> >=20
>>=20
>> Hi Mimi,
>>=20
>> > What a pleasure reviewing your patch set.  Nicely organized.  Well wri=
tten patch
>> > descriptions.
>>=20
>> thank you :)
>>=20
>> > Currently with the SHA1 hash algorithm, whether it is being extended i=
nto the
>> > TPM or not, the measurement list is complete.  Relying on the ima_hash=
 in the
>> > current kernel and the subsequent kexec'ed kernel should be fine, assu=
ming if
>> > they're different hash algorithms both TPM banks are enabled.  Otherwi=
se, the
>> > measurement lists will be incomplete.
>>=20
>> Yes. However with your comment I'm now realizing there's an issue if the
>> set of supported hash algorithms differs between the previous and the
>> next, kexeced kernel -- something I admittedly hadn't thought of before.
>>=20
>> The current behavior as implemented in this RFC is that an unsupported
>> PCR bank would get invalidated *once* upon first use, i.e. extended once
>> with e.g. all 0xFEs. (Note that the actual patch implements invalidation
>> with all 0xFFs, for the choice of the exact invalidation value see
>> below). The idea is that
>> a.) tools could easily recognize this by comparing the PCR bank value
>>     against constant HASH(00 .. 00 | fe ... fe)
>> b.) and they would fail to verify any non-trivial event log against such
>>     a PCR bank if they did not do that comparison ahead.
>>=20
>> In order to implement this invalidate-once logic, there's that
>> ima_extended_pcrs_mask you asked about in reply to [3/7], the
>> preparatory patch for [4/7] ("ima: track the set of PCRs ever
>> extended"). As the set of PCRs ever to be found in any policy rule
>> cannot be predicted, their unsupported banks cannot get invalidated once
>> at __init. Hence this inalidate-at-first-extend logic, which needs that
>> tracking of PCRs ever extended as maintained in ima_extended_pcrs_mask.
>>=20
>> Upon kexec, the current patchset attempts to restore the
>> ima_extended_pcrs_mask from the previous kernel by walking through the
>> measurement list, setting a bit for each PCR found in any event.
>>=20
>> Now consider the following:
>> - some hash algorithm is supported by the initially booted kernel,
>> - but not in the subsequently kexeced one.
>>=20
>> The initially booted kernel would not invalidate the given hash
>> algorithm's bank for any PCR, and the kexeced one would neither, because
>> it would restore the ima_extended_pcrs_mask from the initially booted
>> one. However, the kexeced kernel would also not extend any further
>> events into the now unsupported PCR banks then. That means that these
>> PCR banks would happily verify a measurement list truncated to the point
>> before the kexec, which is of course bad.
>>=20
>>=20
>> I can see two ways around this:
>> a.) Give up on the invalidate-once scheme, unconditionally invalidate
>>     unsupported banks (with 0xfe .. fe) for every new measurement list
>>     entry.
>>=20
>> b.) Make the kexeced kernel to read back PCR banks it doesn't support
>>     from the TPM at __init and see if they had been invalidated by the
>>     previous kernel. Set the bit in ima_extended_pcrs_mask *only* if so.
>>     That is, invalidate unsupported and not yet invalidated PCR banks
>>     upon first use.
>>=20
>>     Also, make it read PCR banks it does support and refrain from
>>     further extending any found to have been invalidated before (for all
>>     PCRs mentioned in the measurement list). That is, leave previously
>>     invalidated PCR banks alone.
>>=20
>> Going with a.) would mean that verifiers would not be able to recognize
>> in O(1) anymore that some bank was unsupported and had not been
>> maintained by the kernel. It would still be possible to figure in linear
>> time whether neither of the kernels in a kexec chain covered by a single
>> measurement list did support a given PCR bank hash.
>>=20
>> For implementing b.), one would have to store a table of precomputed
>> HASH(00 .. 00 | fe .. fe) values for every recognized hash possible in
>> .rodata for comparison purposes, i.e. for every entry in
>> tpm2_hash_map[5] at least -- after all, the whole point is to deal with
>> hashes for which no implementation is available to the kernel, so these
>> values cannot get computed dynamically at runtime.
>>=20
>> With that, if the initially booted kernel did not support some hash
>> algorithm, it would be recognizable by verifiers in O(1) time.
>>=20
>> If the initially booted kernel did support a given hash, but a
>> subsequent kernel in the kexec chain would not, the PCR would get
>> invalidated by the latter. This sitatuation cannot be detected at all
>> (with reasonable effort) from the final PCR hash bank value alone and
>> verification against it would fail then. Perhaps it's noteworthy that
>> this is true with any possible scheme, including the currently
>> implemented one extending with padded SHA1 into unsupported banks.
>>=20
>>=20
>> I think that the decision about what to do now boils down to whether
>> there's any value in verifiers being able to tell that a PCR bank had
>> been unsupported and not been maintained rather than to simply fail its
>> verification if attempted.
>>=20
>> If it is not important, or linear time + the additional implementation
>> complexity burden at the verifier side is acceptable, the much simpler
>> a.) would do.
>>=20
>> Otherwise I could give implementing b.) a try and see how bad the
>> resulting code would get.
>>=20
>> What do you think?
>
> Let me try to summarize 'b'.  The initial unsupported hash algorithms wou=
ld
> continue to be unsupported in subsequent kexec's.  However this does not =
address
> the case where the initial kernel image supported a hash algorithm, but t=
he
> subsequent kexec'ed image does not.  The TPM bank has already been extend=
ed with
> other values.  In this case, like the original violation the attestation =
service
> would not verify.  If I'm understanding it correctly, 'b' is thus a parti=
al
> solution.

Yes, that all matches exactly what I was trying to say. FWIW, I might be
way too naive, but I would expect two categories of existing verifier
behaviors:
- "Real" ones like keylime or so, which are being asked to verify
  against a single specific bank and the result is either yes or no with
  no inbetween.  In particular, these wouldn't fallback to checking
  whether something else like padded SHA1s would perhaps verify.
- The ones more in the development/debugging/testsuite realm, which
  would attempt to verify against all banks and fail (the test?) if any
  does not verify. These would try harder to avoid false negatives by
  testing for the alternatives like padded SHA1s as well. I suppose
  ima-evm-utils' ima_measurement would qualify as such one.

For the first class, simply invalidating the unsupported PCR banks
somehow, i.e. option a.), is good enough. For the second kind however,
the question is whether something like b.) would be helpful and the
additional complexity on the kernel side warranted. But agreed, it's a
partial and best-effort solution. If one kexecs into a kernel with a
proper subset of supported TPM bank hashes, it wouldnt't work.


> My concern with 'b' is the ability to read the multiple TPM bank PCRs so =
early
> during kernel initialization.  Will it succeed?  If it does succeed, will=
 it
> introduce initialization delays?

As the boot aggregate gets extended already at that point in time
(IIRC), I'd expect that reading the PCRs would probably succeed as
well. For the delays imposed on the kexec restore path -- I can't tell
unfortunately. But I would only do it on kexec restore if the
measurement list is non-empty anyway, so systems not having IMA enabled
or ones which wouldn't kexec are not affected.


> FYI, because the IMA Kconfig selects SHA1, we're guaranteed that SHA1 exi=
sts in
> the kernel and the subsequent kexec'ed kernel.  For this reason we're gua=
ranteed
> that the measurement list is complete.  The simplest solution, not necess=
arily
> the best, would be to punt the problem for the time being by replacing the
> "select" with a different hash algorithm.

Yes, that would work as well. IIUC, it would mean that we would
e.g. extend truncated SHA-256 template hashes into a SHA-1 bank, right?
However, since no existing tool like 'ima_measurement' is expecting
that, and would fail a verification then, I'm currently struggling to
see the advantage over just doing a.) and invalidating the PCR banks
with a fixed value right away?


>> > This patch set introduces a new definition of integrity violation. Pre=
viously it
>> > was limited to open-writers and ToMToU integrity violations.  Now it c=
ould also
>> > mean no kernel hash algorithm available.  Unfortunately some attestati=
on
>> > services simply ignore integrity violations.
>>=20
>> Yeah, there's indeed an ambiguity. I think the right thing to do is to
>> make measurement lists unverifiable against unsupported banks and would
>> propose to use 0xfe ... fe for the associated invalidations instead of
>> the 0xff .. ff used for violation events already.
>
> I just realized that unlike the existing open-writers/ToMToU violations, =
by
> definition the new unsupported bank violation would not be included in the
> measurement list, but just extended into the TPM.

That's true, but when invalidating unsupported banks with a single ff
... ff, one could successfully verify a measurement list having only a
single violation entry against an invalidated bank AFAICS. I think it
would be more robust to use a different constant for the invalidation.

Thanks!

Nicolai


>> > > So implement d.). As it potentially breaks existing userspace, i.e.
>> > > the current implementation of ima_measurement, put it behind a Kconf=
ig
>> > > option, "IMA_COMPAT_FALLBACK_TPM_EXTEND". If set to "y", the original
>> > > behavior of extending with padded SHA-1 is retained. Otherwise the n=
ew
>> > > scheme to invalidate unsupported PCR banks once upon their first ext=
ension
>> > > from IMA is implemented instead. As ima_measurement is marked as
>> > > experimental and I find it unlikely that other existing tools depend=
 on
>> > > the padded SHA-1 fallback scheme, make the IMA_COMPAT_FALLBACK_TPM_E=
XTEND
>> > > Kconfig option default to "n".
>> > >=20
>> > > For IMA_COMPAT_FALLBACK_TPM_EXTEND=3Dn,
>> > > - make ima_calc_field_array_hash() to fill the digests corresponding=
 to
>> > >   banks with unsupported hash algorithms with 0xffs,
>> > > - make ima_pcr_extend() to extend these into the unsupported PCR ban=
ks only
>> > >   upon the PCR's first usage, skip them on subsequent updates and
>> > > - let ima_init_ima_crypto() help it with that by populating the new
>> > >   ima_unsupported_tpm_banks_mask with one bit set for each bank with
>> > >   an unavailable hash algorithm at init.
>> > >=20
>> > > [1] https://github.com/linux-integrity/ima-evm-utils
>> > >=20
>> > > Signed-off-by: Nicolai Stange <nstange@suse.de>
>> > > ---
>>=20
>

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

