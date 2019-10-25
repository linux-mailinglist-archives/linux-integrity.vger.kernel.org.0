Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D892E53DD
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfJYSpb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 14:45:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726030AbfJYSpb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 14:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572029129;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9paRnLLRdvZXOp9cLGb2RQRU7/GKkqNC1DIqfB0QbeY=;
        b=dbiCjU4o0M/Nfh0+4z1JsJLakXThFDA8fF4QaCgciQ3qCfv8pZz5yyyV4fIVc4OZtIe2Q9
        n0CvbjpUSUTXBhKZF7C7f8QrJVy9tdVGp82h52BgKN/GGvMuKIKHJ4D6N0wvAEtIsBRF9I
        O1x02zGgvXFSEgC8cBXzxyJT/39+J9g=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-qs_sYo3OMQmYJU77vHg4ng-1; Fri, 25 Oct 2019 14:45:26 -0400
Received: by mail-yb1-f198.google.com with SMTP id a5so2656643ybq.9
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 11:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fVbHX43wiPqb+J3ydMwqDaYmuPF6XwOJdbaDgrdUDlo=;
        b=TsJ+FH9f+cQwjoV2qVeVmhlTbXuSHxeVSPxjjtOKmTi1L/XIt/8Bigh4oaWT4Sg6+J
         zH/g2yRiPkD4oY4OyukFy5aglRj4EE/JZKqyowAlr10DkMyEkkfVNeulCTbd+cfvZ2Uu
         LED8QENCxwjYfFOz+CnX8w6dacy3bSH2/pdjgE8B0CSTWZQEjZnzZW7VW4gwNgOBquzE
         SGGYqwvtKIdT8gmRQh2ZcIAmK1XHUZl3Jj2stG3bbdBVN+WArYdzNn1wBpP5us9IYC2R
         26GIDNzFy3pHugTvHP4bEsy4nNqkq2GX9KI9LMDuoT5nBpaiCsABwelJbKR6hPFcq0ef
         ramw==
X-Gm-Message-State: APjAAAVDEUffw00cGMgb+Ju31Q33of3eTd8IxsVCYFivmwWc43p68lbJ
        Aqst2VJHc5OwICmv7S2Yc47g9oIhZDaM0n4D4dUCbrXpacwGdyhbi3c4HFGby9xYN70Gyxu951p
        ratrUJ8a12mZE8ak5N86xZ4UIFux1
X-Received: by 2002:a81:9a0c:: with SMTP id r12mr3336231ywg.25.1572029124856;
        Fri, 25 Oct 2019 11:45:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzhdyun8ZpCPIfqKiBejy4EXQawnRyIbjDi97brP0Q/QRJiA3sF00QeN4QWfgu7CUUQeOZuzw==
X-Received: by 2002:a81:9a0c:: with SMTP id r12mr3336208ywg.25.1572029124425;
        Fri, 25 Oct 2019 11:45:24 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 137sm4513696ywu.84.2019.10.25.11.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 11:45:23 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:45:22 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Add major_version sysfs file
Message-ID: <20191025184522.5txabdikcrn2dgvj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
References: <20191025142847.14931-1-jsnitsel@redhat.com>
 <1572027516.4532.41.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1572027516.4532.41.camel@linux.ibm.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: qs_sYo3OMQmYJU77vHg4ng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Oct 25 19, Mimi Zohar wrote:
>On Fri, 2019-10-25 at 07:28 -0700, Jerry Snitselaar wrote:
>> Easily determining what TCG version a tpm device implements
>> has been a pain point for userspace for a long time, so
>> add a sysfs file to report the tcg version of a tpm device.
>
>Use "TCG" uppercase consistently.
>=A0
>>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Peter Huewe <peterhuewe@gmx.de>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: linux-integrity@vger.kernel.org
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>thanks!
>
>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
>FYI, on my system(s) the new file is accessible as
>/sys/class/tpm/tpm0/version_major. =A0Does this need to be documented
>anywhere?
>
>

Yes, there should be an entry added to
Documentation/ABI/stable/sysfs-class-tpm.
I will fix that up and the TCG not being uppercase in a v2.

Should Documentation/ABI/stable/sysfs-class-tpm updated in
some way to reflect that those are all links under device
now and not actually there.

>> ---
>>  drivers/char/tpm/tpm-sysfs.c | 34 +++++++++++++++++++++++++++-------
>>  1 file changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
>> index edfa89160010..9372c2d6f0b3 100644
>> --- a/drivers/char/tpm/tpm-sysfs.c
>> +++ b/drivers/char/tpm/tpm-sysfs.c
>> @@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, st=
ruct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RO(timeouts);
>>
>> -static struct attribute *tpm_dev_attrs[] =3D {
>> +static ssize_t major_version_show(struct device *dev,
>> +=09=09=09=09  struct device_attribute *attr, char *buf)
>> +{
>> +=09struct tpm_chip *chip =3D to_tpm_chip(dev);
>> +
>> +=09return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
>> +=09=09       ? "2.0" : "1.2");
>> +}
>> +static DEVICE_ATTR_RO(major_version);
>> +
>> +static struct attribute *tpm12_dev_attrs[] =3D {
>>  =09&dev_attr_pubek.attr,
>>  =09&dev_attr_pcrs.attr,
>>  =09&dev_attr_enabled.attr,
>> @@ -320,18 +330,28 @@ static struct attribute *tpm_dev_attrs[] =3D {
>>  =09&dev_attr_cancel.attr,
>>  =09&dev_attr_durations.attr,
>>  =09&dev_attr_timeouts.attr,
>> +=09&dev_attr_major_version.attr,
>>  =09NULL,
>>  };
>>
>> -static const struct attribute_group tpm_dev_group =3D {
>> -=09.attrs =3D tpm_dev_attrs,
>> +static struct attribute *tpm20_dev_attrs[] =3D {
>> +=09&dev_attr_major_version.attr,
>> +=09NULL
>> +};
>> +
>> +static const struct attribute_group tpm12_dev_group =3D {
>> +=09.attrs =3D tpm12_dev_attrs,
>> +};
>> +
>> +static const struct attribute_group tpm20_dev_group =3D {
>> +=09.attrs =3D tpm20_dev_attrs,
>>  };
>>
>>  void tpm_sysfs_add_device(struct tpm_chip *chip)
>>  {
>> -=09if (chip->flags & TPM_CHIP_FLAG_TPM2)
>> -=09=09return;
>> -
>>  =09WARN_ON(chip->groups_cnt !=3D 0);
>> -=09chip->groups[chip->groups_cnt++] =3D &tpm_dev_group;
>> +=09if (chip->flags & TPM_CHIP_FLAG_TPM2)
>> +=09=09chip->groups[chip->groups_cnt++] =3D &tpm20_dev_group;
>> +=09else
>> +=09=09chip->groups[chip->groups_cnt++] =3D &tpm12_dev_group;
>>  }
>

