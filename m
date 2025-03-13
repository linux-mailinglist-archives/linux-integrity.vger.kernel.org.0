Return-Path: <linux-integrity+bounces-5272-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63732A5FDD9
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 18:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98ED516E93E
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C99318CBE1;
	Thu, 13 Mar 2025 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NF5oSxYh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fNE+eAsM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NF5oSxYh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fNE+eAsM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010A1607B4
	for <linux-integrity@vger.kernel.org>; Thu, 13 Mar 2025 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887292; cv=none; b=FNYYdwa/KELz591nJ2rTD6SCj+GE6DhXbtrpGtNlMVzJ8Y2WxXUfqvlVr1iTubq/nd8xbvCl3M08pEniTwPAyod9EivLPsN+HpxoK1o37LMqgBSYrafXunlHIKfl03HWlgi5gdWcdVz2U+f7gJPSN36q+WTYA12Nj9pQSyOc6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887292; c=relaxed/simple;
	bh=X9jGp/lGksz3grpthwFKZ40t1B2yEAFWn9jNtB3eNUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUjzDXIwJ1xHRPdruCGdFfdkafIrFV01ZgXv+bzP0fCjfO7YrjssFXTE7aE1MR0Cz7PzifYvFFcEg66jBkmAU2C7PpQ4ytFzE/MH1XX8hs5AsGWeJagZPMcmB5sd+eOLmRnA/TioiCBhFSGSXgIHEkxv0s4BhWMIAbktbdsfze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NF5oSxYh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fNE+eAsM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NF5oSxYh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fNE+eAsM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E0F821175;
	Thu, 13 Mar 2025 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741887288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X5teZExJXtoF+96+S6qe8NpWsv7WJatzt6RrVYXYHBQ=;
	b=NF5oSxYhGFyGwdpf6IL4tASTw/cWbZJWcliXVLkrXdHg+4JujDlXEBaO3f2HSSRRdc5iIo
	2IVyA53IZGnKA2dYZ8LFRJISNXNlUP7KwGeyTtpbJChPUI0WZgVxtXuzuKsipUQ6tnMOKH
	yOXnNN47Wv8HmGvK1NZTkrjCZ8fyikI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741887288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X5teZExJXtoF+96+S6qe8NpWsv7WJatzt6RrVYXYHBQ=;
	b=fNE+eAsMXQ+H2dbtYrNx0j1oKMhJk7ek+S8DnKDluUJQL9OLWR8bvMhaQIWV9x95rccIWy
	OrGBMjqB4UVi9cDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741887288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X5teZExJXtoF+96+S6qe8NpWsv7WJatzt6RrVYXYHBQ=;
	b=NF5oSxYhGFyGwdpf6IL4tASTw/cWbZJWcliXVLkrXdHg+4JujDlXEBaO3f2HSSRRdc5iIo
	2IVyA53IZGnKA2dYZ8LFRJISNXNlUP7KwGeyTtpbJChPUI0WZgVxtXuzuKsipUQ6tnMOKH
	yOXnNN47Wv8HmGvK1NZTkrjCZ8fyikI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741887288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X5teZExJXtoF+96+S6qe8NpWsv7WJatzt6RrVYXYHBQ=;
	b=fNE+eAsMXQ+H2dbtYrNx0j1oKMhJk7ek+S8DnKDluUJQL9OLWR8bvMhaQIWV9x95rccIWy
	OrGBMjqB4UVi9cDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BF8D137BA;
	Thu, 13 Mar 2025 17:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gor7IDgX02f3QgAAD6G6ig
	(envelope-from <nstange@suse.de>); Thu, 13 Mar 2025 17:34:48 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v1 0/7] ima: get rid of hard dependency on SHA-1
Date: Thu, 13 Mar 2025 18:33:32 +0100
Message-ID: <20250313173339.3815589-1-nstange@suse.de>
X-Mailer: git-send-email 2.47.1
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nist.gov:url,imap1.dmz-prg2.suse.org:helo];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Hi all,

if no SHA-1 implementation was available to the kernel, IMA init would
currently fail, rendering the whole subsystem unusable.

This patch series is an attempt to make SHA-1 availability non-mandatory
for IMA. The main motivation is that NIST announced to sunset SHA-1 by
2030 ([1]), whereby any attempt to instantiate it when booted in FIPS mode
would have to be made to fail with -ENOENT. As this does potentially have
an impact on lifetimes for FIPS certifications issued today, distros might
be interested in disabling SHA-1 downstream soon already.

Anyway, making IMA to work without a SHA-1 implementation available is not
so straightforward, mainly due to that established scheme to substitute
padded SHA-1 template hashes for PCR banks with unmapped/unavailable algos.
There is some userspace around expecting that existing behavior, e.g. the
ima_measurement command from ([2]), and breaking that in certain scenarios
is inevitable.

I tried to make it the least painful possible, and I think I arrived at
a not completely unreasonable solution in the end, but wouldn't be too
surprised if you had a different stance on that. So I would be curious
about your feedback on whether this is a route worth pursuing any further.
FWIW, the most controversial parts are probably
 - [1/7] ima: don't expose runtime_measurements for unsupported hashes
 - [6/7] ima: invalidate unsupported PCR banks once at first use

Note that I haven't tested this series thoroughly yet -- for the time being
I only ran a couple of brief smoke tests in a VM w/o a TPM  (w/ and w/o
SHA-1 disabled of course).

Many thanks!

Nicolai

[1] https://www.nist.gov/news-events/news/2022/12/nist-retires-sha-1-cryptographic-algorithm
[2] https://github.com/linux-integrity/ima-evm-utils.git

Nicolai Stange (7):
  ima: don't expose runtime_measurements for unsupported hashes
  ima: always create runtime_measurements sysfs file for ima_hash
  ima: move INVALID_PCR() to ima.h
  ima: track the set of PCRs ever extended
  tpm: enable bank selection for PCR extend
  ima: invalidate unsupported PCR banks once at first use
  ima: make SHA1 non-mandatory

 drivers/char/tpm/tpm-interface.c      | 29 +++++++++-
 drivers/char/tpm/tpm.h                |  3 +-
 drivers/char/tpm/tpm2-cmd.c           | 29 +++++++++-
 include/linux/tpm.h                   |  3 +
 security/integrity/ima/Kconfig        | 14 +++++
 security/integrity/ima/ima.h          |  9 +++
 security/integrity/ima/ima_crypto.c   | 83 ++++++++++++++++-----------
 security/integrity/ima/ima_fs.c       | 41 +++++++------
 security/integrity/ima/ima_policy.c   |  5 +-
 security/integrity/ima/ima_queue.c    | 26 ++++++++-
 security/integrity/ima/ima_template.c |  7 +++
 11 files changed, 190 insertions(+), 59 deletions(-)

-- 
2.47.1


