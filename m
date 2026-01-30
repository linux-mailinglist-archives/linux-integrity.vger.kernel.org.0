Return-Path: <linux-integrity+bounces-8370-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKvXMiKVfGkQNwIAu9opvQ
	(envelope-from <linux-integrity+bounces-8370-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 12:25:22 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F9BA0C5
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 12:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26D943083AD3
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1D36B042;
	Fri, 30 Jan 2026 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRvQ2HJK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mBzg43ZO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C926E16C
	for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772031; cv=none; b=n/bO9aCFwkx4lUFBPKVc/97BQG4AAz7uvPQXj6QbwUCTuLj5PTHr7f1H91lv393FYeX8V9FpCe2c9HrqA68vQmn2antbEgO+UFR4KXFsPSZy8BUYp/TyexKkoJnDCcOPb0ZAFxagFES96OC6MGCQ2EonSwlYMDMN5dYjuN0Hoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772031; c=relaxed/simple;
	bh=zdaxgBWHfOjQ1zh3GrG3YLN/+zyFU3lbY6MfKIPUukw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwtJv90GlfnCgkNdOYAccASz6lFTILJszUi2DBNIvXIO/QBUaUxBFT2bXuDt88DomSe3ZczEzvEyG7j/LBhHCJsTYZ6Qwo+s6y/wOUMqo1ar5osFRqO4eHFVWfZ/PoJMFr8YpHiIBJHRsC3csLPROeSO+QoYf6jGwpNzfaCmDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRvQ2HJK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mBzg43ZO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769772028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qi7R1t4hPvfEKk8VW4gjKJE0vso+HGJ4y2WhvsIHDuc=;
	b=VRvQ2HJK1IbT7QLP28euYCxozgQ/TwfyAGI3KvyhsHguf8jCGEU5OPnWTCLUJVRfCIm1Pc
	FGXqiRJtZwdToE9iULIZtMBjTVTKbUGPPKpqlSMG8IDmVivavTeprTjhx+mmAf8rPagv5D
	SudMFBSsIr+a5SuhrDbooj7trHC2z4M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-ZQyXgXSdPsWGdTneJyt8qQ-1; Fri, 30 Jan 2026 06:20:26 -0500
X-MC-Unique: ZQyXgXSdPsWGdTneJyt8qQ-1
X-Mimecast-MFC-AGG-ID: ZQyXgXSdPsWGdTneJyt8qQ_1769772026
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a773db3803so23832265ad.1
        for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 03:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769772025; x=1770376825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi7R1t4hPvfEKk8VW4gjKJE0vso+HGJ4y2WhvsIHDuc=;
        b=mBzg43ZO2Qj99tONERxmMgpEtWCKvm/Pwuqd1Mm1S0BpC+5meEYlUaeZpzGJ+0i0ck
         6XQ1wGbvVb3UdkR3+Mzc/QkPFtrNuO47Iskk46M1daCvLwv75WM+9/9PAWhyjgPDdyo5
         D90loTlZK/wU6nyJCfp9K+wcpvFz9Jo3nL96HJBMbDW/VY7X8WQI9WUklYiU0VIpgylk
         fZ9Z4R98uKUQTssGy6LJvs48EA280StT97PqVdaznVd6PV6FX/oUdmU4e4bVOWJquBWf
         hk2aL1JI0THTZh7C8cmEHKNVJLcM3Oi5cdvdI6P6xKl4a4ACO5TKq3nUu2l9pITv9Gau
         UfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769772025; x=1770376825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi7R1t4hPvfEKk8VW4gjKJE0vso+HGJ4y2WhvsIHDuc=;
        b=aBp9bbK2v/udNrWePrcFYh1SPsdJsM2dr+CFyYYULnvrJSO9JuC1/lAGxrEUnEC1i9
         c8ylb0Bo330cXQCPtR2jcwYqp168NhoPpb+F/nSKIK4tW1EQxn8Z3gftkV4Mh5RAjRh+
         mppZnGABK2q0tZQG4yQABB1WQ4lkn0If2XuYTU3va45PSxXO4MSKjFwM9v9yCa6R5U2p
         QkLsLfUhaVOuxJRe+4W9brjhBVu51b3foJyR5yct+rx70MT1Oy5cLIxdGmtfR9nggZPX
         diZSm/JJBJPGbhIimKUoGS1Ppmc1U7qTZu51/00dhqcO9DWKrD/WOTzJW+7AHc+ZDBc5
         yUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdJprFz4Az5gPIwIqmskcLf9xj7MTbdgKFu1OJ/FcDi+k44+yflaLtiHTXQDpXo74MOqdAOEDBp6NjqqJ6c2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQTl6/+8Cojye/N8AH53g1uz0/OGYnbZo15+HeFhThfFd9gVJ
	wCCe3pcPA+1GjbayewiSK7sD+FSImVCdRBm7uG4O7DTrVjfDxZVycaxMooQRLrcq8Dc+IIoBQIX
	opyhUIrZ9vgoRsQla8YhQs08UDQ8tfrQoVz1ezMb1iNouDsRDvHbv49Ltapuea3xpupq7Pw==
X-Gm-Gg: AZuq6aLH0YrFB424VIhfrTZNJyLdS+UC8E5jrFpNk9+FYaFuuzIpzoiKd0acXEU19cT
	obHVQn4kaIl+1jB77vRNPxZ64e3hoPkjahVQbEbf8sJMW7qjO6pAmulgrA8FHvMfrTbNCovOsAo
	UFxArZCTd7oe/A0N8hESM0agFxomrSPTpqdavecvr3h2B6mUNxUlp9zaS0d2QOjfkYuzQOzbO3L
	NW0YaZ2jzJheyDAFRwuwv93SN9vMp3qVjw1d8u8FjHJlH8DNUf85WunGXe3yLrvrakYqJ8SWDAc
	6TLzSRg/FtQRUima4UTEX4ohRz7/7sF308rgv9RckXkTzLVKdAXZ/FP47RL+n/dWph3HuhBKwfI
	6
X-Received: by 2002:a17:903:b0b:b0:2a0:d46d:f990 with SMTP id d9443c01a7336-2a8d992f0c2mr25748515ad.31.1769772025494;
        Fri, 30 Jan 2026 03:20:25 -0800 (PST)
X-Received: by 2002:a17:903:b0b:b0:2a0:d46d:f990 with SMTP id d9443c01a7336-2a8d992f0c2mr25748205ad.31.1769772024877;
        Fri, 30 Jan 2026 03:20:24 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm72565075ad.3.2026.01.30.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:20:24 -0800 (PST)
Date: Fri, 30 Jan 2026 19:17:16 +0800
From: Coiby Xu <coxu@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Simo Sorce <simo@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Eric Biggers <ebiggers@kernel.org>, 
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IMA and PQC
Message-ID: <aXrKaTem9nnWNuGV@Rk>
References: <1783975.1769190197@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1783975.1769190197@warthog.procyon.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8370-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,redhat.com,huawei.com,gmail.com,oracle.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 766F9BA0C5
X-Rspamd-Action: no action

Hi David, 

Thanks for starting the discussion on potential issues or challenges for
IMA PQC support!

On Fri, Jan 23, 2026 at 05:43:17PM +0000, David Howells wrote:
>Hi Mimi,
>
>I've posted patches which I hope will accepted to implement ML-DSA module
>signing:
>
>	https://lore.kernel.org/linux-crypto/1753972.1769166821@warthog.procyon.org.uk/T/#t
>
>but for the moment, it will give an error to pkcs7_get_digest() if there's no
>digest available (which there won't be with ML-DSA).  This means that there
>isn't a hash for IMA to get at for TPM measurement.
>
>Now, I probably have to make a SHA256 hash anyway for UEFI blacklisting
>purposes, so that could be used.  Alternatively, we can require the use of
>authenticatedAttributes/signedAttrs and give you the hash of that - but then
>you're a bit at the mercy of whatever hashes were used.

IMA also uses pkcs7_get_digest mainly for the purpose of checking if the
digest has been blacklisted:) So you making a SHA256 hash for UEFI
blacklisting will automatically resolve this issue.

>
>Further, we need to think how we're going to do PQC support in IMA -
>particularly as the signatures are so much bigger and verification slower.

According to my experiments done so far, for verification speed,
ML-DSA-65 is consistently faster than ECDSA P-384 which is used by
current CentOS/RHEL to sign files in a package. 

The size of a single ML-DSA-65 signature indeed increases dramatically
compared with ECDSA P-384 (3309 bytes vs ~100 bytes). But I'm not sure
it can be a big problem when considering the storage capacity. Take
latest fresh CentOS Stream 10 x86_64 KVM guest as example, without any
file system optimization, extra ~189MB disk space is needed if all files
in /usr signed using by ML-DSA-65 where the disk size is 50G. But I
don't have enough experience to tell how users will perceive it and I'll
try to collect more feedback.

For the details of my experiments, you can check
https://gist.github.com/coiby/41cf3a4d59cd64fb19d35b9ac42e4cd7
And here's the tldr; version,
- Verification Speed: ML-DSA-65 is consistently ~10-12% faster
   at verification than ECDSA P-384 when verifying all files in /usr;
   ML-DSA-65 is 2.5x or 3x faster by "openssl speed"

- Signing Speed: ML-DSA-65 appears ~25-30% slower when signing
   all files in /usr; ML-DSA-65 is 4x or 4.8x slower by "openssl speed"

- Storage overhead: For ML-DSA-65, /usr will increase by 189MB and
   430MB when there are 27346 and 58341 files respectively. But total
   size of pure IMA signatures are estimated (files x (3309+20) bytes) to
   be ~87MB and ~185MB respectively.

>Would ML-DSA-44 be acceptable?  Should we grab some internal state out of
>ML-DSA to use in lieu of a hash?

According to 
https://www.ietf.org/archive/id/draft-salter-lamps-cms-ml-dsa-00.html
ML-DSA-44 is intended to meet NIST's level 2 security category. Will
NIST level 2 meet users' security requirements?

>
>David
>
>

-- 
Best regards,
Coiby


