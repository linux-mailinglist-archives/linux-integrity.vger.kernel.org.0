Return-Path: <linux-integrity+bounces-7545-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36393C1DEC8
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Oct 2025 01:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25E9F4E0F8D
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Oct 2025 00:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043581F2C45;
	Thu, 30 Oct 2025 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjZ1Rx9w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1CD1F4176
	for <linux-integrity@vger.kernel.org>; Thu, 30 Oct 2025 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784522; cv=none; b=A+j+Fn1SQAgSmqbyDlxvawZrrJ7VFX2pyUrqhr9N75O6VaX/VfSwbg2vcc49o55UeX53cvXf8kNns9RmYXwAKyE+mDTqbSi8wfgHH2a/nKofS4VdOfYDm8dclLQulZaBz5WEvuF5BdX3LAKt/JZ7vB+FIdbgMX0fHh93P+lzcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784522; c=relaxed/simple;
	bh=IUoyLvpsMYGmhZ1JkQITddfw7O2lI9KoOiDoJhY8Eys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkabQPn0svu1S2y8ApLG0rj6FCs04C7vFFCmfirz2ZpfEK1yDt/br/73m3NKxEtTZ4Xm8zbR565LcQ+dB2bAnCZxMAMs1ntQ6lhk/ST5SgKYZFGpQVljlg/WYxCvMHF5M1Td0zFC7scG9UD9SPnvd4AawABafXAqASEE3TP5Xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjZ1Rx9w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761784520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ToFbPMVt0+7kTO9K5L5BO7bcOr/qF+9yBlHuBVL7TkI=;
	b=DjZ1Rx9w1vFi97QJ24ouJVoBBdnpU+ACPYKF0rsaP1zKDCFt7xLkUoXRVzo/i90zs/BuCc
	GmGCQTJD8GvzAtCwa+Ld93TEo4zivLfh4l0JFMOIddpSP2tiRTRJpCtxmDMiP9IZNZKYI6
	ZzQ0mAm+hompFofpcy7vEWSl4OfBNMM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-1rKNTfi4PseO1MQxGtbSVQ-1; Wed, 29 Oct 2025 20:35:17 -0400
X-MC-Unique: 1rKNTfi4PseO1MQxGtbSVQ-1
X-Mimecast-MFC-AGG-ID: 1rKNTfi4PseO1MQxGtbSVQ_1761784517
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a26c0c057eso424009b3a.2
        for <linux-integrity@vger.kernel.org>; Wed, 29 Oct 2025 17:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784517; x=1762389317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToFbPMVt0+7kTO9K5L5BO7bcOr/qF+9yBlHuBVL7TkI=;
        b=XnP2GqFdB5PeveO+9O1JfV8LLSuw4sBL/IvbnjAjvPjGVoR7++EjNz183JSNstlgip
         F8kjG4eFiK+uy/Gd31sgn9ucZnQ9FLDosIhigPtLmtmSiPiPhDNBwrGaWN1ifinL21vy
         084CLd4Gw81NeJGHY4SmX5AqkIzEzQvKw1TAOA2BEC2mtS63EKYJ4bXe1W5e59YxlWdI
         GcwPEooYnm5f6ryp2hgsdoxvlXpEE/3l34tyEDtPbiHCRJlvIffrHYxzmCbllzAXeSTI
         e+SDKsg4Vhsn1xxXBPHp5QbG95c0BBIrvFWkyOZKZnEHnLm6w0QdfcaMi/ybSgMfH3cX
         I/dw==
X-Gm-Message-State: AOJu0Yy6nNrtAtfPsLt6lNVOFeFsrs/WbuT+mNXLGdwKZdjl7tMesYE6
	etTZUySinsR0LiWeJAXWuquJFOafx0CAuVkJjVh4zVJfzrCe7xN3i6BdwtKC2X5mclr6wp6cK+z
	4kYwcR7pVXpgSXLG6fzXAochOjVcCizersOYLkKtrnDYR5n4NCrNYyBcdovuFBemzEcoW1A==
X-Gm-Gg: ASbGncuI+oFacEpAHHRqF4390urUXtJ4BCgA4mq1qwW5mgCrkMD+ISwyz30meMvWKKS
	2OnoVj0LWgTMsnHaYsZlBQ+S4EJLjlcs2rE0Ls0TzzlUzMdBKsywd9/llcJW0nzSmXMtAIXl/ht
	JcRFeV9Vzf5j1QXxDcc4dTRh4T9vbV1Go1KUxvFWEMMBqHndd1jJYDehOnN+beIwWcLNqFc3HOg
	aDAgLNfm/R2EucnD9cHRYzDXVmktwJoxfCNlOdh1AtpjoN3NYji/84h5paDamdXZwRZBckBWV5O
	M08jKHBhNU3CaunuX6696psOTscthQPFsSuQC5oaJ8biCK3s7Jx763GmAmchg4FzKw==
X-Received: by 2002:a05:6a21:3386:b0:334:a15f:8d2d with SMTP id adf61e73a8af0-3465481151dmr5293649637.44.1761784516653;
        Wed, 29 Oct 2025 17:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFio5AWXbLCe0GCxiEDNyLa9vmvddUkVGViUSSGWOijdJL70pEBNvbe1p8oDpeQ5+ERrHT/7w==
X-Received: by 2002:a05:6a21:3386:b0:334:a15f:8d2d with SMTP id adf61e73a8af0-3465481151dmr5293612637.44.1761784516148;
        Wed, 29 Oct 2025 17:35:16 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404dddcsm16488075b3a.38.2025.10.29.17.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:35:15 -0700 (PDT)
Date: Thu, 30 Oct 2025 08:33:33 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <h6jeu3yf33p2ngcvaczjrghm3hunkjf5gq462njghryyc2qeph@jdug44kw6tpb>
References: <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
 <1987088bb29971883d2b5c06a31c8114c729422c.camel@huaweicloud.com>
 <497d1608572eec7d3d498967f0bae7d45023635b.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <497d1608572eec7d3d498967f0bae7d45023635b.camel@linux.ibm.com>

On Mon, Oct 20, 2025 at 09:57:19AM -0400, Mimi Zohar wrote:
>On Mon, 2025-10-20 at 14:45 +0200, Roberto Sassu wrote:
>> On Mon, 2025-10-20 at 08:21 -0400, Mimi Zohar wrote:
[...]
>> >
>> > >
>> > > Another thought is to make CPIO support xattr. Today I realize that
>> > > ima_policy=secure_boot can also cause failure of loading kdump kernel.
>> > > So the issue this patch tries to resolves has much less impact than I
>> > > thought. Maybe we can wait until CPIO xattr support is ready? I'll help
>> > > review and test Roberto's patches if this is the best way forward.
>> >
>> > I'm not sure of the status of the CPIO patch set.  Roberto?
>>
>> I haven't had time to look at it recently. I can take the openEuler
>> version, address the remaining comments and repost.
>
>Thank you!

+1, I'm looking forward to the reposted patch set!


-- 
Best regards,
Coiby


