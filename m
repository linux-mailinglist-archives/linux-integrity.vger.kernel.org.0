Return-Path: <linux-integrity+bounces-7307-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA35BAB051
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 04:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D1819235B5
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B271E1E04;
	Tue, 30 Sep 2025 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpkN4hYz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8618859B
	for <linux-integrity@vger.kernel.org>; Tue, 30 Sep 2025 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199719; cv=none; b=i87Xvl8j7nk6GSdyuYX4tc+oxYlWCVX3egNDz4vya50plBHY+R91OTwBYdt0eHdyz4dwrCURmWz5xTTUj6OS2KuXNd6I9Fr0w764VpC9fiAVnr4T/jEQjYiK2NA/bOKNoLhuBoj9iHysH+0MyW70p1NqGapSmNhk4PwhoQYZUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199719; c=relaxed/simple;
	bh=wJQGgVCMFj3J2tRZt+e5H18nK9hedKnUGtmvcZcCFLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sK908KZEnL6FKxYv/cppuAOScmSrW/GkBeDF+oWq6stXnYQ2psWQlSIoel28HLeKBVdklExLq5WVqG+SSxDF9PMGTk7spNkeHH4H9cxaRkBLuLZSUMjrD8WcecwuIrrCY/iF1OjYGyeH32lJDRINEk31OHoM+9EDTm9qqvzBkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpkN4hYz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759199717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03NexLO5UHcDiL6BtGZCzs9TJxia4xSP+LO1xkJ8UJI=;
	b=OpkN4hYz7vQomBRNL4cjZlCLqajEkUk78GOE5W9YcQEDE00HmArJjdQqyTFJvAuFTQWPB5
	vXuxiOBmEYDQKku1ARCRqvaj3xs7QsjzdInvdnNYhrtEKCJshpgLIum6/rx6Do2ASs5AaO
	hkK8/6B81uj+B24rR0mRC6PHT4G0B4w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-k-wOHCCNP4azXTb-_a5Eug-1; Mon, 29 Sep 2025 22:35:15 -0400
X-MC-Unique: k-wOHCCNP4azXTb-_a5Eug-1
X-Mimecast-MFC-AGG-ID: k-wOHCCNP4azXTb-_a5Eug_1759199715
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-781171fe1c5so3460937b3a.0
        for <linux-integrity@vger.kernel.org>; Mon, 29 Sep 2025 19:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199714; x=1759804514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03NexLO5UHcDiL6BtGZCzs9TJxia4xSP+LO1xkJ8UJI=;
        b=vViwKSWFVPS+7nBJ+cMl9DkQT4verAzRG4XxPIiJlvDCpvAiE9Qi6Xkm7/1Vsb1G3x
         4x+22kfP4Cac04+efi+iOJ+hNwnuYspu66gZfP8q9UavXsV1w4dwscCN3/pl8eE12vyX
         Oyf9m+lebr49QCm6KAx5qW5yPtMgH7WXrDlhtvNynnG76x+O4KoLoK86M9xwfBBhUxIu
         eUn7np17uXVqEEPMHWTbsPfZkQU+RyX+oU3NL/zDkDjSuptasr0k4C6blKLKFLfUvMt8
         XZa/hQCggM+1TSJJDrty0boa8s5MNfv94fr7DhfH8gNZTXzhhNhrCeuNdhHLRG598E0A
         Y15g==
X-Gm-Message-State: AOJu0YwNevC+PrNDQIsL2nMq10aKQ8Ke31JNSszSl9Vg8K03ot3X78Ld
	oLhH9wEIswdRJwEWrfLfbJv8cvSE0PQCzzv7j4gBeDsQuayuaIoXs5gGb+pVNIwlPMi92zSJ43N
	CMtwhkvM40msN7zgHgUojJfdBOMxVfixO3mIEAFXWO8REl7nfUDsov0nDDFh7UdAhEDO8fQ==
X-Gm-Gg: ASbGncsYPjGFkhPNJHvhy+AgDjZ2ngx7I3+/BzKon4AZIc2P5sGege74QLstvmCC7Qz
	2CVrdMVbvLJcklGYM4URzb/B4dhEJlLrz+TujF/+jm4GpSPLaIKv7Cq+khrCm39I4rCsLBlG6u0
	GM2bNUfssw4VWJQ+z58QdeN7CSJE74lOMfPlWi8F4P7Nc9unJ1+BFIstvcloEO1PUMW3BmDUO6i
	lA2oHHiCTbByAcjozJ2Xj2ZG1WUwxfVhV3dDnsGDpRJ3wzKouLDIxBH5PMC79iaf/x5WjzASie5
	STtukcr93j2i5NDugLE8MdVkLt4THIuDVlUu
X-Received: by 2002:a05:6a00:2e2a:b0:781:22cf:b916 with SMTP id d2e1a72fcca58-78122cfbb2cmr10060864b3a.23.1759199714601;
        Mon, 29 Sep 2025 19:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk6lf5UdCs5HU9KjvZY3Dx8H8dMrpHuoGYVyn5iK1EraZ+Yd9xN0D7C0jcRRi5VYye/wwQ0w==
X-Received: by 2002:a05:6a00:2e2a:b0:781:22cf:b916 with SMTP id d2e1a72fcca58-78122cfbb2cmr10060841b3a.23.1759199714246;
        Mon, 29 Sep 2025 19:35:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm12356376b3a.43.2025.09.29.19.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:35:13 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:31:45 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: setting security.ima to fix security.evm for a file
 with IMA signature
Message-ID: <22ya7mhqv3fenf5olfa6nrtpj7ch6vbdhngiblhqaml3zlrbx4@fqf46sgckoay>
References: <20250909041954.1626914-1-coxu@redhat.com>
 <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
 <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
 <cbcbdb3e4aed17f387ae1d357906796551e2f470.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cbcbdb3e4aed17f387ae1d357906796551e2f470.camel@linux.ibm.com>

On Wed, Sep 10, 2025 at 07:15:19AM -0400, Mimi Zohar wrote:
>On Wed, 2025-09-10 at 09:20 +0800, Coiby Xu wrote:
>> On Tue, Sep 09, 2025 at 11:31:20AM -0400, Mimi Zohar wrote:
>> > On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
>> > > When both IMA and EVM fix modes are enabled, accessing a file with IMA
>> > > signature won't cause security.evm to be fixed. But this doesn't happen
>> > > to a file with correct IMA hash already set because accessing it will
>> > > cause setting security.ima again which triggers fixing security.evm
>> > > thanks to security_inode_post_setxattr->evm_update_evmxattr.
>> > >
>> > > Let's use the same mechanism to fix security.evm for a file with IMA
>> > > signature.
>> > >
>> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> >
>> > Agreed, re-writing the file signature stored as security.ima would force
>> > security.evm to be updated.
>> >
>> > Unfortunately, I'm missing something. ima_appraise_measurement() first verifies
>> > the existing security.evm xattr, before verifying the security.ima xattr.  If
>> > the EVM HMAC fails to verify, it immediately exits ima_appraise_measurement().
>> > security.ima in this case is never verified.
>> >
>> > This patch seems to address the case where the existing security.evm is valid,
>> > but the file signature stored in security.ima is invalid.  (To get to the new
>> > code, the "status" flag is not INTEGRITY_PASS.)  Re-writing the same invalid
>> > file signature would solve an invalid security.evm, but not an invalid IMA file
>> > signature.  What am I missing?
>>
>> Hi, Mimi,
>>
>> Thanks for raising the question! This patch is to address the case where
>> IMA signature is already added but security.evm doesn't yet exist. So
>> EVM HMAC fails to verify but there is no exiting
>> ima_appraise_measurement immediately.
>>
>> And you are right that re-writing an invalid IMA file won't fix an
>> invalid IMA file signature. And even when IMA signature is valid, the
>> verification may fail because the key is missing from .ima keyring. This
>> happens because we need to turn off secure boot to enable fix mode. As a
>> result, CA keys won't be loaded into .machine keyring.
>
>> Btw, if I'm not
>> mistaken, current IMA code assumes we are not supposed to fix IMA file
>> signature.
>
>Right, unlike file hashes, new or the same file signature can be written, but
>cannot be "fixed" in the literal sense, as that would require calculating the
>file hash and signing it with a private key.

Thanks for the confirmation! I also added some code comments to explain
the IMA iint cache atomic_flags including IMA_DIGSIG in v2.

>
>This patch triggers "fixing" the EVM HMAC by re-writing the existing IMA file
>signature.  I assume the same result could be achieved by simply re-installing
>the file signature.  In both cases, the EVM HMAC key needs to exist and be
>loaded.


-- 
Best regards,
Coiby


