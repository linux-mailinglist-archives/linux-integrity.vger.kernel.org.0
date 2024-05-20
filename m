Return-Path: <linux-integrity+bounces-2470-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613258C9D59
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE1D283E26
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605B6BFBC;
	Mon, 20 May 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFP1hM52"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E586BFAB
	for <linux-integrity@vger.kernel.org>; Mon, 20 May 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208285; cv=none; b=OQ1QlTR1dffb+CzXoJSJ/dowp54U3g8WFl8Ia+1zF8QM39l2n/uN0r/W9ZNw+Ye946VD/B82Q6hEMrw5J3IkqwCNOuegnoZghoJMUxZeUEex22cYciQsx+lA/izN3quStddiqnE3GPodibE+I9V/MUgI1qstYO4BwNdlBgGnXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208285; c=relaxed/simple;
	bh=ce6oru7LPD9lbhzZfnzBKS2IPT8JY+sTsV2gMVxtYCk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CtXYGEYa/ytJfjlaOd/IuaMUCLxxTpNM7Fl8GREFG2PZZPBoad38prveBCel1HGBYn4lXuIrLHxWBXjU8Z4as418yK59WdM01273QCNjDcVjCI46p+B3n2YFw8WWwPmJPaydSkA5axIZ9hGTZ3uYyH0MZZ/JP8VOC2afTj4QN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFP1hM52; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716208281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9xxq06coPp2aoGXiJwR3/gZ9zYxOiYsiplvRA2+0uqY=;
	b=HFP1hM526Bj4ww30PVw945Te/GG7f4bYD0Ec3xBImzXXA7BDRFQSZbHCAxgFhgbGGbQ9Ze
	KqYspKEfjm1mdJI4Cou3r59EwNXUYDUyHSmVEBhtT5fd7YL+A5UtHQ5BY9UMVfGBT3txIR
	yl1gBiAr9FpM6htqR2y6jEHJaZ1W5FU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-6Z3kB0usO7OYs13PWUSzNQ-1; Mon,
 20 May 2024 08:31:18 -0400
X-MC-Unique: 6Z3kB0usO7OYs13PWUSzNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 848A73C0C2C4;
	Mon, 20 May 2024 12:31:17 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BA0B40C6EB7;
	Mon, 20 May 2024 12:31:17 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id E330530C1C33; Mon, 20 May 2024 12:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id E05EF3FB52;
	Mon, 20 May 2024 14:31:16 +0200 (CEST)
Date: Mon, 20 May 2024 14:31:16 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Fan Wu <wufan@linux.microsoft.com>
cc: Mike Snitzer <snitzer@kernel.org>, corbet@lwn.net, zohar@linux.ibm.com, 
    jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, 
    axboe@kernel.dk, agk@redhat.com, eparis@redhat.com, paul@paul-moore.com, 
    linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
    linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v18 12/21] dm: add finalize hook to target_type
In-Reply-To: <234910c1-40c3-4489-94ab-6e9a5f00d93e@linux.microsoft.com>
Message-ID: <889a7880-8336-a44a-bea4-a4c81c5e5cce@redhat.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com> <1714775551-22384-13-git-send-email-wufan@linux.microsoft.com> <aa767961-5e3-2ceb-1a1e-ff66a8eed649@redhat.com> <212b02a8-f5f0-4433-a726-1639dda61790@linux.microsoft.com>
 <bc9aa053-20a6-eaa-cbe4-344f340242b@redhat.com> <234910c1-40c3-4489-94ab-6e9a5f00d93e@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2



On Fri, 17 May 2024, Fan Wu wrote:

> > So, it seems that the preresume callback provides the guarantee that you
> > looking for.
> > 
> >> -Fan
> > 
> > Mikulas
> 
> Thanks for the info. I have tested and verified that the preresume() hook can
> also work for our case.
> 
> From the source code
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/md/dm-ioctl.c#n1149,
> the whole resume process appears to be:
> 
> 1. Check if there is a new map for the device. If so, attempt to activate the
> new map using dm_swap_table() (where the finalize() callback occurs).
> 
> 2. Check if the device is suspended. If so, use dm_resume() (where the
> preresume() callback occurs) to resume the device.
> 
> 3. If a new map is activated, use dm_table_destroy() to destroy the old map.
> 
> For our case:
> 
> - Using the finalize() callback, the metadata of the dm-verity target inside
> the table is attached to the mapped device every time a new table is
> activated.
> - Using the preresume() callback, the same metadata is attached every time the
> device resumes from suspension.
> 
> If I understand the code correctly, resuming from suspension is a necessary
> step for loading a new mapping table. Thus, the preresume() callback covers
> all conditions where the finalize() callback would be triggered.

Yes.

> However, the preresume() callback can also be triggered when the device 
> resumes from suspension without loading a new table, in which case there 
> is no new metadata in the table to attach to the mapped device.

Yes.

> In the scenario where the finalize() callback succeeds but the preresume()
> callback fails, it seems the device will remain in a suspended state, the
> newly activated table will be kept, and the old table will be destroyed, so it
> seems there is no inconsistency using finalize() even preresume() potentially
> fails.

What does your security module do when the verification of the dm-verity 
hash fails? Does it halt the whole system? Does it destroy just the 
failing dm device? Or does it attempt to recover somehow from this 
situation?

> I believe both the finalize() callback proposed by Mike and the preresume()
> callback suggested by Mikulas can work for our case. I am fine with either
> approach, but I would like to know which one is preferred by the maintainers
> and would appreciate an ACK for the chosen approach.
> 
> -Fan

I would prefer preresume - we shouldn't add new callbacks unless it's 
necessary.

Mikulas


