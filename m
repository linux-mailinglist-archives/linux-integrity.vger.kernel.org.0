Return-Path: <linux-integrity+bounces-5435-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8571AA7143F
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 10:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4720E174C44
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8208D1B0F31;
	Wed, 26 Mar 2025 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GGQ9DGo1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="81/qTr3x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GGQ9DGo1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="81/qTr3x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C141A5B9E
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982969; cv=none; b=jtdDPKtaxbUuumYO7ZmYfrzyGx2O6erTpf1rN6fNiaas6rBQC4A6uojf/0hap8RMixLmE3ir/w36o3j+hvOLKThhJEFGqIM8g1WKCTp3i30vMZ/s+T8fs/fRod1QgKI3JLRI6a6w+FVOBAWx8AMnK0JMRV8eQEtqfbNhVyaAr80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982969; c=relaxed/simple;
	bh=wVei9JOwEWOYgm/JalL6QgMkM57oclEqhIfwU2xCgUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DM1RT5u3/RCccFGtgCfuFm3SMugcp+zWnPmb9fSWvzqlDylgS+RVJTMky+EXFK/iegHGbk3kuYntLXW+HKj9S1N27vkjcVCuOivUHtcytQlgQJ6O13o2Y2AO5wDd0ukkgMcJdnXoEziS7jdW0awU78zIBYD7piE7jLJCL4+Mf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GGQ9DGo1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=81/qTr3x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GGQ9DGo1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=81/qTr3x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7504721164;
	Wed, 26 Mar 2025 09:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742982964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xk93waxRhnduMRjz5Sx0DPymopyidmm+ilySXgLSCcI=;
	b=GGQ9DGo1/AhxjsdcHCG1vbrnfxQio672lyagU+m/FBUL4Xdk+0Gc79iE2d33soXKZa14Qz
	GyBa/n6mZtVStK86wG8C496OFWwAue9SXTQhjtMkm8ynYi9nUnLw1oex3Gs1jcjjr0Nuid
	ICt37so0k1Vgrf3fFF7jPk4LVenmzZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742982964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xk93waxRhnduMRjz5Sx0DPymopyidmm+ilySXgLSCcI=;
	b=81/qTr3xm3H0dXeJOvjrbLTsXWxP7oTdBojntQuD3YCbdS0ItE+TpBGaQspNHIshhwP2Um
	Dj4Ks9be1O/mVlCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742982964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xk93waxRhnduMRjz5Sx0DPymopyidmm+ilySXgLSCcI=;
	b=GGQ9DGo1/AhxjsdcHCG1vbrnfxQio672lyagU+m/FBUL4Xdk+0Gc79iE2d33soXKZa14Qz
	GyBa/n6mZtVStK86wG8C496OFWwAue9SXTQhjtMkm8ynYi9nUnLw1oex3Gs1jcjjr0Nuid
	ICt37so0k1Vgrf3fFF7jPk4LVenmzZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742982964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xk93waxRhnduMRjz5Sx0DPymopyidmm+ilySXgLSCcI=;
	b=81/qTr3xm3H0dXeJOvjrbLTsXWxP7oTdBojntQuD3YCbdS0ItE+TpBGaQspNHIshhwP2Um
	Dj4Ks9be1O/mVlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FEF21374A;
	Wed, 26 Mar 2025 09:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5pVyCjTP42fsbAAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 09:56:04 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>,  James Bottomley
 <James.Bottomley@HansenPartnership.com>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 08/13] ima: track the set of PCRs ever extended
In-Reply-To: <3cd5975b7a5773e1d3f1017c35b2e48222eb2d4a.camel@linux.ibm.com>
	(Mimi Zohar's message of "Tue, 25 Mar 2025 13:09:53 -0400")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-9-nstange@suse.de>
	<3cd5975b7a5773e1d3f1017c35b2e48222eb2d4a.camel@linux.ibm.com>
Date: Wed, 26 Mar 2025 10:56:03 +0100
Message-ID: <874izgp13g.fsf@>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,huawei.com,gmail.com,oracle.com,kernel.org,HansenPartnership.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Mimi Zohar <zohar@linux.ibm.com> writes:

> On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
>> Right now, PCR banks with unsupported hash algorithms are getting
>> invalidated over and over again for each new measurement list entry
>> recorded.
>>=20
>> A subsequent patch will make IMA to invalidate PCR banks associated with
>> unsupported hash algorithms only once at a PCR's first use. To prepare f=
or
>> that, make it track the set of PCRs ever extended.
>>=20
>> Maintain the set of touched PCRs in an unsigned long bitmask,
>> 'ima_extended_pcrs_mask'.
>>=20
>> Amend the IMA_INVALID_PCR() #define to check that a given PCR can get
>> represented in that bitmask. Note that this is only for improving code
>> maintainablity, it does not actually constain the set of allowed PCR
>> indices any further.
>>=20
>> Make ima_pcr_extend() to maintain the ima_extended_pcrs_mask, i.e. to set
>> the currently extented PCR's corresponding bit.
>>=20
>> Note that at this point there's no provision to restore the
>> ima_extended_pcrs_mask value after kexecs yet, that will be the subject =
of
>> later patches.
>>=20
>> Signed-off-by: Nicolai Stange <nstange@suse.de>
>
> Hi Nicolai,
>
> IMA extends measurements in the default TPM PCR based on the Kconfig
> CONFIG_IMA_MEASURE_PCR_IDX option.  Normally that is set to PCR 10.  The =
IMA
> policy rules may override the default PCR with a per policy rule
> specific PCR.

Yes, that matches my understanding.


> INVALID_PCR() checks the IMA policy rule specified is a valid PCR registe=
r.
>
> Is the purpose of this patch to have a single per TPM bank violation or m=
ultiple
> violations, one for each PCR used within the TPM bank?

One for each PCR individually, issued when a given PCR is being
referenced for the first time from some IMA event.

Thanks!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

