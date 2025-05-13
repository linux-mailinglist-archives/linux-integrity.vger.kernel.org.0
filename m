Return-Path: <linux-integrity+bounces-6183-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B06BAB4851
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 02:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9318C0BFC
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF037849C;
	Tue, 13 May 2025 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOtg7blP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9817D2
	for <linux-integrity@vger.kernel.org>; Tue, 13 May 2025 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747095333; cv=none; b=jmf8f/8D7AEAk0IXtjVlJ7twEgcXp0igwtbenpv+AB7A0gegdVUzY8iBKAR65UYzURUx9yRRXDwtUdYWFH7ZDCSP7kBl1IdZxWWLipsdqAncGhN9q5sr+J9ju2gp0GvfCflaePxUrrk2pD18Wa6x90Rh3Ia1nBwoRwRwI6ryIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747095333; c=relaxed/simple;
	bh=SadoHNbEXq5VE89x/WEeeX//Oh6gCSfgCPFxacS6wmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbyV5QhMWGUKf0XwcOPIwxra57mH0n+RALBCEpuy3/VD2gULnSsJdOAH0+AFYGWlstwSCjuDtVAtDioTAYLtER1/uvT4erzT+tpmmRVBDvdJCuu6vVQw1mrSdjmLHj3UKgAUAhbbETeitNXdJkv/T121icT5BQ3ukgt6Evmq+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOtg7blP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747095330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3AmHeJBYgl39ErgKXbHLkXnjMZ6a1n74+nQIVaSb1g=;
	b=dOtg7blPsOAxWbWyyG+vL1JI0nJSkjYsVatHjq/tOJXrX1P2NV6ehl9cSkHz1HUGoUb3e4
	wIYo1FKT0U9QFBSGHQXaHi0L37QZSJO5nDicZqYk+XoNubFpFFvP1ctPAdHsc9/w035do1
	FzYtYOTqLvlBsHm6BloXfBTiEPctF0Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-vOIQnUV6PWmdjh2qcaRDOA-1; Mon, 12 May 2025 20:15:29 -0400
X-MC-Unique: vOIQnUV6PWmdjh2qcaRDOA-1
X-Mimecast-MFC-AGG-ID: vOIQnUV6PWmdjh2qcaRDOA_1747095328
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30ac97eda56so8502009a91.1
        for <linux-integrity@vger.kernel.org>; Mon, 12 May 2025 17:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747095328; x=1747700128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3AmHeJBYgl39ErgKXbHLkXnjMZ6a1n74+nQIVaSb1g=;
        b=tQSTUYVyokHuydAYSWeIx0gTUXLs3Ko8QRFWYa15lfmXun2ihfbN5mhEr4Lg6Scggc
         GqFrKwPKhErAD56T6oEOgvofIm1WVEzxMgeHl64yJ315KllAswBUp/zCcoeuWPVqiXW5
         Q3dcQB406ttTrWNaNdurwvlxHftkPgUfVn79I8yXaDIOZ/6dRa8fXI6XIHQ0BF+omZNa
         ekxFgZ9tBV+bcOexuZv7NH5xpzXSAJNdZ2w9TxJMtfqEg9bfDrqzxC74aoiHJVnSKVdO
         yyH4L7YrcErNKE58sAy1sVkIPilW0rmUNq/vm0u+LSxmKqh8oBlqNWZSgdOYC+Qya5jt
         fAHg==
X-Forwarded-Encrypted: i=1; AJvYcCU2vhJRr4c55emIHUy0VfzihK2hmqQDRETVsELlnlIMS38OuK5Z8cYpy9s4QotVaFO+jXgNOCxTM1D68V0F+Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzaWWbXkj3VgHeejD7z2iKAv+SXPizNg3bvTwKLgy1QAc0+Iin
	3j3JFxDnuaHvPSAEmPvCYdd5YcmJ5TsSer9x7vmrc03388+idBB+gjGugf93VGF9Ba3whh2S2dR
	vOb+PLHWMvSZXQLKAoo3pJsgdArkZEHwwXbif4tj3YYA7LpMSHYGCIToPp+5kiGT/6g==
X-Gm-Gg: ASbGnct1VMH/KHsp7hd48E6tHSqwnmdiSWo5Vsdir7g0yV4DQVVVbOhHf3b1ler1U1g
	sCucoZhuzEXdM7ZO2MW+3T7tYOqmy7XpX0CygDs+MdUFh5NPGloWRC4AzmZVUHVenivDTtAviTT
	pqgTvMEuuejmci9VBo9YDSMKX0Pv5JQbm/s4VEeWm8pjruF9O4wwTu6X7HobP208vg6yQIC7Vey
	z3F4+mVBfTMGs4pyud32ZKyDiI53+3AXumIoKfIAS24RB80fpo8t56OAa+a5wqH+0mGI/h6kBRV
	nJY=
X-Received: by 2002:a17:90b:4ecd:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-30c3cefb9f7mr23828364a91.8.1747095328096;
        Mon, 12 May 2025 17:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFgE3g0PPo1j1o8bvsk61ZcmWZ5XqEMc4KrEKTJX4oJNqWAAOyuTc+O4Fr7Hx4Xjy+6nxPOw==
X-Received: by 2002:a17:90b:4ecd:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-30c3cefb9f7mr23828319a91.8.1747095327642;
        Mon, 12 May 2025 17:15:27 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c394a2467sm7395698a91.0.2025.05.12.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:15:27 -0700 (PDT)
Date: Tue, 13 May 2025 08:14:00 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Baoquan He <bhe@redhat.com>, 
	chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <s56ljuvqmrcy5gzjbrfbowq6gel7u4jjqtgyitvcbjgoiaahex@5kezecpurctk>
References: <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
 <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
 <80766b04cafd24a1d7171b8da03c822d86272f3c.camel@linux.ibm.com>
 <qvv3tniawgb3rvqeuxzckj25xxkcr2tqbwnji5gmdg4x3ahdha@52hwfd36ttf7>
 <00d282d0cf06c3ac208ab9edfddedda1c9a5a77b.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00d282d0cf06c3ac208ab9edfddedda1c9a5a77b.camel@linux.ibm.com>

On Fri, May 09, 2025 at 09:03:11AM -0400, Mimi Zohar wrote:
>[Cc'ing Roberto]
>
>On Fri, 2025-05-09 at 13:59 +0800, Coiby Xu wrote:
>> On Tue, Apr 29, 2025 at 07:39:17AM -0400, Mimi Zohar wrote:
>> > On Mon, 2025-04-28 at 11:48 +0800, Coiby Xu wrote:
>> > > On Wed, Apr 16, 2025 at 11:22:52AM +0800, Baoquan He wrote:
>> > > > On 04/09/25 at 11:40am, Mimi Zohar wrote:
>> > > > > On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
>> > > > ......snip..
>> > > > > > Thanks for confirming. I will consider how to fix it accordingly. Maybe
>> > > > > > after Steven's patches are merged. That would be great if the buffer
>> > > > > > allocating and storing can be skiped for kdump in Steven's patch. While
>> > > > > > I am worried that could disrupt the progress of Steven's patches.
>> > > > >
>> > > > > Agreed, let's get Steven's patch set upstreamed and then make the kdump
>> > > > > exceptions.
>> > > > >
>> > > > > - "ima: kexec: move IMA log copy from kexec load to execute" looks like it
>> > > > > isn't
>> > > > > copying the IMA measurement list records (kexec_post_load), but the memory
>> > > > > for
>> > > > > the IMA measurement list is being allocated (ima_alloc_kexec_file_buf).
>> > > > >
>> > > > > - Do you really want to totally disable IMA for kdump or would disabling
>> > > > > IMA-
>> > > > > measurement be sufficient?  Remember there's already an option to disable
>> > > > > IMA-
>> > > > > appraisal.  Disabling just IMA-measurement would allow IMA-appraisal to
>> > > > > continue
>> > > > > to work.  Meaning based on policy the integrity of files - executables,
>> > > > > kernel
>> > > > > image, etc - could still be verified.
>> > > > >
>> > > > > Without IMA-measurement:
>> > > > > - No adding records to the IMA measurement list
>> > > > > - No IMA measurement list pseudo securityfs files
>> > > > > - No extending the TPM
>> > > > >
>> > > > > With IMA-appraisal:
>> > > > > - Integrity verification of files based on keys, keyrings
>> > > > > - Loading keys
>> > >
>> > > Thanks for listing the impacts of disabling IMA measurement or
>> > > appraisal!
>> > >
>> > > kdump builds and loads its own initramfs as a cpio archive. After a
>> > > kernel crashes, the loaded initramfs will save the crashed kernel's
>> > > memory (vmcore) to specified location and then it will reboot the system
>> > > immediately. Since kdump merely copy files from existing fs into its
>> > > initramfs, I think at least majority of users don't need IMA for kdump.
>> >
>> > That's fine.
>> >
>> > > In fact, currently IMA-appraisal doesn't work for kdump because cpio
>> > > doesn't support xattr.
>> >
>> > Although CPIO doesn't support xattrs, tmpfs supports xattrs.
>>
>> Thanks for pointing it out! I thought tmpfs doesn't support xattrs
>> because ima_policy=tcb excludes TMPFS_MAGIC. There are still many
>> interesting questions for me to explore. For example, I don't understand
>> how 1st kernel's initramfs is shown as ramfs (which doesn't support
>> xattrs) but kdump intiramfs without the squashfs module is shown as
>> tmpfs.
>
>Try adding "rootfstype=tmpfs" to the boot command line.  For a detailed explanation,
>take a look at commit 21528c69a0d8 ("rootfs: Fix support for rootfstype= when root=
>is given").

Thanks for pointing me to the above commit! I'll check it.

>
>>
>> > I'm aware that some
>> > store the security xattr information in a file and write it out as xattrs.
>>
>> If the built initramfs as a CPIO file doesn't carry xattrs, the loaded
>> initramfs still doesn't have xattrs. I just found the initramfs could
>> opt to use squashfs or erofs which supports xattrs but currently it's
>> hardcoded to disable xattrs. For example, recently the dracut erorfs
>> module also follows squashfs to disable xattrs [1]. So in the near
>> future, I don't expect xattrs to be supported in kdump.
>>
>> [1] https://github.com/dracut-ng/dracut-ng/pull

Sorry, I didn't notice the link is incomplete. It should be

[1] https://github.com/dracut-ng/dracut-ng/pull/1296

>
>Right, so the issue isn't the initramfs root filesystem, but CPIO.  Either CPIO
>would need to be extended, which multiple people have attempted to do, or the xattrs
>could be stored in a file and written out to the initramfs root filesystem.  In fact
>Roberto's last attempts at adding CPIO xattr support did something like that.
>
>https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sassu@huawei.com/

Thanks for introducing Roberto's work to me!

>
>Mimi
>

-- 
Best regards,
Coiby


