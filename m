Return-Path: <linux-integrity+bounces-5881-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08DBA896F2
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 10:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EBE3ADC5D
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229F250C08;
	Tue, 15 Apr 2025 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUxLxY0v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393418D65E
	for <linux-integrity@vger.kernel.org>; Tue, 15 Apr 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706523; cv=none; b=tIFDAhHs2W0tQA6ilGQiEPGKm9GH9rM2zq2DlnknQlf62IgEOAKuFGYcYVohRnFrhyUhwcCsPa4o7eRiKTLfC3ocRnAXlijmqZKqkll/HREnKHpYfcYIj0/plRO+xkrNvGZ17QyuJcWdwvVGeXsahMWwp4nseNWKzlV2bavHZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706523; c=relaxed/simple;
	bh=MHKkf2eTQKJSDUVgrB+fzpXdXVMv5f/0cBZlNz363RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwscpzdnK4uOw1oiH1HZPYWDGZmbuoP/+VTm3sEG1q2ECZKr3myvyn9oQuWRFjlVN60U6FDWc+rz9JCu26kUtAGJQkihJuQbUxAq24lc3lbYx38nTCSOUCthtB0/JZfTwSQoBgipsD4IRIs+cIZjQXmtaWLTMxJtRPYDoze4SYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUxLxY0v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744706520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQgMM1c/L1dY1ZPWx+Tr6nBOMEoSGXdQFR50SH8ffA8=;
	b=QUxLxY0v173+svns+yhNDGRuiFfFljRfow/rU7jsS750Vx45P982pQOytQOuJbC0HmOsMX
	9wH+/AyOikWSdgKnEfWgszauBCYQbO/t7SCMmOht/LWTGclxWROA6s8UqReqIrWvGseXC9
	6qmohBUzQ5K7xM77X3sLa+RU8nDgx+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-La_acylzOxeokKKRbQ1wGA-1; Tue, 15 Apr 2025 04:41:58 -0400
X-MC-Unique: La_acylzOxeokKKRbQ1wGA-1
X-Mimecast-MFC-AGG-ID: La_acylzOxeokKKRbQ1wGA_1744706517
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947a0919aso35970095e9.0
        for <linux-integrity@vger.kernel.org>; Tue, 15 Apr 2025 01:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744706517; x=1745311317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQgMM1c/L1dY1ZPWx+Tr6nBOMEoSGXdQFR50SH8ffA8=;
        b=d/iRNBFg2r+JHvAglKCYQDLs+3oaeloCX0BXe9YSFVH2dwl+JKx4xhqdr+PTRg5TBS
         0pujwpH1zya5FBmmn47Y92paPzwT2xwPkfKKLNNnK16qmYb5k+9nSLh/xPr6RtcHrFIY
         8mAcXsymJeqcNkPYYFlQCo2AmcNPIbQ4a23ByOMG1UovdcJ2HynLY2cnyzhSUNlFoYJl
         jFU8LY5EAymWioLK2oC3hvefI0pf39gWdPRtatVq9jXNVckT90jr6Z1PCrHNFOeMICiI
         S8rTOjzsmiS4bcyvAya3sPEfO8m8NkiDD0RKnp/rcNpqyoimxwjgm1ToJ5PR3+qbWhAv
         GwXw==
X-Forwarded-Encrypted: i=1; AJvYcCXZQqLoo1S1EKysG2pVUSQSq6Nqg0OSWdlgmzK80jETijMzMm8gfqNNeK7ztXl5I7QkSBJakF/YVJp+m1mTSs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkLm4LsCKELUG8h65V10GIjKoyQ9gRd4xwo1LesGjw+BqWHCU
	DMuCfwGluTO42HEzMJRRYUGSz0pfdLq/OIpeZM6jxIqVxz73QWdZVH5C4+mosjb494N0Tfk0qnz
	gBfN4rNova1K4AeEH/4hazOa/qqgWslpUl2TBH7IY5/rRXuZ1aPiBxpop1gLi5Pd/Lg==
X-Gm-Gg: ASbGnctja12L9azV5fxS5r9EZx122+nJct8i7rRFd9TuXlaLnq99tIlPCGvDFIjhpy/
	gMU7lTyfQzqZamEUIW9DVsgo4unzXFfmeqi720hBS1J/arZGD7cwxNl/3pJbkHOWuQYlsyzFns7
	R9tAxBD1MB8AZmbw/T8czncaeNAee0XlHUq9U0Tb46juB0CWiJjLfKZJ5vDiFRe651Msx++AcFS
	cT2yXjNEGWNFplcEHcFpdk7hS1g/pQxu8vKQus5/kCAmPK074zPuefVbcGXd0n3WRmurbo0FVxB
	hlojk6EmpW+LBlCDMg==
X-Received: by 2002:a05:600c:1d08:b0:43c:fe9f:ab90 with SMTP id 5b1f17b1804b1-43f3a9aefc4mr100464835e9.28.1744706516958;
        Tue, 15 Apr 2025 01:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/OMyHwno+9Cfn8yM66f8zcKW4KPSM63TW50jawT4VK4YHrLWm5KRsF4/mSRxZf7hHDZfrvA==
X-Received: by 2002:a05:600c:1d08:b0:43c:fe9f:ab90 with SMTP id 5b1f17b1804b1-43f3a9aefc4mr100464635e9.28.1744706516527;
        Tue, 15 Apr 2025 01:41:56 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.162.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cdfdsm13750153f8f.61.2025.04.15.01.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 01:41:55 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:41:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	sudeep.holla@arm.com, stuart.yoder@arm.com, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tpm_crb_ffa: use dev_xx() macro to print log
Message-ID: <yglnqdykvvof7iwviaacqnmmoanhhoefgmaulw7nrlf6zotbgj@obuqtycczzm7>
References: <20250415075712.2157073-1-yeoreum.yun@arm.com>
 <20250415075712.2157073-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250415075712.2157073-3-yeoreum.yun@arm.com>

On Tue, Apr 15, 2025 at 08:57:12AM +0100, Yeoreum Yun wrote:
>Instread of pr_xxx() macro, use dev_xxx() to print log.
>
>Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>---
> drivers/char/tpm/tpm_crb_ffa.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
>index fed775cf53ab..0bb8098e93ae 100644
>--- a/drivers/char/tpm/tpm_crb_ffa.c
>+++ b/drivers/char/tpm/tpm_crb_ffa.c
>@@ -303,7 +303,7 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
>
> 	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
> 	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {
>-		pr_err("TPM partition doesn't support direct message receive.\n");
>+		dev_warn(&ffa_dev->dev, "partition doesn't support direct message receive.\n");

It's pre-existent, but since we are here, should we put \n also in the 
other messages besides this one?

That said, maybe I'd mention in the commit message that we changed some 
errors to warnings and why.

Thanks,
Stefano

> 		return -EINVAL;
> 	}
>
>@@ -324,17 +324,17 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
> 	rc = tpm_crb_ffa_get_interface_version(&tpm_crb_ffa->major_version,
> 					       &tpm_crb_ffa->minor_version);
> 	if (rc) {
>-		pr_err("failed to get crb interface version. rc:%d", rc);
>+		dev_err(&ffa_dev->dev, "failed to get crb interface version. rc:%d", rc);
> 		goto out;
> 	}
>
>-	pr_info("ABI version %u.%u", tpm_crb_ffa->major_version,
>+	dev_info(&ffa_dev->dev, "ABI version %u.%u", tpm_crb_ffa->major_version,
> 		tpm_crb_ffa->minor_version);
>
> 	if (tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR ||
> 	    (tpm_crb_ffa->minor_version > 0 &&
> 	    tpm_crb_ffa->minor_version < CRB_FFA_VERSION_MINOR)) {
>-		pr_err("Incompatible ABI version");
>+		dev_warn(&ffa_dev->dev, "Incompatible ABI version");
> 		goto out;
> 	}
>
>-- 
>LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>


