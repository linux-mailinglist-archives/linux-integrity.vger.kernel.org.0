Return-Path: <linux-integrity+bounces-9196-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKCYNfq232lVYQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9196-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 18:04:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295340633A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 18:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A4DB30E1E9C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8033E3D88;
	Wed, 15 Apr 2026 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slYKzEKj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5B3B27C4
	for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268813; cv=none; b=RKwGif7zAZazhP+vuYwuC5JOjwvxwHlM44nhZFCuhoeePhtLey+GkXXryGcEe5+tK1M40h8Jy1jA9X8mV+tm/Z++dvmBXgaAIjZKQP4faMduovWvDvwU4w2UVkzZ/vpeIXC2EpIYUjuAqQ7M24XxvScnm1ncLhz49VuLC9e7riY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268813; c=relaxed/simple;
	bh=zGjWY6RSLN0McBk1PVHgIRXzFklPLozRqfOhL3KVn28=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J/r2/U9asNr+vjOsS6vSnN8sX0rbfxKY/wlaC71DmcU4Wcj6pefkSXLQaQhr2udvfxF+BdEf3wn5TvJPDxjij8M0TLseFqsPwLiZfWFTmcCbKKV8jQ4Np3IFVzYaAjTIIxFgoN8rpubBIl6HeTZtEvLfzgotTo9aRkpngHUzC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=slYKzEKj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2523e0299so175962905ad.3
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2026 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776268812; x=1776873612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IijrdPO4mSdFlRQuYha0rEsFCOp3Y0I2uG+ErkWzVAE=;
        b=slYKzEKj/np45+PXdzL4MsCZb/kbXDFIisaIRg7d5K1cUGQYBxzQbIwgYa6RjuMivh
         hJJJhdF2zcwuPSoKYQjTXxFsD7BNtA5+RIEz1zfiF+GF//Srik6cPvx+mqZ2y0slN7G6
         7yKufhd4NQzKnSn0+85HASBQQYT8Z2GwNPKOS5CpwI9RTLdPuxPRdO4kh00NrdnbTuxI
         /VqG+9HYwwg5rdEtCmsnxXzBq9UzfvurlJFRbn0Z8Stn9S39HUir8QPjSznwV0ugO2xN
         28cp2j/3CQzzLTA8MfFC5GDYWdeAWdgoQrViUOzChfi4MzVgGbWVEyhD/u68F58iab9d
         DJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776268812; x=1776873612;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IijrdPO4mSdFlRQuYha0rEsFCOp3Y0I2uG+ErkWzVAE=;
        b=IW2ZvvAKSfxjd65+BGW+rOWLuRa3rW13nitlJQKDQB6E1yw5STP+QY/ee4NJgmpkgM
         yKvWEQn8qFeM+ZD56C2Qb5oHDgL0kwDna+YnfgfYj8qhmbuT9OZAjuD1NNyIh1XNvaLr
         Wis91sngeLBHJ5bYwMxphJiCWEr9giuzxv61EhVqX6i4UmOmqRaotdTlfIiIg6QKEC7/
         +JC+dW6haBLKe/G98N5kB9u+W0fTqPJ4opLwjHDr9bKX8G7P1VXZ81dHpEY2kmvJBjox
         VZaOnDLHBHUL0TaYB3iOf31ZjZONI5Fnh/Rdk/HnsINSe3ZbEsMk0AYvJD9xzvogIPTz
         8s/A==
X-Gm-Message-State: AOJu0YwnxABdRcJ7hrw0O83genGJe4p4fRzGdRe+obe2uR+SWnn3wZmj
	+83wcYK1e/Y0zsxFrUoOppJuYnU3+T89EZiWnUvScFr32xZua36/3yYgwUChpCkK50w+vWOG9AG
	JlUK5jQUvQ5rwY38Rze9ivRHmMyESsuUwC0U6peE3BKAX/nkhy5l4b4amrfo1y5W2yHqQ2xteI6
	e9Ah7N4lIEpTJBNyRxx0/Ax4usoczZsy1CZJs02vCCje2Eyw47Pj44P1wOg6Q=
X-Received: from plbmn8.prod.google.com ([2002:a17:903:a48:b0:2b2:4713:9ce4])
 (user=jacqwong job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4502:b0:2b2:53f5:4627 with SMTP id d9443c01a7336-2b2d5939409mr164552305ad.4.1776268811731;
 Wed, 15 Apr 2026 09:00:11 -0700 (PDT)
Date: Wed, 15 Apr 2026 16:00:04 +0000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260415160006.2275325-1-jacqwong@google.com>
Subject: [PATCH v3 0/2] tpm_tis: fix retry exhaustion and add logging
From: Jacqueline Wong <jacqwong@google.com>
To: linux-integrity@vger.kernel.org
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	axelrasmussen@google.com, jhand@google.com, 
	Jacqueline Wong <jacqwong@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9196-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,ziepe.ca,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacqwong@google.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7295340633A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Fix:
- Patch 1: Adds error logs to identify the specific hardware status mismatch.
- Patch 2: Stops execution immediately when retries are exhausted.

v3 changes:
- Improved code alignment to pass checkpatch --strict. 

v2 changes:
- Split logging and logic into separate patches.
- Added retry count to the error message.
- Included dmesg traces below.

Testing:
Dmesg traces obtained using error injection to simulate status register mismatches.

Before:
[  130.288751] tpm tpm0: Operation Timed out
[  250.306070] tpm tpm0: Operation Timed out
[  250.310173] tpm tpm0: A TPM error (-62) occurred attempting to determine the timeouts

After:
[   10.271547] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
...
[   10.646283] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
[   10.653461] tpm tpm0: Exhausted 50 tpm_tis_send_data retries
[   10.659304] tpm tpm0: tpm_try_transmit: send(): error -5
[   10.665435] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
...
[   11.037198] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
[   11.044441] tpm tpm0: Exhausted 50 tpm_tis_send_data retries
[   11.050288] tpm tpm0: tpm_try_transmit: send(): error -5
[   11.055723] tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts

Jacqueline Wong (2):
  tpm: tpm_tis: add error logging for data transfer
  tpm: tpm_tis: stop transmit if retries are exhausted

 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.54.0.rc0.605.g598a273b03-goog


