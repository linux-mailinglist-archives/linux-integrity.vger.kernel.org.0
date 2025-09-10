Return-Path: <linux-integrity+bounces-7043-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94EB50A5D
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 03:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A15F1C611C8
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D06213E9C;
	Wed, 10 Sep 2025 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoGZKXEx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA152218AD1
	for <linux-integrity@vger.kernel.org>; Wed, 10 Sep 2025 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468419; cv=none; b=UwPWoMkJss2YAxX468hoLqSZMEYpsKPg/5Fc3ZOxSLa3W6fxVDih59jRYFEv1Y+XkMmQFbOabr6t72sLkesRiq1M00nDQa2latdqzFkar1+CO5j0Dc/9R1Mt6B5c7iImTaHucYFZbm8CjF7TzFQu/IraHig9Laobmn8YUoGhdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468419; c=relaxed/simple;
	bh=FHt07G2ckc/YJ1ZcIYot/VUnYBJdpLJpENBo+p+6XNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKrvvIZIDSOBiV/n//vC192zVXMPyg7TlYGxOL+UrSCGezgvDonuvveav2FM5O0ch+t+aBRorIb5+YtBh+4JddkLwIIakXQnia4BVP6FPF1XEYYZA/Ec1u1qBe2Se8lKupJgykdGmoBjGIENu6GgRul4zUdqvprr8roYbnmi0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoGZKXEx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757468416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bf0TnMJBEYNTRXq3aALRg5uk33yVz0wdtITnMYWXzk=;
	b=KoGZKXExTTkleqIrIJnK9KcN8qfP6mtpPkqvUGeQabAFor2LUPnv85fe71K6OIeZwnCTmn
	MUmtMsJXmt9sYC/qQO5Y2NxBVV6QOu+zs7YmgpuP84a5/claP2c3OaDINnVhPxqjJN49GM
	8zcPdD9D52CFrqC1aSo7VAw4WGdPh/w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-_CcOJ8PjMsqOey0ypiTgag-1; Tue, 09 Sep 2025 21:40:15 -0400
X-MC-Unique: _CcOJ8PjMsqOey0ypiTgag-1
X-Mimecast-MFC-AGG-ID: _CcOJ8PjMsqOey0ypiTgag_1757468414
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32b698861d8so6100255a91.2
        for <linux-integrity@vger.kernel.org>; Tue, 09 Sep 2025 18:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757468414; x=1758073214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bf0TnMJBEYNTRXq3aALRg5uk33yVz0wdtITnMYWXzk=;
        b=Ml2iMMbhYR8lNQ+Bwu6wNOxqPKy/kelDnjncnk3Ouuij79xphoSCH6stDLG2jO2yRB
         pSX95QlhFeOPnZrLKc356bSAF8zazyTUoKOonL3VrN/SYfYXrvCanPrss7joZ9zKCA5n
         fbVrBugMHlgzi6wAR1tVE/QdsSQ1nTudwQj20+nq8ZxlWATav4ZJvNK3XX69fidchA0F
         7wYSNrM+I0YGwEq9p9uSp5R9nE/rTDyXzHhzmWbvb7YAKcu9cvQ+BtSzq/4YZQC0rxWe
         KL8ts8juZzAsH7m0MlYcC5JoA39AqRqe7EPp+lNdZPg7BQx/MQ5ZnHdA6OCmd9YtMcHw
         RWiA==
X-Gm-Message-State: AOJu0YxrDjFQxMXr5FEDuKeFEJdS5EHVi7nryXoRRCz1aLNiqG0Otduh
	IvpkWjNS0PjO5lAgIiNCCSRCfkKOzV4ccuaC4dvk8ANXhzsgvy2PSp7E96564SzWxrIrfpJf7XU
	RgmvCmP/XkZA7WvzncfgzQMqaoZQQe5L7YBewfhR+l/lX4eXmcbiEPTuX+v3aUYkcs4jQTA==
X-Gm-Gg: ASbGnctFTUzEhdq6GZz0GFOiezFLqF0ESFdtBaGVzhbLsGVYHna++Zi93PEnHb9iIBu
	96Ssq8r3hXv6hKaszh5GSr2T8vrq4dhvbRyuULCVR8t5BGMc82DgLwi1Jr8GNi+QRBUmODINuiu
	5r1EEajk9hV/8gtHh73JcZ89zPhzB3ErL1935iJqprRPF/+Vaik2FSyhLjxHmUROIZ3cjTf3lV5
	U0or3epPQyJibF6mIidU1DUxmp6S6tszJlaFgZTn0lEI8R+lueHEelmQ1VhnoKaxwWp2ioGhdOw
	tmlSLWFButJc/xy4paETc2JRyDnut8k=
X-Received: by 2002:a17:90b:3d04:b0:32a:34d8:33cf with SMTP id 98e67ed59e1d1-32d43f77634mr16823434a91.31.1757468414495;
        Tue, 09 Sep 2025 18:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQlNFYMJg6XtDWuyZkLB1653jaInOG0K9bglwWI7QAmLbCiyDXHVpiFBScl37R1NTsEoaMQ==
X-Received: by 2002:a17:90b:3d04:b0:32a:34d8:33cf with SMTP id 98e67ed59e1d1-32d43f77634mr16823406a91.31.1757468414115;
        Tue, 09 Sep 2025 18:40:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb00f880sm537261a91.0.2025.09.09.18.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 18:40:13 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:36:50 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <wwcnoevou44eoe3ner4oegtdsdg46tlvwidu3ynobs7huac7ae@ljivg5ksohxv>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
 <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
 <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>

On Mon, Sep 08, 2025 at 04:58:05PM -0400, Mimi Zohar wrote:
>On Mon, 2025-09-08 at 10:53 -0400, Mimi Zohar wrote:
>> Hi Coiby,
>>
>> On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
>> > >
>> > > Even without an IMA appraise policy, the security xattrs are written out to the
>> > > filesystem, but the IMA_DIGSIG flag is not cached.
>> >
>> > It seems I miss some context for the above sentence. If no IMA policy is
>> > configured, no ima_iint_cache will be created. If you mean non-appraisal
>> > policy, will not caching IMA_DIGSIG flag cause any problem?
>>
>> Sorry.  What I was trying to say is that your test program illustrates the
>> problem both with or without any of the boot command line options as you
>> suggested - "ima_appraise=fix evm=fix ima_policy=appraise_tcb".  Writing some
>> other security xattr is a generic problem, whether the file is in policy or not,
>> whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should install
>> the IMA signature regardless.
>
>My mistake.  An appraise policy indeed needs to be defined for the file
>signature to be replaced with a file hash.

Thanks for the clarification! rpm-plugin-ima does try to install IMA
signature as shown from the following strace output,

     # strace rpm --reinstall ip*.rpm
     openat(11, "lnstat;68aee3f4", O_WRONLY|O_CREAT|O_EXCL, 0200) = 12
     dup(12)                                 = 13
     write(13, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0'\0\0\0\0\0\0"..., 19256) = 19256
     close(13)                               = 0
     getuid()                                = 0
     fchown(12, 0, 0)                        = 0
     fchmod(12, 0755)                        = 0
     getuid()                                = 0
     utimensat(12, NULL, [{tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */, {tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */], 0) = 0
     fsetxattr(12, "security.ima", "\3\2\4\3232\4I\0f0d\0020O\231\341q\323Q\322\235\341\7\323\224\205\2104\24\241\331#"..., 111, 0) = 0
     fsetxattr(12, "security.selinux", "system_u:object_r:bin_t:s0", 27, 0) = 0
     close(12)                               = 0

But after rpm-plugin-selinux sets security.selinux, the IMA
signature get cleared and is replaced with IMA hash.

>
>>
>> SELinux doesn't usually re-write the security.selinux xattr, so the problem is
>> hard to reproduce after installing the rpm-plugin-ima with "dnf reinstall
>> <package>".

Since rpm-plugin-selinux will write security.selinux for a newly
installed file, so this issue can be easily reproduced. If you want to
reproduce this issue by yourself, here are the steps to reproduce this
issue on Fedora,
1. Turn off secure boot and boot the kernel with 
    "ima_appraise=fix evm=fix ima_policy=appraise_tcb"
2. dnf install rpm-plugin-ima -y
3. dnf reinstall iproute -y
4. Run "getfattr -m - -d -e hex /usr/sbin/ip" to check if /usr/sbin/ip has IMA signature set

And my attached C reproducer is to extract the essence of what
rpm-plugin-ima does so it can be a minimal reproducer and also to
illustrate what the problem is.

>>
>> thanks,
>>
>> Mimi
>>
>

-- 
Best regards,
Coiby


