Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4013B3BD7
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 15:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbfIPNuv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 09:50:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60167 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728005AbfIPNuv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 09:50:51 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 09:50:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568641849;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uorqJP0ilqIXWuBNqGlft+lgbnKPummJ5iAOnvS9bnw=;
        b=CEC167rMUkKMeZ7U4798adRulDg/6BVy3o0MVkWW4E8Xh1K1DXIyowNmZyb5u0axUT9BmX
        KjCnPvNHTXuYlXLdFMDGPEc7ExbKI+NYey7Js06RrdE54upAa5GeP+oVHUUxZ4r3T9irgq
        wy0vHMLGkEhUYTXWxFTaGtCcdvo9x+E=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-ilkoy2xcOCaVL7uIXwODTA-1; Mon, 16 Sep 2019 09:44:40 -0400
Received: by mail-pf1-f199.google.com with SMTP id f2so27118002pfk.13
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 06:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ySq59757mj7fNM1wQt1FEYJJVafWrsei0wkyya9U51g=;
        b=ehJ7RjLdVNeJXho6nXx3RP5rTihK9fRKYBJHa26M3LQ05TogyjD8JtBoUxb0mFmgxC
         7dvi7WYyL4+2Q21B9+OsgTyw45ygjp9gJRBGwdtKW16fqhXas00lKXqKxgnGM9Z8xWaR
         lT9rhUG5YmCXlQNxUtJ/ukUN4MFr2iVq7KQbb8nOh95zcNot7tLOTKPI4tCJO1NOLkv/
         rpjh9S8KLFm/1VLRqQMQfVaL21yYDjadPDR06wRxp9LIF6sVWUFtFoxWMmdRlf0JLriT
         zfJIvCoTWokBCeYOgAG3Wk75+UpetakdhtU5yyX4Rpm4zuM4A3UM8iul1eW9At0s/jkK
         Lv6g==
X-Gm-Message-State: APjAAAU0xEOoqqvh62bLezGYBJtPMUr0gXRJd4ppNDNLjaJti+77MJND
        a+UEOCiyoKz2+BA2yxecsqDEUqgt+cF9MBXh8yP2MsCPBzklchNlzqCSZahDbNTGOnTvZD5Ck0q
        mcHNh067/D50iTElcNSGPk7YD54lK
X-Received: by 2002:a17:90a:b286:: with SMTP id c6mr74286pjr.1.1568641479373;
        Mon, 16 Sep 2019 06:44:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxd6eucafibR9xXC5aTNVsTWnB8ktXs5Dm3p8d24xuo2WY2jIJyAf2xyq7O5EmV1b1RWWDOEg==
X-Received: by 2002:a17:90a:b286:: with SMTP id c6mr74268pjr.1.1568641479108;
        Mon, 16 Sep 2019 06:44:39 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id b16sm41096800pfb.54.2019.09.16.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:44:38 -0700 (PDT)
Date:   Mon, 16 Sep 2019 06:44:37 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>
Subject: Re: LPC System Boot and Security Microconference  (subject change)
Message-ID: <20190916134437.dx7aniyzsmoal45l@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190916073535.25117-1-jarkko.sakkinen@linux.intel.com>
 <20190916074657.GA26795@linux.intel.com>
 <1568635613.4975.40.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1568635613.4975.40.camel@linux.ibm.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: ilkoy2xcOCaVL7uIXwODTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Sep 16 19, Mimi Zohar wrote:
>On Mon, 2019-09-16 at 10:46 +0300, Jarkko Sakkinen wrote:
>> My excuse is the overnight flight last night (no sleep).
>
>Sorry I couldn't make LPC. =A0Did anyone takes notes of the LPC System
>Boot and Security microconference?
>
>thanks,
>
>Mimi
>

There is an etherpad somewhere, but I haven't found a link to it yet,
and there will eventually be videos posted as well.

