Return-Path: <linux-integrity+bounces-2019-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBC4899293
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Apr 2024 02:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0741C2160F
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Apr 2024 00:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EAA632;
	Fri,  5 Apr 2024 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gEDdzpg+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pDIZw7la";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gEDdzpg+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pDIZw7la"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F3393
	for <linux-integrity@vger.kernel.org>; Fri,  5 Apr 2024 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276692; cv=none; b=Lr6937LO89VkFFdOcVqcdApc/ukNdSAu3d70H17/k/acJZE7agOSzTRhbzjT8UJZIoDjxStN42SeKaIE3qVj1xi6fqpoTxKPrzZs3T596N4sdqTJ5/qo7UZjf3F3xjuPn6BGXrf92f2UBoVpAo30zBKXDHmEZ2mRi3OjIMQrGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276692; c=relaxed/simple;
	bh=O9XRJIR1zOHd8bvHcvdLIZFMs2dvKnIIv+UMbXIDXWY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J+/F7hnPXAZJ75a1MPk+i8RCi7Ll0U1Po1KEpY6YcM9RgOmwefqLhTY9iU9szb5FookSkaLuJ6/Pr1yTTSWAYDq8POfkd7HAnfuTqC2af3r4RHTYiJ/P/kCBOjQg24nzmxr3a67+261TdU+oiXOXUCHll44BDoX98cM2pk2uHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gEDdzpg+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pDIZw7la; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gEDdzpg+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pDIZw7la; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C3171F45A;
	Fri,  5 Apr 2024 00:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712276689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9XRJIR1zOHd8bvHcvdLIZFMs2dvKnIIv+UMbXIDXWY=;
	b=gEDdzpg+6AwI7Lpi8v9bbczOg+gZNkOsTMBkIsEfRU89iRag0GtT4+3swLTjCBuv7m4pdZ
	5kEn62pp11d9tjz5JnJAICWKYbVvj0BTsP8nu5VOj6sEf5sPhAcHX8bk+s2YBCzjHBS0Yr
	Eij4ojPcHZ/pkj1UEeXB1CYesU08XEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712276689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9XRJIR1zOHd8bvHcvdLIZFMs2dvKnIIv+UMbXIDXWY=;
	b=pDIZw7lavRuKWLzX9a2hcOB9nxJqQQ1gxdKH/+ViwpRKX/KqTRGr9b+cRps+jrGZMn27i5
	dLH4sRNf2QPcQpAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712276689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9XRJIR1zOHd8bvHcvdLIZFMs2dvKnIIv+UMbXIDXWY=;
	b=gEDdzpg+6AwI7Lpi8v9bbczOg+gZNkOsTMBkIsEfRU89iRag0GtT4+3swLTjCBuv7m4pdZ
	5kEn62pp11d9tjz5JnJAICWKYbVvj0BTsP8nu5VOj6sEf5sPhAcHX8bk+s2YBCzjHBS0Yr
	Eij4ojPcHZ/pkj1UEeXB1CYesU08XEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712276689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9XRJIR1zOHd8bvHcvdLIZFMs2dvKnIIv+UMbXIDXWY=;
	b=pDIZw7lavRuKWLzX9a2hcOB9nxJqQQ1gxdKH/+ViwpRKX/KqTRGr9b+cRps+jrGZMn27i5
	dLH4sRNf2QPcQpAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A7FE139F1;
	Fri,  5 Apr 2024 00:24:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WNp9E89ED2bmNwAAn2gu4w
	(envelope-from <wbrown@suse.de>); Fri, 05 Apr 2024 00:24:47 +0000
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
In-Reply-To: <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
Date: Fri, 5 Apr 2024 10:24:37 +1000
Cc: linux-integrity@vger.kernel.org,
 peterhuewe@gmx.de,
 jgg@ziepe.ca,
 Takashi Iwai <tiwai@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F34D4DB5-EDFF-4E04-A35D-D9044F513A99@suse.de>
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
 <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6.1.1)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca,suse.de];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.80
X-Spam-Flag: NO



> On 5 Apr 2024, at 01:06, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> Since the code is accessing /dev/tpm0 and not /dev/tpmrm0 this issue
> should be mitigated by the user space resource manager.

My code is operating via /dev/tpmrm0, not /dev/tpm0. And after each =
iteration, all sessions are cleared and removed.=20

If I operate on /dev/tpm0 the issue goes away. So the error is actually =
in the resource manager itself.=20

--
Sincerely,

William Brown

Senior Software Engineer,
Identity and Access Management
SUSE Labs, Australia


