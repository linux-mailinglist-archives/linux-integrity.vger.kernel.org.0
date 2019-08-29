Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45D8A27E6
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 22:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfH2UZe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 16:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfH2UZe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 16:25:34 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D69A32A09AF
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2019 20:25:33 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id f14so4860376qkm.15
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2019 13:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NuHHLR0Jmm8ntfmdI9Q5wrpjxW7viaKhnVI/5kDaleU=;
        b=nz+I30BXRzXGupui96TIVS0aMFd3+i7/zwhEmgGgayRUoHxsjUwsLU/7hGzfUq88Ay
         Xgg9LjyInprqhUlVjoGYumsGGjU6M3dNU3Zd+VHHrs4GOXveszh2Awr3Byy4KTim5WR6
         Hk8svLKGYyTTKTRbrf3O3ObvtUr3vJxpM6EcYI5D+KM38GKECb5LS5VGBQiPmCRpgqDn
         n7jOw032Vw0eOEeCuHL8aOw3uu5GBx08IHCng/zOES2p+vw1cQhExxs0dVGNJDC3EIWg
         wdKyQuT2vctKKAqhpJyAqRAdTitLbT1Jo35KPgZ8VvL7Ei/qR23iYeLMgm+eeUHsFm9x
         7Mxw==
X-Gm-Message-State: APjAAAUu8ns2ZEC79weTAS8aKJbWCl4IF8O/nzeDeut1kHDFQqebNSRa
        O4dLLZIbRXy029DV+vYIkFNeeJOQh+EfOyXwTRzbSe32Y3mW27MqgQ1x9bICyQ4iNd7G9NuSDfE
        1B2jijzeyjavB1VKFBTFj5okaRPXl
X-Received: by 2002:ad4:4562:: with SMTP id o2mr8040617qvu.116.1567110333126;
        Thu, 29 Aug 2019 13:25:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxs0vClYjBCNgThc5YxpIImI8F5yuS4HC6WUH2mHJXGillmdxBV8QNH7LS7tPQK3c4grE80iw==
X-Received: by 2002:ad4:4562:: with SMTP id o2mr8040601qvu.116.1567110332822;
        Thu, 29 Aug 2019 13:25:32 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n62sm1676745qkd.124.2019.08.29.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 13:25:32 -0700 (PDT)
Date:   Thu, 29 Aug 2019 13:25:27 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexey Klimov <aklimov@redhat.com>
Subject: Re: [PATCH 2/2 v2] tpm_tis: override durations for STM tpm with
 firmware 1.2.8.28
Message-ID: <20190829202527.auyqek7yryuvaruk@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alexey Klimov <aklimov@redhat.com>
References: <20190828004621.29050-1-jsnitsel@redhat.com>
 <20190828004621.29050-3-jsnitsel@redhat.com>
 <20190829144002.zhuqxnsswgl65pnm@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190829144002.zhuqxnsswgl65pnm@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 29 19, Jarkko Sakkinen wrote:
>On Tue, Aug 27, 2019 at 05:46:21PM -0700, Jerry Snitselaar wrote:
>> There was revealed a bug in the STM TPM chipset used in Dell R415s.
>> Bug is observed so far only on chipset firmware 1.2.8.28
>> (1.2 TPM, device-id 0x0, rev-id 78). After some number of
>> operations chipset hangs and stays in inconsistent state:
>>
>> tpm_tis 00:09: Operation Timed out
>> tpm_tis 00:09: tpm_transmit: tpm_send: error -5
>>
>> Durations returned by the chip are the same like on other
>> firmware revisions but apparently with specifically 1.2.8.28 fw
>> durations should be reset to 2 minutes to enable tpm chip work
>> properly. No working way of updating firmware was found.
>>
>> This patch adds implementation of ->update_durations method
>> that matches only STM devices with specific firmware version.
>>
>> Cc: Peter Huewe <peterhuewe@gmx.de>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> ---
>> v2: Make suggested changes from Jarkko
>>     - change struct field name to durations from durs
>>     - formatting cleanups
>>     - turn into void function like update_timeouts and
>>       use chip->duration_adjusted to track whether adjustment occurred.
>
>The code repetition looks horrible so I wrote a patch that should help:
>
>https://patchwork.kernel.org/patch/11121475/
>
>Read the remar that prepends the diffstat.
>
>/Jarkko

LGTM, and testing it on a 1.2 tpm system here worked fine. You can add my
Reviewed-by and Tested-by.

I have reworked this 2/2 patch to make use of these new structs and
pull the tpm1_getcap calls out of the for loop. So I will submit a v3
to go on top of your patch.
