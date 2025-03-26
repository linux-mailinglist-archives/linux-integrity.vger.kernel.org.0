Return-Path: <linux-integrity+bounces-5440-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59624A717B9
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 14:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4E7A3ABE
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19E1EB5C0;
	Wed, 26 Mar 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zY9ntoT0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZApb6cmH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uxP/yxEv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7I2Syf60"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13D42A97
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996774; cv=none; b=YiyF890rORcibgvLUvAJ4cM5SFOvkiGEooHnklnHB+CtLMdxvovmp59cEBODwVZZSgxf/QWgxKvV3HL5n7BJwMOyfQawKQa7/BDKO+wB3MgVahTakvquYDvPg3iKvZJ1qmqQRfM5k71/7T7fVKyKR0+UY3f86DN2htnovSCQblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996774; c=relaxed/simple;
	bh=3fXF0s7Lr97Mx30wHkU7YdB2Bni6vue4HSrPiKMG7kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UprLie9lB67Dx6k+jIj9ipAcpSN3cXfVM8XvbfqkUrUxHBttnhkGlF9/J4Yu6jL6iifhwJ91gLZbRMgmUAGgXCBzeN+O8f/+rjguRqHAY9rOV2SzrUHKFmm4t9AD+yovfZymVj+n1wrUALzVg+lD3ysL4z4TB7+nF2xQY5gnK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zY9ntoT0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZApb6cmH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uxP/yxEv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7I2Syf60; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D69E81F44E;
	Wed, 26 Mar 2025 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742996765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTG/Q8no1YkK7xiuHcS7e1v3axl5d4cauK+3RFAeiBw=;
	b=zY9ntoT0VworqMSXYhm3W+mJ7v1PV5nB5LFAV9tr6/a4Q+lP4ZaEhEw8oqUequdWwR9aOW
	S0T1UDvzCVNioQe77CDxCxwBAvI5IIBz2jotnfv3XIuTlyBjjyCEk4kdSoBe1vAwqFCuxR
	QPCcgQkwYsM4bpox7VLPl/PTR4DN+1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742996765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTG/Q8no1YkK7xiuHcS7e1v3axl5d4cauK+3RFAeiBw=;
	b=ZApb6cmH4iiwyllFeyGJzvplvLFixeU98E7MWaEesl98/r9hextN1HqNKM1xRgYQ2zn4Tn
	eVwjLCOS4wu1jkCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742996764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTG/Q8no1YkK7xiuHcS7e1v3axl5d4cauK+3RFAeiBw=;
	b=uxP/yxEvb05prcMPpSQkDwCwI4/ezeFMPuF2kzsZyrM93G7A6LOwvqvUyBu0lb8lwUanTM
	JKu/L+3DSg6T7rqGIXZdAexvmlnA+14R7mwJVKUfPKoi6hcL6Zb6rH3oeMRYARXLAFaUis
	oaUuVks8JAbnlUcrAj4RAGDX7yZ862Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742996764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTG/Q8no1YkK7xiuHcS7e1v3axl5d4cauK+3RFAeiBw=;
	b=7I2Syf601hxMxDyXIrpq7WTI7OILFQeHwkansOtUhYWK0WNbFEN4AeeTR1xGMgSanknUpt
	SbyCLeyDmtPujkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FC781374A;
	Wed, 26 Mar 2025 13:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iiqUHRwF5GcOOQAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 13:46:04 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>,  James Bottomley
 <James.Bottomley@HansenPartnership.com>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/13] ima: always create runtime_measurements
 sysfs file for ima_hash
In-Reply-To: <fbd87f01b5463e399900df8dcb094a9039bd589f.camel@linux.ibm.com>
	(Mimi Zohar's message of "Wed, 26 Mar 2025 09:17:05 -0400")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-3-nstange@suse.de>
	<35d199c2a09e9215aad715c97a6702dd04be4a98.camel@linux.ibm.com>
	<fbd87f01b5463e399900df8dcb094a9039bd589f.camel@linux.ibm.com>
Date: Wed, 26 Mar 2025 14:46:03 +0100
Message-ID: <87wmcboqg4.fsf@>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Mimi Zohar <zohar@linux.ibm.com> writes:

> On Wed, 2025-03-26 at 09:21 +0100, Nicolai Stange wrote:
>> Mimi Zohar <zohar@linux.ibm.com> writes:
>>=20
>> > On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:

>> > "ima_hash" is the default file hash algorithm.  Re-using it as the def=
ault
>> > complete measurement list assumes that the subsequent kexec'ed kernels=
 configure
>> > and define it as the default file hash algorithm as well, which might =
not be the
>> > case.
>>=20
>> I don't really see why the ima_hashes would have to match between kexecs
>> for this to work -- all events' template hashes are getting recreated
>> from scratch anyway after kexec (ima_restore_measurement_list() ->
>> ima_calc_field_array_hash()).
>>=20
>> That is, if ima_hash=3Dsha256 first, and ima_hash=3Dsha384 after kexec, =
one
>> would have *runtime_measurements_sha256 first and
>> *runtime_measurements_sha384 after kexec. And both had exclusively
>> template hashes of their respective algo in them each.
>>=20
>> What am I missing?
>
> Your solution would work nicely, if the "ima_hash" algorithm could be gua=
ranteed
> to be built into the kernel.  It's highly unlikely someone would choose a=
 hash
> algorithm not built into kernel, but it is possible.  hash_setup() only v=
erifies
> that the hash algorithm is a valid name.

But ima_init_ima_crypto(), hence the whole IMA __init, would fail if
ima_hash was unavailable at __init time?

Thanks,

Nicolai

> Either fix hash_setup() to guarantee that the chosen hash algorithm is bu=
ilt
> into the kernel or use the CONFIG_IMA_DEFAULT_HASH and add a Kconfig to s=
elect
> the hash algorithm.  This would be in lieu of v2 05/13.
>
>> > Drop this patch.
>>=20
>> Fine by me, but just to confirm, in case there's no TPM attached and
>> SHA1 was disabled, there would be no /sys/*/*runtime_measurement* at all
>> then. Is that Ok?
>
> Of course not.  :)
>
>> ima_hash was chosen here only, because after this series, it will be the
>> only single algorithm guaranteed to be available.
>
> With the proposed changes to "[RFC PATCH v2 05/13] ima: select CRYPTO_SHA=
256
> from Kconfig', SHA256 would be added to the "extra" measurements if the T=
PM
> SHA256 bank is disabled.


--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

