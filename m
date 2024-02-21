Return-Path: <linux-integrity+bounces-1322-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4515785D3AB
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 10:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682F81C21D1A
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634A47F59;
	Wed, 21 Feb 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XLb70K0X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3i4Yo6GJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XLb70K0X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3i4Yo6GJ";
	dkim=neutral (0-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0Q2A+w0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D247F5C
	for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507734; cv=none; b=VStIAOIMFBzJRgK1aRm4I7ZiUH3y20Th8VUYchwmG4AE4uwzhvjHG2qgT7a+XDVmeT4pK2GJD2vAgkqA8+FwCGw/BcNnW2jz8P/VFEbKQOOAiVV5zXgLTiyL4V9Nno5JatL7krURCjUUWq++B3lP2VlLe8utEP23HV9ZmyK8ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507734; c=relaxed/simple;
	bh=Pg/PYiCKk/bqfBenhN+jaO19Z2p53QjS+bTAPZtr7X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAHQrCn+mEvwdq2V9lt8cJ4V4+z3JvkAXJ3xcBHLiqwpZagDNoDtXYnEsMqRAEiFSkXZs4Cp17urOJiwFWrAf4I8jOhj8LR6ZiEunXccPKosxBC58wnktMA9w4FthN93DIO3pfac/+ETefAtiJSAfYf6M50902xZghTwrlxO9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XLb70K0X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3i4Yo6GJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XLb70K0X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3i4Yo6GJ; dkim=neutral (0-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0Q2A+w0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41E0B1FB4E;
	Wed, 21 Feb 2024 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708507730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=8xyu9Hj+h69IKvciS22b2xw4Aw1MaHbSy1ltGMp4iCg=;
	b=XLb70K0XE6AfKToW+Ujv/m5QCW6BevF4gAoUfYJBgAIf4m3MCWCOBYadXAZbSRgOsUbZuH
	jZWY3rrLDgOVezSxtq7LtTsvOLwYnhsU/IynV+bcFCmqJ7Xkny7eK0Lvf9WVWluLAXqThO
	JajLmUTuqcgBbrPQ6w8r6YCyIFwt9qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708507730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=8xyu9Hj+h69IKvciS22b2xw4Aw1MaHbSy1ltGMp4iCg=;
	b=3i4Yo6GJoGicYiMUT3YcPk1xAd81AmN19pxilMMoK/RA3vYcT444UzGuoNzFzn7TWu6/Iy
	4S/bBnxwczGJigCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708507730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=8xyu9Hj+h69IKvciS22b2xw4Aw1MaHbSy1ltGMp4iCg=;
	b=XLb70K0XE6AfKToW+Ujv/m5QCW6BevF4gAoUfYJBgAIf4m3MCWCOBYadXAZbSRgOsUbZuH
	jZWY3rrLDgOVezSxtq7LtTsvOLwYnhsU/IynV+bcFCmqJ7Xkny7eK0Lvf9WVWluLAXqThO
	JajLmUTuqcgBbrPQ6w8r6YCyIFwt9qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708507730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=8xyu9Hj+h69IKvciS22b2xw4Aw1MaHbSy1ltGMp4iCg=;
	b=3i4Yo6GJoGicYiMUT3YcPk1xAd81AmN19pxilMMoK/RA3vYcT444UzGuoNzFzn7TWu6/Iy
	4S/bBnxwczGJigCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A415013A25;
	Wed, 21 Feb 2024 09:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nNAvJlHC1WXSBwAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 21 Feb 2024 09:28:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: dmitry.kasatkin@gmail.com,
	linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	a.mardegan@omp.ru,
	dbaryshkov@gmail.com,
	ebiggers@google.com,
	gcwilson@linux.ibm.com,
	git@andred.net,
	kgoldman@us.ibm.com,
	mjg59@srcf.ucam.org,
	patrick.ohly@intel.com,
	patrick@puiterwijk.org,
	petr.vorel@gmail.com,
	roberto.sassu@huawei.com,
	sorenson@redhat.com,
	stefanb@linux.ibm.com,
	stephen.smalley.work@gmail.com,
	tianjia.zhang@linux.alibaba.com,
	vgoyal@redhat.com,
	vt@altlinux.org,
	z.jasinski@samsung.com,
	zohar@linux.ibm.com,
	Petr Vorel <pvorel@suse.cz>
Subject: [ima-evm-utils: PATCH v1 1/1] Change license to LGPL-2.0-or-later and GPL-2.0-or-later
Date: Wed, 21 Feb 2024 10:28:39 +0100
Message-ID: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864003C470 for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 08:11:49 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso4047711fa.2 for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1708503107; x=1709107907; darn=vger.kernel.org; h=content-transfer-encoding:mime-version:message-id:date:subject:cc :to:from:from:to:cc:subject:date:message-id:reply-to; bh=2tbJib+kst8GjcLmTyERQIlMEjnjEiTvE+TjUqJjhh4=; b=B0Q2A+w0OyAprfBbm/k4MSk9nJ3f4VosNmxa9M5zOyK6SYaolWk+G/QMcgcvgy8Y8Z fLmByCmLpv6HA0QRRglnAYYTTmBZHfEq6CMl3wsecbliVJqp+tZpOchCly+qWDF8AriF ZRWL5oXLzVuGMYC5zEqSYCOtDJ+GS09tbYWpnzwdbh6aRTI+X8yZ1n+SORPM1Re4eLYW pk9EvmNRBiU8wqjchzCPMQVBSivOyJ1bRKN7PseMCvs2BgYw4zhYDlA2QY2rS2I4frV7 s4ohGgRGUJSA8LmY7a+LdjhUaqbNDCmXnhjT/jVr+DdwRHMniv9G1iaRdQIDSYbqZW4i IKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1708503107; x=1709107907; h=content-transfer-encoding:mime-version:message-id:date:subject:cc :to:from:x-gm-message-state:from:to:cc:subject:date:message-id :reply-to; bh=2tbJib+kst8GjcLmTyERQIlMEjnjEiTvE+TjUqJjhh4=; b=fHX8pAwQUiW1BzdTSGIYCpnujKHGXM3NT6jPCjZDMeUCydmYjOWjXGFeWFPxyPbpOW Q8ryK/tWX4Qw5uRVt811wmBwzmwHlx11yo8CJgpzhy4h/WgDw0pF3Pirs2sqmgIixR1J r0MmMu9yKALXq/CkNcnWJGVDrYvyW4SEdMnr5IzCQoGAKdKu2uUpTfXdjtzi9/qGOUq8 JASJAFNDmMB2FeVQ2+sqg0mAmqFemAe+UBl+010t9mEftjjuVVu2uO957Tbn3y8/MpoL 2Z46c7Xx0qaWNkGQ4IF6rbKrWRXR74xiP2L70wDMMGmu5PrKMFj62vXc7d528FPQKiRB wOdg==
X-Gm-Message-State: AOJu0YwTXhc3w54DBHOg4teM10czD/ly9FCEvYLIwEQGnLKxdWEjGw87 r+uYqGgt+6EhP0xFqrWYsyx8zBQixCJJE0A094Pyr3zE0SyVlgKM6ls6/gFTjGMC4kLL
X-Google-Smtp-Source: AGHT+IGwFuQcFzmsc5LsWrg9q5WB6KU9vNa/YsSkl+MoJR2SFXVEIEjn1f712FGpelUo+GOukogYBg==
X-Received: by 2002:a05:6512:3995:b0:512:c9ad:2cc0 with SMTP id j21-20020a056512399500b00512c9ad2cc0mr2923383lfu.34.1708503106676; Wed, 21 Feb 2024 00:11:46 -0800 (PST)
Received: from kds.. ([212.149.142.231]) by smtp.gmail.com with ESMTPSA id e10-20020ac2546a000000b005117a6a27bcsm1556823lfn.186.2024.02.21.00.11.45 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Wed, 21 Feb 2024 00:11:45 -0800 (PST)
X-Mailer: git-send-email 2.40.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *****
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XLb70K0X;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3i4Yo6GJ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [5.73 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 SUSE_ML_WHITELIST_VGER(-0.10)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLic9mzq3mmdtog88cdgw6y6f5)];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MAILLIST(-0.15)[generic];
	 FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[30.95%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_COUNT_FIVE(0.00)[6];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 PRECEDENCE_BULK(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-integrity@vger.kernel.org];
	 HAS_LIST_UNSUB(-0.01)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_TO(1.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 RCVD_IN_DNSWL_NONE(1.00)[209.85.208.179:received];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[HansenPartnership.com,omp.ru,gmail.com,google.com,linux.ibm.com,andred.net,us.ibm.com,srcf.ucam.org,intel.com,puiterwijk.org,huawei.com,redhat.com,linux.alibaba.com,altlinux.org,samsung.com,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 5.73
X-Rspamd-Queue-Id: 41E0B1FB4E
X-Spam-Flag: NO

From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>

Currently libimaevm provided by this project is used by the tool evmctl,
which is also provided by this project.

An issue was reported about using libimaevm with other software. Its
GPL2-only license makes it incompatible to use with other licenses, in
particular GPL3-only.

To address this issue, change the project license to GPL-2.0-or-later
and libimaevm to LGPL 2.0 or later.

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
---
 COPYING                | 339 -----------------------------------------
 LICENSES.txt           |  13 ++
 src/evmctl.c           |  25 +--
 src/hash_info.gen      |  10 +-
 src/imaevm.h           |  25 +--
 src/libimaevm.c        |  25 +--
 src/pcr.h              |   2 +
 src/pcr_ibmtss.c       |   2 +-
 src/pcr_tss.c          |  25 +--
 src/pcr_tsspcrread.c   |  25 +--
 src/utils.c            |   2 +-
 src/utils.h            |   2 +
 tests/functions.sh     |  11 +-
 tests/gen-keys.sh      |  11 +-
 tests/ima_hash.test    |  11 +-
 tests/sign_verify.test |  11 +-
 tests/test_mmap.c      |   2 +-
 17 files changed, 30 insertions(+), 511 deletions(-)

Hi Dmitry,

I fully agree with this, but all files I added SUSE copyright with my email
weren't touched. These files actually have no license. Therefore I have no idea
if my ack make sense.

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

 delete mode 100644 COPYING
 create mode 100644 LICENSES.txt
...

