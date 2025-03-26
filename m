Return-Path: <linux-integrity+bounces-5429-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91431A71199
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 08:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BCA188F34B
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA82319E971;
	Wed, 26 Mar 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g2dBOKFE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="95zpjipH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g2dBOKFE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="95zpjipH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578918B47C
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975052; cv=none; b=lFYk6sOx8JTp6+cpDbSbPonIN/+tOVoKwX/pZCY4o7C4/JGteBzcTP9rxvx5hYySl0HLVlWVCTZIBqhD9xcyd0PXub4UNtj9FU7ZIF0c2yYpc6+2vPiAxDZN7ojNArsrPjJ/RHBVvUzhgnRcc/LNpP6cGwj/u/l+FnXsxN+1W1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975052; c=relaxed/simple;
	bh=tqPkgVSbn2CEzOhe6WnsQWZ/1vrodNUni94BJnIKrrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHPP0kCBaxeP4EG6eSf7g2s8xtN70K78YBe+vthqWdiXcmk9mQI0M232Ph/s+UUggxLEup8yyXOn0n4TSqeG/OFuYRxaHUUh2wCw4zKDqjmja+i9xy26PJKfQ1hGQW8lmxk/hvA2ybwO9BJrohypd23v3CfjVXUpIsZe53eMsxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g2dBOKFE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=95zpjipH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g2dBOKFE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=95zpjipH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 032181F391;
	Wed, 26 Mar 2025 07:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742975049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H14cf0h4hA1iZJ4ft6h1BcTqrmXePBdkHIS0VqKvXRY=;
	b=g2dBOKFEW0KSc+QwbEX1MTssE8u6dtOdn/y1mYBnyi4Y2qpbc4jN11Ac4yyswlkaGJfOm9
	QgvMopbFgr3WLQOu7PapaDAPVjMgtndH76iJepUuKgxcI46/4Ehvt1Y2i1eNa42E5EFkyA
	84OAOBps26nAHaWR+fkiXo3ixjw3/b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742975049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H14cf0h4hA1iZJ4ft6h1BcTqrmXePBdkHIS0VqKvXRY=;
	b=95zpjipHkaWn/tKoOgUJAV9jihVBdg9DuLRUyukCLBHzKylEfC2v10p8BXARi6sLvVAZaE
	wc+DqLyjViHUsMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742975049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H14cf0h4hA1iZJ4ft6h1BcTqrmXePBdkHIS0VqKvXRY=;
	b=g2dBOKFEW0KSc+QwbEX1MTssE8u6dtOdn/y1mYBnyi4Y2qpbc4jN11Ac4yyswlkaGJfOm9
	QgvMopbFgr3WLQOu7PapaDAPVjMgtndH76iJepUuKgxcI46/4Ehvt1Y2i1eNa42E5EFkyA
	84OAOBps26nAHaWR+fkiXo3ixjw3/b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742975049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H14cf0h4hA1iZJ4ft6h1BcTqrmXePBdkHIS0VqKvXRY=;
	b=95zpjipHkaWn/tKoOgUJAV9jihVBdg9DuLRUyukCLBHzKylEfC2v10p8BXARi6sLvVAZaE
	wc+DqLyjViHUsMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B49551374A;
	Wed, 26 Mar 2025 07:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0RllKkiw42d1QwAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 07:44:08 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>,  James Bottomley
 <James.Bottomley@HansenPartnership.com>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/13] ima: don't expose runtime_measurements for
 unsupported hashes
In-Reply-To: <0e7ca7094baf8f9968e72b43441745c420d61215.camel@linux.ibm.com>
	(Mimi Zohar's message of "Tue, 25 Mar 2025 10:26:51 -0400")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-2-nstange@suse.de>
	<0e7ca7094baf8f9968e72b43441745c420d61215.camel@linux.ibm.com>
Date: Wed, 26 Mar 2025 08:44:08 +0100
Message-ID: <87a598s0c7.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.60
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,huawei.com,gmail.com,oracle.com,kernel.org,HansenPartnership.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Mimi Zohar <zohar@linux.ibm.com> writes:

> On Sun, 2025-03-23 at 15:08 +0100, Nicolai Stange wrote:
>> IMA creates one runtime_measurements_<hash-algo> sysfs file for every TPM
>> bank + for SHA1 if not covered by any such. These differ only in that the
>> template hash value for each record is of the file's associated algorithm
>> each.
>>=20
>> The kernel does not necessarily support each hash algorithm associated
>> with some TPM bank though -- the most common case probably being that the
>> algorithm is not built-in, but provided as a module, if at all, and thus
>> not available at IMA init time yet.
>
> At least from an IMA perspective, the IMA Kconfig selects "CRYPTO_SHA1", =
making
> it the only crypto hash algorithm required to be built into the kernel.
>>=20
>> If that happens to be the case, the behavior is a bit counter-intuitive:
>> probably for historic reasons and to still extend the TPM bank with
>> something, a record's template hash is filled with the padded SHA1 value.
>> That is, it is perfectly possible that runtime_measurements_sha256 conta=
ins
>> padded SHA1 template hashes if SHA-256 was unavailable at IMA init.
>
> As you explained in "[RFC PATCH v2 09/13] ima: invalidate unsupported PCR=
 banks
> only once", not extending the TPM bank:
>   b.) is a security risk, because the bank would validate an empty measur=
ement
> list.
>
> The solution was to extend a padded SHA1 digest, which could still be ver=
ified.
> The question boils down to whether extending the TPM bank with a valid, m=
aybe
> deprecated hash algo, is better than not extending it at all.  Was that t=
he
> right solution?  I believe it was at the time.  SHA1 was being deprecated=
 for
> specific use cases, not all usecases.

No doubt about that, I'll drop the "counter-intuitive" part. Even now
(or by 2030 to be more specific), it should be only FIPS users caring
about SHA1 in this context at all.


> So the question is what to do going forward.
>
>>=20
>> I would argue that it's likely that no existing userspace tool is relying
>> on this fallback logic -- they either wouldn't consume the hash value fr=
om
>> the measurement list directly but recreate it by themselves, as is requi=
red
>> for verification against PCRs, or, if they did, they would somehow assum=
e a
>> hash algorithm and expect the hashes in the measurement list to be of th=
at
>> type. If of the latter kind, this could even lead to hard to debug
>> verification failures. For example, from looking at keylime's current
>> code, the verifier logic seems to assume that the template hashes found
>> in the provided measurement list are of the configured 'ima_log_hash_alg'
>> type. In particular, it does not check against padded SHA1 upon
>> mismatch.
>
> The downside, if none of the TPM bank hash algorithms are configured as b=
uiltin
> in the kernel, is the lack of a measurement list.

Yes. Just for the record, going forward SHA256 will be, with [v2 05/13]. So
unless the SHA256 bank is disabled by firmware, it should be fine then.


> True, not implementing the fallback is simpler, but it is their
> choice.

The point I was trying to make is that no tool currently exists that
would successfully verify a /sys/*/*runtime_measurements_sha256 with
SHA1s template hashes in it. keylime would not as outlined above, and
ima-evm-utils ima_measurement command wouldn't either, because it works
only on /sys/*/*runtime_measurements_sha1 to begin with. (I previously
missed the latter fact, but its ima_verify_template_hash() does a
hard-coded SHA1). That is, ima_measurement's fallback logic only
applies to the PCR validations, not to the sysfs files.


>> That being said, there's also another dimension: currently IMA has a
>> hard requirement on SHA-1 and subsequent patches in this series will
>> attempt to get rid of that. If SHA-1 is not available at IMA init though,
>> it would also mean that padded SHA-1 values cannot get filled in as a
>> fallback for other unsupported algorithms. Substituting something like
>> hard coded all-zeroes or all-ones would be dangerous, because some
>> application or user scripts could perhaps (ab)use the template hashes fr=
om
>> the exported measurement lists for some kind of fingerprinting scheme or
>> so.
>
> Agreed, using the open-writer/ToMToU integrity violation to indicate an
> unsupported TPM bank would not be a good idea.
>
>>=20
>> In conclusion, I think it's best to not create the
>> runtime_measurements_<hash-algo> sysfs files for hash algorithms not
>> supported by the kernel. That way, applications expecting a certain
>> hash algorithm for the measurement list and which are not able to handle
>> the padded-SHA1 fallback scheme would fail with a clear indication on wh=
at
>> the proem is. Furthermore, as digests for unsupported banks are not
>> getting exposed to userspace anymore, we'll have all flexibility to
>> set it to any value internally, including all-ones as will be needed in
>> a subsequent patch when addressing PCR extend for unsupported banks.
>>=20
>> So, do not create runtime_measurements_<hash-algo> sysfs files for
>> unsupported hash algorithms. Likewise for their ascii counterparts.
>>=20
>> Note that at this point, SHA-1 is still mandatory, and thus,
>> runtime_measurements_sha1 as well as the "runtime_measurements" will
>> remain there, even though the code has provisions already to skip their
>> creation as well in case SHA-1 was unavailable.
>>=20
>> Signed-off-by: Nicolai Stange <nstange@suse.de>
>>=20
>
> If the purpose of this patch set is to actually remove IMA's dependency o=
n a
> working SHA-1, at some point the Kconfig "select CRYPTO_SHA1" needs to be
> removed.  Otherwise the kernel will be built with SHA1 builtin
> (CONFIG_CRYPTO_SHA1=3Dy).

I should have described it better. In the first step at least, the goal
is to remove the runtime dependency only. Because when SHA1's
->fips_allowed in crypto/testmgr.c gets flipped to false, SHA1
instantiation would fail with -ENOENT if the kernel was booted with a
fips=3D1 on its command line. Users not interested in FIPS, i.e. the vast
majority, might still want to use SHA1 and there's no real reason not
to.

But yes, it would definitely make sense to drop the CRYPTO_SHA1 dep, at
least at some point. Perhaps by simply moving it to the new
IMA_COMPAT_FALLBACK_TPM_EXTEND. I would personally not do that now
though, just in case there'll be some unexpected fallout from this
series.


> If the purpose of this patch set is preparatory for eventually removing t=
he SHA1
> dependency, then the cover letter and the patch descriptions should indic=
ate
> that.
>
> Assuming the latter, other than updating the patch description, the patch=
 is
> fine.
>
> Before posting the non-RFC version of this patch, please trim the patch
> description.

Point taken.


> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks _a lot_!

Nicolai

>
--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

