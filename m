Return-Path: <linux-integrity+bounces-9347-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA8rHD+872mLFQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9347-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 21:42:55 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C069F479722
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 21:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDE68301FC83
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07FB125AA;
	Mon, 27 Apr 2026 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj2FmjLh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4B285CA2
	for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318971; cv=none; b=kUFHvklxHnJ+EBwEOZ224IlhiL9SPUVJB3h6AnQpsCTvxVOKN2xTfFzcS44xgP0ZKYP6oMrz9nOMpFs+HDpmMzhmTYTyuHNEC0QN+g11WqmVmyVtqddNoGwkyNdDApVOOHJBGjKh1hdBcaOYLy7KzT1zzkkKPFDg41o+3NVsE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318971; c=relaxed/simple;
	bh=8C4x7vxUOOlQr8sDYVkiRViYRsHDFk8NOhZROPC7a3Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UnGsHwwknJN+hJWVdg8qY86kwihc0Bsw7bm794qsJLH4EheTsh5GmUCw+gQK9Hz2myGrzfq4y7R+7o+yyMQwqVAfBPOAGWwkIw0KWqUHIcDBVp0pqU4YLLfIvG7gbefzK00lTAwpNL4Iey9VkKdL4D9yLcGceLlQ2dJOslvS59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bj2FmjLh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777318969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thRMuDd+G1UhyHlG+VcSH87KRUvT6lfoxtzBUqqH42M=;
	b=bj2FmjLhPERylZYaEgR2qqC0xASrsidXnF5tJindeSHNj/llM4OW7SmNin/DjRITtyiP/B
	5NIosCSetR/8IX7KUN7WNYCjkSU7RATj7e+Ir2tyT9P1G3UIwtMcTjMYTJuLrN3mM7S0XN
	E0bBeuxJZzfkC+tgV9QrO2w6xZMMytE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-x9JmcEjNMUODkqwL8Cqm1A-1; Mon,
 27 Apr 2026 15:42:43 -0400
X-MC-Unique: x9JmcEjNMUODkqwL8Cqm1A-1
X-Mimecast-MFC-AGG-ID: x9JmcEjNMUODkqwL8Cqm1A_1777318962
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF5761956050;
	Mon, 27 Apr 2026 19:42:41 +0000 (UTC)
Received: from [10.44.34.100] (unknown [10.44.34.100])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D332319560AB;
	Mon, 27 Apr 2026 19:42:39 +0000 (UTC)
Date: Mon, 27 Apr 2026 21:42:37 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
cc: Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
    Roberto Sassu <roberto.sassu@huawei.com>, 
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH 05/10] dm-ima: Fix UAF errors and measuring incorrect
 context
In-Reply-To: <75a6b1cf-9f0d-8fc2-57d5-f6dee4913c65@redhat.com>
Message-ID: <a137657f-64e7-6796-33db-51b200b87fa5@redhat.com>
References: <20260414002244.1917447-1-bmarzins@redhat.com> <20260414002244.1917447-6-bmarzins@redhat.com> <75a6b1cf-9f0d-8fc2-57d5-f6dee4913c65@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: C069F479722
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-9347-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpatocka@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On Mon, 27 Apr 2026, Mikulas Patocka wrote:

> Hi
> 
> 
> On Mon, 13 Apr 2026, Benjamin Marzinski wrote:
> 
> > +	smp_mb__before_atomic();
> > +	atomic_inc(&ima->measure_idx);
> > +	wake_up_all(&ima->ima_wq);
> 
> There should be smp_mb__after_atomic() after atomic_inc() and before 
> wake_up_all(). Otherwise, the increment of atomic_inc could be moved 
> inside the wait queue spinlock in wake_up_all and executed after the wait 
> queue is checked for being empty.
> 
> Generally, the atomic variables and barriers are very hard to get right, 
> this is not performance-critical code that would justify the 
> complications, so I suggest to use a normal spinlock instead.
> 
> You can use something like:
> 	spin_lock_irq(&ima->ima_wq.lock);
> 	ima->measure_idx++;
> 	wake_up_all_locked(&ima->ima_wq);
> 	spin_unlock_irq(&ima->ima_wq.lock);
> 
> --- this would be obviously safe and easy to verify.
> 
> Mikulas

BTW. you can see "&ic->endio_wait.lock" in drivers/md/dm-integrity.c for 
an example, how to use this pattern.

Mikulas


