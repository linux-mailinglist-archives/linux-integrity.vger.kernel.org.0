Return-Path: <linux-integrity+bounces-5208-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B6FA596DE
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 15:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88347A6368
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5522B8B1;
	Mon, 10 Mar 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGfbJCB3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948022B5B6
	for <linux-integrity@vger.kernel.org>; Mon, 10 Mar 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615197; cv=none; b=mQf/+Fc9klW9Ua+dclbhZgdeOpjbL3TJJEUCP/MeR0KRNar4BbNIZ+UpL4Q12mKthKeSBx970Z1kxMaSUREfKxxs1kZd5/6vvTSoLlugwfBEHI5XVT4uCT4v5fXcDJzOtpZF1RITP/6iaZr+eMOLtSOmiS+vcwZzZu3JbS9Vetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615197; c=relaxed/simple;
	bh=5yRa8msLShePncZ4iDaj+ETPUsYjrQ57wsSamBBpqFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrOjtttYds+b1TsfZfAiJNvNkjJYlvrR8dSqZLr2NS/Iwema/lNbsvMNznrK68MZlKWXNjqUbWAMxDwC/CEzTlwJVQS7+ZKTvczZ6HhKfo6fGgt3mvo5aGJi54O1/CtimVl79CRXWwMBu+nV1GssIMVT931myAdUKxW8RdpR4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGfbJCB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741615193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifLyZAwaMIQnJH8LV9Yf25LDs5jy6kdU3M/pInj3w4g=;
	b=CGfbJCB3h74hfYh9wvbwHoAqsZ4D5zYvleITVtJeT+Fl1BKy0jj/NMtsYdyeoO20obKDqZ
	JKhhgZrZzqa60YeqCuqhrOCPox2zJdobkp+HLaw5ewmWT8XvHqfWUFQ+dIVCyWoK8DqSqh
	kIvccIwUKI/qIJP0j1vsD3eCszoFazk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-gKI5my7lOI20PTMKZtQ4ZA-1; Mon, 10 Mar 2025 09:59:52 -0400
X-MC-Unique: gKI5my7lOI20PTMKZtQ4ZA-1
X-Mimecast-MFC-AGG-ID: gKI5my7lOI20PTMKZtQ4ZA_1741615191
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so6280395e9.3
        for <linux-integrity@vger.kernel.org>; Mon, 10 Mar 2025 06:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615191; x=1742219991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifLyZAwaMIQnJH8LV9Yf25LDs5jy6kdU3M/pInj3w4g=;
        b=xHM3u7BadADypWH7MuLZZYpGJ5+GSzQhqSSXIv5rglDHHOmLwwnGeXfRpuW4T0B9Z1
         BQby67pb73yYgHCUuAGkNCBRxX5YIvJXfmXQN4QGHtZx0CYocxTzo4XCEzUR753Vkewz
         mXwvbz7BIu2F0wB0lf4hPc24ozE62kW84GlkLnbuydqK7T7JUZFuGUyxwaB0h4rrerqt
         6sgDUMUFl6EDitncuunlzCYDWHNd7uhGVXs88CCSYX8jBWpHFBBTqpvql4lKix7BbUG/
         1GRbQa0RGgRCZ08cY8jSbLZxxsspiHJgQv4nisEBlAYzKJ4TeFqsS15lkDTau1NRJbS2
         gIAA==
X-Forwarded-Encrypted: i=1; AJvYcCUeo4IyeMUu0JBuJMbH2Ks0jyJ0hCxxLgeOtJxCxACO/yakFdmX4K1TmcuhZoSjG/+VeoMpRC7Zcvgkozz2aek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0J+eCKLKqZLkrsTaYcy4zfQjENsb119malcuq0TerjGxWWIP
	/viSRvbUG7P+gg0+Tv1mupeFHi7Jz2T6FBuPugTO1cfRhlTQ0EQv7Ok64EvMrBR1i3+eYSgcbI8
	JULcy6DGCJN/Ki3ikFgAZX80tmkare6a0KMts7O2YMEXLowKGxg/Xl+5yEzoeuBqIyYU9Kk0kug
	==
X-Gm-Gg: ASbGncvqiHz5odbNK/6a9i3MGzlmQAdCZXJ+xW/75daUFQYAqXa4f2jFIS722TFbJpc
	68LxX2VAlc84u/qg7GlFbgFbaXTvqGUW3lHkYNg+IE8QlskxZX/MVph1OvMkGzmgzYe36KosTht
	Pfl4HLS5seKBCHMzUjcatcHf6gq0NwTMFQ4m+BbkTP+X8crKrlXvBY/4njxrR2BADVqHbN49SMD
	GXi6O/2II6eFpGEjEI+1L78+01cH1LJ/KalqycRIx9CfFhwejBJofaQXWswAR50K6Pp5c9RuWJR
	hR8eYp8ktkMmUaRO+O8/mBktMlX8OJsV+pf1vAgqYKoxaXdYSQmDp279Fhcc9yCs
X-Received: by 2002:a05:600c:19cd:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43cf1b81b78mr36929225e9.30.1741615190715;
        Mon, 10 Mar 2025 06:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFmVHuNChMNNNrFWHjGJdn1345A9IsanbdgH+oWygKlCfwy44eSx0LLGJRthRLUF/igUx+qA==
X-Received: by 2002:a05:600c:19cd:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43cf1b81b78mr36928725e9.30.1741615190121;
        Mon, 10 Mar 2025 06:59:50 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceeb5995esm64570735e9.16.2025.03.10.06.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:59:49 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:59:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 2/6] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <6yzzspawrp6lg3m242bcdl5egpdvt6je2kc3cuznnnze7iypc7@4uaonepi7myq>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-3-sgarzare@redhat.com>
 <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>
 <mjftygohmhgs6daqvgkh2jbfuqjquchcaovcjtnzyhilnt5ww5@l3fr7phqh2ps>
 <3dd645f2-476a-d0d5-c8c1-c87307f2d756@amd.com>
 <20250310135133.GIZ87uZZNhNSkmxvg1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250310135133.GIZ87uZZNhNSkmxvg1@fat_crate.local>

On Mon, Mar 10, 2025 at 02:51:33PM +0100, Borislav Petkov wrote:
>On Mon, Mar 10, 2025 at 08:27:37AM -0500, Tom Lendacky wrote:
>> I don't think anything needs to be checked or printed.
>
>Yes.

Ack, I removed the check and the print.

@Boris I also removed `ret` to continue the slimming, so the end
result should be this:

bool snp_svsm_vtpm_probe(void)
{
	struct svsm_call call = {};

	/* The vTPM device is available only if a SVSM is present */
	if (!snp_vmpl)
		return false;

	call.caa = svsm_get_caa();
	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);

	if (svsm_perform_call_protocol(&call))
		return false;

	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
}

Quite nice, thanks for the review!
Stefano


