Return-Path: <linux-integrity+bounces-7579-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69BC38AC0
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 02:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D521886BFD
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 01:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A11E3DF2;
	Thu,  6 Nov 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFlG5bSa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwN49pjI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4104618C031
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391745; cv=none; b=RL3XQieX3IsQjRNu4nC9lyJQB6L5yVZqYAU4dRQ8eTCiHYUH+b/hvz96bUj7NxeftWZSWRsek8rQWuVHzYnDJDuG8bMjjJZ9mx6G/8kI0jLKPD/P+8Ugcqpg6A8pquBnI28xm+KzyMhSxO7iIlJC+yNQbumAsAKlXVbTgdu6lBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391745; c=relaxed/simple;
	bh=MDc77b0yYFaiTlpvZdZOIt25PErklXu0A44q3+fRQao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKyVOQOl6ZYeaKG2YFp+8qUh27lJHGfasV8HCrY5rIp07nunqxtvfx3cQnAIWaduAypboX8oBElFSACF392LpWLzeBC1sq3dFucI4wi7GwaB34pgulBSDnxlZosCnyQValvwSBkb4Wi0xo8hprVWU6nxWwfORIGVyns32TzE5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFlG5bSa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwN49pjI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762391742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpU+/xQHHJRFTQ3d6N+Gk66txNoxwS8muPGcXzThu4Y=;
	b=JFlG5bSa3l5/kao/45FaxtWQ2u/nRaIo0P8P2Ckj867UPvsdaPu/q3O1F8ghF2TdgIwlQj
	Dsx0LXXSy4cH/TQcmU/WuiYGBDol4LM/yUS9pV45TJM5fqxgBCDrGZAkeBnjNFyltHzKru
	xiurI3FWCjQOLDkRDRsfa93LWllvTh4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-tCFt6F3ZMom7KxQg-_QKSA-1; Wed, 05 Nov 2025 20:15:40 -0500
X-MC-Unique: tCFt6F3ZMom7KxQg-_QKSA-1
X-Mimecast-MFC-AGG-ID: tCFt6F3ZMom7KxQg-_QKSA_1762391740
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7afc1d55072so299302b3a.0
        for <linux-integrity@vger.kernel.org>; Wed, 05 Nov 2025 17:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762391740; x=1762996540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpU+/xQHHJRFTQ3d6N+Gk66txNoxwS8muPGcXzThu4Y=;
        b=JwN49pjIkudKvQ1YHi5kilEfTV5FfcOTJgOAOLQob9KrEwq/TnO2MRpEA30uHyysnJ
         dKhs4Lvv70VI4rPvYvrcm0In3V+F+0S3nJBRVY9AHHqOHwF2S1bRse15ycfoyGNOpfa4
         yNsRTDyi5gWepD3qal+SISOu3h8/QUdft9AQOagTFJNY09Mubyqwfa/8bvn55G6v0E/k
         2URkzVb1yO4FYs46LqdYz8SuASMEPx0XrtW1MzoXXu3KKC+xgku7v0WDjkBjxkRzeaeK
         OadOTg+KcmczLMpDIrhM8npPUCyTRdLx1uUNy1DdEezFL/9+PHHJ9wGpfBlFUwctN72R
         E0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391740; x=1762996540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpU+/xQHHJRFTQ3d6N+Gk66txNoxwS8muPGcXzThu4Y=;
        b=V3y5T83kmUgLLdZADL872ooyWQt7LIMRgaNgAy13yVFXxzUT5aoxiRVOBROJAwYi1c
         EU/gOYM+C413MZmJKeBbYzd44sCtb6arXZhKYGdDUHUXjui1mc6JIjUrZjBPSrEQnl0c
         mLJ5xbikce5prw5ZzvvCJ8KyshEk1yBRSfEfog1655bbRV+ZVMhqNndrwxnAzr1mqWW+
         8O+3tylzCLuMj4ayEnTAoQrnHld2otF0h2BQz/eBqA93Pe+/PgPkNG/c15XT/8KmBpr1
         +zF5ix1z04Gs2mhuKnFx/YPOew1/CEBQdHO5qQk5S6Yhb2j4qn2A5gn3vdCqXm7fxhc2
         3nWA==
X-Forwarded-Encrypted: i=1; AJvYcCV4WtQhcUVy4lJOqJRJvPloSgOcq+PH7zmy8FZLyIbwF9BAPwsY425CZ2018+b4KmCxEKwPpcr9wCJ5GQ178aI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7i5mQML8WxVB3cTGkFhZNup0lYYyV0c0HZgD+am9BDTGKw+8B
	rQ1zfaEFl8Iplxx5vxugc1fOurWM6AFgK5w+01E15QzEnmCKnah7fuctu3FMKSLqcgYJCBjvQE4
	zHGA3qLpR8s3ljr5esTVb0i6BWeD1NAhIPttLfZpAfkOH9AchIAl00o4uHHTR4R4+TaGAXvDg4N
	jydX8mKirqQTswcEwZtqkWkneGhoZoQ37HD5yAb2wCSTTk
X-Gm-Gg: ASbGncvGYlSYkcb/2RG2KIYdNPlspk8Rs9a4MWF8oFs/M9HyjHakCpubDWo0S7Yg9Ks
	RWFXtfsA6f1eVEzxgf+psmDJ+A7u9ATytoeZ9FVgKPyiHbTGvJOQkk5BB7elaLi99w57WPSAdhF
	TP11sr/4LtWLv7QR+mNy20o6jIC/8v/f/M6kL7eljl+7g8zW95f/GPbTyo
X-Received: by 2002:a05:6a20:7f83:b0:347:6c59:c728 with SMTP id adf61e73a8af0-34f84013e8cmr6524220637.8.1762391739766;
        Wed, 05 Nov 2025 17:15:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWmP8T75BYVAEODQyprbrgb0t85KfaaPTk9oa4Un/hkZU21VI14iTVWUltKXfQZOucBtAha8hOeAxTIy67Mf8=
X-Received: by 2002:a05:6a20:7f83:b0:347:6c59:c728 with SMTP id
 adf61e73a8af0-34f84013e8cmr6524184637.8.1762391739354; Wed, 05 Nov 2025
 17:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105130922.13321-1-piliu@redhat.com> <20251105130922.13321-2-piliu@redhat.com>
 <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
In-Reply-To: <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 09:15:28 +0800
X-Gm-Features: AWmQ_bkaZeeTVPgQitrAcHy5UsjO--zmL_VCoy8Ahhy155j47bWBbZj8mwo9iD8
Message-ID: <CAF+s44Rj8Jszzk0JeaTOWL5eErHt6jugtXoyuitSPjsQkU8VpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 8:14=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed,  5 Nov 2025 21:09:22 +0800 Pingfan Liu <piliu@redhat.com> wrote:
>
> > When I tested kexec with the latest kernel, I ran into the following wa=
rning:
> >
> > [   40.712410] ------------[ cut here ]------------
> > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 ki=
mage_map_segment+0x144/0x198
> > [...]
> > [   40.816047] Call trace:
> > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > [...]
> > [   40.855423] ---[ end trace 0000000000000000 ]---
> >
> > This is caused by the fact that kexec allocates the destination directl=
y
> > in the CMA area. In that case, the CMA kernel address should be exporte=
d
> > directly to the IMA component, instead of using the vmalloc'd address.
>
> This is something we should backport into tearlier kernels.
>
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: linux-integrity@vger.kernel.org
> > To: kexec@lists.infradead.org
>
> So I'm thinking we should add
>
> Fixes: 0091d9241ea2 ("kexec: define functions to map and unmap segments")
> Cc: <stable@vger.kernel.org>
>
> yes?
>

Yes, it should be. Thanks for your help!


Best Regards,

Pingfan


