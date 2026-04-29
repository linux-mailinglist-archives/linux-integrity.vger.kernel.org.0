Return-Path: <linux-integrity+bounces-9385-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBidB05o8mkBqwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9385-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:21:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D028949A14C
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A4E0302307C
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083E3379EFF;
	Wed, 29 Apr 2026 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YH110+X2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4538423A
	for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2026 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494084; cv=none; b=HIof6/sOAx9jGVts+qt0ZWwhmRUra4OuryZxJk+wi4ih6lnT1tBI7rLHMftVCUaYPm40CRkyF20vlqriJXVtALtpApAzBhif0auyFFTgLZhU6Eg+HAba22X69efwFNhxyeAu1JvgVqodOaESPDJnF74JG2OcnN/22ZVu4n76A34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494084; c=relaxed/simple;
	bh=5nTyOwdMYanm7hNJTUM/TSInNM4qMG3i1lCtm03jVcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o40+yt/PaupefJKcqkrc1s7IlQpH6BGx28YE3U4ooMhYdEmYRn5tbhCfFVauD/87YASp/ZONR3W2xwU23lkLMHMpCEJL5fzwM/1zrQvQWXEJDoG53FWeK5qKzzj1UJ6GwKI7vCNqCi77/ilR9hrCLgIsSbPWMtwp+YQQIPN3aoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YH110+X2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777494080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8VK6nM9SAk0NXUMrwNMnfZkodOPfnvsT0a7R2BtP0JI=;
	b=YH110+X2mfkgx3a7Zqr7x9l6dgxflnKTQoyz+Skyz9A3mtapv0tLy29E5FF8zGAP9cuzgv
	7hLyYOl0oNQJzveZuO8GxrHveMSGuUAD5iPfHa9QLzVyybCQz5JmjKq9ifqqHnAm04umxT
	L2r0MVbFYRIKm5zwXagOyRYDwdda/TY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-4A5Tj6KQNYSQpuM4FTivjA-1; Wed,
 29 Apr 2026 16:21:14 -0400
X-MC-Unique: 4A5Tj6KQNYSQpuM4FTivjA-1
X-Mimecast-MFC-AGG-ID: 4A5Tj6KQNYSQpuM4FTivjA_1777494071
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 590261800352;
	Wed, 29 Apr 2026 20:21:11 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB80030001A1;
	Wed, 29 Apr 2026 20:21:10 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63TKL9I62823280
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:21:09 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63TKL8B82823279;
	Wed, 29 Apr 2026 16:21:08 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        steven chen <chenste@linux.microsoft.com>
Subject: [PATCH v2 00/10] Fix dm-ima bugs
Date: Wed, 29 Apr 2026 16:20:58 -0400
Message-ID: <20260429202108.2823261-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: D028949A14C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9385-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmarzins@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

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

Changes in v2:
- 05/10: Switched from using atomics and barriers to using a spinlock to
         serialize the dm_ima_measure_on_* functions
- 05/10: Fixed typos in comments and commit message
- 06/10: changed no_data string from "table_rename" to "device_rename"

If this patchset is going in largely as it is, I should point out that
there are changes to the ima measurements in corner cases, where the
data was previously incorrect (as mentioned in the patches). However
it's possible, although I don't think very likely, that systems are
expecting these incorrect measurements. We could bump the version number
because of this possible change in the measurements, but IIUC, since
this version number itself is part of the IMA measurements, that would
guarantee that systems would get different measurements. 

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

 drivers/md/dm-ima.c   | 492 +++++++++++++++++++-----------------------
 drivers/md/dm-ima.h   |  68 ++++--
 drivers/md/dm-ioctl.c | 146 +++++++++++--
 drivers/md/dm.c       |   2 +-
 4 files changed, 410 insertions(+), 298 deletions(-)

-- 
2.53.0


