Return-Path: <linux-integrity+bounces-7078-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA0B57013
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 08:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D13AE7F8
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08427874F;
	Mon, 15 Sep 2025 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaUMUjS0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021E1F418F
	for <linux-integrity@vger.kernel.org>; Mon, 15 Sep 2025 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916621; cv=none; b=BZiWZFjHuN9FTiGlP/Wm4L3tuUB1It5gJIQSrs8vxs77U5lmi4pX3iPy+bacVn2HHf6z2rBtU1SsvP1eY/8/dJhY8cKRhqgGi+PRCe+h7bP0K25Bw4e8B2n6ESUKvb98zaZ7Ir6YT9AbBbMbaK4it0cXK4QDw2eFu4sduUTt9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916621; c=relaxed/simple;
	bh=hn/AO5Wc5PezQglXXzvuXeX5O2ZUagUhwm5XzDzqzz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TopeZ/JhtERmNEGaEE04rWS0P2JbqYMvi+1u+hZX4Pt5sDOWi2WScjMxRtXJWwEZlKJlL/G+JAAdOTq4Cdg/oCSWcKp6b3NAxoj90HanPwxIPXgVSN2gdISUEnULGNcjyt8jJ479cByMIF7mWYHxztqKM6ysWVI8wzz0QY0marY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaUMUjS0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757916618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQLpe+khIHoCgKf3IFT4TfFBdedPAuIsgy8bFmFQ+Iw=;
	b=HaUMUjS0IfwlgutSlX4s0ln9+EK2ujiSa3nnNTaeBy1ZDhoPDeLT8EFQsgjCJVkslDiGeE
	e/oJRud/h0FMACf9mdigwOGDXfoot8dD3WQGZkVhJIFru9kpMWi898LJmAcggedtBbcUEh
	7QgsLxV7Hi5N64GQwRzgwd/rNsnHuv4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-6HlNG_3tPO6XkasBB1h_Zg-1; Mon, 15 Sep 2025 02:10:15 -0400
X-MC-Unique: 6HlNG_3tPO6XkasBB1h_Zg-1
X-Mimecast-MFC-AGG-ID: 6HlNG_3tPO6XkasBB1h_Zg_1757916614
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7761dd1c845so1777335b3a.0
        for <linux-integrity@vger.kernel.org>; Sun, 14 Sep 2025 23:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757916614; x=1758521414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQLpe+khIHoCgKf3IFT4TfFBdedPAuIsgy8bFmFQ+Iw=;
        b=NvgBGjdHQ0QT/n6XeO3mGP+jf1WJ5L0MzIgLpkuPNJLCbuRknmOFnAdYzpcEFrO29H
         6YOwe0mSFWlDxfBMLO1j9a2MvD/3p3Nr7t9z8lMYYB+wwtDTBlXtlqS40wts7NlGXuQZ
         AytHMpFsskn5jYm23YIc2b4rMaeV79It6VQEeYMA5xgGcGTCBX75ZIFD7JQXK/Qa/Wbx
         IuxMU9SsFmal/KF7e1GQg3fsxvRdPPC64PooXKAEFnuZMM24n6Xh9CdpLYBH4z3rDZVn
         yeIc6D3ec9/0N3yqpxuZb9UlVy9vWlLrWo09foPe8pczP0v1eqVtWOfr+A+fyJArvAf8
         KAFg==
X-Gm-Message-State: AOJu0Yx4eQ5pjwlsyjmbF+b98HhK6u4B7Cfo27UCO9Ir6tnBxPYp1JAO
	E/9YGZsXw/E5Ti+BAL6z6QypCf7QLS7w2tYrKT+jrYv9wS6cjmnIglDbz05PKhPLFvmZ1YuUkWU
	1ZuN8i55WINFQ87raM7n8Qc9TRnrBPKj2Lz3AHIJ5kCJRpb6IsooNHAoaZF7Ss5pPmL2j7Q==
X-Gm-Gg: ASbGncuwsCcqvleatbnwbBNnpuRkab/SPhGY5I75go1Vt6EJ0HZzuvKbnB8AscA+mnt
	F8oihSeI+L9rq8iL2Nmb/X6AGnnURu6g5Ac7EIFD+f2/Oy7TP8jvTJYiwpbkE1sJl2Nt6nJNK9S
	NooNSy+2hlbabibK3rTZ31bnz4SoOKyknVmzjzfzWleInYTxxX91Rr5lMr/uvnvyEzKE9ZoZxL5
	BUqApMZNGtEWVquSBHd76rR2CEP3OpQBG5lDSKKGP6fta56xtkAI7MYo5cpk7fAhULvZiZcKepJ
	xlpByRiY3sgaz3ZdlQdpp/oeDB7Afvk=
X-Received: by 2002:a05:6a20:748d:b0:249:467e:ba57 with SMTP id adf61e73a8af0-2602a59a02amr14839207637.24.1757916614399;
        Sun, 14 Sep 2025 23:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECQRPiQitOqtajzh6bXpLG+V7zH9SLL0OR61z/8orLwVHwrBxRsiKGz8RZndsKYlzFa4Vdpw==
X-Received: by 2002:a05:6a20:748d:b0:249:467e:ba57 with SMTP id adf61e73a8af0-2602a59a02amr14839189637.24.1757916614030;
        Sun, 14 Sep 2025 23:10:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793bc77sm11823853b3a.4.2025.09.14.23.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 23:10:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:07:04 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <xy26wjlyha2m3jlcnowr74q4mv2vyr7xzm7zh2ab47osx5hffi@jhwihai3t4wb>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
 <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
 <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
 <wwcnoevou44eoe3ner4oegtdsdg46tlvwidu3ynobs7huac7ae@ljivg5ksohxv>
 <6f2b7320b691669068dda110c29c25f8aae2f244.camel@linux.ibm.com>
 <gw7xopwfzrp5qatwqa4n4i3miztbvbdolfaa2jxslb5pktc7fs@56r7n6feu55m>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <gw7xopwfzrp5qatwqa4n4i3miztbvbdolfaa2jxslb5pktc7fs@56r7n6feu55m>

On Mon, Sep 15, 2025 at 12:06:14PM +0800, Coiby Xu wrote:
>On Wed, Sep 10, 2025 at 08:21:33AM -0400, Mimi Zohar wrote:
>>On Wed, 2025-09-10 at 09:36 +0800, Coiby Xu wrote:
>>>On Mon, Sep 08, 2025 at 04:58:05PM -0400, Mimi Zohar wrote:
>>>> On Mon, 2025-09-08 at 10:53 -0400, Mimi Zohar wrote:
>>>> > Hi Coiby,
>>>> >
>>>> > On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
>>>> > > >
>>>> > > > Even without an IMA appraise policy, the security xattrs are written out to the
>>>> > > > filesystem, but the IMA_DIGSIG flag is not cached.
>>>> > >
>>>> > > It seems I miss some context for the above sentence. If no IMA policy is
>>>> > > configured, no ima_iint_cache will be created. If you mean non-appraisal
>>>> > > policy, will not caching IMA_DIGSIG flag cause any problem?
>>>> >
>>>> > Sorry.  What I was trying to say is that your test program illustrates the
>>>> > problem both with or without any of the boot command line options as you
>>>> > suggested - "ima_appraise=fix evm=fix ima_policy=appraise_tcb".  Writing some
>>>> > other security xattr is a generic problem, whether the file is in policy or not,
>>>> > whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should install
>>>> > the IMA signature regardless.
>>>>
>>>> My mistake.  An appraise policy indeed needs to be defined for the file
>>>> signature to be replaced with a file hash.
>>>
>>>Thanks for the clarification! rpm-plugin-ima does try to install IMA
>>>signature as shown from the following strace output,
>>
>>Agreed. I was referring to the SELinux label, which would be installed for new
>>files, but not necessarily re-installed on existing files.  The test program
>>simplified testing.  Thank you.
>
>My pleasure! Note reinstalling a package using dnf/rpm is equivalent to
>installing a new package in terms of this issue. Because according to
>the strace output and rpm's source code, when reinstalling a package,
>the following steps happens, taking lnstat as an example,
>
>1. A temporary file "lnstat;68aee3f4" is created
>2. Read the content from RPM and write it to lnstat;68aee3f4
>3. Set file permission
>4. Set security.ima by rpm-plugin-ima
>5. Set security.selinux by rpm-plugin-selinux
>6. Rename "lnstat;68aee3f4" to lnstat
>
>And here's the strace output,
>
>    # strace rpm --reinstall ip*.rpm
>    openat(11, "lnstat;68aee3f4", O_WRONLY|O_CREAT|O_EXCL, 0200) = 12
>    dup(12)                                 = 13
>    write(13, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0'\0\0\0\0\0\0"..., 19256) = 19256
>    close(13)                               = 0
>    getuid()                                = 0
>    fchown(12, 0, 0)                        = 0
>    fchmod(12, 0755)                        = 0
>    getuid()                                = 0
>    utimensat(12, NULL, [{tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */, {tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */], 0) = 0
>    fsetxattr(12, "security.ima", "\3\2\4\3232\4I\0f0d\0020O\231\341q\323Q\322\235\341\7\323\224\205\2104\24\241\331#"..., 111, 0) = 0
>    fsetxattr(12, "security.selinux", "system_u:object_r:bin_t:s0", 27, 0) = 0
>    close(12)                               = 0
>    ...
>    renameat(11, "lnstat;68aee3f4", 11, "lnstat") = 0

Btw, I realize my commit message that says the problem happens when reinstalling a
package can be a bit misleading. So in v3, I rephrase it as 
"... installing/reinstalling a package will not make good reference IMA generated"


