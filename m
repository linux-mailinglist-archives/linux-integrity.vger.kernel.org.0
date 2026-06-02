Return-Path: <linux-integrity+bounces-9716-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBdzGVg1HmqahwkAu9opvQ
	(envelope-from <linux-integrity+bounces-9716-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 03:43:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06682626E79
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 03:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 978E3300FFA0
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 01:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5D1A4F3C;
	Tue,  2 Jun 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvyHKTwj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647021E515;
	Tue,  2 Jun 2026 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364577; cv=none; b=l34kSCY/45pgs0XqwLnBWvCGOc9m4I2seG2xuCcWCc33jCCmQ0/qZuKDkWWyMRm2rHq9iUkMmwaQI6l4c3N1OPrgTzKn/4F1MKTshOGU0TPcxsIo3zXvPo8xvz/1Be/jOaIH22j7MgZizQjrIPkewkTRc+IGYrxsrMvFM/VHPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364577; c=relaxed/simple;
	bh=HqpZj31f7T8Am9sNA3UW15wRg8mZ8ux30j6CLDfZ1vs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CtoG0UBbLFk6jaKIhJkaeGf7gElWci10fNduLcKFPQhjeqduhsnYYDbzLr0IzRhO5jS13ckZ5TV3gDLpaYvB8qHiDR9vxpOPCs9h3FKwQrnoUeP88XO/kJfi56kc0eq0RQzOrvwocjnwSR3sHKx9vSxWZvnMjYSa55xDNLHVURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvyHKTwj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 723941F00893;
	Tue,  2 Jun 2026 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780364576;
	bh=HqpZj31f7T8Am9sNA3UW15wRg8mZ8ux30j6CLDfZ1vs=;
	h=Date:From:To:Cc:Subject;
	b=jvyHKTwjm/SXOZi1V7JgHn7nrdfojauT1g/9c46UcGfXu8xbzAaj1/IWi+KLQp+Bu
	 EylvAnLCipovrvNkvCAzmUxl9Zlu95JdQiDh0Z9mBRcoD1T1LXLvp6VQ77cqBac57G
	 ZLvrwyv+jsUdXtGdC6hOAjPJTj6OEMHLuC55AQzZN6qDlA+pkEuY65193qAivWEs4g
	 8g1Dxp1rKfFAiHfN078tyRCgvkCyRALLzMv1qBfYrQwBL/OcosBD0YE4hWIsf1H07K
	 3VebE/lkxM5qWOVcNtq54TDyA9UcS5fy76PYOoco4c2vtmjv7Vb2hN2MEn5lTvBZwL
	 M16yPZhfsaUJA==
Date: Tue, 2 Jun 2026 04:42:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Subject: Landstrip
Message-ID: <ah41G3F850HLeiBQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[crates.io:server fail,tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-9716-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,crates.io:url]
X-Rspamd-Queue-Id: 06682626E79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I played with an idea could Landlock LSM be used to do conceptually a
better fit sandbox for programs such as Anthropic Sandbox Runtime [1].

After some missteps at first I got it pulled together quite well:

https://crates.io/crates/landstrip

To see it in action I also have a fork of pi-hashline-readmap plugin,
which was a cherry-picked test case I wanted to try out given it already
hooks the bash tool command for compressed output.

I just thought that this might interest some as Landlock is not really
over-used kernel feature in "application sense".

This is a more lower barrier and more failure tolerant to deploy than
Bubblewrap based container for this use and purpose in my opinion
at least.

[1] https://github.com/anthropic-experimental/sandbox-runtime/issues/291
[2] https://github.com/jarkkojs/pi-hashline-readmap

BR, Jarkko

