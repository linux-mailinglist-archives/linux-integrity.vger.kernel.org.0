Return-Path: <linux-integrity+bounces-9934-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rw2NC85YVWqunAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9934-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 23:29:50 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C8574F41D
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 23:29:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F8qvbRU8;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9934-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9934-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54358300B18D
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA28535E1D3;
	Mon, 13 Jul 2026 21:29:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E035E1A3;
	Mon, 13 Jul 2026 21:29:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978187; cv=none; b=etGZzfN8eSD/P/32ON1SqhvXNL/TN385aWXGRKLcgAubadzX5CWLRmQVVJ4bzsaZGHEHllqc+i5wMRJdUqtHLNakpUpDmyXem/GEXAibl3gFXxLq635cpFspN/O1vARkRxtTKnw3r+zRuuYXhfqkyzYCxjJgjABGCGw7sY/8Q0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978187; c=relaxed/simple;
	bh=riXZKB+wdpFkvAXkrUsMvOdoSkn9egwykd4ShYNkDnA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nzk268HqVriqT+kN3yQe8HPRUCGDbJw1k8/ZfP7Gr1BM7RJkh9pKBCvNGjlHgthBjVmkX+O9aCUpSFOoc07mMmKXBAclX73OcZX52AAxLPEqCSyM5Qc23Z/0JYCfUBkv8mV/8wbUttuKpcUlXjiY1AXkBRKeOCNQRVrcFN/uptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8qvbRU8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 061411F000E9;
	Mon, 13 Jul 2026 21:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783978186;
	bh=riXZKB+wdpFkvAXkrUsMvOdoSkn9egwykd4ShYNkDnA=;
	h=Date:From:To:Subject;
	b=F8qvbRU800cl+hCTiRtIH5Bq2hqyQNuvlPb0VDu3GEoytMXxSdjupMhaNSmHdqzJ5
	 +59jFPMuN/TNlB+8K8PC3NenyAYpC8zQru5VQWH0WfSi7cG7ZISlXnkkeC5ou/LDw3
	 DmxBoVA76REruF0Vv3gcLMXKQX+XA+xecWwoURo8Coc7i5ucJpureyWz5YZLA7GaPa
	 vwq5qJ5FCt2nYBOx2jpeyylomQU3P+Wy53qccJ8MetjZNHbhZtuBInBlQFTf62B/ag
	 ciD79ZPXfITVfF44oem56s0H8PBXyYpjXYDyULM/KOA+xZXye6dNqDLgX5LlfvD2+S
	 hkhmYUps3d5Hg==
Date: Tue, 14 Jul 2026 00:29:42 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: AI assisted patches and credits where it is due
Message-ID: <alVYxv8esyv2SKpt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9934-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:keyrings@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2C8574F41D

I sometimes get patches, which are literally just LLM output dumps.

Even finding out if there is a bug symptom/bug has been delegated to
me.

I'm thinking of followning process when this happens next time:

1. Do all the real work.
2. Retain whatever model was used as co-author.
3. Downgrade submitted from author to reporter.

I've seen also reasonable AI assisted patches and this type of behavior
just downplays them.

Any better ideas? I'm open.

BR, Jarkko

