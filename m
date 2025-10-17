Return-Path: <linux-integrity+bounces-7482-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312BFBEBFC7
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 01:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA841AA44E5
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AA92857F0;
	Fri, 17 Oct 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrxjltB3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4F354AE7
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743223; cv=none; b=IAN4cDrair+PtFk62d/PAdcX+VYQ3CyADNW5msRS2DymdRqVrxh/qmKRhyXZ2j5PyIJUeMnAhIOuPfs90rKMBi1Ptpuj/eSw7vBeiWVig7Yhu/CD6d9GE5+A4TyojhGg/XgBMzOJy59wCAko5NjHEDG9CtJMdMRC3SKO+ukNcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743223; c=relaxed/simple;
	bh=X15D7W7Yx+YypyD4X90aWBxbDYgolY88Bw0oGieHLNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3J9ddxwKNLlL3TXumH8ciJhEa4VH5CNB3CYSexmQeLffObVfC031LnPZb8pMrRHdnijJ4WhcHLT03hiSh2ScJKm+6b8B0OAcINcYjKdPswWn5zBoHp5M7T8pt8P6D626hO5i9tC0rntt3iNLwhrZf/xxs7k/W1sBcYDidn9mmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrxjltB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760743220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jklMDzg5tnspS4DtYkQeZ5gfoOlrwW26LupLwBUHbVM=;
	b=UrxjltB3SnXDcNQwme6+ycivwR6/GvU1TKcaOJWzov4ffW86+gYm/ssbqtiClStlGTrdU7
	EX4+wHxCV2TW9/n2AUljZDapZVq/hpKoQPdOX5LaCVejl2348XziohKh8q2TCYJJlsLg0P
	kexVh4FOiKWb3kjPnc3qOiwNDLcMrmw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-8cC860ZKNuiPgh2T-Z3_bw-1; Fri, 17 Oct 2025 19:20:17 -0400
X-MC-Unique: 8cC860ZKNuiPgh2T-Z3_bw-1
X-Mimecast-MFC-AGG-ID: 8cC860ZKNuiPgh2T-Z3_bw_1760743215
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5529da7771so1454946a12.0
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 16:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760743215; x=1761348015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jklMDzg5tnspS4DtYkQeZ5gfoOlrwW26LupLwBUHbVM=;
        b=NQILitqUeF+478ZEjWFnU8GpnC5Fl8JPmOhfjW3FnUi5ynpV7McDrgb1QUbcCob27H
         4uyx0PcQqCo7jWidELwU0aKUSkEou5WAJi7z7cg+S87GkUuQ9Y5JmgGxzlUoHFA3VsV2
         q4pVW3VhOi23AZmF8xIU7TPdV34AfIbWrLgjQrIVleVkTQPrfczkWxjDSXI0YWNZnIOg
         ynRRuJTOqR2VZFk0rVuGofevxGzHMD7ccehLkYsLgKJavXAfuxRi91TaK/rHBEdk4gMU
         Sxk3e+J81N8YdFkidpqhmlxfEDaKyN+rlnyY9G+n7sZvXEY7dfHUSmGEK4mKhbM8TLmC
         YfuQ==
X-Gm-Message-State: AOJu0YylJGwOUeyHoKbXpmaL9HIVmlA1kNnax3gm77hRFQAzFoztHFJK
	kOVtIY83IXAbrGFuHVOkyzuYJ7ZzWHCdDUdolhtzPe60zEp8R6QX+Dsmgf0wVTCHuIG3f9rBmX6
	siNceYVhxlgkuD5G0mcRWMubUSVE0M82d0idC3NMre3jPK1t7EltP/htpAMp6SLnqMfLOzw==
X-Gm-Gg: ASbGncsO0rotzc5rPtJj/qebSOa4+28Zkbu1rZV1rg7ZlGfyj9qfF+K9E7tec/iIzgR
	Ff1nVMQ8gjzhMYabdHPy3XUx7fnFYCh5tSrtG//hnlo/QcyUF8g6M4BNdGRWuhZYEPdsj/Ibv4W
	G5mYJBjWHj5SC7khYExvX8WKzTJb+DXT7KR9HNvwBbyIpzLdUGifgIyf2IKQW35G99xhRyk+6o+
	aB4di67mWpJt33LZAaozN/qyn+oUgxlnIPGkUqhIrjxUQxr4T/V8uUuH9MXX1aTwR2jHzof8lV3
	dpHRyF4DK5D6XAUEajRLXbn7T+oVi5TLvkscqZn7ufzaynX0ZYbdJ1imgFhYDZN9gQ==
X-Received: by 2002:a05:6a21:998f:b0:334:a76b:f2eb with SMTP id adf61e73a8af0-334a8611df5mr8351857637.40.1760743215006;
        Fri, 17 Oct 2025 16:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeWnHiXFhbw7OvrCOiB+4cPFE84Qu8uloSHk2Ao65aZKH8uUskv5C8QWgX7QdEpfV57i8r5A==
X-Received: by 2002:a05:6a21:998f:b0:334:a76b:f2eb with SMTP id adf61e73a8af0-334a8611df5mr8351804637.40.1760743214287;
        Fri, 17 Oct 2025 16:20:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm889121a12.14.2025.10.17.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 16:20:13 -0700 (PDT)
Date: Sat, 18 Oct 2025 07:19:27 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>

On Fri, Oct 17, 2025 at 01:49:58PM -0400, Mimi Zohar wrote:
>On Fri, 2025-10-17 at 11:19 +0800, Coiby Xu wrote:
>> On Thu, Oct 16, 2025 at 10:31:35PM -0400, Mimi Zohar wrote:
>> > On Thu, 2025-10-16 at 11:46 +0800, Coiby Xu wrote:
>> > > On Tue, Sep 30, 2025 at 04:28:14PM -0400, Mimi Zohar wrote:
>> > > > On Tue, 2025-09-30 at 09:57 -0400, Mimi Zohar wrote:
>> > > > > On Sun, 2025-09-28 at 11:03 +0800, Coiby Xu wrote:
>> > > > > > Currently, for any IMA policy that requires appraisal for kernel modules
>> > > > > > e.g. ima_policy=secure_boot, PowerPC architecture specific policy,
>> > > > > > booting will fail because IMA will reject a kernel module which will
>> > > > > > be decompressed in the kernel space and then have its signature
>> > > > > > verified.
>> > > > > >
>> > > > > > This happens because when in-kernel module decompression
>> > > > > > (CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_module
>> > > > > > syscall instead of init_module to load a module. And IMA mandates IMA
>> > > > > > xattr verification for finit_module unless appraise_type=imasig|modsig
>> > > > > > is specified in the rule.  However currently initramfs doesn't support
>> > > > > > xattr. And IMA rule "func=MODULE_CHECK appraise_type=imasig|modsig"
>> > > > > > doesn't work either because IMA will treat to-be-decompressed kernel
>> > > > > > module as not having module signature as it can't decompress kernel
>> > > > > > module to check if signature exists.
>> > > > > >
>> > > > > > So fall back to default kernel module signature verification when we have
>> > > > > > no way to verify IMA xattr.
>> > > > > >
>> > > > > > Reported-by: Karel Srot <ksrot@redhat.com>
>> > > > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > > > > > ---
>> > > > > > Another approach will be to make IMA decompress the kernel module to
>> > > > > > check the signature. This requires refactoring kernel module code to
>> > > > > > make the in-kernel module decompressing feature modular and seemingly
>> > > > > > more efforts are needed. A second disadvantage is it feels
>> > > > > > counter-intuitive to verify the same kernel module signature twice. And
>> > > > > > we still need to make ima_policy=secure_boot allow verifying appended
>> > > > > > module signature.
>> > > > > >
>> > > > > > Anyways, I'm open to suggestions and can try the latter approach if
>> > > > > > there are some benefits I'm not aware of or a better approach.
>> > > > >
>> > > > > Coiby, there are multiple issues being discussed here.  Before deciding on an
>> > > > > appropriate solution, let's frame the issues(s) properly.
>> > >
>> > > Hi Mimi,
>> > >
>> > > Thanks for listing and framing the issues! Sorry, it took me a while to
>> > > go through your feedback as I also had a 8-day holiday.
>> > >
>> > > > >
>> > > > > 1. The finit_module syscall eventually calls init_module_from_file() to read the
>> > > > > module into memory and then decompress it.  The problem is that the kernel
>> > > > > module signature verification occurs during the kernel_read_file(), before the
>> > > > > kernel module is decompressed.  Thus, the appended kernel module signature
>> > > > > cannot be verified.
>> > >
>> > > Since IMA only accesses a kernel module as a fd or struct file*, even if
>> > > IMA hook is triggerd after kernel module is decompressed, IMA still
>> > > doesn't know the default verification has passed or can't access the
>> > > decompressed kernel buffer [2] to do the verification by itself.
>> > >
>> > > [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/module/main.c?h=v6.17#n3689
>> > >
>> > > > >
>> > > > > 2. CPIO doesn't have xattr support. There were multiple attempts at including
>> > > > > xattrs in CPIO, but none were upstreamed [1].  If file signatures stored in
>> > > > > security.ima were available in the initramfs, then finit_module() could verify
>> > > > > them, as opposed to the appended kernel module signature.
>> > >
>> > > Thanks you for pointing me to the work [1]. I'll take a more careful
>> > > look at [1]. I think CPIO supporting xattr can be a long-term solution
>> > > and also close a important security gap.
>> > >
>> > > > >
>> > > > > 3. The issues described above are generic, not limited to Power.  When
>> > > > > CONFIG_MODULE_SIG is configured, the arch specific IMA policy rules do not
>> > > > > include an "appraise func=MODULE_CHECK".
>> > >
>> > > Yes, the issue is not limited to Power. And thanks for correcting me
>> > > that Power arch specific IMA policy rules don't have this problem! Sorry
>> > > I misread the code.
>> > >
>> > > > >
>> > > > > 4. Unlike the arch specific IMA policy rules, the built-in secure boot IMA
>> > > > > policy, specified on the boot command line as "ima_policy=secure_boot", always
>> > > > > enforces the IMA signature stored in security.ima.
>> > > > >
>> > > > > Partial solutions without kernel changes:
>> > > > > - Enable CONFIG_MODULE_SIG  (Doesn't solve 4)
>> > > > > - Disable kernel module compression.
>> > > > >
>> > > > > Complete solution:
>> > > > > - Pick up and upstream Roberto Sassu's last version of initramfs support [1].
>> > > > > - Somehow prevent kernel_read_file() from failing when the kernel_read_file_id
>> > > > > enumeration is READING_MODULE and the kernel module is compressed.  The change
>> > > > > might be limited to ima_post_read_file().
>> > > >
>> > > > or perhaps not totally.
>> > > >
>> > > > init_module_from_file() doesn't pass the flags variable to kernel_read_file().
>> > > > You might want to consider defining a new kernel_read_file_id enumeration named
>> > > > READING_COMPRESSED_MODULE.
>> > >
>> > > Thanks for suggesting the solutions! I like the solution of CPIO
>> > > supporting xattr but it seems it won't land in upstream soon. So I
>> > > prefer the last approach. I've implemented one [3] by defining a new
>> > > kernel_read_file_id enumeration, would you like me to post the patches
>> > > to the mailing list directly?
>> > >
>> > > [3] https://github.com/coiby/linux/tree/in_kernel_decompression_ima
>> >
>> > A few thoughts, before you post the patch.
>>
>> Thank you for sharing your thoughts!
>>
>> >
>> > 1. In the general case, the kernel module could be compressed, but without an
>> > appended signature.  The new code should only defer appended signature
>> > verification, if there isn't an xattr or appended signature.
>>
>> I'll add these two condition checks, thanks!
>>
>> >
>> > 2. Instead of defining an additional process_measurement() argument to identify
>> > compressed kernel modules, to simplify the code it might be possible to define a
>> > new "func" named COMPRESSED_MODULE_CHECK.
>> >
>> > +       [READING_COMPRESSED_MODULE] = MODULE_CHECK,  -> COMPRESSED_MODULE_CHECK
>>
>> I also thought about this approach. But IMA rule maps kernel module
>> loading to MODULE_CHECK. If we define a new rule and ask users to use
>> this new rule, ima_policy=secure_boot still won't work.
>
>I don't have a problem with extending the "secure-boot" policy to support
>uncompressed kernel modules appended signatures, based on whether
>CONFIG_MODULE_SIG is enabled.  The new rule would be in addition to the existing
>MODULE_CHECK rule.

I assume once the new rule get added, we can't remove it for userspace
backward compatibility, right? And with CPIO xattr supported, it seems
there is no need to keep this rule. So if this concern is valid, do you
think we shall switch to another approach i.e. to make IMA support
verifying decompressed module and then make "secure-boot" to allow
appended module signature?

Another thought is to make CPIO support xattr. Today I realize that
ima_policy=secure_boot can also cause failure of loading kdump kernel.
So the issue this patch tries to resolves has much less impact than I
thought. Maybe we can wait until CPIO xattr support is ready? I'll help
review and test Roberto's patches if this is the best way forward.

>
>>
>> >
>> > 3.  The patch title "ima: Use default kernel module signature verification for
>> > compressed ones" is a bit off.  It should be something along the lines of "ima:
>> > defer compressed kernel module appended signature verification".
>>
>> >
>> > 4. Simplify the patch description.
>>
>> I'll rephrase the title and try simplifying it. Thanks!
>
>Thank you.
>

-- 
Best regards,
Coiby


