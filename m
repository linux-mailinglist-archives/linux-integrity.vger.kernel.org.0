Return-Path: <linux-integrity+bounces-9181-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDwBMzqJ3mlXFgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9181-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 20:36:42 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1654F3FDBA2
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 20:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F65F3032073
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB3B3009E1;
	Tue, 14 Apr 2026 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGD7seD3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4D31B101
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776191713; cv=none; b=X9Yd87U5urzwzVxTRJLag/BkNfB8eWwOzJSymD0SPMAjZq0M4/m+HZ8g/a3E/9c2948zBtwxCmIb/nMd1ucS8acAGkxZG2BXgLU8Uy9pTvBeN2SeMTtV9KRcSwsaQfi0OWHQHQL8MtyTC2RbetvzgYtnZ0x8LrG6E0k4Ggx9Kt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776191713; c=relaxed/simple;
	bh=jG3SJ2UDkFr172PJmfPN9RC1nSKIojbIeSYU8sEjGk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7cnQ6HNCv0GAbg+DOl4GKdT1jQgei+o3c+QRNrdL8uhgstH2mOLk1X9pq6MDqnA2NtYrrfw63R/K4Z4qmLFQZGhUSVvqjb5ApAvsB1l273TKH0oEihDTWPciFa1K19nbkT1sHjTBuwOn4x5R6Zm40FnB86EXBlv+pLHNUusLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGD7seD3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776191711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8P4KyMBQD5XgNwu1KSgwH6g9MpC+vp4OJ5CZE90VEw=;
	b=iGD7seD3071XP+1qFZ1HXFcHax+sNa7p0lLLr9EbGWv0FdPj9zgebcJgxI51brdqPnhOCV
	jOXC1gf0jzUUEjQoAHIfj6EpN0cQqTiZ02Vwaggb3QaPWRu/VbFB3bZTPnBP45Zd88njzq
	ovFDWiXvHLdEDDl952p3NJ2osueyYPk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-yiMExI4WP2KzT4aM278hPA-1; Tue,
 14 Apr 2026 14:35:07 -0400
X-MC-Unique: yiMExI4WP2KzT4aM278hPA-1
X-Mimecast-MFC-AGG-ID: yiMExI4WP2KzT4aM278hPA_1776191706
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1A60195608D;
	Tue, 14 Apr 2026 18:35:05 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F981180049F;
	Tue, 14 Apr 2026 18:35:05 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63EIZ4D31945641
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 14:35:04 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63EIZ3ts1945640;
	Tue, 14 Apr 2026 14:35:03 -0400
Date: Tue, 14 Apr 2026 14:35:03 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [RFC PATCH 00/10] Fix dm-ima bugs
Message-ID: <ad6I1yu6b26qRbEa@redhat.com>
References: <20260414002244.1917447-1-bmarzins@redhat.com>
 <ad51kuxJuU84Amep@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad51kuxJuU84Amep@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-9181-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmarzins@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1654F3FDBA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 01:12:50PM -0400, Mike Snitzer wrote:
> On Mon, Apr 13, 2026 at 08:22:34PM -0400, Benjamin Marzinski wrote:
> > The dm-ima code does not guarantee that the dm_ima_measure_on_*
> > functions will not be called at the same time. Since they modify and
> > free shared memory, this can lead to Use-After-Free errors or garbage
> > measurements. Further, they don't make sure that the state they measure
> > corresponds to the actual device state. For instance if table_load()
> > runs at the same time as do_resume() on a table swap,
> > dm_ima_measure_on_device_resume() can end up thinking the wrong table is
> > active. Or a concurrent dm_hash_rename() and a table swap, can end up
> > with a the new active table still using the old name. This patchset
> > makes sure the the dm-ima function are serialized and report the correct
> > device state.
> > 
> > However, the code is still messier that in could be. This is because
> > it duplicates the current measurement events and format. I would really
> > like to know if that is necessary. Specifically, it currently measures
> > the following dm device and table actions:
> > 
> > load
> > clear
> > rename
> > resume
> > remove
> > 
> > I don't see the benefit of reporting changes to the inactive table, or
> > resumes where the device does not change state. From the user's point of
> > view, the device is still the same after these events.  At the same
> > time, it doesn't measure device creates if no table was loaded, so you
> > can have situations where the the first measurement for a device is a
> > rename or a remove. A more sensible set of actions to measure would be:
> > 
> > create
> > table_swap
> > rename
> > remove
> > 
> > Also, the measurement format doesn't map well to how dm device's are
> > actually set up, in a way that makes it harder for the code and records
> > extraneous information. First, like I mentioned before, I don't see the
> > benefit of measuring the inactive table. Second, the name, uuid, and
> > major/minor numbers are properties of the device, not it's table (and dm
> > devices can't have partitions, so the minor count will always be 1). I
> > don't see a reason to store and occasinally log this information twice,
> > if there is an active and incative table, and it forces extra
> > coordination between the dm_ima_measure_on_* functions.
> > 
> > I'm wondering it we are stuck with the current events and format, now
> > that this has been released? Or could we bump the version, and change
> > what events we measure, and how we format the output?
> > 
> > Benjamin Marzinski (10):
> >   dm-ima: remove dm_ima_reset_data()
> >   dm-ima: remove broken last_target_measured logic
> >   dm-ima: Remove status_flags from dm_ima_measure_on_table_load()
> >   dm-ima: don't copy the active table to the inactive table
> >   dm-ima: Fix UAF errors and measuring incorrect context
> >   dm-ima: remove new_map from dm_ima_measure_on_device_clear
> >   dm-ima: Fix issues with dm_ima_measure_on_device_rename
> >   dm-ima: Handle race between rename and table swap
> >   dm-ima: Fail more gracefully in dm_ima_measure_on_*
> >   dm-ima: use active table's size if available
> > 
> >  drivers/md/dm-ima.c   | 506 +++++++++++++++++++-----------------------
> >  drivers/md/dm-ima.h   |  67 ++++--
> >  drivers/md/dm-ioctl.c | 146 +++++++++++-
> >  drivers/md/dm.c       |   2 +-
> >  4 files changed, 421 insertions(+), 300 deletions(-)
> 
> Pretty extensive changes needed here all things considered.
> 
> SO I'm aware, who is using dm-ima?  I see that Tushar Sugandhi is no
> longer at Microsoft and so he isn't cc'd on these changes.  I can
> infer from Cc some potential users, but I just want to make sure this
> code isn't just technical debt that we're having to carry in DM now?

I don't actually know if anyone is. The issue is that the Use After Free
crashes can happen as long as CONFIG_IMA is set, regardless of whether
or not you have any IMA policy set.

If we don't need to care, we could just serialize the
dm_ima_measure_on_* functions to keep them from having concurrent access
to shared memory, and let them keep reporting bogus data if there are
races (or simply unfortunate orderings. load then rename then resume
currently forgets the rename, even without a race) That's a much smaller
change, and if they're currently good enough for any users, it won't
make them any worse.

-Ben

> 
> Thanks,
> Mike


