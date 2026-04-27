Return-Path: <linux-integrity+bounces-9346-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B4/OWG672knFQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9346-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 21:34:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4805A479582
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 21:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DF403028372
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5136137C10A;
	Mon, 27 Apr 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOSXKAXJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171FB37BE6A
	for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318438; cv=none; b=kTUn2Z0N2zqUN7sIqmVnPUSb/6s9P2ajtSP+Y900Z41JyyJu7JWP2IKbtmdRaHM+FI/FUjcKyV8qa0ks4ql3Q4DvNwzyAhjc5MlyJP4LuwqTQBLcHOyAwhyaj+KSz3gDAT+mhg854x7bviukj2fkn2ScuWXGcqqYh5DI44daoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318438; c=relaxed/simple;
	bh=KS45z/As0ar/Z5Xqhyxpu0aZa+Ue0NXKWdbKvzeZkw4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kCGy+6Dbk3q0jHZUl1r/cVpiAVEs049hl8DyOxIl82nFIYtf0ep9c336c8T1SHLDBEo+hOfUQIXLU+XhtIM3xUdKsxv5VCyuaN1/l6NmMVkufzotE6L42R9TwPT3/vOqcOwsBuoL436Aqz3KA7JmdIvvC1h3uXUlEltndmEhLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOSXKAXJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777318436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/k5vVoeUoyUVeEHSdQW+16kTNwgmVmfnWtj6Ni3pxQ0=;
	b=gOSXKAXJBvwOr9UerJh2UA9uM3U5eqdkGwApaWFUFAAqr5DFhXWFb1GhZ0f6JibAONSHdi
	j8sFqHbYWj2DErWdwx6DA3InxZ4zcrrELFuoDG5d1F58YdsqKVKWgoSEtarW21c8Qg6xsc
	CSCHVXvMhkuCF0zPv52ZELlZulhKpGQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-WKEZHm81PxizuxW4xeD57A-1; Mon,
 27 Apr 2026 15:33:52 -0400
X-MC-Unique: WKEZHm81PxizuxW4xeD57A-1
X-Mimecast-MFC-AGG-ID: WKEZHm81PxizuxW4xeD57A_1777318431
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 534E11956050;
	Mon, 27 Apr 2026 19:33:50 +0000 (UTC)
Received: from [10.44.34.100] (unknown [10.44.34.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C6083000C22;
	Mon, 27 Apr 2026 19:33:47 +0000 (UTC)
Date: Mon, 27 Apr 2026 21:33:42 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
cc: Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
    Roberto Sassu <roberto.sassu@huawei.com>, 
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH 05/10] dm-ima: Fix UAF errors and measuring incorrect
 context
In-Reply-To: <20260414002244.1917447-6-bmarzins@redhat.com>
Message-ID: <75a6b1cf-9f0d-8fc2-57d5-f6dee4913c65@redhat.com>
References: <20260414002244.1917447-1-bmarzins@redhat.com> <20260414002244.1917447-6-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 4805A479582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-9346-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi


On Mon, 13 Apr 2026, Benjamin Marzinski wrote:

> +	smp_mb__before_atomic();
> +	atomic_inc(&ima->measure_idx);
> +	wake_up_all(&ima->ima_wq);

There should be smp_mb__after_atomic() after atomic_inc() and before 
wake_up_all(). Otherwise, the increment of atomic_inc could be moved 
inside the wait queue spinlock in wake_up_all and executed after the wait 
queue is checked for being empty.

Generally, the atomic variables and barriers are very hard to get right, 
this is not performance-critical code that would justify the 
complications, so I suggest to use a normal spinlock instead.

You can use something like:
	spin_lock_irq(&ima->ima_wq.lock);
	ima->measure_idx++;
	wake_up_all_locked(&ima->ima_wq);
	spin_unlock_irq(&ima->ima_wq.lock);

--- this would be obviously safe and easy to verify.

Mikulas


