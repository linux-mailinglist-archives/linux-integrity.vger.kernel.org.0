Return-Path: <linux-integrity+bounces-7565-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47315C3374F
	for <lists+linux-integrity@lfdr.de>; Wed, 05 Nov 2025 01:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30E844E7EFD
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Nov 2025 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A50C22D785;
	Wed,  5 Nov 2025 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLVVHsI7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJ/9CW9F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DEE224AF3
	for <linux-integrity@vger.kernel.org>; Wed,  5 Nov 2025 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301959; cv=none; b=YOIziv1LwW7rGoz8QTM4j6WbRbnkzcI+28a2z1EaDNtbZAffFQrOhEMKOE4Bi2N73R2Rmljsd9dPyHIZ+h0f6yggewSPBgKcUMUtbLVTMrJ/Kqdmcg2t+78iUKosyNhQKTaaIO7Vu66xsy4dVYiCfbT2W/UTp2X2mk5ky8a+HAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301959; c=relaxed/simple;
	bh=CXBidnbCR5ifmFwvHayw3FaO8i8qfw5gJZXUu4WTevA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2DHWUa23kokWH+WYFZ8PH81YKJrJO7nZyjVwoZRmezJKFjrtSNneA1KIuhP4aeGGlqJDSgmC5qhPH02XFqLa9RKHWpXn5Kml+VM0EQOS1/1PfyFQIxK+Uh8PsQVfOO4SRr2Pz6E2RBdbZJfGLr8/nb0JF1xa/6sSBsD6HctCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLVVHsI7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJ/9CW9F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762301956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hF/Q0Jxg/bJ4rsgyrnW9VOMqT1HQ3E8+/Upt51gSeWM=;
	b=hLVVHsI7bzOs9Ab3FSMinO2p7Anh3ZVRKQrtSKn6X3TmQZX9souzl+8RWOfVgkcZ0ZX+HG
	cp7ybCK1reXl+u4sakzV00I5pCIQWqjLMP/9aHJzEya7DRXGx0h8sWzHGkY7qCwlEbiAkK
	gN4kGwBSJupBcMU4v/5Vnhr0bhpTrq8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-ADGvBTAvNg2U_Br6XC7Aow-1; Tue, 04 Nov 2025 19:19:15 -0500
X-MC-Unique: ADGvBTAvNg2U_Br6XC7Aow-1
X-Mimecast-MFC-AGG-ID: ADGvBTAvNg2U_Br6XC7Aow_1762301954
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso5677149a12.1
        for <linux-integrity@vger.kernel.org>; Tue, 04 Nov 2025 16:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762301954; x=1762906754; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hF/Q0Jxg/bJ4rsgyrnW9VOMqT1HQ3E8+/Upt51gSeWM=;
        b=AJ/9CW9FkoFt4RY4R2TbCGSlM2RwkBuFhDSpjIvcnUE9OvBKX6BevnF+oiTTUHAG3U
         24zTy/IkDZ1RM068Qp1CuxDnVt/YXW8/ng9EQ8cCGo7twktx+UPs5wj+iBGIQ4q65MS2
         ccJIMfgHuC9y/SDktzd+er5WNb0IK4GP9gWg2MrmiKA6quDJnZ7mk5A8QBq/5syNvMkt
         jG9QScLl5Yp9gaVyphyAB4MjzKyS4ehGkWbhShzXuSbw+UCpuj5MiDQYz89+/aVVUIGP
         wXWYv7F4fasDZ1Jp3r1om9MsuBuBIBi/qcSkFj4HDl+EhvXZJ7xx9hvSRq/lmq65qZM1
         k9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301954; x=1762906754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hF/Q0Jxg/bJ4rsgyrnW9VOMqT1HQ3E8+/Upt51gSeWM=;
        b=UJJAtjj4Zm7m/8AgQLow/DZEBVH42l1jq/92lmyb1wznn3RQpg9cxHd7DuA+8fP4g4
         63L2sLgcKPro1eCOZvl4MeT7mjDxxq/XhercQ1E8mj+YhYUMRCC8BGTI7+O3Tb75NNtC
         hL7xiY3P0iw9aSunwV9I0jMsrjF2G7z2HuKfCjdgEwLphMtCLVELcxTCgKekxuzHUmE5
         cjmuVSKvKHb3Bgrbt1T+WLFon/SpzqtBlHc0ri+k/KVF0zEVfCu0zs51m2yA95ig42fW
         Bfh6NFmkzUXFYxWS/wywkPQNPivyvUmnU6MMGiF+PNyVLfmfIOyWEwjFsJfvCVfYjLOF
         6y1g==
X-Gm-Message-State: AOJu0YxcV/Qt1VWa8YizH68oeA3pWJPYxhcTrEvCMA/LFz2tk+/WxOk5
	36LOh3pDSA0sQHurudCpn6iInRj1/EZklKfMNPKpcFvPz5sZgsz877wuLZssjOBLjuXYn74qjsX
	oHFxyWvSOZRsBy29WCP4k2/2fxh/hHfQSSDskSGjrlxiYmrVJo/u2XRidlBNTrH6s4YQThA==
X-Gm-Gg: ASbGncsFcHCmJvEzV8bocdue2ZF3Fuhg0QnC8kMH+cxv9OAQiW+oG/wn29+2u2Ui7c5
	ODPccoN15VelYQg2mtl/pMElXp0cl83F54SCTB+FHczqQ6IS+uD8NqK5UTturfSXo1/pQdi143w
	l7ztlF6Ehy659DehSONWjeWc4dam+Bint77gJXFZU+jC2RvAe0nD2djDZf7NnbprJEuVzrKFR6N
	upp5dMGbk5/hKIOfsuXSFSp9YVA1rNO5kmPYHGpEz5f+zYbYI7RkB0SeLiPIfle8SIoMOteQZfC
	4nwzVKPvYnQOi2JswbFviMybSHoj0iA3UHimUeeXsEafmCPBFgSeQroCMf2bP/wbhGOvgg==
X-Received: by 2002:a17:903:2405:b0:290:c0d7:237e with SMTP id d9443c01a7336-2962adaf2cbmr20013885ad.39.1762301953490;
        Tue, 04 Nov 2025 16:19:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvLsNYSLufcGqpq910+wiTcGPaxLeUOI30KPT7POMh/wI/jxby0rWhm6jQT1thiVu8Y4E3iw==
X-Received: by 2002:a17:903:2405:b0:290:c0d7:237e with SMTP id d9443c01a7336-2962adaf2cbmr20013465ad.39.1762301952858;
        Tue, 04 Nov 2025 16:19:12 -0800 (PST)
Received: from localhost ([2409:8924:a812:1670:4703:63e6:48fd:865d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a69d91sm39637355ad.95.2025.11.04.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:19:12 -0800 (PST)
Date: Wed, 5 Nov 2025 08:18:25 +0800
From: Coiby Xu <coxu@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
Message-ID: <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>

On Sun, Nov 02, 2025 at 10:43:04AM -0500, Paul Moore wrote:
>On Sun, Nov 2, 2025 at 10:06 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>> On Sat, 2025-11-01 at 12:50 -0400, Paul Moore wrote:
>> > On Fri, Oct 31, 2025 at 3:41 AM Coiby Xu <coxu@redhat.com> wrote:
>> > >
>> > > Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
>> > > is enabled, IMA has no way to verify the appended module signature as it
>> > > can't decompress the module.
>> > >
>> > > Define a new LSM hook security_kernel_module_read_file which will be
>> > > called after kernel module decompression is done so IMA can access the
>> > > decompressed kernel module to verify the appended signature.
>> > >
>> > > Since IMA can access both xattr and appended kernel module signature
>> > > with the new LSM hook, it no longer uses the security_kernel_post_read_file
>> > > LSM hook for kernel module loading.
>> > >
>> > > Before enabling in-kernel module decompression, a kernel module in
>> > > initramfs can still be loaded with ima_policy=secure_boot. So adjust the
>> > > kernel module rule in secure_boot policy to allow either an IMA
>> > > signature OR an appended signature i.e. to use
>> > > "appraise func=MODULE_CHECK appraise_type=imasig|modsig".
>> > >
>> > > Reported-by: Karel Srot <ksrot@redhat.com>
>> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > > ---
>> > > v1: https://lore.kernel.org/linux-integrity/20250928030358.3873311-1-coxu@redhat.com/
>> > >
>> > >  include/linux/lsm_hook_defs.h       |  2 ++
>> > >  include/linux/security.h            |  7 +++++++
>> > >  kernel/module/main.c                | 10 +++++++++-
>> > >  security/integrity/ima/ima_main.c   | 26 ++++++++++++++++++++++++++
>> > >  security/integrity/ima/ima_policy.c |  2 +-
>> > >  security/security.c                 | 17 +++++++++++++++++
>> > >  6 files changed, 62 insertions(+), 2 deletions(-)
>> >
>> > We don't really need a new LSM hook for this do we?  Can't we just
>> > define a new file read type, e.g.  READING_MODULE_DECOMPRESS, and do
>> > another call to security_kernel_post_read_file() after the module is
>> > unpacked?  Something like the snippet below ...
>>
>> Yes, this is similar to my suggestion based on defining multiple enumerations:
>> READING_MODULE, READING_COMPRESSED_MODULE, and READING_DECOMPRESSED_MODULE.
>> With this solution, IMA would need to make an exception in the post kernel
>> module read for the READING_COMPRESSED_MODULE case, since the kernel module has
>> not yet been decompressed.
>>
>> Coiby suggested further simplification by moving the call later.  At which point
>> either there is or isn't an appended signature for non-compressed and
>> decompressed kernel modules.
>>
>> As long as you don't have a problem calling the security_kernel_post_read_file()
>> hook again, could we move the call later and pass READING_MODULE_UNCOMPRESSED?
>
>It isn't clear from these comments if you are talking about moving
>only the second security_kernel_post_read_file() call that was
>proposed for init_module_from_file() to later in the function, leaving
>the call in kernel_read_file() intact, or something else?

Hi Paul and Mimi,

Thanks for sharing your feedback! Yes, you are right, there is no need
for a new LSM hook. Actually by not introducing a new LSM hook, we can
have a much simpler solution!

>
>I think we want to leave the hook calls in kernel_read_file() intact,
>in which case I'm not certain what advantage there is in moving the
>security_kernel_post_read_file() call to a location where it is called
>in init_module_from_file() regardless of if the module is compressed
>or not.  In the uncompressed case you are calling the hook twice for
>no real benefit?  It may be helpful to submit a patch with your
>proposal as a patch can be worth a thousand words ;)
>
>
>> > diff --git a/kernel/module/main.c b/kernel/module/main.c
>> > index c66b26184936..f127000d2e0a 100644
>> > --- a/kernel/module/main.c
>> > +++ b/kernel/module/main.c
>> > @@ -3693,6 +3693,14 @@ static int init_module_from_file(struct file *f, const ch
>> > ar __user * uargs, int
>> >                        mod_stat_add_long(len, &invalid_decompress_bytes);
>> >                        return err;
>> >                }
>> > +
>> > +               err = security_kernel_post_read_file(f,
>> > +                                                    (char *)info.hdr, info.len,
>> > +                                                    READING_MODULE_DECOMPRESS);
>> > +               if (err) {
>> > +                       mod_stat_inc(&failed_kreads);
>> > +                       return err;
>> > +               }
>> >        } else {
>> >                info.hdr = buf;
>> >                info.len = len;
>>
>> == defer security_kernel_post_read_file() call to here ==

By moving security_kernel_post_read_file, I think what Mimi means is to
move security_kernel_post_read_file in init_module_from_file() to later
in the function,

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b261849362a..66725e53fef0c1 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3678,6 +3678,7 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
  	struct load_info info = { };
  	void *buf = NULL;
  	int len;
+	int err;
  
  	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
  	if (len < 0) {
@@ -3686,7 +3687,7 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
  	}
  
  	if (flags & MODULE_INIT_COMPRESSED_FILE) {
-		int err = module_decompress(&info, buf, len);
+		err = module_decompress(&info, buf, len);
  		vfree(buf); /* compressed data is no longer needed */
  		if (err) {
  			mod_stat_inc(&failed_decompress);
@@ -3698,6 +3699,14 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
  		info.len = len;
  	}
  
+	err = security_kernel_post_read_file(f, (char *)info.hdr, info.len,
+					     READING_MODULE);
+	if (err) {
+		mod_stat_inc(&failed_kreads);
+		free_copy(&info, flags);
+		return err;
+	}
+
  	return load_module(&info, uargs, flags);
  }

If we only call security_kernel_post_read_file the 2nd time for a
decompressed kernel module, IMA won't be sure what to do when
security_kernel_post_read_file is called for the 1st time because it
can't distinguish between a compressed module with appended signature or
a uncompressed module without appended signature. If it permits 1st
calling security_kernel_post_read_file, a uncompressed module without
appended signature can be loaded. If it doesn't permit 1st calling
security_kernel_post_read_file, there is no change to call
security_kernel_post_read_file again for decompressed module.

And you are right, there is no need to call
security_kernel_post_read_file twice. And from the perspective of IMA,
it simplifies reasoning if it is guaranteed that IMA will always access
uncompressed kernel module regardless regardless of its original
compression state. 

So I think a better solution is to stop calling
security_kernel_post_read_file in kernel_read_file for READING_MODULE.
This can also avoiding introducing an unnecessary
READING_MODULE_UNCOMPRESSED/READING_COMPRESSED_MODULE enumeration and
can make the solution even simpler,

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index de32c95d823dbd..7c78e84def6ec7 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -107,7 +107,12 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
  			goto out_free;
  		}
  
-		ret = security_kernel_post_read_file(file, *buf, i_size, id);
+		/*
+		 * security_kernel_post_read_file will be called later after
+		 * a read kernel module is truly decompressed
+		 */
+		if (id != READING_MODULE)
+			ret = security_kernel_post_read_file(file, *buf, i_size, id);
  	}

Btw, I notice IMA is the only user of security_kernel_post_read_file so
this change won't affect other LSMs. For a full patch, please visit
https://github.com/coiby/linux/commit/558d85779ab5d794874749ecfae0e48b890bf3e0.patch

If there are concerns that I'm unaware of and a new
READING_MODULE_UNCOMPRESSED/READING_COMPRESSED_MODULE enumeration is
necessary, here's another patch
https://github.com/coiby/linux/commit/cdd40317b6070f48ec871c6a89428084f38ca083.patch


>
>-- 
>paul-moore.com
>

-- 
Best regards,
Coiby


