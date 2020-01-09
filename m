Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D891362D0
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jan 2020 22:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgAIVto (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jan 2020 16:49:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34330 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725829AbgAIVtl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jan 2020 16:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578606580;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=jP05U3J7xQbdMnr/CfhHt9vwscvvHAPq8Wq8LG9LWJo=;
        b=cJli3nwIelwtP2ROy2tWCb6nkcaM3VxABEPLiSLB77KZ6WE+kOlIu/QKIERvZPQwzD45m1
        2RlaPRyv2uYpiBQQl9/5YvFYZ0blUMjwMIUcNCiwbwXn5w+HJrTPCFfbW4B4ofXMVOCBNC
        TM+XI2sknYSVP6RB5H7tPar2OEYwkro=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-UOOVVW5OPSqviVtRoy1c4A-1; Thu, 09 Jan 2020 16:49:38 -0500
X-MC-Unique: UOOVVW5OPSqviVtRoy1c4A-1
Received: by mail-yw1-f72.google.com with SMTP id a16so5855150ywa.18
        for <linux-integrity@vger.kernel.org>; Thu, 09 Jan 2020 13:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=jP05U3J7xQbdMnr/CfhHt9vwscvvHAPq8Wq8LG9LWJo=;
        b=H7qTtCj8EeXiKdJ9AnzMFX/Bf1sVX86sMH4qHWNneWdKRUYXjAlUh+nfvBywaZ81pe
         QHpzhYiCFT7MaAeE/ejOh6/Lwcvla7xZJSKe6cPkezVxOIFVFBgZJWmrZE/hCj3RCG7T
         0rosOVdVl4AqR7kUSALcuOMStki/DFIKEEvcgRvFcbhbMrYKmUlVoCX8pJqhK4BT1s+n
         wVpW17wKEMjITYsQSgqrydVbFPZzVGMG/dD00PN/V3RT7/RhTkYr8YHknEMYNacPGCYF
         vI82wvAxgiD8G5EwGT73GcGYQjBZKI5dEnpy2+T/9mOqwd7owQZajSZaFRyrI0fyyp9C
         5eVw==
X-Gm-Message-State: APjAAAVTQzaU3xEdtcL59c2diwV33zke9T2qRZGR2P4WYNPmRSMSFFxx
        8fm9IStQCRtwqXorioM5LhBEJIuxSrII2ie4LIDy9jCBpG1KfqU7C4/WkU4BFkA6KubLBmPdqAm
        kZZBRZkVups78nYu9baAkhfQwX/b1
X-Received: by 2002:a81:1b88:: with SMTP id b130mr161022ywb.514.1578606578366;
        Thu, 09 Jan 2020 13:49:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8ikvQAKqAc60KdU2r0EKeN5NCJJ0/miKwf9hOWHgJ5YdaDBB4+0SwW+TvMSACfP3kocICBg==
X-Received: by 2002:a81:1b88:: with SMTP id b130mr161003ywb.514.1578606578052;
        Thu, 09 Jan 2020 13:49:38 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id r66sm47795ywh.57.2020.01.09.13.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:49:37 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:49:35 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Add tpm_version_major sysfs file
Message-ID: <20200109214935.ud7p7uwjimilxvi7@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
References: <20191030225843.23366-1-jsnitsel@redhat.com>
 <20191128010826.w4ixlix3s3ovta3m@cantor>
 <20191129235131.GA21546@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191129235131.GA21546@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat Nov 30 19, Jarkko Sakkinen wrote:
>On Wed, Nov 27, 2019 at 06:08:26PM -0700, Jerry Snitselaar wrote:
>> On Wed Oct 30 19, Jerry Snitselaar wrote:
>> > Easily determining what TCG version a tpm device implements
>> > has been a pain point for userspace for a long time, so
>> > add a sysfs file to report the TCG major version of a tpm device.
>> >
>> > Also add an entry to Documentation/ABI/stable/sysfs-class-tpm
>> > describing the new file.
>> >
>> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > Cc: Mimi Zohar <zohar@linux.ibm.com>
>> > Cc: Peter Huewe <peterhuewe@gmx.de>
>> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> > Cc: linux-integrity@vger.kernel.org
>> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> > ---
>> > v4: - Change file name to tpm_version_major
>> >    - Actually display just the major version.
>> >    - change structs to tpm1_* & tpm2_*
>> >      instead of tpm12_* tpm20_*.
>> > v3: - Change file name to version_major.
>> > v2: - Fix TCG usage in commit message.
>> >    - Add entry to sysfs-class-tpm in Documentation/ABI/stable
>> >
>> > Documentation/ABI/stable/sysfs-class-tpm | 11 ++++++++
>> > drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++-----
>> > 2 files changed, 38 insertions(+), 7 deletions(-)
>> >
>>
>> Anyone else have feedback?
>
>I can apply this after the issues on hand have been sorted out.
>
>/Jarkko
>

Hi Jarkko,

Will this get queued up for 5.6?

Regards,
Jerry


