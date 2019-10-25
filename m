Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E90E415F
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 04:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfJYCMH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 22:12:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732948AbfJYCMH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 22:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571969525;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jidlgzTgtjWEnSlNkbgFbTTY71x/qeOQ/z5fqs+Lrko=;
        b=EAo2HUTW82XwpisFkm7pvWcyyYrwGsijEjuzG++gJvQlI7QkxrKUH/lllpAO2UyBz+m1aL
        XNc3fz1QKD13H+o4GKGx1xcrVgQtgfRo4GUQ2O3KTBwAVl+G6NMqbdjWNXhnX6tPztmsVx
        evtr1F/wfAl+CM0dPDUSgaaVM+hNbi8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-yPHme-1LOluCktAA9G8q4g-1; Thu, 24 Oct 2019 22:12:04 -0400
Received: by mail-yb1-f200.google.com with SMTP id t48so746559ybi.22
        for <linux-integrity@vger.kernel.org>; Thu, 24 Oct 2019 19:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SaVdG3lhFlR6Qr8n+mB9mHj2cm/I2mQXo1eS2C+ohX4=;
        b=GrYNJTGTiGhLjhZMudcwJoRYb8nWb/oRphKprg+Wi+bz/JdRmNXn2DU+IXrgES6fc3
         tmfo2Wza8HQC8bYKt1p3yhqg2M7SHQu67yBSBQ19QFKL642msuKH0DIf/tq8ysi1zrq6
         +QphFT87jk5ZmBXK2hG/TEl4Vy3ketBUGcb29/7H2Z3aSjUY+d++oCdNBt6Fl4481VEu
         azuUP7tX6kbSsXgBY1n7Zn215cXR0Reib5ijQNvYH6oGf0z6ulN6KxbBjsget9p8bSlg
         qA9hb42EkDvTVYa2daF6XjHnIp2hSVYR16rjnFrEBWDQBumxpufBESNA/xOF/uPKsIv1
         Fkuw==
X-Gm-Message-State: APjAAAWotB187cRy0PL9bRDeDAVG5ZJEA/YR/HP43CvC9fauK5888cuf
        otOpyfqoL8IJNYQb0s5CxGxVfIKsGv3WFhmi1mKhUkKWMf4E/txGkSanFCz6CvxeCUqmDcDSkQz
        YIUw0vnsHy+cgAXJbz7rpnbpwubOA
X-Received: by 2002:a81:48d1:: with SMTP id v200mr453779ywa.318.1571969522587;
        Thu, 24 Oct 2019 19:12:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyG+6dQfDIBqeRdQtBluev4gHldBXK3OS55p+h88o8nlmDitJfjQinSbtm8/Wvr3vNnEumnBQ==
X-Received: by 2002:a81:48d1:: with SMTP id v200mr453756ywa.318.1571969522151;
        Thu, 24 Oct 2019 19:12:02 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id j3sm543643ywb.10.2019.10.24.19.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 19:12:01 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:11:59 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Petr Vorel <pvorel@suse.cz>, Nayna <nayna@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191025021159.dt7ifgnebnke6ca7@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024213842.c6cl4tlnsi56pgcy@cantor>
 <1571964420.5173.12.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1571964420.5173.12.camel@linux.ibm.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: yPHme-1LOluCktAA9G8q4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Oct 24 19, Mimi Zohar wrote:
>On Thu, 2019-10-24 at 14:38 -0700, Jerry Snitselaar wrote:
>> On Thu Oct 24 19, Jarkko Sakkinen wrote:
>> >On Thu, Oct 24, 2019 at 02:18:48PM +0200, Petr Vorel wrote:
>> >> Hi all,
>> >>
>> >> I wonder what to do with this patch "ima: skip verifying TPM 2.0 PCR =
values" [1].
>> >> Is it a correct way to differentiate between TPM 1.2 and TPM 2.0?
>> >> Or something else should be applied?
>> >>
>> >> How is the work on TPM 2.0 Linux sysfs interface?
>> >> But even it's done in near future, we'd still need some way for older=
 kernels.
>> >>
>> >> Kind regards,
>> >> Petr
>> >>
>> >> [1] https://patchwork.ozlabs.org/patch/1100733/
>> >
>> >version_major sysfs file would be acceptable if someone wants to procee=
d
>> >and send such patch.
>> >
>> >Also replicants for durations and timeouts files would make sense for
>> >TPM 2.0.
>> >
>> >/Jarkko
>>
>> Is it as simple as doing this?
>>
>> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
>> index edfa89160010..fd8eb8d8945c 100644
>> --- a/drivers/char/tpm/tpm-sysfs.c
>> +++ b/drivers/char/tpm/tpm-sysfs.c
>> @@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, st=
ruct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RO(timeouts);
>>
>> -static struct attribute *tpm_dev_attrs[] =3D {
>> +static ssize_t version_major_show(struct device *dev,
>> +                                 struct device_attribute *attr, char *b=
uf)
>> +{
>> +       struct tpm_chip *chip =3D to_tpm_chip(dev);
>> +
>> +       return sprintf(buf, "TPM%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
>> +                      ? "2.0" : "1.2");
>> +}
>> +static DEVICE_ATTR_RO(version_major);
>> +
>> +static struct attribute *tpm12_dev_attrs[] =3D {
>>         &dev_attr_pubek.attr,
>>         &dev_attr_pcrs.attr,
>>         &dev_attr_enabled.attr,
>> @@ -320,18 +330,28 @@ static struct attribute *tpm_dev_attrs[] =3D {
>>         &dev_attr_cancel.attr,
>>         &dev_attr_durations.attr,
>>         &dev_attr_timeouts.attr,
>> +       &dev_attr_version_major.attr,
>>         NULL,
>>  };
>>
>
>The TPM version seems to be included in "dev_attr_caps.attr".
>
>> -static const struct attribute_group tpm_dev_group =3D {
>> -       .attrs =3D tpm_dev_attrs,
>> +static struct attribute *tpm20_dev_attrs[] =3D {
>> +       &dev_attr_version_major.attr,
>> +       NULL
>> +};
>
>This should work, but wouldn't exporting this information under
>security/tpmX, like the binary_bios_measurements, be a lot easier to
>find and use?
>
>Mimi
>

/sys/kernel/security/tpmX/major_version (on fedora and rhel at least, is it=
 elsewhere on other distros?)

versus

/sys/class/tpm/tpmX/major_version

I don't know that it is any easier to find.

>> +
>> +static const struct attribute_group tpm12_dev_group =3D {
>> +       .attrs =3D tpm12_dev_attrs,
>> +};
>> +
>> +static const struct attribute_group tpm20_dev_group =3D {
>> +       .attrs =3D tpm20_dev_attrs,
>>  };
>>
>>  void tpm_sysfs_add_device(struct tpm_chip *chip)
>>  {
>> -       if (chip->flags & TPM_CHIP_FLAG_TPM2)
>> -               return;
>> -
>>         WARN_ON(chip->groups_cnt !=3D 0);
>> -       chip->groups[chip->groups_cnt++] =3D &tpm_dev_group;
>> +       if (chip->flags & TPM_CHIP_FLAG_TPM2)
>> +               chip->groups[chip->groups_cnt++] =3D &tpm20_dev_group;
>> +       else
>> +               chip->groups[chip->groups_cnt++] =3D &tpm12_dev_group;
>>  }
>>
>>
>> Did a quick test on 2 systems here.
>

