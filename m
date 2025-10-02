Return-Path: <linux-integrity+bounces-7357-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E6BB353C
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Oct 2025 10:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8907D543E8E
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Oct 2025 08:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470530EF84;
	Thu,  2 Oct 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="25uo8ZTH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5SJ61uoT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="25uo8ZTH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5SJ61uoT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3B311C2C
	for <linux-integrity@vger.kernel.org>; Thu,  2 Oct 2025 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394237; cv=none; b=XZodjc/RUM5RvzWSdFCqTnYvmV7Xl4Ii1IxR4RbZMenh7oO5VTHGzN/e2RCLj7BD6vVirudj1xdaB6bW5tii6b0l0iO4mYxPCmsgVXes4hc1h1I4m5JGtsnB7uBz3S9JRmUxI1Kw/smLxHjVCbvhpDv1slYfF6ViqDnpO8qj9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394237; c=relaxed/simple;
	bh=6zoj/3XaiyJArvjPCfYaAwEhIvw6f4a+jIVZ+Z6xa3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFCqUDaVEUC27UVY0VhSDttEPMYVi428e80dGFNqjSgihMa0j3JVkrMEDK1w7kEbIWmwI6gZcRtqyaMo5ZKmJsWtLaZK0O5yolV77UB9taINU/4bGHb9Tyat78VF/cBgYJBrHLE/FRNTzFI/K2PCz0HqdkM/7H7AUm2kGMmeO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=25uo8ZTH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5SJ61uoT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=25uo8ZTH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5SJ61uoT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5659533846;
	Thu,  2 Oct 2025 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759394224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KNwNW8+GpdP3RkB0MEUHO+PnqhML7d+AlfzTXFBKkg8=;
	b=25uo8ZTH1Vv1zGjuCO56kaP1O/s3yRgRCnsiuhAbG8yff4+kXIVLqbSYp3gbA26ezhks3k
	U1MPr/1V8r1Lp2k6XjCBHBU9JgFHbYEVPwaYN0HiOY0i3JQ2Mmf1w5/FjCUm5/xgUK6tPZ
	77keuw0sU/W3Tn0IwqOVb1bKUga6BKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759394224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KNwNW8+GpdP3RkB0MEUHO+PnqhML7d+AlfzTXFBKkg8=;
	b=5SJ61uoTMBoGzXQNiFA3T820IXhLLWbPTf99U9C9bOV4rBFdDIEydgVFBw/7MJvN8/7A14
	UuAsYDUDrqaaTYBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759394224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KNwNW8+GpdP3RkB0MEUHO+PnqhML7d+AlfzTXFBKkg8=;
	b=25uo8ZTH1Vv1zGjuCO56kaP1O/s3yRgRCnsiuhAbG8yff4+kXIVLqbSYp3gbA26ezhks3k
	U1MPr/1V8r1Lp2k6XjCBHBU9JgFHbYEVPwaYN0HiOY0i3JQ2Mmf1w5/FjCUm5/xgUK6tPZ
	77keuw0sU/W3Tn0IwqOVb1bKUga6BKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759394224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KNwNW8+GpdP3RkB0MEUHO+PnqhML7d+AlfzTXFBKkg8=;
	b=5SJ61uoTMBoGzXQNiFA3T820IXhLLWbPTf99U9C9bOV4rBFdDIEydgVFBw/7MJvN8/7A14
	UuAsYDUDrqaaTYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D79B213990;
	Thu,  2 Oct 2025 08:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JM9MK853miCWQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 02 Oct 2025 08:37:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Martin Doucha <mdoucha@suse.cz>
Subject: [PATCH 0/4] ima_{conditionals,measurements}.sh enhancements
Date: Thu,  2 Oct 2025 10:36:57 +0200
Message-ID: <20251002083701.315334-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80


Petr Vorel (4):
  ima_{conditionals,measurements}.sh: Add temporary user
  ima_conditionals.sh: Split test by request
  ima_conditionals.sh: Use 'sg' without 'sudo'
  ima_{conditionals,measurements}.sh: Use 'su' instead of 'sudo'

 runtest/ima                                   |  5 +-
 .../integrity/ima/tests/ima_conditionals.sh   | 81 ++++++++++++-------
 .../integrity/ima/tests/ima_measurements.sh   | 15 ++--
 .../security/integrity/ima/tests/ima_setup.sh | 12 +++
 4 files changed, 71 insertions(+), 42 deletions(-)

-- 
2.51.0


