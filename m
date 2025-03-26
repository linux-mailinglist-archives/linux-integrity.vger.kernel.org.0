Return-Path: <linux-integrity+bounces-5428-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67103A71095
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 07:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27199189015C
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 06:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3286418E750;
	Wed, 26 Mar 2025 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OY3XEinK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pTYtWRcR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OY3XEinK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pTYtWRcR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251215381A
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742970846; cv=none; b=ln15GN6mfTXPVut1jBLfpK8FWuZcsZi9UTHHRsNNfNLQZT7Oqqudw8GhgbDjgD8xjH6gIVwm7vJkzmqn8SpdetH7dhMZ3frRm9i64tE+kSFAjlzTfwqfAE6OQMwGa49WjRXH3xb4f5XFD5iMrNgAOJgOX2acgfh+sU0/LDm/kZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742970846; c=relaxed/simple;
	bh=9zav64XBELO2rxde9ChRMOgvN7iEcgi6P6AKIhj053w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XycViB2KMcitux4g8D8K9dLLelh8bsAdTevtQSIDc70a/fHuSR0f81m4C4Lx0O0hjToviMTLK9nMOehrAs+x8Szl0zcx9A0xU8Ni5cPtHPQp7ThYu+rOg4mojr3E5Mc4T8SAC+mCmB0mGP8dxJ5cSbv3+mTZ7KM7Sr2uGSB1qtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OY3XEinK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pTYtWRcR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OY3XEinK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pTYtWRcR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DB4E1F391;
	Wed, 26 Mar 2025 06:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742970842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5lO1CvYevwJtjnVdy0mhrufgFCHw/Q2ueX7SBARC9Q=;
	b=OY3XEinKpcqWlhZfhtPF/6lM3PB8am70iBadM2cQ8vCPZuJaFjo7KTunaDQZN0RqYVd/Gz
	Lke09/wvEGRMpC96XvDbAZA2OZHwtuqeLluhU6zIgLx+d1DrW7xKyMMzv+ASGr1gmGX3t6
	FVsYmz1Ns+sKnhLemxZnHGJWOT0MoU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742970842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5lO1CvYevwJtjnVdy0mhrufgFCHw/Q2ueX7SBARC9Q=;
	b=pTYtWRcReO9YbuCwOnwydnHFpTXHTddIpH6wiRHriaZ8d+2Yaelua4lMx45XPXeiPX0P3n
	EHLa7adWN53XvHCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742970842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5lO1CvYevwJtjnVdy0mhrufgFCHw/Q2ueX7SBARC9Q=;
	b=OY3XEinKpcqWlhZfhtPF/6lM3PB8am70iBadM2cQ8vCPZuJaFjo7KTunaDQZN0RqYVd/Gz
	Lke09/wvEGRMpC96XvDbAZA2OZHwtuqeLluhU6zIgLx+d1DrW7xKyMMzv+ASGr1gmGX3t6
	FVsYmz1Ns+sKnhLemxZnHGJWOT0MoU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742970842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5lO1CvYevwJtjnVdy0mhrufgFCHw/Q2ueX7SBARC9Q=;
	b=pTYtWRcReO9YbuCwOnwydnHFpTXHTddIpH6wiRHriaZ8d+2Yaelua4lMx45XPXeiPX0P3n
	EHLa7adWN53XvHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA58D13927;
	Wed, 26 Mar 2025 06:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gp39M9mf42cyLwAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 06:34:01 +0000
From: Nicolai Stange <nstange@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Nicolai Stange <nstange@suse.de>,  Mimi Zohar <zohar@linux.ibm.com>,
  Roberto Sassu <roberto.sassu@huawei.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,  Eric Snowberg <eric.snowberg@oracle.com>,
  Jarkko Sakkinen <jarkko@kernel.org>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/13] tpm: authenticate tpm2_pcr_read()
In-Reply-To: <300575957cee207c4191b8bc70219d13d467fdd7.camel@HansenPartnership.com>
	(James Bottomley's message of "Sun, 23 Mar 2025 13:25:15 -0400")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-11-nstange@suse.de>
	<300575957cee207c4191b8bc70219d13d467fdd7.camel@HansenPartnership.com>
Date: Wed, 26 Mar 2025 07:34:01 +0100
Message-ID: <87ecyks3l2.fsf@>
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
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
>> PCR reads aren't currently authenticated even with
>> CONFIG_TCG_TPM2_HMAC=3Dy yet.
>
> The reason being TPM2_PCR_Read can only support an audit session, so it
> has even more overhead than the usual HMAC session for something you
> don't care about and because no-one relies on plain reads anyway,
> relying entities use quotes.
>
>> It is probably desirable though, as e.g. IMA does some PCR reads to
>> form the cumulative boot digest subsequently extended into PCR 10 (an
>> operation which *is* authenticated).
>
> Could you elaborate on what security properties this adds?  I can't see
> any form of attack that could be done by altering the boot aggregate:
> either the relying party cares, in which case it will quote the boot
> log and arrive at its own value, or it doesn't, in which case the value
> in the log is superfluous.

Thanks a lot for the explanation, it makes a lot of sense now. The above
was assumption based, along the lines of "the boot_aggregate gets
measured into the IMA PCR, therefore committing to its value must serve
some purpose and the extended value should probably be genuine".

I would like to make it clear that my main motivation for this patch
wasn't about the IMA-measured boot_aggregate integrity, but more about
not getting blamed for (silently) breaking the null_key auth based
protection guarantees provided for IMA's PCR extends with the last patch
in this series (which would skip some extends conditioned on what's
previously been read). FWIW, it's been agreed upon to split this series
in batches, with the first one extending to up to [9/13] only, so this
patch here wouldn't be part of that.

>> +		/*
>> +		 * Exclusivity is not needed, but set in the
>> response.
>> +		 * Set it here too, so that the HMAC verification
>> +		 * won't fail.
>> +		 */
>> +		tpm_buf_append_hmac_session(chip, &buf,
>> TPM2_SA_AUDIT
>> +					    |
>> TPM2_SA_AUDIT_EXCLUSIVE,
>> +					    NULL, 0);
>
> Exclusivity here requires no other command be unaudited between the
> session starting and now.  That means that with the lazy flush scheme
> you have a reasonable chance of this being violated and triggering an
> error on the command.

Noted, I didn't realize there's a lazy flushing scheme in place.

Thanks!

Nicolai

>
> Additionally, the response will only have the exclusive flag set if the
> above condition (no other unaudited command since session start) is
> true, which it might not be.  The problem you're having is that
> tpm2_auth_check_hmac_response() uses the command session flags to
> calculate the rpHash, which is a useful short cut because for non-audit
> sessions they're always the same.  If you want to use audit sessions,
> you have to teach it to dig the response session flags out of the
> header and use them instead.
>

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

