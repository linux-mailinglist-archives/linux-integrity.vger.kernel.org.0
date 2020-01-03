Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C4B12FEAA
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 23:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgACWUl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 17:20:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34577 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728711AbgACWUl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 17:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578090039;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=XnSUMV4CmdDFxrQqyXNTjbfD9ugmEdfmzjPTQuwTWZw=;
        b=heJW3iDL24t2kZmfprJcvjdv5YkFcQDEsHt8SW8Jlu+Qwk6FGCfwazVeV5MNuSZ4wLLQ8C
        qQ3EKua5pVDw0A9gyQm0aZwdx1rcV5vA3Ov2MGEU+O9lIOVG5nS6Yspm662Oi3pwY4MkUD
        MaJrIwN1QygCpvSVlqVOkm4ph+0JJho=
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-d6OaNcNTNJOr2bCJEf1KWQ-1; Fri, 03 Jan 2020 17:20:37 -0500
X-MC-Unique: d6OaNcNTNJOr2bCJEf1KWQ-1
Received: by mail-yw1-f69.google.com with SMTP id q187so35283552ywg.12
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 14:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XnSUMV4CmdDFxrQqyXNTjbfD9ugmEdfmzjPTQuwTWZw=;
        b=e8mLYwjqat4xHZWVrnoy7E/5bD5lj0Qp7Tuxcbwam5ZOVJUk/PxTYIfbnayFVigpDI
         7nR3GnBFXdrtQD++8kR4uuHOuvKQBQmOAM6gCxQ+d4Tv+5H94pAyMf/HwBWLDmNzxD7q
         pPal4JzIBhW2/WNxC7MEFuD6GhxVBQ8laqse9sKB3S9e9w0LZwDjcT5P7cNkEg3AfQVf
         bJJ+oAC1F93wE3WT/ob2M1i1u3ey4Oqz8W3kFIByDaUVhvHYBX9LC2k3AVvFVj5X31Rg
         LJHrE5KvjM9aLgDiV0tAeCpWf4ceYrnnSmvRBdPLXWEX6fGO/8T5tfTw64lT2w0HH4I2
         jiMg==
X-Gm-Message-State: APjAAAVIRMbwnp/4g8dp15/hF8lfovxQC40MUEnMzjgPOXlwZNvY6nNr
        lTxPRHJg83gRat48T2SoriGKBcZHKtFohdip4YLCyDd1MDtSh4sOdq528vTMdxBF4yGbNZlFqgk
        4TkdukCmg/Mh6olcg4Z10POj2Y1cl
X-Received: by 2002:a81:a210:: with SMTP id w16mr67972709ywg.261.1578090037458;
        Fri, 03 Jan 2020 14:20:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoGwDBDRXk5ne5/FCFTtRS99NBmRrQ5TNa3jIfrp2nR32DquxsvWG+7uoumbjX2q0D+Hmbug==
X-Received: by 2002:a81:a210:: with SMTP id w16mr67972701ywg.261.1578090037256;
        Fri, 03 Jan 2020 14:20:37 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d199sm24596866ywh.83.2020.01.03.14.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:20:36 -0800 (PST)
Date:   Fri, 3 Jan 2020 15:20:35 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Christian Bundy <christianbundy@fraction.io>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20200103222035.uznrrc6ndarognva@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Christian Bundy <christianbundy@fraction.io>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191228151526.GA6971@linux.intel.com>
 <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
 <20191231010256.kymv4shwmx5jcmey@cantor>
 <20191231155944.GA4790@linux.intel.com>
 <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
 <20200102171922.GA20989@linux.intel.com>
 <CAPcyv4hXwujZ-+8f-5q2UthNOSszeHfNQxxjNVPQjOWeT0KDQg@mail.gmail.com>
 <CAPcyv4gPEu+D+hRqG4HOU24+6xGpZsOb4Po8V+asvvFU-hk6ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPcyv4gPEu+D+hRqG4HOU24+6xGpZsOb4Po8V+asvvFU-hk6ng@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jan 02 20, Dan Williams wrote:
>On Thu, Jan 2, 2020 at 11:20 AM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Thu, Jan 2, 2020 at 9:21 AM Jarkko Sakkinen
>> <jarkko.sakkinen@linux.intel.com> wrote:
>> >
>> > On Tue, Dec 31, 2019 at 11:47:37AM -0800, Christian Bundy wrote:
>> > > > Christian, were you having any issues with interrupts? You system was going
>> > > > into this code as well.
>> > >
>> > > Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
>> > > with UEFI firmware and the problem has disappeared. Please let me know if there
>> > > is anything else I can do to help.
>> > >
>> > > Christian
>> >
>> > Takashi wrote yesterday [*]:
>> >
>> > "I'm building a test kernel package based on 5.5-rc4 with Jarkko's revert
>> > patches"
>>
>> Nice, I also built one of those. Just waiting for access to the system
>> again to gather results.
>
>Ok, it looks good.
>
>Tested-by: Dan Williams <dan.j.williams@intel.com>
>Tested-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
>
>It does report:
>
>[    2.546660] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
>[    2.546823] tpm tpm0: tpm_try_transmit: send(): error -5

That is the tpm2_get_tpm_pt call for testing the interrupts failing,
and is expected with the reverts.

>[    2.546824] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
>polling instead
>
>...at boot, but tpm2_nvlist works ok.
>

