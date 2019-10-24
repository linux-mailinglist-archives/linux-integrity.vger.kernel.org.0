Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E64E3E59
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 23:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfJXViv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 17:38:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34948 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729033AbfJXViv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 17:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571953130;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQANpucKvOAjURgm9S+UVt5+2lKcM3WgQQHEXlGppkg=;
        b=UfySg7+di3qN0QsI0yXBqwGlNyi3masBaqAn17/AEUeea0ziYR9AOpRbM0X39DFM2wqzMv
        OM7EZbQ/438EVzVuSK+wfwvlylTvVvx43y153syYmrm1Le8thVVXiNw2uiEYraIwZVxZM9
        /c0CpcBYdicgkFNkr4GN4AVPocIOZeY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-fjlxn3T5Pfm-rtVBcUVTnA-1; Thu, 24 Oct 2019 17:38:46 -0400
Received: by mail-yb1-f199.google.com with SMTP id t48so270959ybi.22
        for <linux-integrity@vger.kernel.org>; Thu, 24 Oct 2019 14:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6bpScGowFHRBXcUEN+4yTWVU8KLyKeA/nY1wEZHF1W0=;
        b=J9qe9sGloP6B4zIHS+bDy1lTtoP+N6ZzRNW8+6ZXLu5ZtuDyWt2f4BOHKHRnMaY3R4
         l1gE9KECob9ZQilMbtrxNbjOnW7jaHx4pjs5l2atTO9FTnkI9Wa+05OtjyjGtqM+uBPi
         UmleVwRMRfp9rlJkQLy4kV2qjxh6OcxXyEM+/grmoARX8y38zzipYATBpdk8jeabmkKH
         EgjsWBce14vnX2ohg6R75RaBBYHR/78YfB/zNpDHhQcPQ157KMH2xFLvjpTvhYhw+AMy
         Q8hFB5wW63ZTOelko5e6LlxxcJol7g440O4uvbWHJMuF9rAEz3SpJqAAwrmeenCyyw+i
         gD2w==
X-Gm-Message-State: APjAAAUIrubxGOAdEgaSWz1ji87WUghN72+igH7Htz/gF7KVKXm56zfG
        432+E9RB4RJN1hsUl2Xhay7pfg5FgKD5r4dZW9j1ZjibZ11akStP5tWEPS2Ms1WrhzwoWYu12IV
        Ibl/AM7Pw9IANNphgco0AM5DhBaKc
X-Received: by 2002:a5b:783:: with SMTP id b3mr392731ybq.441.1571953125650;
        Thu, 24 Oct 2019 14:38:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwP0jiaXh4Lq/w0sNsRcXQelkxPqeawRDU+N9vsZeqSkqSSzTlJSPjf6tf/5swn/HDSpYMqMg==
X-Received: by 2002:a5b:783:: with SMTP id b3mr392715ybq.441.1571953125249;
        Thu, 24 Oct 2019 14:38:45 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id b73sm13172ywe.35.2019.10.24.14.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 14:38:44 -0700 (PDT)
Date:   Thu, 24 Oct 2019 14:38:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Petr Vorel <pvorel@suse.cz>, Nayna <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191024213842.c6cl4tlnsi56pgcy@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191024172023.GA7948@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: fjlxn3T5Pfm-rtVBcUVTnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Oct 24 19, Jarkko Sakkinen wrote:
>On Thu, Oct 24, 2019 at 02:18:48PM +0200, Petr Vorel wrote:
>> Hi all,
>>
>> I wonder what to do with this patch "ima: skip verifying TPM 2.0 PCR val=
ues" [1].
>> Is it a correct way to differentiate between TPM 1.2 and TPM 2.0?
>> Or something else should be applied?
>>
>> How is the work on TPM 2.0 Linux sysfs interface?
>> But even it's done in near future, we'd still need some way for older ke=
rnels.
>>
>> Kind regards,
>> Petr
>>
>> [1] https://patchwork.ozlabs.org/patch/1100733/
>
>version_major sysfs file would be acceptable if someone wants to proceed
>and send such patch.
>
>Also replicants for durations and timeouts files would make sense for
>TPM 2.0.
>
>/Jarkko

Is it as simple as doing this?

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index edfa89160010..fd8eb8d8945c 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, struc=
t device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeouts);
=20
-static struct attribute *tpm_dev_attrs[] =3D {
+static ssize_t version_major_show(struct device *dev,
+                                 struct device_attribute *attr, char *buf)
+{
+       struct tpm_chip *chip =3D to_tpm_chip(dev);
+
+       return sprintf(buf, "TPM%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
+                      ? "2.0" : "1.2");
+}
+static DEVICE_ATTR_RO(version_major);
+
+static struct attribute *tpm12_dev_attrs[] =3D {
        &dev_attr_pubek.attr,
        &dev_attr_pcrs.attr,
        &dev_attr_enabled.attr,
@@ -320,18 +330,28 @@ static struct attribute *tpm_dev_attrs[] =3D {
        &dev_attr_cancel.attr,
        &dev_attr_durations.attr,
        &dev_attr_timeouts.attr,
+       &dev_attr_version_major.attr,
        NULL,
 };
=20
-static const struct attribute_group tpm_dev_group =3D {
-       .attrs =3D tpm_dev_attrs,
+static struct attribute *tpm20_dev_attrs[] =3D {
+       &dev_attr_version_major.attr,
+       NULL
+};
+
+static const struct attribute_group tpm12_dev_group =3D {
+       .attrs =3D tpm12_dev_attrs,
+};
+
+static const struct attribute_group tpm20_dev_group =3D {
+       .attrs =3D tpm20_dev_attrs,
 };
=20
 void tpm_sysfs_add_device(struct tpm_chip *chip)
 {
-       if (chip->flags & TPM_CHIP_FLAG_TPM2)
-               return;
-
        WARN_ON(chip->groups_cnt !=3D 0);
-       chip->groups[chip->groups_cnt++] =3D &tpm_dev_group;
+       if (chip->flags & TPM_CHIP_FLAG_TPM2)
+               chip->groups[chip->groups_cnt++] =3D &tpm20_dev_group;
+       else
+               chip->groups[chip->groups_cnt++] =3D &tpm12_dev_group;
 }


Did a quick test on 2 systems here.

