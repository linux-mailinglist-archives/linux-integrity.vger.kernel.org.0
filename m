Return-Path: <linux-integrity+bounces-5398-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AABA6CFB8
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC89016E802
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92CDF60;
	Sun, 23 Mar 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JVB86PYw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nQzWs5Nz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jztpDx32";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dt3QRzMv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7FA469D
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739697; cv=none; b=dH5J9bY6G9P/WAYBmQaqvCmfna8BBGXGlpcIF1SOBQLQlmYczTIG7y3TBZ4lcVd/drn3QobgOihsm4CfTO3ppcS+erIORBHZoJwUrklIoA4ZxF1AbWRQk/AzDG7JA7NqtLaoxG7ZeB3BBITvgTHEbO30ndYFyivvvZQLxCsmnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739697; c=relaxed/simple;
	bh=XJ+L38rS//K9XpzTu8wB2LVs017e3YfwFDW+V1x8ozw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JxXM+G7rd6eumrD2Clb0WIbacW14U0QPg2LVb1ZPO2co1UaY494gWazTDM5o1umNx5wTp7VAyxF+PHGYAHp3uC0ptP/aAQI9IevV1plyg0EQZS4D5aOikpMrC6NUTj479RWsQdgysVGqdOQCpnxXdFkzeahpJ2R+xcAMhw3eUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JVB86PYw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nQzWs5Nz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jztpDx32; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dt3QRzMv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C06301F445;
	Sun, 23 Mar 2025 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZCGhOhrWhO2/XLhlKGz9XPeVAo8qv4HD8ptuAaEb6M=;
	b=JVB86PYwfaKCYteubKzjqOBJuCCb2LFclwf2YOetXefb8WX1DYjaIObtLx5I1bLoGuomyq
	Mq0OFakxFmpuXnOxYb4EKkFOtE0PGn70szgroB6fVNSKn/hxnL6AZmq9bZnH9bmqCYUkWp
	3tvfOiKkJf5OOnDDlAYMu8qW4e9HFe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZCGhOhrWhO2/XLhlKGz9XPeVAo8qv4HD8ptuAaEb6M=;
	b=nQzWs5NzaSPia2mPkTrZUvNWvSwCWCRJQnweL5r9yMmEjy4alnK7G7OiBhI98AvDA3h/oN
	ZabhOxCxS6RBsYCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZCGhOhrWhO2/XLhlKGz9XPeVAo8qv4HD8ptuAaEb6M=;
	b=jztpDx324F2T95YeEpFN8WVOSu/oa5SiC5yMmABBaRMKpcvsYBTRqZjEg6raid3c1qvM6C
	e/WkHGApCg6yB++HUKOKWgvWpbsoni8HzVZgZZuuJ6Kh0pDi0eNzaxHk2H3wAWhHA23k3j
	x3PahRyfwfwLe4/9FZX9gBwafHlpN0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZCGhOhrWhO2/XLhlKGz9XPeVAo8qv4HD8ptuAaEb6M=;
	b=Dt3QRzMvID5gT3ir7p+gZkIm0wlHXWLedLCRK0eoc+pWYtW3ZyoRpF5G75Lp8F690zf8Ti
	DqsICLYH80NubMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 838711339F;
	Sun, 23 Mar 2025 14:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sZDVHuwY4Gc2PwAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:21:32 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,
  linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 6/7] ima: invalidate unsupported PCR banks once
 at first use
In-Reply-To: <4e760360258bda56fbcb8f67e865a7a4574c305a.camel@linux.ibm.com>
	(Mimi Zohar's message of "Tue, 18 Mar 2025 16:49:57 -0400")
References: <20250313173339.3815589-1-nstange@suse.de>
	<20250313173339.3815589-7-nstange@suse.de>
	<34ebd15aae07402d19279ef4286197112c4afc01.camel@linux.ibm.com>
	<8305c89ec354320100ec272052c036300366a2af.camel@linux.ibm.com>
	<4e760360258bda56fbcb8f67e865a7a4574c305a.camel@linux.ibm.com>
Date: Sun, 23 Mar 2025 15:21:31 +0100
Message-ID: <871punddzo.fsf@>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Mimi Zohar <zohar@linux.ibm.com> writes:
> On Tue, 2025-03-18 at 16:55 +0100, Nicolai Stange wrote:
>> Mimi Zohar <zohar@linux.ibm.com> writes:
>> > FYI, because the IMA Kconfig selects SHA1, we're guaranteed that SHA1 =
exists in
>> > the kernel and the subsequent kexec'ed kernel.  For this reason we're =
guaranteed
>> > that the measurement list is complete.  The simplest solution, not nec=
essarily
>> > the best, would be to punt the problem for the time being by replacing=
 the
>> > "select" with a different hash algorithm.
>>=20
>> Yes, that would work as well. IIUC, it would mean that we would
>> e.g. extend truncated SHA-256 template hashes into a SHA-1 bank, right?
>> However, since no existing tool like 'ima_measurement' is expecting
>> that, and would fail a verification then, I'm currently struggling to
>> see the advantage over just doing a.) and invalidating the PCR banks
>> with a fixed value right away?
>
> Replacing the "Kconfig select" has more to do with having at least one
> guaranteed complete measurement list.  I'm fine with extending a TPM bank=
 with
> an unknown kernel hash algorithm violation (either option a or b).

Ok, I think I got it now.

FWIW, a v2 can be found at
https://lore.kernel.org/r/20250323140911.226137-1-nstange@suse.de , includi=
ng a
patch for selecting SHA256 now.

Thanks a lot for all your feedback!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)

