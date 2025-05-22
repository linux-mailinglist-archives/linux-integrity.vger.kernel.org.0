Return-Path: <linux-integrity+bounces-6293-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1114FAC0459
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 08:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8834F4E3EC7
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF8E221293;
	Thu, 22 May 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/o7v4Zk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35A018DF8D
	for <linux-integrity@vger.kernel.org>; Thu, 22 May 2025 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893954; cv=none; b=Tny2UMMxlotIy9hHfzwGrhumAVyhFl149N5Y0H1D7vd4sQoUU1uLBUx6hTGlGMsZ1imgvjCUEsYrxzPl1P5M2Q4cU7cIdC1tPPp/XmMrDZ70n4/rtq/R66sYfhUG912T9910pN+qDfGtGclGukOamhqcnpRFkUcqxKMayUdZ1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893954; c=relaxed/simple;
	bh=I+7T0XWA3psCI0S3YgG5g5cyv/Ez0iIKfqzxER3LdUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjzYeHU13LFS05SDVDOFaM3o30FzvMy27A/3QK0jQ20j9nPJCXcVB71G4Gweha8RE5JSjpCFjUHwcFy/q6aNyJ6wyKkiyXPe1Kd3CAo6sjcbRRTM+FVcGsZkn8X3YTpycumtoz4dGqKI5OUSPPXDqqUVW6gMJGfXzImyMG80kCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/o7v4Zk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747893951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5UcmE338HgvT5w4WTQ/s8ig0Q1beM5AA/bl1F3aF54=;
	b=a/o7v4ZkwmBXwwC5djpQGh5E3iE7kPwsGSehez+eqvdE1PI4tM0QCW4vxC1N52f80gzasr
	MFAPb0E4Ht7tTFAbYx1UlI9eMCArXgaGA15+l7sfAltxz2lTaO/YH84OIEJvt358qdrvh1
	+1Fs9b/FCcHmiWkB9tqKCU1eVN8EAGc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-QEs6Fsz8MYKJBxzUagv5eQ-1; Thu, 22 May 2025 02:05:49 -0400
X-MC-Unique: QEs6Fsz8MYKJBxzUagv5eQ-1
X-Mimecast-MFC-AGG-ID: QEs6Fsz8MYKJBxzUagv5eQ_1747893948
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so524709a12.2
        for <linux-integrity@vger.kernel.org>; Wed, 21 May 2025 23:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747893948; x=1748498748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5UcmE338HgvT5w4WTQ/s8ig0Q1beM5AA/bl1F3aF54=;
        b=rb290KQEaWf6mkaVZtz3yAbkAkMkZ+MimxEHGDAeeH7FkNEyKMK6n8xE7oJXqeHNsK
         GIWp0CPuVFw6PUpvOV+YspnA/kUsw8Xp5ZMKck7fW8aMVLu5sLNaYbDzPhZEF98a6ihl
         r2AMbw+M2QZH0Q1xP2z9OmZl0qGC1VPcGzBF6ZrLuPPhtKV8tt+1LZ0bW7+z0vU8Qa2H
         QYX4O0rn8S8EkXaktcVeOsrbFbJISBL+v0q7h5dVzzk4k9Nt91YezFso7qzKIlGdoQms
         Wx+nWp5R06v3gJhVTTtvQxL7Y7MBkfSJZ690+dsmQlyluDM5Z/F9nkt32SBAwjNDdb0x
         3r1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP19toqivPGNVg/iRuBdERfga0EWooOefFm4YUiwpsTEc35XzvhKibEn5T6awJC7xKuuXwpIX6Yc48X8Qcoiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuUzHGv+rNtlTsl0sNzVg/Z8T/Tv2HDDjMLu0YkAaUskckIGd
	94SOT4lR2DzPI7REZ5lY7HKOM2qgDjpOkjAfu75Y7/jDGVwWK1FbcLhiv48PBG8SxgtSGMpbUPu
	BRSdKTJkNV0xLpBSvbv3IhmU4GhixqMrycGB08R2Qf4IFwjZCyLxCh6c4H1f+9wFaCqbxYA==
X-Gm-Gg: ASbGncv/P7hJc/DNhk+A0yGFJBtppRda/z7wL1Z9yuezAsTLMlfwU3iC3XGaEAic4U0
	fn9NSNOC1dzHEFacYDg06m59nTylt5wXtKTfIoOqHV2lYqKhBVPxSkH9K6WJ7h3eoqvitB9bGAk
	kakFQRh4j1z+T5Y5LnoOWkqnRsBiTCH5j2vzIhh0ZaNshobD53/6AvTWLlNS9iyiBi6e2C9riWx
	ymDsh7YO+lklkwEmI2Q00KfV0S0OsPrw9RAGSzRGkXgkZV8o2hPsLvczvg1XCQQVRll3xuUjRAe
	pp8=
X-Received: by 2002:a05:6a20:12ca:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-21621875ab8mr35263899637.4.1747893948575;
        Wed, 21 May 2025 23:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTFkdwaFGdarcTnLubzQX5o2FjgnhFMq7UwYkJHfRvH9tVaqvdnFp2FCz6WDEjhRKA3X+QBA==
X-Received: by 2002:a05:6a20:12ca:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-21621875ab8mr35263873637.4.1747893948226;
        Wed, 21 May 2025 23:05:48 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a0b19sm10539159a12.74.2025.05.21.23.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 23:05:47 -0700 (PDT)
Date: Thu, 22 May 2025 14:02:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, 
	ruyang@redhat.com, chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <wzquib7u5sycaf5prdgztlcudvaa2kma6jv3zmyfw7krzgnbkp@x2u5vnumfl4v>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>

On Thu, May 22, 2025 at 11:24:13AM +0800, Baoquan He wrote:
>On 05/21/25 at 08:54am, Mimi Zohar wrote:
>> On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
>> > CC kexec list.
>> >
>> > On 05/16/25 at 07:39am, Baoquan He wrote:
>> > > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
>> > > extra memory. It would be very helpful to allow IMA to be disabled for
>> > > kdump kernel.
>
>Thanks a lot for careufl reviewing and great suggestions.
>
>>
>> The real question is not whether kdump needs "IMA", but whether not enabling
>> IMA in the kdump kernel could be abused.  The comments below don't address
>> that question but limit/emphasize, as much as possible, turning IMA off is
>> limited to the kdump kernel.
>
>Are you suggesting removing below paragraph from patch log because they
>are redundant? I can remove it in v2 if yes.

I understand Mimi's suggestion as the commit message should answer the
question why disabling IMA should be limited to kdump.

-- 
Best regards,
Coiby


