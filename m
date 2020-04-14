Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7CA1A8C72
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 22:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgDNU2P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 16:28:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2633098AbgDNU2D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 16:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586896081;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=gFhKg1i0fnRjhPnvNhhvH31RVPmlylOwcXirBGzACwY=;
        b=QX3DN5JYUf9GWzqn0d31av65ZTIqf/RONt2+tehFWyY3RVdbM/DHEw35DgP+pxvtExhKVc
        tmbr657l6HSEgZwA8z239lg4EsXAl/aEzMItZflZghjJ2honDtyIh1coOkV3ATduEO1mbn
        KAsQI0nHGopGsVE68Gv+r8PZgtq0m3A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-fua8plzMNl2dJKGgrnKcFw-1; Tue, 14 Apr 2020 16:26:17 -0400
X-MC-Unique: fua8plzMNl2dJKGgrnKcFw-1
Received: by mail-qk1-f200.google.com with SMTP id k16so12805162qkk.16
        for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2020 13:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gFhKg1i0fnRjhPnvNhhvH31RVPmlylOwcXirBGzACwY=;
        b=s1uU5Usr7NQyYA/1ar2vmznw7r7vRhZxWTr0DReQ3JWbBIr1vz9INE8EEVAGEqYGtd
         eGFwlfp5tPwmDAnqyHYYeZL0Xz/2kyKlpeHucO9mI71kgsoYNSDOozgYOxyszofsDVaV
         nHQTU1LI+FvQYjffi/zUhcg70b4swNbF11iqAOPsu91QixpRRbQeXCoxcVIBJHRr96fc
         +cbYbNd17KH2k6XkQgj7EcWBWoGgdPR8nUQUsG2jJ20QpvY4REBBY6haTOYCcFaZLYHI
         rM4yCVFyZqRP6iI2WOVU+TvM7EfXwK1dIsssW8O4eJ7I/yq5XbQODk6gYLTVlR1YmRSe
         CDOg==
X-Gm-Message-State: AGi0Pua5q8IzrOrwjNk8kVNVRFWVy15UYX+PdYabSDsvBvwELElfoNXe
        GNftUvgl+6ZfqrrA8UQS6+dL9Xc2ewewE5YBD5FtWhFBXmXIYywJGC38n/ABxbDHzF7qSthOkT/
        phw2xuO/o2RELHbG2N+PQ+VECHRTb
X-Received: by 2002:ad4:55eb:: with SMTP id bu11mr1771400qvb.192.1586895977462;
        Tue, 14 Apr 2020 13:26:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLL/739Bunp9PWRhInCCopdTucT0TPb7bitw7FUwX4bvc+D2WRR+F0MR9Hi3wsAxrEA6InUdg==
X-Received: by 2002:ad4:55eb:: with SMTP id bu11mr1771387qvb.192.1586895977300;
        Tue, 14 Apr 2020 13:26:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g187sm10909209qkf.115.2020.04.14.13.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:26:16 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:26:15 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
Message-ID: <20200414202615.stnurisucqxblenj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
References: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
 <76d46ffbad294a6385779c29c4e5cafd@huawei.com>
 <20200414193542.GB13000@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200414193542.GB13000@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Apr 14 20, Jarkko Sakkinen wrote:
>On Tue, Apr 14, 2020 at 11:55:43AM +0000, Roberto Sassu wrote:
>> > -----Original Message-----
>> > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
>> > owner@vger.kernel.org] On Behalf Of Tianjia Zhang
>> > Sent: Tuesday, April 14, 2020 1:42 PM
>> > To: peterhuewe@gmx.de; jarkko.sakkinen@linux.intel.com; jgg@ziepe.ca;
>> > arnd@arndb.de; gregkh@linuxfoundation.org; zhang.jia@linux.alibaba.com
>> > Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
>> > tianjia.zhang@linux.alibaba.com
>> > Subject: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
>> >
>> > For the algorithm that does not match the bank, a positive
>> > value EINVAL is returned here. I think this is a typo error.
>> > It is necessary to return an error value.
>>
>> Yes, thanks.
>>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>
>Happen to have the commit ID at hand for fixes?
>
>Thanks.
>
>/Jarkko
>

9f75c8224631 ("KEYS: trusted: correctly initialize digests and fix locking issue")

