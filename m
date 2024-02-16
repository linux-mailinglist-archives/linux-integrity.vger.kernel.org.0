Return-Path: <linux-integrity+bounces-1282-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D106857B51
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Feb 2024 12:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5161C218A9
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Feb 2024 11:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62E59B57;
	Fri, 16 Feb 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwTlM3H6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F559B47
	for <linux-integrity@vger.kernel.org>; Fri, 16 Feb 2024 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082139; cv=none; b=dBTWel58GQoPL7rz57jYlNjoEZZe/u+IjhIll1edDZi5Y9oRNOoZiNh5xjVyCiIB2QaU7/S4QI41rdZvtSCgZQU3zgL2TxGAgnumIJQxdARgFgXb+XFX0tFP241i6MaZzGuQrhUmDU3h9BKVglgMBL1Q2O4UT1shkxuVzqexTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082139; c=relaxed/simple;
	bh=gcI2zFkiJLvsn0nkNdjmzHtooKW+t6UPU/213ASspKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA4BlMjotbxyyxeCflbp9VsQeQTH6cOXAD17E4dPZwcY77mkltva7sylhgTi44BQCsNmo4jSzg5tm1SC/sZ/gzxH0lwkco7rZSNH7UM5JgREGahcqgYVEEHyKW9AaS0OpwMExckzWMmrufzGUornuDVpl1x0zu6cAt1RSHKIEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwTlM3H6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cWx2BjWmlnNzwn5DMsMis1QLNV5jlo2UreFfpR6bCh4=;
	b=YwTlM3H6vy9Myx0Rj8AlQpESWrNgrfqqbB0kjz3TvlnTQzuhZWVuDxYuJKVs9IdNSiHgRP
	ysMFxKeO31+rqVa1WdeOW1gLdULLF03r/ZJqZfA08YRiWWwwz75HNPbLSmk+YvzSzLa0Wd
	88U3P8KAGpES1oNhHe/48j38sSQhpfg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-nwmptuvvPdO-hZzdh_Wtdg-1; Fri, 16 Feb 2024 06:15:35 -0500
X-MC-Unique: nwmptuvvPdO-hZzdh_Wtdg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-59fa26aae1cso254098eaf.3
        for <linux-integrity@vger.kernel.org>; Fri, 16 Feb 2024 03:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082134; x=1708686934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWx2BjWmlnNzwn5DMsMis1QLNV5jlo2UreFfpR6bCh4=;
        b=lKOpihivSnJI/ONm4604E0IpWwlLypSuuKX3gYBWOBIpl33mxXC1UOsyu3FZEElDwu
         btxwQUSU38y4/Z+RXiyKifIa9V+HN2z46U/UrQxhkrCF9EoH/t9LfyJY9FAADlf5iEy8
         TP5UhSOr3kGI/OunaFf+vtiI9j1dsl393DdmRByKibqYWA9XI5cx0w4FHCc0cKxtMX71
         TCfVMBqxxP12+tB3NGHlzqBqFSA9zff7MJZuuXeiu9dB1mjn3Cm3Mo7G4Pah8PgyjHRg
         qBuEBwXFg1JxgekQf+Dy8J9TjSLyPEASlCt1CqKleIpQTkDugh1X2MtVKtC8zgaFycCg
         Rfeg==
X-Forwarded-Encrypted: i=1; AJvYcCV4G4ztbodRGnCAZ7GPFZFs5yQK73IH9ZIah3iPN6Yp7LxtoOkAgijTOEekmp+cEQSgkgET80blGELOn95iPaKeUUsahAcdzblkeYMqVWnq
X-Gm-Message-State: AOJu0Yz1wna5ww4+h0u257OEXgMgkO0Ljl8OrYW8uul8ob75BRlebJKg
	MU+a6l6fzyGbZg9iIEI3fdBD7L8rdR6v2+ZGiVME9MEoeXtSLPLDBmGuLsa3xHPgcW1VjNGo3l3
	kguwPLZmzFXo2t7zrwhjp0+r3f6RhjM72qjgzG9RxXFQbtORAMLBEHNnH4sSTfKnYvg==
X-Received: by 2002:a05:6358:e484:b0:178:fcd3:c316 with SMTP id by4-20020a056358e48400b00178fcd3c316mr3862964rwb.19.1708082134432;
        Fri, 16 Feb 2024 03:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEXFS/6A1CU+tkZCl3LqWZoyfkFXBbtOqi684Tub/2r8HFJl2wD8ae/14lEfYPwMipCFTwvg==
X-Received: by 2002:a05:6358:e484:b0:178:fcd3:c316 with SMTP id by4-20020a056358e48400b00178fcd3c316mr3862947rwb.19.1708082133984;
        Fri, 16 Feb 2024 03:15:33 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w21-20020aa78595000000b006dd843734c8sm2854143pfn.81.2024.02.16.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:15:33 -0800 (PST)
Date: Fri, 16 Feb 2024 19:10:41 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: itrymybest80@protonmail.com, Eric Snowberg <eric.snowberg@oracle.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] integrity: eliminate unnecessary "Problem loading
 X.509 certificate" msg
Message-ID: <pgwe5qhu7j3t7l37d3tj2nf6wpcjfonxonxjk4ozpinbhl4llr@g5ddvx7cgqsk>
References: <20231227044156.166009-1-coxu@redhat.com>
 <20240109002429.1129950-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240109002429.1129950-1-coxu@redhat.com>

Hi Mimi,

Could you take a look at this version of patch? If it escaped your
attention because it got buried in the same thread, sorry for that. And
I won't send new version as a reply to previous version in the future.

On Tue, Jan 09, 2024 at 08:24:28AM +0800, Coiby Xu wrote:
>Currently when the kernel fails to add a cert to the .machine keyring,
>it will throw an error immediately in the function integrity_add_key.
>
>Since the kernel will try adding to the .platform keyring next or throw
>an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>so there is no need to throw an error immediately in integrity_add_key.
>
>Reported-by: itrymybest80@protonmail.com
>Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
>Fixes: d19967764ba8 ("integrity: Introduce a Linux keyring called machine")
>Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
>v2
> - improve patch subject [Mimi]
> - add Fixes tag [Jarkko]
> - add Reviewed-by tag from Eric
>---
> security/integrity/digsig.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
>index df387de29bfa..45c3e5dda355 100644
>--- a/security/integrity/digsig.c
>+++ b/security/integrity/digsig.c
>@@ -179,7 +179,8 @@ static int __init integrity_add_key(const unsigned int id, const void *data,
> 				   KEY_ALLOC_NOT_IN_QUOTA);
> 	if (IS_ERR(key)) {
> 		rc = PTR_ERR(key);
>-		pr_err("Problem loading X.509 certificate %d\n", rc);
>+		if (id != INTEGRITY_KEYRING_MACHINE)
>+			pr_err("Problem loading X.509 certificate %d\n", rc);
> 	} else {
> 		pr_notice("Loaded X.509 cert '%s'\n",
> 			  key_ref_to_ptr(key)->description);
>-- 
>2.43.0
>

-- 
Best regards,
Coiby


