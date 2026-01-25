Return-Path: <linux-integrity+bounces-8307-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIIfOGJPdmkbPQEAu9opvQ
	(envelope-from <linux-integrity+bounces-8307-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 18:14:10 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61308818C6
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 18:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0315530036CA
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3207823C51D;
	Sun, 25 Jan 2026 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU1Co7Sk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A523B612;
	Sun, 25 Jan 2026 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769361248; cv=none; b=T9plvQwe4pTiAnFwXOdat/aqjVxltyhNvY7LfFvX4w/BLmqur4scpLCoOtIFDxFxJf/O7OBnc/ulrUya+OmyyfZXBg3DADesqY/+EX4FsJCfRX26QBkpBAmxC5BSQ7pr/iodcvf3LxZmwXuhov+oco4pmSjDlFwzx8TcSRN8lYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769361248; c=relaxed/simple;
	bh=Hlu8lC4Ceqyxn5s/VrnGuFwL8Hyd/GHbzAjuuMja7MA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oQCh0G+OAoEnAQi8wgVHZsXzV2ICwsutCo8riyi04SJ6ryfoB8O5I3VVTh8nW/2xQ1QJCvZwwszKNJ9kSjSNxm1O5rA69jY4kGg1YlnqNMW4Cses/JLO36YGV+TykldJJM++a6k8tRIg9r+Q+Z7t/ean4RKJtFB2xeKAmhWsoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU1Co7Sk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1799EC4CEF1;
	Sun, 25 Jan 2026 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769361247;
	bh=Hlu8lC4Ceqyxn5s/VrnGuFwL8Hyd/GHbzAjuuMja7MA=;
	h=Date:From:To:Cc:Subject:From;
	b=hU1Co7SkfzXXi+O4zxcd1eO1jNXQEL9+DavkjPz47Ghix0/lyNzi+uccaA7v1Kfl+
	 OLfKLWT6LhAms7zpRBlqdOckRuuVkiZoOHBIxZTuuBRrYxMsa/IJcgGVTk9cjssSnb
	 pQ9wVPLJHfLrRz2OYBx1fGSFFYfm1TA5QmL+V3jzE5RGF4VaiN1GMbGaO8k+x/pHCY
	 OKNs/fC/Ytd1dU+DHRoXlAsdPqYxAF/8fcB+CKBms/YAOi/WolD4IQdgR0EqCLgjED
	 6/Kl33YmeNCEQB8axIBHa+dgVmqIRj2OUS+a3gQxqO81cIwoN2Mx71baa9nxlnpgoG
	 o9uvLaQ/UBOZQ==
Date: Sun, 25 Jan 2026 19:14:03 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] KEYS: trusted: keys-trusted-next-6.19-rc7
Message-ID: <aXZPW1HnC0kM-VDC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc {{version}}
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-8307-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61308818C6
X-Rspamd-Action: no action

The following changes since commit d91a46d6805af41e7f2286e0fc22d498f45a682b:

  Merge tag 'riscv-for-linus-6.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2026-01-24 18:55:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.19-rc7

for you to fetch changes up to 6342969dafbc63597cfc221aa13c3b123c2800c5:

  keys/trusted_keys: fix handle passed to tpm_buf_append_name during unseal (2026-01-25 19:03:45 +0200)

----------------------------------------------------------------
Hi,

This a late fix for v6.19.

BR, Jarkko

----------------------------------------------------------------
Srish Srinivasan (1):
      keys/trusted_keys: fix handle passed to tpm_buf_append_name during unseal

 security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

