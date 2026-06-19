Return-Path: <linux-integrity+bounces-9816-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iD2KDJWXNWr10gYAu9opvQ
	(envelope-from <linux-integrity+bounces-9816-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 21:25:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB026A7826
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 21:25:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WK69Rno4;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9816-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9816-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24DE0302166D
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E762342514;
	Fri, 19 Jun 2026 19:25:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16810343D7B;
	Fri, 19 Jun 2026 19:25:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897104; cv=none; b=KpYDYwV+5Qi5/Mw0yVe7pXfGEBjtFr7FvHb4+sWqBK284P8Qmo8XIEXIdJi3OXF/Epwig2DDJir9v9oL3t1dImf05KKMOfcANwQTi801pUkDSb2qNVMzHAHQs4IW6TQF8M0aERYI9gvp8mA+A/lsVL+F4eALjwaJWLx2hrHY5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897104; c=relaxed/simple;
	bh=6N19KjCQA3e3C/yvz1V/+p4cgWE/QN6EsUNeS5iC5/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jGwRRbFZYtyaezq7TCAp43ctmH0mgGwheYgGrc3JqG1WgVEwHyC7S0DjhyV8usWAXOql5gs155GHBxRdUCHvt23CBBHYcta8YpW8ifKi11B4owybDowVNh5qbrzfmITQg5XcRQsy9M1sBcwR3j8QP+cpGGb7Vs0KD9USCil8wqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK69Rno4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18011F000E9;
	Fri, 19 Jun 2026 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897104;
	bh=kDjfA20/ngjPYsSdjNQMWOcUxyzGk4HcXsstUvZcXQQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=WK69Rno415a9DDLHmX5LnDHKIR2mzJmaI/LaiF0RmIYrOeNmhsivKzqDfP9pQwWdr
	 ut4zyMzIOA78+oeRVqxHbNh9qA0M/K9xQuGf19RxBGLJ9Mp0hEzHPGZzrriuFw7JKm
	 kmtSBGEI4Yli7jfI0+mldCAJLbqnR0e2hfBYMsQevkoaaCiS0UP6Kj3rFVljbHxmZN
	 fv+0GD2BPRlshNb9ADbGmHKILI90Xo/ujV2oN+MbY254ua+rpnMOPGiMZA/nI/hNSv
	 UlvjrfQGuaE1y/HWyXwNqB3xP1Fnn5iadI6X3MThLJrwAJMrw6+kEt5ojalz240LSI
	 Ww2GbF5S4rHDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199F73AAA0F6;
	Fri, 19 Jun 2026 19:24:58 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <2a5a07ef24454c295c3a63ae8cedcd6c47578101.camel@linux.ibm.com>
References: <2a5a07ef24454c295c3a63ae8cedcd6c47578101.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <2a5a07ef24454c295c3a63ae8cedcd6c47578101.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.2
X-PR-Tracked-Commit-Id: 35d6f5e788dae0dcc4c42d1280360f19aef9ab52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0798268aa4c26ece25020b3ddeeef9a5941209c0
Message-Id: <178189709668.4037507.12635092401561450213.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jun 2026 19:24:56 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-9816-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zohar@linux.ibm.com,m:torvalds@linux-foundation.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:roberto.sassu@huaweicloud.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AB026A7826

The pull request you sent on Thu, 18 Jun 2026 10:06:01 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0798268aa4c26ece25020b3ddeeef9a5941209c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

