Return-Path: <linux-integrity+bounces-5545-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6DDA78A48
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 10:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69181188CA2C
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22716235374;
	Wed,  2 Apr 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0tXi31L"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6621D233717
	for <linux-integrity@vger.kernel.org>; Wed,  2 Apr 2025 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743583510; cv=none; b=GzLSfra6oCULM7WZtLRjWqJ9DB+CT81wykdOMAuS45IR7PlQHGilacNNmjA0Q8DoJRgNEPH5ivs0IHR3bWy9sQBqlhYP2kW5dUTwLpARqVHQb+KZzD7Xg56GoOIrTMUtIM5q56sLidAH3jIrz9CuIkbVv0yK6zTXbC4Nnie/clY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743583510; c=relaxed/simple;
	bh=Uc5r9Pum9uvTB/QYxEY2UG6XLU3qWRi+aBx+8XgGtPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9ka8yCAiVJsrjuhfFAcYOe/lNePWu8jrqSRPtamywwAm3LEvFFEeRd1oeE9AICFBswIrGlaK8pSMvJVoIDxEcCXOqG7l2TW+UrHTdNH6N3E8v51ZyoDn6t+/jyRN0WVFspMdO0oHN7fawikeTlZMfY1GCegDQUoWOf25gGFh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0tXi31L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743583507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ5rqwO2zrtxM+k33EU2A19c926SMTdHUn2V9GINfc4=;
	b=e0tXi31LuDdd+DBMtJxSQU0zP7lqB2vYO6eLFGcF7fNPN9g4MAbB7Qi82MJR1nzvyELnGd
	tw15lrRrR1Ji0XWAt5kUbAeHPjEYnERgqkybISfXNKRce1yaNgpk+P/RYEZMIYsTEiiOMg
	c0pTx2YfOTafYSyjqD2kV4MAO6oW0ok=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-aUYAfvtwMCeSABnp27WAKw-1; Wed, 02 Apr 2025 04:45:05 -0400
X-MC-Unique: aUYAfvtwMCeSABnp27WAKw-1
X-Mimecast-MFC-AGG-ID: aUYAfvtwMCeSABnp27WAKw_1743583505
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3055f2e1486so6144920a91.0
        for <linux-integrity@vger.kernel.org>; Wed, 02 Apr 2025 01:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743583505; x=1744188305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ5rqwO2zrtxM+k33EU2A19c926SMTdHUn2V9GINfc4=;
        b=tBDkNZIDjsVDonygQnbjCZNFM9CYJ+C78qH4f7EDZrJGy7OHYBHO2mb6hmVYKrxdXE
         FZQkt7JoEYJ0inYE0b2wxWgNhC8LaIHtBiqf3eG6lYcaqOm4ooy8leMkSsLPrfLa3nag
         nNM7e1ACRCkTEkq12K/e8Bx4onOfirHOUeQXn6P8pvZTRmotZh7boBB7F9PatH9VkJXm
         1oC1FG2/5fjAj6GFnoepbM0Kyx4iS37BPYxKcqs+cyYRwt2UV9/50W21/PohNWZvtPpd
         O3JdJefuwfIy3VZVQ/YY1ZzkMQah9KvchSsDBujgdl/KVdPk78XmSwynfTYnLettCKV7
         J+1g==
X-Forwarded-Encrypted: i=1; AJvYcCX4uztwCTt5Ob1QE3pBd30qedUIJxayweL9UAbasuiCSzkXiWHL8GVppte0bZnxMUpTV4b3qLZeZAet8m2imGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwINOctb5nzLI4Ttm3aZX30GBDSme7TCYeFz4WxLWlSCJNzCICW
	sMgOkUxv1Zq6vRAVxgqvtrLcbCmcdbhbXULODg5autnhmuVsXpN+y2ImxP4DT3nOa8VGg3D/T8s
	Nnkxr1oeS9qo0/PGsIWc6mr7tvr7+Wr80YGeN3YGMKbizUFduRHNqIDotTCpt0Pxlkw==
X-Gm-Gg: ASbGnculpij8aj/gEG5caB6xhuI98BlRUoX2XkgvS/AeQeQFcGZsGbjDqA6wOf5cVCi
	KOidyLst0i32EmCurdWDB0nWZ+gnnOqBPzvOmjaR/EGk+7np0dJkos95tMyYo++inYJIGQgQXt9
	n9HvK2YihG7DRALxUXOs8AgSbO2phfMJT5/+s/DcbxjqLirh5gl0y8TMLDb25KciKy+qe6XVrv4
	Kr8EHufH60ynUKwPAR9tO/HOOYY5PpNSqduTCf8uESPZOjeCvCKeWeqRTNiP8RYOi5HV3fKZ1no
	hRUBmVc=
X-Received: by 2002:a05:6a20:c701:b0:1f5:8e54:9f10 with SMTP id adf61e73a8af0-2009f75b1b3mr27633103637.34.1743583504725;
        Wed, 02 Apr 2025 01:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNqPrnFWcI0KzZugfSso7yYOl9ecVA4ev8O29z9DMGZUP9V1eMmmdV9OaMRWROghUGsvpHHA==
X-Received: by 2002:a05:6a20:c701:b0:1f5:8e54:9f10 with SMTP id adf61e73a8af0-2009f75b1b3mr27633077637.34.1743583504369;
        Wed, 02 Apr 2025 01:45:04 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710636aesm10725535b3a.91.2025.04.02.01.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:45:03 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:43:57 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, RuiRui Yang <ruyang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
References: <20250331061611.253919-1-bhe@redhat.com>
 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>

On Tue, Apr 01, 2025 at 11:30:09PM -0400, Mimi Zohar wrote:
>On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
[...]
>> > > that.  Please don't make it generic like this.
>> > >
>> > > Please refer to ima_appraise_parse_cmdline().
>> >
>> > Hi Mimi,
>> >
>> > To save memory for kdump, it seems init_ima has been to be skipped thus
>> > ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
>> > you have any specific concerns in mind?
>>
>> I think as Mimi said see below logic enforces the IMA even with the
>> cmdline disabling, see ima_appraise_parse_cmdline:
>> if (sb_state) {
>>                 if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
>>                         pr_info("Secure boot enabled: ignoring
>> ima_appraise=%s option",
>>                                 str);
>>         } else {
>>                 ima_appraise = appraisal_state;
>>         }

Thanks for pointing me to the above code! Note with the whole IMA
disabled as done by this patch, the above code will not run so IMA
(appraisal) won't be enforced.

>
>Thanks, RuiRui.
>

Mimi, so do I understand it correctly that your want IMA-appraisal to be
always enabled as long as secure boot is enabled even if users choose to
disable IMA? I wonder what security issue will it bring if this promise
gets broken considering other LSMs can SELinux can be disabled when
secure boot is enabled?

>Coiby, would disabling just IMA-measurement, as opposed to IMA-appraisal, save
>sufficient memory for kdump?

For disabling just IMA-measurement, do you mean not enabling any measure
rules?  The more memory reserved for the kdump kernel, the less memory
can be used by the 1st kernel. So from the perfective of kdump, we try
to make the memory footprint as smaller as possible. 

Baoquan, do you have any statistics about the memory overhead of IMA?


-- 
Best regards,
Coiby


