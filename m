Return-Path: <linux-integrity+bounces-3332-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17D954B26
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815021C23008
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD681BC07F;
	Fri, 16 Aug 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBvFf9x3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9011BB69B
	for <linux-integrity@vger.kernel.org>; Fri, 16 Aug 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815312; cv=none; b=pauNBzyGtOyQL2qMYKlRFak7nLTneW32Z8mH4WlrLvQbdPTAH3DdPsSJovuz1ePvICbIYWVuuUMAME6g/e+u9oP9n6L95iDNTxnws9ai6Z/ErnDUFPZURDlrW9I+VNn8P568AOTLBj3eYZ24iEWr0RQHNWddUQtuitX9u5V3yIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815312; c=relaxed/simple;
	bh=lDar9DmTlw3ePp5Q6kmmihzaxbm6I0P3DPXryScVANs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kDZNwe6HFYewd2RSCC8dBZLCSPYo3fMCiD5mTp5LznFjbW5xbp7OdVTr7iI1t5MULPMkwEQDzsPOjxspEsfCXwTZKazPKeq2KbcJv+IgBYTnfy0mxBJVWCBAre9YYq1OXVws8Kw4bCd/0Il/5zGYFxQUT8aNOS2oJDZSoT0J7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBvFf9x3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723815310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDOEDproV6IdIvTfwNaoQVF0QCH62QV3M+COrHMBt9A=;
	b=PBvFf9x3zpqahSayzhZW0WwohO3C8YXcLMCAu0oauaF4B+zfb294JTc8FDeqTHiWXWVKIv
	liFVEXt2ACC87edSkFuI9/ksfxsmIdjld38N+LZFpEWGBrLV90kO5bvVSWdJ9dgFXYKmRA
	P/GUXELVgHdosdWoJY18c4h7OPyLLRc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-HGvqPeTXPKC2fZi24A5kRA-1; Fri,
 16 Aug 2024 09:35:05 -0400
X-MC-Unique: HGvqPeTXPKC2fZi24A5kRA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FB19193E8F7;
	Fri, 16 Aug 2024 13:35:03 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9AB91956054;
	Fri, 16 Aug 2024 13:35:02 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id A6B7E30C1C1E; Fri, 16 Aug 2024 13:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id A1F8B3FB48;
	Fri, 16 Aug 2024 15:35:01 +0200 (CEST)
Date: Fri, 16 Aug 2024 15:35:01 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Paul Moore <paul@paul-moore.com>
cc: Mike Snitzer <snitzer@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
    linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
    linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 12/20] dm verity: expose root hash digest and signature
 data to LSMs
In-Reply-To: <CAHC9VhQrnu8Sj=XnDvg=wGTBxacvMSW6OJyG3-tpwrsbGat6vA@mail.gmail.com>
Message-ID: <88695db-efc0-6cc6-13ee-fd7c2abe61c@redhat.com>
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com> <1722665314-21156-13-git-send-email-wufan@linux.microsoft.com> <9dc30ca6-486c-4fa9-910d-ed1dc6da0e95@linux.microsoft.com>
 <CAHC9VhQrnu8Sj=XnDvg=wGTBxacvMSW6OJyG3-tpwrsbGat6vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="185210117-1569210666-1723814889=:1417825"
Content-ID: <5538cf-7394-958-6f84-c8dc4adbca47@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-1569210666-1723814889=:1417825
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <e38cf2c9-a8f2-b095-bdda-7ca01566581a@redhat.com>



On Thu, 15 Aug 2024, Paul Moore wrote:

> On Thu, Aug 8, 2024 at 6:38 PM Fan Wu <wufan@linux.microsoft.com> wrote:
> >
> > Hi Mikulas,
> >
> > I hope you’re doing well. I wanted to thank you again for your thorough
> > review for the last version. I’ve since made some minor updates for this
> > version, including adding more comments and refactoring the way the hash
> > algorithm name is obtained due to recent changes in dm-verity.
> >
> > Would you mind if we keep the Review-by tag on the latest version since
> > the changes are minor? Your feedback is greatly valued, and I’d
> > appreciate it if you could take a quick look when you have a moment.
> 
> To add a bit more to this, this patchset now looks like it is in a
> state where we would like to merge it into the LSM tree for the
> upcoming merge window, but I would really like to make sure that the
> device-mapper folks are okay with these changes; an
> Acked-by/Reviewed-by on this patch would be appreciated, assuming you
> are still okay with this patch.
> 
> For those who may be missing the context, the full patchset can be
> found on lore at the link below:
> 
> https://lore.kernel.org/linux-security-module/1722665314-21156-1-git-send-email-wufan@linux.microsoft.com

Hi

I'm not an expert in Linux security subsystems. I skimmed through the 
dm-verity patch, didn't find anything wrong with it, so you can add

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

> > >
> > > +#ifdef CONFIG_SECURITY
> > > +     u8 *root_digest_sig;    /* signature of the root digest */
> > > +#endif /* CONFIG_SECURITY */
> > >       unsigned int salt_size;
> > >       sector_t data_start;    /* data offset in 512-byte sectors */
> > >       sector_t hash_start;    /* hash start in blocks */
> > > @@ -58,6 +61,9 @@ struct dm_verity {
> > >       bool hash_failed:1;     /* set if hash of any block failed */
> > >       bool use_bh_wq:1;       /* try to verify in BH wq before normal work-queue */
> > >       unsigned int digest_size;       /* digest size for the current hash algorithm */
> > > +#ifdef CONFIG_SECURITY
> > > +     unsigned int sig_size;  /* root digest signature size */
> > > +#endif /* CONFIG_SECURITY */
> > >       unsigned int hash_reqsize; /* the size of temporary space for crypto */
> > >       enum verity_mode mode;  /* mode for handling verification errors */
> > >       unsigned int corrupted_errs;/* Number of errors for corrupted blocks */

Just nit-picking: I would move "unsigned int sig_size" up, after "u8 
*root_digest_sig" entry.

Mikulas
--185210117-1569210666-1723814889=:1417825--


