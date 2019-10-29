Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5EE8FB9
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2019 20:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfJ2TLY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Oct 2019 15:11:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21130 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728462AbfJ2TLY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Oct 2019 15:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572376281;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVQp5CGRx1PyvKgrlWv3b5v3aS+4Vv1jm/fv8rfBPR4=;
        b=JAtYKGVqx+3dmwTQn8ekJ0qAw2F4D26GPBeViUKDN5q9B7s+9gYXxcauoItkJfpMl+ez0Q
        YsIe5um0H+knJ2q8rVMQfnprr8Oiz5Meq3EeOmXeifecM0WmHVPD78Sn+jT5QUYIujKRtZ
        sQtwR43LY1a8G5KJOO9QlwpSZHSLtV8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-kt5lGfkmMZS8CRi0ig9IUw-1; Tue, 29 Oct 2019 15:11:20 -0400
Received: by mail-yb1-f197.google.com with SMTP id g135so2380ybf.1
        for <linux-integrity@vger.kernel.org>; Tue, 29 Oct 2019 12:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sVtwN1kmSxVpSY0Gti66u5ds+Iq3Vu9z0OH9D/yOKKA=;
        b=GhM+63zGEYZutkLwmZ9tFG/y0MgZAMz+wMRhnyVqWJvJO+fN6OiY1nMzaR5F0WHdYd
         lW8PElNwNZybhSyOWC9chz6B0WFbClvA/kbAtaSJXsSZgcHufayYsuaqsHC0wPF509JJ
         +tADd5gHMj1NSWjHr7iHxFPnywP31WbvZC0BVhIY2n2VkrWjtj9401zNSPRtWVoO69fP
         MabL0vXkyp3jCfgyO6YvBemmu4xF6blqf0aBEvqMypvVs92ZPNZteof7gscBJBAjzhIB
         js4hUN3MkSBquRSdGxPK2xYvOFze1dOp7WbndBbm8oJQk14wI7XsPOHVuN9pts9k4Vbe
         MavA==
X-Gm-Message-State: APjAAAVmKfVEOpVCrhcXcpdYUS5o0yJgSyluJE2Q6QuyWsrJFQ+F7ZVM
        98yS0RWuCRd4yhuil0YXi5dN958fQWP2zSEB7AbdGGqqhAzZ+FQfuNzafV4RtRNDfUIYNnGrJ+H
        dYCI0XjNizka2DSG4/EwvP/kvLLcO
X-Received: by 2002:a81:9342:: with SMTP id k63mr18603332ywg.259.1572376280189;
        Tue, 29 Oct 2019 12:11:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIo0nu1QiFYzXsqc3qYVMlhK7WX5N1PZWEXhpO273XA5O1YWuA+Lg/iBZkH+W6gtx/LKofNQ==
X-Received: by 2002:a81:9342:: with SMTP id k63mr18603306ywg.259.1572376279827;
        Tue, 29 Oct 2019 12:11:19 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z196sm21489453ywz.30.2019.10.29.12.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:11:18 -0700 (PDT)
Date:   Tue, 29 Oct 2019 12:11:17 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191029191117.g2mwmhslko4b2sgx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
References: <20191025193103.30226-1-jsnitsel@redhat.com>
 <20191028205313.GH8279@linux.intel.com>
 <20191028210507.7i6d6b5olw72shm3@cantor>
 <20191029091731.GC9896@linux.intel.com>
 <20191029124342.GB6128@ziepe.ca>
 <20191029142225.GC7415@linux.intel.com>
 <1572361008.4812.2.camel@HansenPartnership.com>
 <20191029152211.GE6128@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191029152211.GE6128@ziepe.ca>
User-Agent: NeoMutt/20180716
X-MC-Unique: kt5lGfkmMZS8CRi0ig9IUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Oct 29 19, Jason Gunthorpe wrote:
>On Tue, Oct 29, 2019 at 07:56:48AM -0700, James Bottomley wrote:
>> On Tue, 2019-10-29 at 16:22 +0200, Jarkko Sakkinen wrote:
>> > On Tue, Oct 29, 2019 at 09:43:42AM -0300, Jason Gunthorpe wrote:
>> > > On Tue, Oct 29, 2019 at 11:17:31AM +0200, Jarkko Sakkinen wrote:
>> > > > On Mon, Oct 28, 2019 at 02:05:07PM -0700, Jerry Snitselaar wrote:
>> > > > > On Mon Oct 28 19, Jarkko Sakkinen wrote:
>> > > > > > On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar
>> > > > > > wrote:
>> > > > > > > +=09return sprintf(buf, "%s\n", chip->flags &
>> > > > > > > TPM_CHIP_FLAG_TPM2
>> > > > > > > +=09=09       ? "2.0" : "1.2");
>> > > > > >
>> > > > > > This is not right. Should be either "1" or "2".
>> > > > > >
>> > > > > > /Jarkko
>> > > > >
>> > > > > Okay I will fix that up. Do we have a final decision on the
>> > > > > file name,
>> > > > > major_version versus version_major?
>> > > >
>> > > > Well, I don't see how major_version would make any sense. It is
>> > > > not as future proof as version_major. Still waiting for Jason's
>> > > > feedback for this.
>> > >
>> > > $ find /sys/ -name  "*version*"
>> > > /sys/devices/pci0000:00/0000:00:17.0/ata1/host0/scsi_host/host0/ahc
>> > > i_host_version
>> > > /sys/devices/virtual/net/docker0/bridge/multicast_mld_version
>> > > /sys/devices/virtual/net/docker0/bridge/multicast_igmp_version
>> > > /sys/firmware/efi/esrt/entries/entry0/lowest_supported_fw_version
>> > > /sys/firmware/efi/esrt/entries/entry0/last_attempt_version
>> > > /sys/firmware/efi/esrt/entries/entry0/fw_version
>> > > /sys/module/acpi/parameters/acpica_version
>> > >
>> > > etc..
>> > >
>> > > Not a single example of the backward version.
>> > >
>> > > Most likely it should be called 'tpm_version'
>> >
>> > The postfix gives tells the part of the version number that the file
>> > reports. If you really want to add the prefix, then the appropriate
>> > name would be tpm_version_major.
>> >
>> > I'd still go with just version_major as tpm_ prefix is somewhat
>> > redundant.
>>
>> You have to be careful with overly generic names in sysfs ... this is
>> what happened to us in SCSI:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D42caa0edabd6a0a392ec36a5f0943924e4954311
>>
>> That's not to say version_major is wrong ... plenty of sysfs files have
>> generic names like this, it's just that tpm_version_major might be more
>> future proof.
>
>Indeed, it is a bit a global namespace, so nothing wrong with adding
>tpm_
>
>Jason

So tpm_version_major?

