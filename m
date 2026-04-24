Return-Path: <linux-integrity+bounces-9316-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BVWFHoy62lfJwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9316-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 11:06:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3DC45BDCD
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD30E3003726
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907DF294A10;
	Fri, 24 Apr 2026 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSvLYQkl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46F221FCD;
	Fri, 24 Apr 2026 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021556; cv=none; b=gBFWX7n4A0sTW/HLJHnd1T5/gVIjRKXkD3aC2IukuHFUC3dM8mKFln5Pa/4DwqlNfy4TRnmN6py5EhC1BOg7NIhvT37vCDaAPM3IHYv9AurrBxX5fUTxHVn167eqz3XVQ1IXjPnyuIf8IJPjn9e6zSWRA+hecO/vfqPBS+wkJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021556; c=relaxed/simple;
	bh=7PFm+QQuLq59kl+BDNPwDMb6QB6MGxC+l5QBmBMZ2/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rQ8jTmXg09ZklwbwudQe8vrpbk32+s6dHWdRMokv3bjhG2o5vIAx7d4S649YEIHLXx28RD80L76imPyO9UfLbMe5WL80aX+2CVFT2pNHOPdWUW1UeolnSj5seVMph07GFIwEiRg79Hj0CGjpV2T7oD0Bnon3AipsGFy5qK8A9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSvLYQkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B319DC19425;
	Fri, 24 Apr 2026 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777021556;
	bh=7PFm+QQuLq59kl+BDNPwDMb6QB6MGxC+l5QBmBMZ2/M=;
	h=Date:From:To:Cc:Subject:From;
	b=TSvLYQklnU1BRRR3llfn7/CsLvbB3eDH6A3FFQeHUF5Vt5Fwe2gQeKDCAeuKo7cEl
	 +VxH08nW6CRF4QQdc3G8u3OJFaXSCiCMZPZHIAxvNWg5LIwpucp2nxRJrgV1TevRsK
	 5AnqrcvOPcQE5OmyDAmtY4+yHzQtV0USAeOXbO7LOMwXYl751Lt462RqvCjkRV1zZa
	 bCsdfEzKeOlDt37UUk20DxaHJJep1YKZBp0Z/gS1FaDfma1PwGA8wNErEv67t5tWSp
	 M+dLyR/tIEs4X4cCJ/RwhnYH5RbifAIxFAO6yYW3w0hbLj/EYkWUSCF0N/kKZwKlNj
	 P5XlP4ORCEB3Q==
Date: Fri, 24 Apr 2026 12:05:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next changes on my tree
Message-ID: <aesyb0h16NPy-T3o@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: DA3DC45BDCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9316-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi,

First I want to apologize for messing up with PRs for 7.1 [1]. I've
taken steps to sanitize my branching and the changes are now reflected
to -next:

commit 3ee56e5cf8afb875beab59e42e0b69cdb31050ab
Merge: e77ce03e10ba 4fb4ce024d06
Author: Mark Brown <broonie@kernel.org>
Date:   Thu Apr 23 13:26:01 2026 +0100

    Merge branch 'for-next-keys' of
    https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

commit e77ce03e10baf7b84d169efcaa497861dc9a07bf
Merge: c6391bbee383 949692da7211
Author: Mark Brown <broonie@kernel.org>
Date:   Thu Apr 23 13:26:00 2026 +0100

    Merge branch 'for-next-tpm' of
    https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

I'm now travelling right now in Budapest but will be back in Finland
tomorrow, and will retry my PRs then.

Paul, I promised to look into [2] this week but unfortunately it is
delayed +1 but is on my TODO list for next week along with couple
of other kernel review/testing backlog items :-) Hope you understand.

[1] https://lore.kernel.org/linux-integrity/aeVSbVIFaCDRXf7C@kernel.org/T/#t
    Yes, and I know late cc-tagging was also additional reason for
    NAK, can't blame branching on that. I did also execute stupid shit
    to add in.
[2] https://lore.kernel.org/all/ad--R8KaGgucLxmH@kernel.org/

BR, Jarkko

