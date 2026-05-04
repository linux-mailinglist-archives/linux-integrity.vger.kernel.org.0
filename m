Return-Path: <linux-integrity+bounces-9413-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIafAlK/+Gnh0AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9413-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 17:46:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 528454C0DA4
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 17:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB45C3018AE2
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB653E0C55;
	Mon,  4 May 2026 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUU3bAsH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91533DF019
	for <linux-integrity@vger.kernel.org>; Mon,  4 May 2026 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909558; cv=none; b=najos5txfakRZ/ZhIrO2JwcC7wX25iSbOjN2cSmTLUoYfsq9S7vArvIPz8hAerx+q1TGUQu1EDvNDUxpNPxBx1xQ3NRTAEX5xnhq/sgTrmFpwprqWWrRG01WloZLtkXswo8YZWFOTA8N2RNfWvr2EUF8KGkYsdl8g3t15t22v1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909558; c=relaxed/simple;
	bh=UncsDpUux9RPqUz8sjxaXS3FdJ2vgHGJfOrjz4Zt2iM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d8LxYcm2ZGpw2ThkuaFj9t42RWzsk9+hE5dDAM8mZ44yAvjVfOfb31IX8QpSjB8pcHQWlJeVGL++Fik0DCpLafqf3S45F3vx5CLQeqCm9QrdnCTpQRzPs/AlF1ECtuVPeAPQH0HLpvcY5HC6MpYflx+6SSK6wLiZZzxuHWjF5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUU3bAsH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777909554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A69Kep75LLqd41mMNsXegVZLwk7G1mxWb4F0HACVbMo=;
	b=bUU3bAsHd9OFcozwF4BENuqXIxttNKx4Vddh7M56ODk58sLLGXjG1FL+4TkR+IzsShGY4Z
	KXLKDVqG16/ya1miRYuTvzoLUcAkFDP+Nw8jlOTow5PYf73Rd5tl4NtsGh+RIqACsVPr0k
	3YPuO2OM3c1BKlNfnyPsKBDcG+HGgx0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-tPByX-99Nx6Jbw5aqgCrYA-1; Mon,
 04 May 2026 11:45:52 -0400
X-MC-Unique: tPByX-99Nx6Jbw5aqgCrYA-1
X-Mimecast-MFC-AGG-ID: tPByX-99Nx6Jbw5aqgCrYA_1777909551
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD2841800348;
	Mon,  4 May 2026 15:45:50 +0000 (UTC)
Received: from [10.44.34.35] (unknown [10.44.34.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13D58180045E;
	Mon,  4 May 2026 15:45:47 +0000 (UTC)
Date: Mon, 4 May 2026 17:45:44 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
cc: Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    linux-integrity@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
    Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
    Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
    steven chen <chenste@linux.microsoft.com>
Subject: Re: [PATCH v2 00/10] Fix dm-ima bugs
In-Reply-To: <20260429202108.2823261-1-bmarzins@redhat.com>
Message-ID: <f90f2f8e-37c4-9412-1f33-b95f821aa7d6@redhat.com>
References: <20260429202108.2823261-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 528454C0DA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,linux.microsoft.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-9413-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpatocka@redhat.com,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Applied, thanks.

Mikulas



On Wed, 29 Apr 2026, Benjamin Marzinski wrote:

> The dm-ima code does not guarantee that the dm_ima_measure_on_*
> functions will not be called at the same time. Since they modify and
> free shared memory, this can lead to Use-After-Free errors or garbage
> measurements. Further, they don't make sure that the state they measure
> corresponds to the actual device state. For instance if table_load()
> runs at the same time as do_resume() on a table swap,
> dm_ima_measure_on_device_resume() can end up thinking the wrong table is
> active. Or a concurrent dm_hash_rename() and a table swap, can end up
> with a the new active table still using the old name. This patchset
> makes sure the the dm-ima function are serialized and report the correct
> device state.
> 
> However, the code is still messier that in could be. This is because
> it duplicates the current measurement events and format. I would really
> like to know if that is necessary. Specifically, it currently measures
> the following dm device and table actions:
> 
> load
> clear
> rename
> resume
> remove
> 
> I don't see the benefit of reporting changes to the inactive table, or
> resumes where the device does not change state. From the user's point of
> view, the device is still the same after these events.  At the same
> time, it doesn't measure device creates if no table was loaded, so you
> can have situations where the the first measurement for a device is a
> rename or a remove. A more sensible set of actions to measure would be:
> 
> create
> table_swap
> rename
> remove
> 
> Also, the measurement format doesn't map well to how dm device's are
> actually set up, in a way that makes it harder for the code and records
> extraneous information. First, like I mentioned before, I don't see the
> benefit of measuring the inactive table. Second, the name, uuid, and
> major/minor numbers are properties of the device, not it's table (and dm
> devices can't have partitions, so the minor count will always be 1). I
> don't see a reason to store and occasinally log this information twice,
> if there is an active and incative table, and it forces extra
> coordination between the dm_ima_measure_on_* functions.
> 
> I'm wondering it we are stuck with the current events and format, now
> that this has been released? Or could we bump the version, and change
> what events we measure, and how we format the output?
> 
> Changes in v2:
> - 05/10: Switched from using atomics and barriers to using a spinlock to
>          serialize the dm_ima_measure_on_* functions
> - 05/10: Fixed typos in comments and commit message
> - 06/10: changed no_data string from "table_rename" to "device_rename"
> 
> If this patchset is going in largely as it is, I should point out that
> there are changes to the ima measurements in corner cases, where the
> data was previously incorrect (as mentioned in the patches). However
> it's possible, although I don't think very likely, that systems are
> expecting these incorrect measurements. We could bump the version number
> because of this possible change in the measurements, but IIUC, since
> this version number itself is part of the IMA measurements, that would
> guarantee that systems would get different measurements. 
> 
> Benjamin Marzinski (10):
>   dm-ima: remove dm_ima_reset_data()
>   dm-ima: remove broken last_target_measured logic
>   dm-ima: Remove status_flags from dm_ima_measure_on_table_load()
>   dm-ima: don't copy the active table to the inactive table
>   dm-ima: Fix UAF errors and measuring incorrect context
>   dm-ima: remove new_map from dm_ima_measure_on_device_clear
>   dm-ima: Fix issues with dm_ima_measure_on_device_rename
>   dm-ima: Handle race between rename and table swap
>   dm-ima: Fail more gracefully in dm_ima_measure_on_*
>   dm-ima: use active table's size if available
> 
>  drivers/md/dm-ima.c   | 492 +++++++++++++++++++-----------------------
>  drivers/md/dm-ima.h   |  68 ++++--
>  drivers/md/dm-ioctl.c | 146 +++++++++++--
>  drivers/md/dm.c       |   2 +-
>  4 files changed, 410 insertions(+), 298 deletions(-)
> 
> -- 
> 2.53.0
> 


