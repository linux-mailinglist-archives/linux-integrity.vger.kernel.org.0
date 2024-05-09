Return-Path: <linux-integrity+bounces-2357-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A71C8C1383
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 19:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD3E1C203DE
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691308F7A;
	Thu,  9 May 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvpKdYu1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1035171A2
	for <linux-integrity@vger.kernel.org>; Thu,  9 May 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274442; cv=none; b=TYUmbUwi+gZvo25/TkZCr6RWyyKySAWtvTrNsJCn5wgIpPzgP5xMLw1WR8bP2a3Zl0HF0a4JVPB28F3WTa3zyMTeoHh/UvPU6C1DVcAuqcktSiV8tGGZlYWeKV0uo+3hqBxLQbziN/vpG28U1xLfNP/EjA1TTIYx7UBtQIWx16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274442; c=relaxed/simple;
	bh=JTqRwvs7ATnblMDzbI8kYx5IrTBxMWNprcLAXd5ODXg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pZrXb7GkbblKb6VNWvtflnrB31xyjC7Vw2uK8ohGtQO030PUnVHic1X9tY5qY/ZsetzFz3GKayDF95l3TlTDur3eijq3Jit8i1X3nEZdaBw5ZXNRMAzyu9FJhd9xto2GNnny0+rUlvORBY00aemg8pLpw3FNIW093uGYQJ+OoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvpKdYu1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715274439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ca9Pf11lzbP4jlatyhKofM52bEPeu8vNmdS1FsH4a8=;
	b=GvpKdYu10fnHDW/pAoyK20EECRTJN/Yec8Sow2na6ca6Jc0DaUwN+Rqcd9dAwzM34sF2Nr
	pb9GzTIbh/vMFHEhBxGN4T6FJVQ28pnUuYGyYScmpFQG3HifUkBUXmOstiOWHkHpwdtvSD
	ymBkaQTaKH7QV3JuzvR3zdMZNMbVkP8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-Y19FXQdzO2eI8S9NubSUHw-1; Thu,
 09 May 2024 13:07:16 -0400
X-MC-Unique: Y19FXQdzO2eI8S9NubSUHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71A903802292;
	Thu,  9 May 2024 17:07:14 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB1CB1169588;
	Thu,  9 May 2024 17:07:13 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id A5F3A30C1B8F; Thu,  9 May 2024 17:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 9F5133E683;
	Thu,  9 May 2024 19:07:13 +0200 (CEST)
Date: Thu, 9 May 2024 19:07:13 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Fan Wu <wufan@linux.microsoft.com>
cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
    tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
    snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com, 
    linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
    linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v18 12/21] dm: add finalize hook to target_type
In-Reply-To: <212b02a8-f5f0-4433-a726-1639dda61790@linux.microsoft.com>
Message-ID: <bc9aa053-20a6-eaa-cbe4-344f340242b@redhat.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com> <1714775551-22384-13-git-send-email-wufan@linux.microsoft.com> <aa767961-5e3-2ceb-1a1e-ff66a8eed649@redhat.com> <212b02a8-f5f0-4433-a726-1639dda61790@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3



On Wed, 8 May 2024, Fan Wu wrote:

> 
> 
> On 5/8/2024 10:17 AM, Mikulas Patocka wrote:
> > 
> > 
> > On Fri, 3 May 2024, Fan Wu wrote:
> > 
> >> This patch adds a target finalize hook.
> >>
> >> The hook is triggered just before activating an inactive table of a
> >> mapped device. If it returns an error the __bind get cancelled.
> >>
> >> The dm-verity target will use this hook to attach the dm-verity's
> >> roothash metadata to the block_device struct of the mapped device.
> >>
> >> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> > 
> > Hi
> > 
> > Why not use the preresume callback?
> > 
> > Is there some reason why do we need a new callback instead of using the
> > existing one?
> > 
> > Mikulas
> Thanks for the suggestion.
> 
> Mike suggested the new finalize() callback. I think the reason for not using
> the preresume() callback is that there are multiple points that can fail
> before activating an inactive table of a mapped device which can potentially
> lead to inconsistent state.
> 
> In our specific case, we are trying to associate dm-verity's roothash metadata
> with the block_device struct of the mapped device inside the callback.
> 
> If we use the preresume() callback for the work and an error occurs between
> the callback and the table activation, this leave the block_device struct in
> an inconsistent state.

The preresume callback is the final GO/NO-GO decision point. If all the 
targets return zero in their preresume callback, then there's no turning 
back and the table will be activated.

> This is because now the block device contains the roothash metadata of it's
> inactive table due to the preresume() callback, but the activation failed so
> the mapped device is still using the old table.
> 
> The new finalize() callback guarantees that the callback happens just before
> the table activation, thus avoiding the inconsistency.

In your patch, it doesn't guarantee that.

do_resume calls dm_swap_table, dm_swap_table calls __bind, __bind calls 
ti->type->finalize. Then we go back to do_resume and call dm_resume which 
calls __dm_resume which calls dm_table_resume_targets which calls the 
preresume callback on all the targets. If some of them fails, it returns a 
failure (despite the fact that ti->type->finalize succeeded), if all of 
them succeed, it calls the resume callback on all of them.

So, it seems that the preresume callback provides the guarantee that you 
looking for.

> -Fan

Mikulas


