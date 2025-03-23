Return-Path: <linux-integrity+bounces-5384-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA0A6CF8E
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604B53B088D
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0F2D05E;
	Sun, 23 Mar 2025 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kA1KVXjn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G1C5xdJM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kA1KVXjn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G1C5xdJM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC51D1A29A
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742738995; cv=none; b=FX9DKSWp7YaLx757E9DDsLDnfQlGBRld8uI6tGmepCjehskKeAFJvec1tudagTki+zxhB+C6s+MqOaJVbAU4oud8H2elyPAMAkqIkq6b+Ur8J7kR+XEErQEmBf26V+3Oce7Fw3MHG09PiH5MJrNnrtOTZE4krgjOp4VNrpleCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742738995; c=relaxed/simple;
	bh=tw8P2c8xUPFYU2DXYjM9S98UP/nyibc5aTWNlVSGE24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWJ2GDHgmvQO0i6ElOskxj+dvbGiNpb2bTqX6Lv2nMcHnJYPn9mPNHynoJlbyNpA7wT1Z+GNkDAgdPxkdsn6zSm21GzO1iW+0ZZjjlwAuV0oOOg3OqOSIFdGbsZANgAhSMvnixsrUMxcMeklMqvPkLY95NfTEz3kFEbNUgWWIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kA1KVXjn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G1C5xdJM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kA1KVXjn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G1C5xdJM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5CCE2119D;
	Sun, 23 Mar 2025 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742738991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2jDLWApycLVfP31DaCdo1jO1vVA011lwCmzuDG5Z3OQ=;
	b=kA1KVXjnkgC3AKpCldlI7fh/o3QWCuq+CbxghnZ8Z5LkeLOD8+qRakqIgs3KRi9yE6z2c8
	GnviqgE9Z7EnLZ/Z9IOMs1TR2TMcPwknm+eed2YRsfOdp8bfKoNWFwMx1MDhN6OFcNhvZw
	tg1+ldkFRNXE4yX+eWdpMDReGWFHE8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742738991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2jDLWApycLVfP31DaCdo1jO1vVA011lwCmzuDG5Z3OQ=;
	b=G1C5xdJMj91qp1ul8epLYxh8l2Emog056gPYEiKXwmk1NJu4m3N4ql0H+e8AHALXPNE9Gk
	kyZ7O4th9m9DF+Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742738991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2jDLWApycLVfP31DaCdo1jO1vVA011lwCmzuDG5Z3OQ=;
	b=kA1KVXjnkgC3AKpCldlI7fh/o3QWCuq+CbxghnZ8Z5LkeLOD8+qRakqIgs3KRi9yE6z2c8
	GnviqgE9Z7EnLZ/Z9IOMs1TR2TMcPwknm+eed2YRsfOdp8bfKoNWFwMx1MDhN6OFcNhvZw
	tg1+ldkFRNXE4yX+eWdpMDReGWFHE8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742738991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2jDLWApycLVfP31DaCdo1jO1vVA011lwCmzuDG5Z3OQ=;
	b=G1C5xdJMj91qp1ul8epLYxh8l2Emog056gPYEiKXwmk1NJu4m3N4ql0H+e8AHALXPNE9Gk
	kyZ7O4th9m9DF+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 989271339F;
	Sun, 23 Mar 2025 14:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nVUUJC8W4Gd7PAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:09:51 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v2 00/13] ima: get rid of hard dependency on SHA-1
Date: Sun, 23 Mar 2025 15:08:58 +0100
Message-ID: <20250323140911.226137-1-nstange@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

this is v2 of the RFC series to disentangle IMA from its current
dependency on a working SHA-1 implementation.

For reference, v1 can be found at [1].

Several options for when and how to invalidate unsupported TPM PCR banks
by extending them with a unique constant had been discussed at the v1:
a.) every single time a new entry gets added to the measurement list
b.) or only once.

b.) is appealing, because it enables recognizing unsupported banks right
away from their value, but comes at a significant additional complexity.
Fortunately, it turned out that it's possible to develop b.) incrementally
on top of a.), so this series can get truncated
- after [5/13] ("ima: select CRYPTO_SHA256 from Kconfig") to get a.),
- or after [9/13] ("ima: invalidate unsupported PCR banks only once")
  to get a partial b.), invalidating unsupported banks only once for
  each kernel booted, but redoing it for each kernel in a kexec chain,
- or not at all to get the full b.), i.e. to skip reinvalidations even
  from later kernels in the kexec chain if possible.

I would personally go for the full set, because it also enables some
perhaps helpful diagnostics for the kernel log, but OTOH I'm clearly
biased now because I've implemented everthing. So it's your judgement
call now on how to proceed. Either way, I would send the next iteration in
non-RFC mode with the full CC set. If you opted for a.) only, it would be
a.) only, i.e. [1-5/13]. If you decided for b.), it might make sense to
send in two batches to facilitate review: [1-9/13] first and the rest
somewhen later.

FWIW, I did some testing now, on the full series in a VM with a swtpm
attached to it:
- both with and without CONFIG_TCG_TPM2_HMAC (for [10/13] ("tpm:
  authenticate tpm2_pcr_read()" coverage) and
- with a focus on verifying everything related to the new invalidation
  logic is working as intended.

Thanks a lot!

Nicolai



Changes to v1:
- [v1 1/7] ("ima: don't expose runtime_measurements for unsupported
  hashes"): no change.
- [v1 2/7] ("ima: always create runtime_measurements sysfs file for
  ima_hash"): no change.
- [v1 3/7] ("ima: move INVALID_PCR() to ima.h"): moved to [v2 6/13],
  otherwise no change.
- [v1 4/7] ("ima: track the set of PCRs ever extended"):
  moved to [v2 8/13], drop code restoring ima_extended_pcrs_mask at kexec,
  update it from ima_pcr_extend() only if the tpm_pcr_extend() was
  successful.
- [v1 5/7] ("tpm: enable bank selection for PCR extend"): moved to
  [v2 7/13], fix a bug by actually passing the skip mask from
  tpm_pcr_extend() to tpm2_pcr_extend().
- [v1 6/7] ("ima: invalidate unsupported PCR banks once at first use"):
  gone, superseded by the new
    [v2 3/13]  ("invalidate unsupported PCR banks")
    [v2 9/13]  ("ima: invalidate unsupported PCR banks only once")
    [v2 13/13] ("ima: don't re-invalidate unsupported PCR banks after
              kexec")
- [v1 7/7] ("ima: make SHA1 non-mandatory"): moved to [v2 4/13],
  diff context updates due to ima_unsupported_tpm_banks_mask not
  existing yet at this point in the series.

- [v2 5/13] ("ima: select CRYPTO_SHA256 from Kconfig"): new to
  (hopefully) address feedback at [2].
- [v2 10/13] ("tpm: authenticate tpm2_pcr_read()"): new, prerequisite
  for the next in a sense.
- [v2 11/13] ("ima: introduce ima_pcr_invalidated_banks() helper"): new,
  prerequisite for [13/13].
- [v2 12/13] ("ma: make ima_free_tfm()'s linkage extern"): new,
  likewise a prerequisite for [13/13].


[1] https://lore.kernel.org/r/20250313173339.3815589-1-nstange@suse.de
[2] https://lore.kernel.org/r/4e760360258bda56fbcb8f67e865a7a4574c305a.camel@linux.ibm.com


Nicolai Stange (13):
  ima: don't expose runtime_measurements for unsupported hashes
  ima: always create runtime_measurements sysfs file for ima_hash
  ima: invalidate unsupported PCR banks
  ima: make SHA1 non-mandatory
  ima: select CRYPTO_SHA256 from Kconfig
  ima: move INVALID_PCR() to ima.h
  tpm: enable bank selection for PCR extend
  ima: track the set of PCRs ever extended
  ima: invalidate unsupported PCR banks only once
  tpm: authenticate tpm2_pcr_read()
  ima: introduce ima_pcr_invalidated_banks() helper
  ima: make ima_free_tfm()'s linkage extern
  ima: don't re-invalidate unsupported PCR banks after kexec

 drivers/char/tpm/tpm-interface.c      |  29 +++-
 drivers/char/tpm/tpm.h                |   3 +-
 drivers/char/tpm/tpm2-cmd.c           |  75 ++++++++-
 include/linux/tpm.h                   |   3 +
 security/integrity/ima/Kconfig        |  15 ++
 security/integrity/ima/ima.h          |  12 ++
 security/integrity/ima/ima_crypto.c   | 216 ++++++++++++++++++++++----
 security/integrity/ima/ima_fs.c       |  41 +++--
 security/integrity/ima/ima_policy.c   |   5 +-
 security/integrity/ima/ima_queue.c    |  54 ++++++-
 security/integrity/ima/ima_template.c |  84 +++++++++-
 11 files changed, 471 insertions(+), 66 deletions(-)

-- 
2.49.0


