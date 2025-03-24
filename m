Return-Path: <linux-integrity+bounces-5403-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E570A6D6D3
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 10:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D137A63B6
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EA225D90A;
	Mon, 24 Mar 2025 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cmdz1vD4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E2E25D8ED
	for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806831; cv=none; b=kVyvKnflYtBM3pB010jl4Cy2X4c7FdnZyp0TLbYzCFBHl1FX0ge2HoBhJCAUFn7ffuznGJjGAcFn2eAq/BSny/MMIs9ALDhNzFjkN05QRLJwHFGR/ehc5AxgEkR5cRpytoarOB7imqdMRC6rwwD1YmcP6n12MKpaUA9+GUq1nFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806831; c=relaxed/simple;
	bh=VtQd7ZzM47zcnMCUYhBnsvT1LXfPEQwzDz8Bh3c7XCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rekl7mCVq781aPJsZwPkWXQhrkuiF2Ct+OoUhpDOYGnhRpSN9KZpCMRRtfmb49cAosBLuQGyNV5hTBHQlGmfqj2wPt0nZqAdVWUmqdtofeKpOz8kaVcnPP6JDiD7h3h0HeztWZob/clOKp0W466jlTfxeGtUPVrH6VoQpID0iUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cmdz1vD4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742806828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtQd7ZzM47zcnMCUYhBnsvT1LXfPEQwzDz8Bh3c7XCo=;
	b=Cmdz1vD4DduND6kKa7mIKltgIZKc2FgVxtKHUlImtr7+jyjPz3N6Nsa/aOB2Zod4LQeGBM
	kGl4nMN6E1zdBMlNifdEn+8QiglAbbJ05253Dux1sMWRGSiziFIlpVdxq+RmqKwbsVl7NF
	gxYHEe+jyYfJDwCpsAglf/S8kXT6zcQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-dgr14XNqNomBDWc3MZkxcg-1; Mon, 24 Mar 2025 05:00:26 -0400
X-MC-Unique: dgr14XNqNomBDWc3MZkxcg-1
X-Mimecast-MFC-AGG-ID: dgr14XNqNomBDWc3MZkxcg_1742806825
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6fecf913cb1so51215747b3.2
        for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 02:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806825; x=1743411625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtQd7ZzM47zcnMCUYhBnsvT1LXfPEQwzDz8Bh3c7XCo=;
        b=QuF1+IHTyFL6eOpRFlvFzybwylO4EO1UIMTzht46GreR6NsuAM1h+3gRO+k8Rx54Sn
         LRAoXmSuTJQIC8tP66bwRQSckW/p5HkOXV0KhKEkKM1t6uhOThQkhB8dzm9d1qoS/+Uk
         zFqDeiBk843won1r+0+wMcZZPAwsEHkrYJ8yWgduI0Zfyq9pc8pfLQRVhERdUeCEtH7G
         44JewvGjTgQFH6h12HOJz+v57fsgXieJv1tCBG5LMVOKmXOGzLO0sm7RtPpNIsmm/zjh
         PQndMlPNuUHV2eykXbsKsR/agmFwEz9un6LEJTcsEIQ2lfx4Z/D8wDDvFaU3P/RlbvFU
         iJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCULR2ceMrdZyz1AcV55aP1uimrVYWb972pBxlt2f3oufgHYxarOnHkCeLsHfSmGrVarx9y70dE+9v3GVCmF9pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCOGGGIJx+8HCrMIecaz8YHShm+w0NN25vqDsvjkEziepMT07
	B133Q1KtmkwQpJGkU0cHYR/1hZAUTm1JxmcHtE7AcpreacioFhldyEx0Ub5En4qmdCwBux162oJ
	D5QRuEWruOLDayewi/zd9fRZARIe+vAIoFN4CT7KUFNZiJk+n5cgiu/wiZgbpMCBnQ/XpSsOF+w
	Fxh3peKASL2sm/4+iVSjr3ZbhxguBJLT8EfW6W/tBb
X-Gm-Gg: ASbGncviXzFbeMaHcQgNNglleHhhWJPCRyqUVcuH9/upUmP4f95ZtAAI8fSN3Ij8zEc
	lYBESCOYsbHKRwOaXtcSVWJ2c7EL7uIGFXqgNTQYJAMFlbhXTPLyCdQUIUUV0yfphBPvDXw==
X-Received: by 2002:a05:690c:3588:b0:6fe:b109:6973 with SMTP id 00721157ae682-700bacfba94mr158096057b3.24.1742806825345;
        Mon, 24 Mar 2025 02:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrUHGJpHADoIDbX/Sou896YczE/U5d5SAf7THitdTqPnQR8uE2GhDufDdh/tsFnucbOoNKGD29uDDAHCwOw5c=
X-Received: by 2002:a05:690c:3588:b0:6fe:b109:6973 with SMTP id
 00721157ae682-700bacfba94mr158095497b3.24.1742806824797; Mon, 24 Mar 2025
 02:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311094225.35129-1-sgarzare@redhat.com> <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com> <Z9glWp6U6vyEmKQa@kernel.org>
 <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
 <Z9wuLVeP726Cssqp@kernel.org> <20250320171619.GOZ9xNY4W54avW2a-u@fat_crate.local>
 <Z9xQw8QpRKk26G6R@kernel.org> <rspkz663fg7i7jomvg5ehv3ldr6ayehttb7vgwwzsfsxafzb5y@uhqcadvsmw6f>
 <20250321220520.GFZ93ioO0JtfhXCb1n@fat_crate.local> <Z98av2cbURhSy6Rk@kernel.org>
In-Reply-To: <Z98av2cbURhSy6Rk@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 24 Mar 2025 10:00:13 +0100
X-Gm-Features: AQ5f1Jq8rkzGdhbXeWVtUWD697l_-G9Y-_hvBqVxJBnsvHw0N0RMVXOA163V3KQ
Message-ID: <CAGxU2F68_3nAzgPNj0m1SX-RPumuM2utX6B0-s4GDvFixJmt7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command functions
To: Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 22, 2025 at 10:17:03PM +0200, Jarkko Sakkinen wrote:
>On Fri, Mar 21, 2025 at 11:05:20PM +0100, Borislav Petkov wrote:
>> On Fri, Mar 21, 2025 at 10:01:17AM +0100, Stefano Garzarella wrote:
>> > Just a note, patch 2 adds `include/linux/svsm_vtpm.h`, that file is
>> > basically a translation of the AMD SVSM specification into structures and
>> > functions used to communicate with SVSM in the way it is defined by the
>> > specification.
>> >
>> > I realized that the file does not fall under any section of MAINTAINERS.
>> > How do you suggest we proceed?
>> >
>> > Should we create an SVSM section to maintain it, including the TPM driver
>> > and future other drivers,etc.?
>>
>> This all belongs to the TPM drivers, right?

For now yes, we may have other devices in the future, but we can think
about that later.

>>
>> I.e., drivers/char/tpm/
>>
>> So I guess add that header to the TPM DEVICE DRIVER section if the gents there
>> are fine with it...
>
>It's fine for me but I'd suggest to rename the header as "tpm_svsm.h".
>Then this will already provide coverage:
>
>https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=a2fbcecc7027944a2ce447d4dd72725c5822321f
>

Great, I'll rename it and send v4.

Thanks,
Stefano


