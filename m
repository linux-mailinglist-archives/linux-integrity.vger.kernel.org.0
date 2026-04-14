Return-Path: <linux-integrity+bounces-9175-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAevMFiK3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9175-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:29:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A63F47A1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF287307D239
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48523A9BD;
	Tue, 14 Apr 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alavQo2r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF52222CC
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126174; cv=none; b=sczf7uuIORMgbSeQLXAEqN7AfpUasXyDv3BG1cYCxzJf2WBNOHqR4fCKRWd/OYa+N/jpzt9XR2SM4MFl/EmHdumB3RU1s9yFBiuUNPi/wr5S2qjiwtvcgbjsepjBkvtynj5sZtjWh6U8RsytXOwuBRwEuwo88KQT00i6P3JQkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126174; c=relaxed/simple;
	bh=4RL03Ywa/Y8bAx7bmZ6TMEcazsp4xQVfN7ChOOQP5pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JExfXRDFfDnSGokHJbkyCjgjy0OQtdRmts3KrTIxiPjIfDeMgT3WZ0xBRdK1xh2BYYJDrwXoOiUEzVPAuh6d2fv/73xp+FZNrnSsZzu7/W+ihkUdjtpRQy57VoxdC9LfZsHi7S6Pv+a+RDpT5vdq9blg7YFm079WS1aRbao+RNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alavQo2r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ptBdRIl9Rnd7CJlQKOxJjpR2Kf/2ZleQtd9Kf4cnXAY=;
	b=alavQo2r7vRlZzvyOaYbgne2yJG4iV1L5ujBdXqfUqehlFvwgIl3CN4W5D4QcIZOxFe5vd
	Bv8qeqAq1lleZqcrfDRpe0aJoGa9uniLTIHiIMjSynMhPLT/Wn8Ub4sP98VISfSG6Zrr4n
	yf2843LQvhMHE5piLt0dHXa81uSUltI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-ydO8UCvvNnGdYnnZbzOLcA-1; Mon,
 13 Apr 2026 20:22:47 -0400
X-MC-Unique: ydO8UCvvNnGdYnnZbzOLcA-1
X-Mimecast-MFC-AGG-ID: ydO8UCvvNnGdYnnZbzOLcA_1776126166
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79906195608B;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E17003000C16;
	Tue, 14 Apr 2026 00:22:45 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0Mimi1917466
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:44 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0Miuw1917465;
	Mon, 13 Apr 2026 20:22:44 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [RFC PATCH 00/10] Fix dm-ima bugs
Date: Mon, 13 Apr 2026 20:22:34 -0400
Message-ID: <20260414002244.1917447-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9175-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmarzins@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.970];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 671A63F47A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dm-ima code does not guarantee that the dm_ima_measure_on_*
functions will not be called at the same time. Since they modify and
free shared memory, this can lead to Use-After-Free errors or garbage
measurements. Further, they don't make sure that the state they measure
corresponds to the actual device state. For instance if table_load()
runs at the same time as do_resume() on a table swap,
dm_ima_measure_on_device_resume() can end up thinking the wrong table is
active. Or a concurrent dm_hash_rename() and a table swap, can end up
with a the new active table still using the old name. This patchset
makes sure the the dm-ima function are serialized and report the correct
device state.

However, the code is still messier that in could be. This is because
it duplicates the current measurement events and format. I would really
like to know if that is necessary. Specifically, it currently measures
the following dm device and table actions:

load
clear
rename
resume
remove

I don't see the benefit of reporting changes to the inactive table, or
resumes where the device does not change state. From the user's point of
view, the device is still the same after these events.  At the same
time, it doesn't measure device creates if no table was loaded, so you
can have situations where the the first measurement for a device is a
rename or a remove. A more sensible set of actions to measure would be:

create
table_swap
rename
remove

Also, the measurement format doesn't map well to how dm device's are
actually set up, in a way that makes it harder for the code and records
extraneous information. First, like I mentioned before, I don't see the
benefit of measuring the inactive table. Second, the name, uuid, and
major/minor numbers are properties of the device, not it's table (and dm
devices can't have partitions, so the minor count will always be 1). I
don't see a reason to store and occasinally log this information twice,
if there is an active and incative table, and it forces extra
coordination between the dm_ima_measure_on_* functions.

I'm wondering it we are stuck with the current events and format, now
that this has been released? Or could we bump the version, and change
what events we measure, and how we format the output?

Benjamin Marzinski (10):
  dm-ima: remove dm_ima_reset_data()
  dm-ima: remove broken last_target_measured logic
  dm-ima: Remove status_flags from dm_ima_measure_on_table_load()
  dm-ima: don't copy the active table to the inactive table
  dm-ima: Fix UAF errors and measuring incorrect context
  dm-ima: remove new_map from dm_ima_measure_on_device_clear
  dm-ima: Fix issues with dm_ima_measure_on_device_rename
  dm-ima: Handle race between rename and table swap
  dm-ima: Fail more gracefully in dm_ima_measure_on_*
  dm-ima: use active table's size if available

 drivers/md/dm-ima.c   | 506 +++++++++++++++++++-----------------------
 drivers/md/dm-ima.h   |  67 ++++--
 drivers/md/dm-ioctl.c | 146 +++++++++++-
 drivers/md/dm.c       |   2 +-
 4 files changed, 421 insertions(+), 300 deletions(-)

-- 
2.53.0


