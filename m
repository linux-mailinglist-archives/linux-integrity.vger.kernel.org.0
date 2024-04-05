Return-Path: <linux-integrity+bounces-2018-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA1899292
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Apr 2024 02:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55AC28ABF9
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Apr 2024 00:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6382F81F;
	Fri,  5 Apr 2024 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NoPi3OjO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3JcSVENf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NoPi3OjO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3JcSVENf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A734393
	for <linux-integrity@vger.kernel.org>; Fri,  5 Apr 2024 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276666; cv=none; b=XTmuQByCamG9RfCwP4Dz4nmbOaATiEDTbf6JgD6cyDzIena7leS5CsVv1XhRVC2UXDjBT4OG+c5+d9vIPns02/S6Q8o/y047Z9w5pm5RkmEztwaxeh6c19hls64uDRk+wtPkFbv9fJWa/O95uiqHDPUywaulIkdokJ4IGxsDbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276666; c=relaxed/simple;
	bh=tXhqAQ6YRn3h7zaH2Ot08/tXzA4hudJo5zlljI3WTr4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KZHFu7KVWF8DfcrKKrhe52ZuVa3kfAA9pfMBjz6IWT34SWQJL8e2UCFw/MjdsayiBJbseRuSlw+ZdMXYOhfcBASVk1EOtxpUnnX2FQgbuqsN5pswMeoy68tA3zyAH8WeR6QdbFSPqi34YNxMvhjMr4VtCXrqwJAN2pIIqIs5GP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NoPi3OjO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3JcSVENf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NoPi3OjO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3JcSVENf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75E591F458;
	Fri,  5 Apr 2024 00:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712276662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KC7MHgAHccAcAALrxn/z4CF51Rt9tMo4vMuL7PnoaGM=;
	b=NoPi3OjOXkUszmooatFIpAcsrw1gpw50HwKfOxkHTctOaUHa45BG+AMbNkPhjPybIXO7SK
	MOuhCklj1ft/QPAcipIDum9O83Cdl8CbCYsyWVfG8JBine9MzR0aQl9ANMScevXBJTjVJE
	JlO38yOvcIc6MUeyBiPxW2YPLqcK8TI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712276662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KC7MHgAHccAcAALrxn/z4CF51Rt9tMo4vMuL7PnoaGM=;
	b=3JcSVENf5ZIaWLOBpqCfMrN56XiqK5/PtjQjzhpv41zCQEvdWwJG+WLpl+vW0Fhb441Zyb
	Z8cwu7tq8C6v6nDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712276662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KC7MHgAHccAcAALrxn/z4CF51Rt9tMo4vMuL7PnoaGM=;
	b=NoPi3OjOXkUszmooatFIpAcsrw1gpw50HwKfOxkHTctOaUHa45BG+AMbNkPhjPybIXO7SK
	MOuhCklj1ft/QPAcipIDum9O83Cdl8CbCYsyWVfG8JBine9MzR0aQl9ANMScevXBJTjVJE
	JlO38yOvcIc6MUeyBiPxW2YPLqcK8TI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712276662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KC7MHgAHccAcAALrxn/z4CF51Rt9tMo4vMuL7PnoaGM=;
	b=3JcSVENf5ZIaWLOBpqCfMrN56XiqK5/PtjQjzhpv41zCQEvdWwJG+WLpl+vW0Fhb441Zyb
	Z8cwu7tq8C6v6nDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DA482139F1;
	Fri,  5 Apr 2024 00:24:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iebGH7NED2bmNwAAn2gu4w
	(envelope-from <wbrown@suse.de>); Fri, 05 Apr 2024 00:24:19 +0000
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.1\))
Subject: Re: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
From: William Brown <wbrown@suse.de>
In-Reply-To: <6857f043301a100ee93b3ea120a2d1d60e83efdb.camel@HansenPartnership.com>
Date: Fri, 5 Apr 2024 10:24:06 +1000
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
 linux-integrity@vger.kernel.org,
 peterhuewe@gmx.de,
 jgg@ziepe.ca,
 Takashi Iwai <tiwai@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A174330-E1BB-4160-BD90-EAE6150706B5@suse.de>
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
 <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
 <D0BFMGM02V7A.1HEWQ05350K07@kernel.org>
 <6857f043301a100ee93b3ea120a2d1d60e83efdb.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3731.700.6.1.1)
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MV_CASE(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmx.de,ziepe.ca,suse.de];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hansenpartnership.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]



> On 5 Apr 2024, at 01:49, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> The reality is that unless you context save a session, you don't need
> degapping and pretty much every TSS based use of sessions doesn't need
> to save them, so people who construct TPM based systems rarely run =
into
> this.=20

This is the odd part - I'm *not* context saving sessions here.

     Running `target/debug/examples/hmac`
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrLoaded, value: 0 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrLoadedAvail, value: 3 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrActive, value: 1 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrActiveAvail, value: 63 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: ActiveSessionsMax, value: 64 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: ContextGapMax, value: 255 }] })

     Running `target/debug/examples/hmac`
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrLoaded, value: 0 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrLoadedAvail, value: 3 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrActive, value: 1 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrActiveAvail, value: 63 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: ActiveSessionsMax, value: 64 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: ContextGapMax, value: 255 }] })

     Running `target/debug/examples/hmac`
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrLoaded, value: 0 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrLoadedAvail, value: 3 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrActive, value: 1 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: HrActiveAvail, value: 63 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: ActiveSessionsMax, value: 64 }] })
true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: =
[TaggedProperty { property: ContextGapMax, value: 255 }] })


I could be completely wrong, but my reading of the specification is that =
HrActive/HrLoaded are the values of interest here, and we can see they =
remain at 0/1 for each test as the sessions and loaded objects are =
removed at the end of each test.=20

And yet, I'm running into the error 0x0901. So something else is going =
on that I'm not 100% sure about.


--
Sincerely,

William Brown

Senior Software Engineer,
Identity and Access Management
SUSE Labs, Australia


