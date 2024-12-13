Return-Path: <linux-integrity+bounces-4382-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4154E9F0B9B
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 12:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823B41886478
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD021DE3BD;
	Fri, 13 Dec 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb0fMbi9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02311C3C16
	for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090543; cv=none; b=hq/YT/tT4wt4cyj6YX+LgbHZNFB76VzN05gMbm5Jmn+tkxBKGKzFgfwbGgVIG1KjPzMBY+GNhTHfqUxzt/gKc4pH0fbsbLaoS0haa5qFr7AYoGV1lYgv/bbt3SrR+Hcdo39vnQEZwhoym+5hpqm1KIc1NdQbhHqrO7vSxgc4sh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090543; c=relaxed/simple;
	bh=QGT2SF2RrviqaJQfbCFot02KwB9XhZnwgAtpBU5l9lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7v91nKoDn/utZrYimx9djnG22G05tWdERdnWZBBMQSmaBg2vdjRIZZEbYz8zBUB9EP9onft0YDhyHZWApJMmud6fPyP03JEPz47OfVBE80N7LweIx7CypxBPbAiCJFYIsiJc+fll2TtbG7WddofhLx30TxIqi67YnvDjfyqry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb0fMbi9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734090540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pp0PgMN56ieGrHNFi7i6KMaUXuRE1vzehzF7+bFcb8=;
	b=eb0fMbi9csmZfFfgPdJx+nxNirr1mG1/M3KNyn+pooCoxN1B1UAjZ+CMFF5n7+Ug51GDej
	ZgbQ2yvjb+69Tf+lPASDUi49dDcxuwtj3Ib85NDuozXVp6szWwB/JxSyEV+T+gFFc7ym4s
	qEu8tXybX3sjFKadNQIpDMgYSy+rL1E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-eF2oTXVgPKufM79Kz_27XQ-1; Fri, 13 Dec 2024 06:48:59 -0500
X-MC-Unique: eF2oTXVgPKufM79Kz_27XQ-1
X-Mimecast-MFC-AGG-ID: eF2oTXVgPKufM79Kz_27XQ
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d88833dffcso24913706d6.0
        for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 03:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090539; x=1734695339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Pp0PgMN56ieGrHNFi7i6KMaUXuRE1vzehzF7+bFcb8=;
        b=P8UxM4zjx2EMP5nZ0cqj/AM4ML0F8Z3f/qEPZVf7/4mNRMz2HszmRueYSBFk50ZDHR
         JKaCLLRJbMfbDN9rZtb4UtBYcxgBYWbdxMO4on2LXF0hb42bGT1nr7/O13+jEH0iQ5Aj
         5n7zf9qjn+XbpTo2tSAseVjTxNdUKhkRhoKKhMDS49TyK8ldXkzcdN6nKgwN8yZ69aK5
         ILo6jyLQdZwfCV2e5Mx4+FlqDdaZZaA973a3vmLAjGst7UqxfUZOusWTzQK+5m4Y0dQ+
         ObRPU+xwsyn2gAafl7j7A6PR2FZASnnt4+02QXn22ML7gBpjEvvWyBWqE9OWQ+KRzJBY
         xbtg==
X-Forwarded-Encrypted: i=1; AJvYcCVOrP6eG1IFUaO+BMbKZGUUDvAnM3Yyfl/4CU0tlpg5OvCYpsvaLwEIZ5ZrNqVVaHbaFvuPeC6L9eKJA6V6rHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3md5AQE48SX5mEZpyDoDjE6iTO6ppY6nPeN1ipjrqLo2/+PZz
	fvFVWeG+RU7P5wCshiq1oynlRn87CUFRSh5e2yvcotmnXaeJZm4qxeaAGulSzhPBJBVtmO27pc4
	0Awu8IPnqVGrkk4HaUjXloUEKNg83BBBiSBn8XRXtmdDpVl3F2oSPp/dlJ7Vvwm0EYw==
X-Gm-Gg: ASbGncvryHWUMymta6f36zeg4sYajwALtwDCCXqEF55BKO2n4XSYnAOfjzTcQG8+q1U
	+qUKwzYw9BA1bPjtP4Xnyk1q5EdDIp5uZDQdjJl/SsKbo/GM7Y1w1u13ftjhuGHKGfPiwYSbGyi
	m63qLSgVn8TQz8I3GqLg5RExOmsTliHTDZ+4c6KOkFs5yiwPl98Io9AxQoxLGS52GqK0kX8WwlL
	vm/SP/7ZKbNuXe4A6q8yivy7HxlDGfXn+SCTkcliocMkqqRm4KS6oKo1GhFvGoVfDMCP2oNjGpa
	lLQi87DfC59pj/U1TWRQT+x5U85fmNAM
X-Received: by 2002:a05:6214:2622:b0:6d8:a5dc:866e with SMTP id 6a1803df08f44-6dc96998c54mr41274776d6.47.1734090539051;
        Fri, 13 Dec 2024 03:48:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVe9Bmg971vhiBdlReKshUrR7Ut9jwZGEsYOm0pIixkfuL80sk4rWNQhEv9/FV31WsOy9c9w==
X-Received: by 2002:a05:6214:2622:b0:6d8:a5dc:866e with SMTP id 6a1803df08f44-6dc96998c54mr41274186d6.47.1734090538603;
        Fri, 13 Dec 2024 03:48:58 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da673441sm90963686d6.1.2024.12.13.03.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:48:58 -0800 (PST)
Date: Fri, 13 Dec 2024 12:48:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-integrity@vger.kernel.org, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <4valfkw7wtx3fpdv2qbymzggcu7mp4mhkd65j5q7zncs2dzorc@jjjevuwfchgl>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <f8c6c1e0-a42d-6fa6-a10e-925592d7992f@amd.com>
 <9083d4cd50649ea1971e31445c554f44e8d12bf9.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9083d4cd50649ea1971e31445c554f44e8d12bf9.camel@HansenPartnership.com>

On Wed, Dec 11, 2024 at 12:02:49PM -0500, James Bottomley wrote:
>On Wed, 2024-12-11 at 10:30 -0600, Tom Lendacky wrote:
>> On 12/10/24 08:34, Stefano Garzarella wrote:
>[...]
>> > +static bool is_svsm_vtpm_send_command_supported(void)
>> > +{
>> > +       struct svsm_call call = {};
>> > +       u64 send_cmd_mask = 0;
>> > +       u64 platform_cmds;
>> > +       u64 features;
>> > +       int ret;
>> > +
>> > +       call.caa = svsm_get_caa();
>> > +       call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
>> > +
>> > +       ret = svsm_perform_call_protocol(&call);
>> > +
>> > +       if (ret != SVSM_SUCCESS)
>> > +               return false;
>> > +
>> > +       features = call.rdx_out;
>> > +       platform_cmds = call.rcx_out;
>> > +
>> > +       /* No feature supported, it must be zero */
>> > +       if (features)
>> > +               return false;
>>
>> I think this check should be removed. The SVSM currently returns all
>> zeroes for the features to allow for future support. If a new feature
>> is added in the future, this then allows a driver that supports that
>> feature to operate with a version of an SVSM that doesn't have that
>> feature implemented. It also allows a version of the driver that
>> doesn't know about that feature to work with an SVSM that has that
>> feature.
>>
>> A feature added to the vTPM shouldn't alter the behavior of something
>> that isn't using or understands that feature.
>
>I actually don't think this matters, because I can't see any reason to
>use the SVSM features flag for the vTPM.  The reason is that the TPM
>itself contains a versioned feature mechanism that external programs
>already use, so there's no real need to duplicate it.
>
>That said, I'm happy with either keeping or removing this.

If we remove the check, should we print some warning if `feature` is not 
0 or just ignore it?

Thanks,
Stefano


