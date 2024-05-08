Return-Path: <linux-integrity+bounces-2352-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA68C02E2
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 19:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F1B2813AF
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B847E564;
	Wed,  8 May 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQ2Ohnos"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E6101CF
	for <linux-integrity@vger.kernel.org>; Wed,  8 May 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188662; cv=none; b=GeaAx4Jgxviv7WaYeRJP45eX8vU9EGFhKX9yQocZNoZCrBYiBXdRd49uJrdjCKsdiFGdxzFg8OvXVA/11yJTWZbxcKs6Sq6V327D0LrNcP5AXDIHp02IioUt1c10dIzjI/UhTY4oAIRcU24wtW1nK6RmQ60aRh98O5v5B/AvJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188662; c=relaxed/simple;
	bh=Kxn1OpXajAC4QAVxlaCCK4ZVHRi/UjZM97fUkWUoxJE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pr2QZ2ipVx4YVyUBF+9YIVjaOYVjT3W6q5qTvW96EBmbKhDF+LeV6CPmN6wIMEgIXLbba0T0xHJnlZg1ICQP0tck0bAvMEl5myyGDAEOl4m3ZrMy3eepqqCDz/VdkP4cSj5XJfk79JYCeNtRhjBLdj+5DfRTnbm/KhZluiaDnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQ2Ohnos; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715188660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RgumTHjw5lWA0kR5RCBEM/DVrmph4hHsyV7IvxPwa1U=;
	b=aQ2OhnosJ732Gkeca30VkyqMryBQKJzdHzBmVt+YcqJyCV+dMAWtEUvz7cOSe4xYscVdi7
	iZTgZ6+wcVNMf09Zj5mNfbq68DyH+wXy5GmB/K82kp+aW+NmRfof0GjJFJ/lVyh8yR0EXs
	XKcxQbYvvZ3syRQEL30buAUU4fNxlRE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-xjcmPchrNO2ZGK2OhCc-NQ-1; Wed, 08 May 2024 13:17:36 -0400
X-MC-Unique: xjcmPchrNO2ZGK2OhCc-NQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29F60101A551;
	Wed,  8 May 2024 17:17:35 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BCD8A1C066AC;
	Wed,  8 May 2024 17:17:34 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 9EA9C30C2BDF; Wed,  8 May 2024 17:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 986D73E5E0;
	Wed,  8 May 2024 19:17:34 +0200 (CEST)
Date: Wed, 8 May 2024 19:17:34 +0200 (CEST)
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
In-Reply-To: <1714775551-22384-13-git-send-email-wufan@linux.microsoft.com>
Message-ID: <aa767961-5e3-2ceb-1a1e-ff66a8eed649@redhat.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com> <1714775551-22384-13-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7



On Fri, 3 May 2024, Fan Wu wrote:

> This patch adds a target finalize hook.
> 
> The hook is triggered just before activating an inactive table of a
> mapped device. If it returns an error the __bind get cancelled.
> 
> The dm-verity target will use this hook to attach the dm-verity's
> roothash metadata to the block_device struct of the mapped device.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

Hi

Why not use the preresume callback?

Is there some reason why do we need a new callback instead of using the 
existing one?

Mikulas


