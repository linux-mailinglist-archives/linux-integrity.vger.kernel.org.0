Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DBF10DBEB
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2019 01:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK3ANB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Nov 2019 19:13:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31903 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727209AbfK3ANA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Nov 2019 19:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575072778;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKbyuOkS3PW2MGMOCeB8esOqQ/aSq2T37sj0B9rPVCA=;
        b=YPpupQLwnM2rvB7pFDAmXibdB7tk/ZoFv1e0HH2jGMyVGVY568PUwpLqk7LtP28lxHhbna
        aBZBn8Izb9hvbYvT1MxU9nmWcUeWunw4JlTBSu2ag8HQdkUj+rtBGFkmZrnsub9SMT2gFy
        y5k952BG62WNLOG7h0Ykl5OgceoAhuQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-IHNVjXxnPF-_FeRdQmT_wg-1; Fri, 29 Nov 2019 19:12:57 -0500
Received: by mail-pj1-f72.google.com with SMTP id c23so15534296pjs.16
        for <linux-integrity@vger.kernel.org>; Fri, 29 Nov 2019 16:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=H5rAN0lVb9RDPiR1/dzryPNeMEEOLBOdHyVpcyv58Ps=;
        b=snDyUGjDWlt+3bXtZseXiCI+lCGY41WVSihF2jbkrR1lZT/ZqESOzZfGbaOhXm2vot
         lT4h25VkIeFNkjdpUdPvdSt/rMB7ZBY4JYYEFtskFdejUPILCP9wjoxj/nBV1T8X7bwn
         S1gZ/WoVLRB3zIpRtsxdimgmxXlM5z5tajJeOOC+q+9OtLXqmJnUKGWv0pDv5TkAguyM
         o4Jiez9oiuAfrExHz0TwGBruugEaOEm+Lk8v0I79ypgpRzi+DDzosZ21GW7ZlKygQJBR
         UsdQ5WCbrKFj740aJ5dhW5WKlYGrDBSvy84w2yLm0NLwGjmTg7EtL9Z1HDyemXEHIoOP
         U2nw==
X-Gm-Message-State: APjAAAVdmnbrQtn/ZiHe7u7LSrMxa6izkxgsUkmrYKYi3Nsw225CvIFU
        VA0H+wiCpRd7P9DKd8936vkdm/PQpPrpzoypOHKDmblnsqeS89sUeT5G9HfotmbEfAYy88NI4QE
        Zn/Dx7yKX14KcBfpIRxib8dIGrPEs
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr16707428plq.295.1575072776009;
        Fri, 29 Nov 2019 16:12:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMwyPTp0Icx4kxymsXV5XAdBQ+nWGUPwk3u+Z2NJVehlr1bkBur/T2EmX4WPTg2gVS98kU8A==
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr16707389plq.295.1575072775364;
        Fri, 29 Nov 2019 16:12:55 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q6sm13863724pfl.140.2019.11.29.16.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 16:12:54 -0800 (PST)
Date:   Fri, 29 Nov 2019 17:12:53 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.4
Message-ID: <20191130001253.rtovohtfbg25uifm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
References: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
 <CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com>
 <20191127205800.GA14290@linux.intel.com>
 <20191127205912.GB14290@linux.intel.com>
 <20191128012055.f3a6gq7bjpvuierx@cantor>
 <20191129235322.GB21546@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191129235322.GB21546@linux.intel.com>
X-MC-Unique: IHNVjXxnPF-_FeRdQmT_wg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat Nov 30 19, Jarkko Sakkinen wrote:
>On Wed, Nov 27, 2019 at 06:20:55PM -0700, Jerry Snitselaar wrote:
>> There also was that other issue reported on the list about
>> tpm_tis_core_init failing when calling tpm_get_timeouts due to the
>> power gating changes.
>
>Please add a (lore.ko) link for reference to this thread.
>
>/Jarkko
>

https://lore.kernel.org/linux-integrity/a60dadce-3650-44ce-8785-2f737ab9b99=
3@www.fastmail.com/

