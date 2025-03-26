Return-Path: <linux-integrity+bounces-5431-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4CA712FC
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 09:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3095E3A3C07
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF211A4F21;
	Wed, 26 Mar 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FaHMFtpa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W+luWktA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FaHMFtpa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W+luWktA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42D1A5B87
	for <linux-integrity@vger.kernel.org>; Wed, 26 Mar 2025 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978709; cv=none; b=IV+ruxomNLvz9zMV0a5sNPuMwZx0qwK4cEZUw+R/9fCr9UKQpnVWz6XbyAeFC3b+teNd9K6TFCnDNQX/1OwawqVUSWoKYyRdanckcuOXzzo6KTajasf/OBuGmbyqm3sa/eQRXDoN5V7fSRmZAXG1c0V/7qf1JEnwVgjIalvB3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978709; c=relaxed/simple;
	bh=HWAiggdTKxJZL2el/jilM8w3A7auhTpdSaIDXER4twg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BWwNFSwKQRNrsp9/VBggikesjjXeYvGFXPJz0oB1ouTpq7GQmJ2O9uazUY3/FlJplQJkH5Kl2rF547XVX2zFUAyOOvwWUWVVm8bMZlr+TTh3Xjqy9hRlkfJFmdWQc7vuNH7ejZvj2kmGd8p4JohcGjXUYvcBtYAJ1GukMLG4WgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FaHMFtpa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W+luWktA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FaHMFtpa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W+luWktA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC98B21179;
	Wed, 26 Mar 2025 08:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742978705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ff3SV2PTsw8orOC0Yhcz/hKa8Dme0rCu6RdQz9ChCM=;
	b=FaHMFtpaHeZY8gADsMX/tH4zQAWSJNMHC+Q386fji5echHlZsxH9r5mwP5UMqUeJjYC9Hv
	cQErBHtmqwj9rulwjb8LjYBrOslFfx/gxFNllV/FFKppqM11vOl7Cg/UfzXcF/HkOE7S83
	xbzXvibrngdz31u+P6xS8FC78is49+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742978705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ff3SV2PTsw8orOC0Yhcz/hKa8Dme0rCu6RdQz9ChCM=;
	b=W+luWktAB6rJ3T3bJI5wJX+nXwSEtS1t6WF+UW9Y7kAvSYcURIavVwyhIiTP+zFEYNu70h
	fEzwpXr6SafXi1Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742978705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ff3SV2PTsw8orOC0Yhcz/hKa8Dme0rCu6RdQz9ChCM=;
	b=FaHMFtpaHeZY8gADsMX/tH4zQAWSJNMHC+Q386fji5echHlZsxH9r5mwP5UMqUeJjYC9Hv
	cQErBHtmqwj9rulwjb8LjYBrOslFfx/gxFNllV/FFKppqM11vOl7Cg/UfzXcF/HkOE7S83
	xbzXvibrngdz31u+P6xS8FC78is49+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742978705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ff3SV2PTsw8orOC0Yhcz/hKa8Dme0rCu6RdQz9ChCM=;
	b=W+luWktAB6rJ3T3bJI5wJX+nXwSEtS1t6WF+UW9Y7kAvSYcURIavVwyhIiTP+zFEYNu70h
	fEzwpXr6SafXi1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63E1C13927;
	Wed, 26 Mar 2025 08:45:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WUMbF5G+42ecVgAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 08:45:05 +0000
From: Nicolai Stange <nstange@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,  Nicolai Stange <nstange@suse.de>,
  Roberto Sassu <roberto.sassu@huawei.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,  Eric Snowberg <eric.snowberg@oracle.com>,
  Jarkko Sakkinen <jarkko@kernel.org>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/13] ima: invalidate unsupported PCR banks
In-Reply-To: <eded3bf8d7aeb90ffa85bb160af0060c1d10ad34.camel@HansenPartnership.com>
	(James Bottomley's message of "Tue, 25 Mar 2025 11:44:59 -0400")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-4-nstange@suse.de>
	<5b15393c8046cf87cc09e932e6addf20d9b1d871.camel@HansenPartnership.com>
	<f7d257cd3f98447b2b3d7aff1eee6586c1596606.camel@linux.ibm.com>
	<eded3bf8d7aeb90ffa85bb160af0060c1d10ad34.camel@HansenPartnership.com>
Date: Wed, 26 Mar 2025 09:45:04 +0100
Message-ID: <87sen0qiy7.fsf@>
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_WP_URI(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,suse.de,huawei.com,gmail.com,oracle.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[hansenpartnership.com:email,trustedcomputinggroup.org:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Mon, 2025-03-24 at 21:03 -0400, Mimi Zohar wrote:
>> On Sun, 2025-03-23 at 17:18 -0400, James Bottomley wrote:
> [...]
>> > Instead of any of that, why not do what the TCG tells us to do for
>> > unsupported banks and simply cap them with 0xffffffff record
>> > EV_SEPARATOR and stop extending to them? (note this would probably
>> > require defining a separator event for IMA)
>>=20
>> open-writers and ToMToU integrity violations are added to the IMA
>> measurement list as 0x00's, but are extended into the TPM using
>> 0xFF's.=C2=A0 Unfortunately, as mentioned previously, some verifiers
>> ignore these integrity violations by automatically replacing the
>> 0x00's with 0xFF's.

I've researched the EV_SEPARATOR now, and according to [1], sec. 10.4.1
("Event Types"), PDF p. 128, the _digest_ of 0xffffffff is to get
extended. So there's no conflict with how IMA violations are extended
(plain 0xff ... ff), in case that was the reason Mimi mentioned it.

However, the main point of this patchset is to handle unsupported algos,
so I think the HASH(0xffffffff) constant cannot get computed.


> That sounds like something that should be fixed ...
>
>> What do you mean by "simply cap" them?=C2=A0 Does it automatically preve=
nt
>> the PCR from being extended?=C2=A0 If not, then this patch set is doing
>> exactly that - preventing the TPM bank from additional extends.
>
> The idea of separators as understood by the TCG (the EV_SEPARATOR
> event) is that they divide the log up into different phases.  If you
> see a measurement belonging to a prior phase after a separator you know
> some violation has occurred, even if the log itself verifies.  The
> point being that if you log a separator in the last phase of boot (and
> for IMA logs there only is a single phase) there can be no more valid
> measurements after that event because of the separator, so the PCR is
> termed capped, meaning you can't validly extend to it and if you do the
> verifier shows a violation.

The motivation for extending with constant 0xfe ... fe into unsupported
banks is based on a very similar line of reasoning: because no event
template HASH() would possibly come out as that particular constant, no
sequence of events, including an empty one, could get verified against
such a bank.

Thanks,

Nicolai

[1] TCG PC Client Platform Firmware Profile Specification, Level 00
    Version 1.06 Revision 52, December 4, 2023
    https://trustedcomputinggroup.org/wp-content/uploads/TCG-PC-Client-Plat=
form-Firmware-Profile-Version-1.06-Revision-52_pub-3.pdf

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

