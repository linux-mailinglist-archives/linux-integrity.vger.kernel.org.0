Return-Path: <linux-integrity+bounces-5752-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57FBA83BB3
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43B64A4437
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D351E0B91;
	Thu, 10 Apr 2025 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEfc4PAo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5821CEEBB
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271481; cv=none; b=U8hgZyd9m1t5L18hdj0QKxA/oh68yD+s5K0PWY1gSBBL4+eFoIQZvpW1LiFJlJ1EwAmv9nXAWhHNJ4SRC0pC2VMgbCzZ49W+bdQrrmE2jO47vBvCZn8q7usvWg6aAXO1hZtRD7ayf5NJBhYF0D0Jns4ZKKbJoYHTDop113GItrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271481; c=relaxed/simple;
	bh=/x/sdAmlKBLB6ANTVAOUKEOQ2pYfuORpJBZOwj1Zl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX7/kMXLSuZEYszvhVvisRyPQ/tT2StgqTwjbt5vNL1Ek9iJ871Th3rhAR9a22anEfRes2ePk1waPHxNMgA6IIpx3Vlbijsg+YuLtSC4u8XGVs5IogBEx3Cj0jzZ6tqoIwnazr8MYwTYsIx0a7xcQC7P4/DTKFbS0KOOZIEtz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEfc4PAo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744271479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncwEW164eIm02E7SqERquGllFqE6R8n6rhgXWGPPjCY=;
	b=DEfc4PAo4tXcmUxrNyVjMcIr1rtPy4ZoRHBcieIY9Rz7u0FSzFa8UPIsoGqKrT3IPS3Y/G
	KLmHqGIDfrf9qiPUD9iURZfIWnI/R74dQZwE+9Hupnhq3NIe90CJP7jcG+zgqQ/TyfIFwE
	VPEU4IS06hquYfjNvi7AYWiWSu+H130=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-B6O8ZLkCO2uTSJVSTNjBsg-1; Thu, 10 Apr 2025 03:51:17 -0400
X-MC-Unique: B6O8ZLkCO2uTSJVSTNjBsg-1
X-Mimecast-MFC-AGG-ID: B6O8ZLkCO2uTSJVSTNjBsg_1744271476
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3d89cc4f3so35359566b.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 00:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744271476; x=1744876276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncwEW164eIm02E7SqERquGllFqE6R8n6rhgXWGPPjCY=;
        b=o0bjjAGWk5aTMQBlqqTqcCF5T+8p0F7isHdSrPFGZCP3oyIt1A11nJXHohdhsrrj8b
         3WLcKAEmceDzE6fo4uRPdbp8+WisdWTBHwlpNrPnGoDYAASz8jSZadgzBmx4PzceBO7p
         kkRqkYVW0NQmQWmazk+vfCcZRkZ6M14AX212gvIvC5xIL1PWuasbbpfM20Uf760wmirV
         LqrsGqlwyn6z4qEwPyDknj39Sa+vfPqz00fnX5TKRdgJU/cibl739Y24jbsGK4TIxwGK
         TRE4sAO42Pyk2tBXNYdzLyxVI6/tSOaEPCv/I3+yG1uCx/MP9AdS9sjWIWAjOMvSPEdP
         qMVg==
X-Forwarded-Encrypted: i=1; AJvYcCUiJTkI14itYlPpO/m17AdgwX241eVEIqyq6aTxA3YY1rxFf6bNHxWFoLvjt3VTVkcAEAXyMJPhUBHWTnY9suc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9tLTIXhXk2cmMZGLY3usa8PMb4an1f4kFDkcrGWJXp/fTofe7
	Q/FXI543ahBiz/wvRZhWkTWHLEnKtfclEfMo8kLsZ0nAfFsfF5/rMBA1sXLeqHVwyw23tDElMcn
	495rqZNf8WQw+b2O8B+gkTc6scsTJX8BnQj05MEYDoAsuqVy1SQaXK8+xJ8zCSMrWMw==
X-Gm-Gg: ASbGncvg4Qw58UNDStMkObQbUi42TWen2VKsASVOF7V4Xbvl1UdHJdbjBf+VI3sEdvP
	liNMoGREIVuOoPJVP/2bET2XCg+SfdNBveCm/wipjeYqj7bX8cna9+wX1VFEU8K4IgCNDOtiCbQ
	szINK4hT6y+q2YUYDQ8nIt1QUrZnmCZxTCvYQ315vkTQO39SC3Wrkp4txYNWdnia4jL+xHF6FLZ
	jeO62EbYPDIYjo/dwjTrBi42XCJPkLKqdFfDsqhDLh8X+PR3f79B7e6dolh6K9qwNEmexae3wZh
	D4mnAxgRnrLv5GuW1EHK/o+L1uzoB0KIFPhB6BSuuGepq4/D0uoJsty/S4tL
X-Received: by 2002:a17:906:7956:b0:ac2:758f:9814 with SMTP id a640c23a62f3a-acac0080da0mr107850966b.23.1744271475758;
        Thu, 10 Apr 2025 00:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG39WP8R6g3L71aG5bOHh176hMN6GTv/0pLjw6bk7AARBM3hGYhEni5D0BkGErIWIflkTXBgw==
X-Received: by 2002:a17:906:7956:b0:ac2:758f:9814 with SMTP id a640c23a62f3a-acac0080da0mr107849166b.23.1744271475184;
        Thu, 10 Apr 2025 00:51:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb422asm223457566b.115.2025.04.10.00.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:51:14 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:51:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, peterhuewe@gmx.de, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: tpm: tpm-buf: Fix uninitialized return values in
 read helpers
Message-ID: <t2ri7facyvtmt6rx6xwcjos7rgtyiln7cywl2gt4effgukeejc@f3ml4apdh4zs>
References: <20250409205536.210202-1-purvayeshi550@gmail.com>
 <Z_dh4tRIa6xxAWQ2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z_dh4tRIa6xxAWQ2@kernel.org>

On Thu, Apr 10, 2025 at 09:14:58AM +0300, Jarkko Sakkinen wrote:
>On Thu, Apr 10, 2025 at 02:25:36AM +0530, Purva Yeshi wrote:
>> Fix Smatch-detected error:
>> drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
>> uninitialized symbol 'value'.
>> drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
>> uninitialized symbol 'value'.
>> drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
>> uninitialized symbol 'value'.
>>
>> Call tpm_buf_read() to populate value but do not check its return
>> status. If the read fails, value remains uninitialized, causing
>> undefined behavior when returned or processed.
>>
>> Initialize value to zero to ensure a defined return even if
>> tpm_buf_read() fails, avoiding undefined behavior from using
>> an uninitialized variable.
>
>How does tpm_buf_read() fail?

If TPM_BUF_BOUNDARY_ERROR is set (or we are setting it), we are 
effectively returning random stack bytes to the caller.
Could this be a problem?

If it is, maybe instead of this patch, we could set `*output` to zero in 
the error path of tpm_buf_read(). Or return an error from tpm_buf_read() 
so callers can return 0 or whatever they want.

Thanks,
Stefano


