Return-Path: <linux-integrity+bounces-5312-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D2A6732F
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 12:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7185D167C46
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584792080E3;
	Tue, 18 Mar 2025 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Baa749my";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0mxJ8sxS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Baa749my";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0mxJ8sxS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C168207E12
	for <linux-integrity@vger.kernel.org>; Tue, 18 Mar 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298859; cv=none; b=H5pp1dV8NU8RwwbJ2z6LZ+VhbC9JFZah7t2hguVtSVeVYCv9LH3azzLtRYomATE8c9T79DNq8+nicK1bLXftqdxPrF+Xi/XpJJ1QXP6G4wpvgJzJ8NxgUE2XYmQ6ql8VH3ORat/+n8nzyr6J8sEzdu57hDxcDzSydjLCu1zP8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298859; c=relaxed/simple;
	bh=EqZUIlLw/jwO3LBiJCfM7y3AEPTrVCIp8EAM4HXXbZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MP7kKGEssumCumP/8Qm9KtSYyBTFYWsclhGN90SfSSkbvteJqPpCbnjP7y+hshptOkMLDRNDRTICSnCvf3XcxM/kbwzKkYVKkgNZNqqqychWgcVqCJrmhvPIjMvQ0OMHA0je5tm4FgMZ58fyN/Yq9U48PbN3rnzkgSRxLc01XkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Baa749my; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0mxJ8sxS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Baa749my; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0mxJ8sxS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78B631F827;
	Tue, 18 Mar 2025 11:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742298855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0UG6kzBcoboMdXZNxJy/iqEM0YPu9mcSX4Ke+dMoOs=;
	b=Baa749my6eY5grgndtwI1dabG5fks6tB8JzqAkZp/RQpdgC/tORs2slvdYzCPHWvMmfGbb
	y+2CoDn0TDuMgV3qRzY+jkChO2b/pidk5B+J+h6cIrDzvw9Xut/M7myMDxrdXCOwCrQRHE
	jMMHww3n8FsY3pSXJQstoxB7qPMRUd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742298855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0UG6kzBcoboMdXZNxJy/iqEM0YPu9mcSX4Ke+dMoOs=;
	b=0mxJ8sxSQ0i9BRvuDKeO8nV+QJxBiz2xQdczKjWtwSZg9CHIL/chnpQBrXo9XWSUH1smxo
	Bu91/xkTyNW+hpAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Baa749my;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0mxJ8sxS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742298855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0UG6kzBcoboMdXZNxJy/iqEM0YPu9mcSX4Ke+dMoOs=;
	b=Baa749my6eY5grgndtwI1dabG5fks6tB8JzqAkZp/RQpdgC/tORs2slvdYzCPHWvMmfGbb
	y+2CoDn0TDuMgV3qRzY+jkChO2b/pidk5B+J+h6cIrDzvw9Xut/M7myMDxrdXCOwCrQRHE
	jMMHww3n8FsY3pSXJQstoxB7qPMRUd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742298855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0UG6kzBcoboMdXZNxJy/iqEM0YPu9mcSX4Ke+dMoOs=;
	b=0mxJ8sxSQ0i9BRvuDKeO8nV+QJxBiz2xQdczKjWtwSZg9CHIL/chnpQBrXo9XWSUH1smxo
	Bu91/xkTyNW+hpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30F5B1379A;
	Tue, 18 Mar 2025 11:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L4CMCude2WcHUwAAD6G6ig
	(envelope-from <nstange@suse.de>); Tue, 18 Mar 2025 11:54:15 +0000
From: Nicolai Stange <nstange@suse.de>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Nicolai Stange <nstange@suse.de>,  Mimi Zohar <zohar@linux.ibm.com>,
  Roberto Sassu <roberto.sassu@huawei.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,  Jarkko Sakkinen <jarkko@kernel.org>,  Eric
 Snowberg <eric.snowberg@oracle.com>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/7] ima: get rid of hard dependency on SHA-1
In-Reply-To: <d01f5ae9654ca07aa93cb061b21b79ff5c83aa79.camel@huaweicloud.com>
	(Roberto Sassu's message of "Tue, 18 Mar 2025 12:00:54 +0100")
References: <20250313173339.3815589-1-nstange@suse.de>
	<d01f5ae9654ca07aa93cb061b21b79ff5c83aa79.camel@huaweicloud.com>
Date: Tue, 18 Mar 2025 12:54:14 +0100
Message-ID: <87pliek109.fsf@>
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
	FREEMAIL_CC(0.00)[suse.de,linux.ibm.com,huawei.com,gmail.com,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.de:dkim]
X-Spam-Score: -0.81
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 78B631F827
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO

Roberto Sassu <roberto.sassu@huaweicloud.com> writes:

> On Thu, 2025-03-13 at 18:33 +0100, Nicolai Stange wrote:
>> Hi all,
>>=20
>> if no SHA-1 implementation was available to the kernel, IMA init would
>> currently fail, rendering the whole subsystem unusable.
>>=20
>> This patch series is an attempt to make SHA-1 availability non-mandatory
>> for IMA. The main motivation is that NIST announced to sunset SHA-1 by
>> 2030 ([1]), whereby any attempt to instantiate it when booted in FIPS mo=
de
>> would have to be made to fail with -ENOENT. As this does potentially have
>> an impact on lifetimes for FIPS certifications issued today, distros mig=
ht
>> be interested in disabling SHA-1 downstream soon already.
>>=20
>> Anyway, making IMA to work without a SHA-1 implementation available is n=
ot
>> so straightforward, mainly due to that established scheme to substitute
>> padded SHA-1 template hashes for PCR banks with unmapped/unavailable alg=
os.
>> There is some userspace around expecting that existing behavior, e.g. the
>> ima_measurement command from ([2]), and breaking that in certain scenari=
os
>> is inevitable.
>>=20
>> I tried to make it the least painful possible, and I think I arrived at
>> a not completely unreasonable solution in the end, but wouldn't be too
>> surprised if you had a different stance on that. So I would be curious
>> about your feedback on whether this is a route worth pursuing any furthe=
r.
>> FWIW, the most controversial parts are probably
>>  - [1/7] ima: don't expose runtime_measurements for unsupported hashes
>>  - [6/7] ima: invalidate unsupported PCR banks once at first use
>>=20
>> Note that I haven't tested this series thoroughly yet -- for the time be=
ing
>> I only ran a couple of brief smoke tests in a VM w/o a TPM  (w/ and w/o
>> SHA-1 disabled of course).
>

Hi Roberto,

> thanks a lot for the patches. Still didn't go through them, but if I
> understood correctly you assume that the SHA1 PCR bank would be still
> seen by IMA.
>
> In light of deprecation of SHA1, is this assumption correct?

yes, the assumption made here is that a SHA-1 TPM bank might exist and
is visible to IMA, but that the kernel would not have a working SHA-1
implementation available.

>
> I would expect that TPM manufacturers or even the TPM driver would
> change to fullfill that.
>
> I guess the first stage would be making sure that the SHA1 PCR bank is
> unusable at the TPM driver level. A first thought would be to extend
> the SHA1 PCR bank with a random value at boot (or earlier), so that the
> remote attestation would never work on that PCR bank. At that point, I
> would probably go further and not expose the SHA1 PCR bank at all, so
> you would have less problems on IMA side.

I would like to note in this context that from my POV there's nothing
really special about SHA-1 when compared to any other potential TPM bank
hash algos the kernel doesn't have an implementation for. That is, if a
TPM implemented say SHA3-256 and the kernel did not have an
implementation of that built-in, it would be a very similar situation as
far as IMA is concerned, i.e. it would have to get handled somehow.

Thanks!

Nicolai

>
> The second stage would probably be that the TPM firmware would be
> updated, not allowing the SHA1 PCR bank to be allocated.
>
> Other than that, sure, also actions need to be done to remove SHA1
> support in IMA (will look at your patches).
>
>>=20
>> [1] https://www.nist.gov/news-events/news/2022/12/nist-retires-sha-1-cry=
ptographic-algorithm
>> [2] https://github.com/linux-integrity/ima-evm-utils.git
>>=20

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

