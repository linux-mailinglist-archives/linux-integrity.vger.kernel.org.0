Return-Path: <linux-integrity+bounces-6028-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAFCA9E6D0
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Apr 2025 05:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F3D3B8501
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Apr 2025 03:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E8156F3C;
	Mon, 28 Apr 2025 03:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxGF7hyu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42E8BE7
	for <linux-integrity@vger.kernel.org>; Mon, 28 Apr 2025 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745812252; cv=none; b=SNPRWh/O6ELYDPH1T6Cnni+X7uxDTGLRccGXLnqO9RAhvxlEaJfz72NPjaXRXnqaNjkEnzfA+KCDT0Oanh8sk7Ka/7rnydR+WW64WBMlnuC+nS8PD6hoKCo9U6UAEWXF0VeWOGR1MFqYQlRWUujC78bIIc5e2hq8Nw3KuO2RaDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745812252; c=relaxed/simple;
	bh=480hED4EL5PAAPOKlVbk/ilCobAM7RQ8UYPOI2+2Sg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVuSn9FSH/T1XzGhRkacvHxdCffkV49xfEqAwSIbzWdfirhbUQf6yXU3cV9CegY3/yvNA82zZMux9+SwBuxTYhfjczP2bCAS4Ui6S79RJ6pnZw9Yo8z3UKlPuKFMLaypE7hQJ0hMeiN1bKlPuUw1gaPKpZYgdAorv/5dawbJWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxGF7hyu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745812248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbo+2a9JBJRZ/sxLnfgVH6LOGHNdpN/py6v/3sMtqqk=;
	b=dxGF7hyuCuiOLMZKbdyWF+lPn+t0i16RoXlCwiK9lG5weyNnNl2XpUasiStfvbY56A+GXT
	v4OfLhBIRoDDl/5hM0alzWrt6EC5sGhQkquU3Cht/AZjv1FNoiZP3q7jKE9cK0Re2Amij7
	bME7xGIOzAnqsz6LmM1nMCxqe77oTag=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-ENuqz7U5MUK6YYBJ9vmzhA-1; Sun, 27 Apr 2025 23:50:47 -0400
X-MC-Unique: ENuqz7U5MUK6YYBJ9vmzhA-1
X-Mimecast-MFC-AGG-ID: ENuqz7U5MUK6YYBJ9vmzhA_1745812246
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af59547f55bso2337614a12.0
        for <linux-integrity@vger.kernel.org>; Sun, 27 Apr 2025 20:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745812246; x=1746417046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbo+2a9JBJRZ/sxLnfgVH6LOGHNdpN/py6v/3sMtqqk=;
        b=R0t8WZKt/7fOQE5r1xJ7zt5zZa6RUNsnY9JwCkG/2IuQ+Do3BQWwyefLwx41LaCEK/
         VqtRxXIz6e+pPC0muaO4XoGkmIoJwks6sbYm0EMND0TjrOGVwf12qDzcCxDYLBx3ZIAm
         6c8Kvu4UjuNqwuejhTn61hSA7dNDPs5a2iKpLL2BcOHnxtaHm9H6oPmMB76TbkJ4L9m9
         1BEkBh6srLAQxkPeGazJ2t1gDBx5pBubKU9d7s4h2Jrv3np0JtP+aDLoKD66O2eMssnD
         SJqX/RHiZYEXs5rRKWHDfYDCZYUuK3ZhW68sKmeyaEIZbIUfPASikuBh8I2+reCOOoNX
         tz7g==
X-Forwarded-Encrypted: i=1; AJvYcCXQznzO+iN+mTS7ueEw2p2Xx1y0McNILxQ/AAZXWcYIyKwqRLIeFF0EIlleSgr+mKy1IedUoSsD/ysomytcELE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KpvcGCYVlupKliN8hklNbGuzbK+sG1rcjAToJpEz9twzcLIr
	HUgFq9eiUBf/ULLM9AhHyJ1AEcxXT0JbgVVhRTgcCiX4CdMRQs7SD+Fa102J5kXCTHre6bsAVmz
	fbCHz+0IY4m2LDZ8U5L3NLDEWrU2HxGgYnHeLa6/QYwCZX5SFOHRMDKUdGWwR7afRKA==
X-Gm-Gg: ASbGncudzZnNKV5FDNis4ZmwXS3QryafyeOi9YbtNddlzNRDB8CL6fPYAGIQtBO7QCo
	o4jUkFtxXX1dmGppJ6KHVrbxyxClPXrM5C2q/WQXWcTQUOlKpeWIrXV8LmHxxRAYQLyuWf7tRpF
	G7iL/Wa9rwK/mRxVUI1TLwdyz3n6Ws6Ma3ABvJkKAuycOW4viEMHbiRhr0C5mLWZCN/Gv/1BJZj
	JHxU4ziZI6c9bD7oycHbla+7pGK24hyj/z28tluH2sv1yRi5Rsn6hJ7hPi6LX+51IloNgZAM+nQ
	Q98=
X-Received: by 2002:a17:902:ea07:b0:224:e33:889b with SMTP id d9443c01a7336-22dc6a02897mr129450785ad.12.1745812246498;
        Sun, 27 Apr 2025 20:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVFYsPlT2IQH/8g/Ppb2JU1Bp7a0oc6sqVCGjUPDTj65f4oD4rCO7sbjZ9q3vvWinALN4nhw==
X-Received: by 2002:a17:902:ea07:b0:224:e33:889b with SMTP id d9443c01a7336-22dc6a02897mr129450525ad.12.1745812246140;
        Sun, 27 Apr 2025 20:50:46 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbc0c6sm71732915ad.81.2025.04.27.20.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 20:50:45 -0700 (PDT)
Date: Mon, 28 Apr 2025 11:48:25 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>, 
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
References: <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>

On Wed, Apr 16, 2025 at 11:22:52AM +0800, Baoquan He wrote:
>On 04/09/25 at 11:40am, Mimi Zohar wrote:
>> On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
>......snip..
>> > Thanks for confirming. I will consider how to fix it accordingly. Maybe
>> > after Steven's patches are merged. That would be great if the buffer
>> > allocating and storing can be skiped for kdump in Steven's patch. While
>> > I am worried that could disrupt the progress of Steven's patches.
>>
>> Agreed, let's get Steven's patch set upstreamed and then make the kdump
>> exceptions.
>>
>> - "ima: kexec: move IMA log copy from kexec load to execute" looks like it isn't
>> copying the IMA measurement list records (kexec_post_load), but the memory for
>> the IMA measurement list is being allocated (ima_alloc_kexec_file_buf).
>>
>> - Do you really want to totally disable IMA for kdump or would disabling IMA-
>> measurement be sufficient?  Remember there's already an option to disable IMA-
>> appraisal.  Disabling just IMA-measurement would allow IMA-appraisal to continue
>> to work.  Meaning based on policy the integrity of files - executables, kernel
>> image, etc - could still be verified.
>>
>> Without IMA-measurement:
>> - No adding records to the IMA measurement list
>> - No IMA measurement list pseudo securityfs files
>> - No extending the TPM
>>
>> With IMA-appraisal:
>> - Integrity verification of files based on keys, keyrings
>> - Loading keys

Thanks for listing the impacts of disabling IMA measurement or
appraisal! 

kdump builds and loads its own initramfs as a cpio archive. After a
kernel crashes, the loaded initramfs will save the crashed kernel's
memory (vmcore) to specified location and then it will reboot the system
immediately. Since kdump merely copy files from existing fs into its
initramfs, I think at least majority of users don't need IMA for kdump.
In fact, currently IMA-appraisal doesn't work for kdump because cpio
doesn't support xattr. As for the issue of not properly updating the
security xattrs, I think in most of cases disabling IMA-appraisal in
kdump won't cause the trouble. If the vmcore is saved to a remote fs, the
local fs won't even be touched. If the vmcore is saved to local fs and
the appraisal rules cover the saved vmcore and the created logs files,
we only need to update the xattr file of three files. So from the
perspective of kdump, it's good to disable IMA for kdump to save memory.
Of course we can't rule out the possibility some users may want to need
IMA in kdump. So a flexible solution like providing a knob to allow
users to enable IMA in kdump will be the ideal solution.

Btw, recently, a colleague reminds me of an issue that the system hangs
because systemd fails to load incorrect /etc/ima/ima-policy. Of course,
we should ask users to verify the policy beforehand. But it's still
possible the booting process may be stopped by a strict, albeit
syntax-correct policy and users can't log into the system to fix the
policy. Do you think a knob to disable IMA is needed to address these
cases or is there a better solution?

>
>Currently, Kdump has no demand to do integrity verification based on
>keys, keyrings, except of Coiby's LUKS support in kdump:
>
>[PATCH v8 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
>https://lore.kernel.org/all/20250207080818.129165-1-coxu@redhat.com/T/#u
>
>I have talked to Coiby, he will do some investigations to see if loading
>keys related to IMA or IMA-appraisal functionality is related to LUKS
>support in kdump because the LUKS support in kdump also needs
>store/restore keys/keyrings between normal kernel and kdump kernel.

Thanks for reminding me about kdump LUKS support. IMA will create
keyring like .ima for loading keys and other components can still create
their own keyrings or use existing keyrings. And I can confirm kdump
LUKS support won't be affected. 

-- 
Best regards,
Coiby


