Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E5E40AB
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 02:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfJYArK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 20:47:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387940AbfJYArK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 20:47:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P0hCUV140531
        for <linux-integrity@vger.kernel.org>; Thu, 24 Oct 2019 20:47:08 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vuj4cg4dv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 24 Oct 2019 20:47:08 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 25 Oct 2019 01:47:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 01:47:03 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9P0l2cJ34865272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 00:47:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7782052054;
        Fri, 25 Oct 2019 00:47:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.206.19])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2CB9152052;
        Fri, 25 Oct 2019 00:47:01 +0000 (GMT)
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Petr Vorel <pvorel@suse.cz>, Nayna <nayna@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Thu, 24 Oct 2019 20:47:00 -0400
In-Reply-To: <20191024213842.c6cl4tlnsi56pgcy@cantor>
References: <1558041162.3971.2.camel@linux.ibm.com>
         <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
         <20190517150456.GA11796@dell5510> <20191024121848.GA5908@dell5510>
         <20191024172023.GA7948@linux.intel.com>
         <20191024213842.c6cl4tlnsi56pgcy@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102500-0012-0000-0000-0000035D2A2A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102500-0013-0000-0000-000021985EC6
Message-Id: <1571964420.5173.12.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250006
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-24 at 14:38 -0700, Jerry Snitselaar wrote:
> On Thu Oct 24 19, Jarkko Sakkinen wrote:
> >On Thu, Oct 24, 2019 at 02:18:48PM +0200, Petr Vorel wrote:
> >> Hi all,
> >>
> >> I wonder what to do with this patch "ima: skip verifying TPM 2.0 PCR values" [1].
> >> Is it a correct way to differentiate between TPM 1.2 and TPM 2.0?
> >> Or something else should be applied?
> >>
> >> How is the work on TPM 2.0 Linux sysfs interface?
> >> But even it's done in near future, we'd still need some way for older kernels.
> >>
> >> Kind regards,
> >> Petr
> >>
> >> [1] https://patchwork.ozlabs.org/patch/1100733/
> >
> >version_major sysfs file would be acceptable if someone wants to proceed
> >and send such patch.
> >
> >Also replicants for durations and timeouts files would make sense for
> >TPM 2.0.
> >
> >/Jarkko
> 
> Is it as simple as doing this?
> 
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index edfa89160010..fd8eb8d8945c 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(timeouts);
>  
> -static struct attribute *tpm_dev_attrs[] = {
> +static ssize_t version_major_show(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
> +{
> +       struct tpm_chip *chip = to_tpm_chip(dev);
> +
> +       return sprintf(buf, "TPM%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
> +                      ? "2.0" : "1.2");
> +}
> +static DEVICE_ATTR_RO(version_major);
> +
> +static struct attribute *tpm12_dev_attrs[] = {
>         &dev_attr_pubek.attr,
>         &dev_attr_pcrs.attr,
>         &dev_attr_enabled.attr,
> @@ -320,18 +330,28 @@ static struct attribute *tpm_dev_attrs[] = {
>         &dev_attr_cancel.attr,
>         &dev_attr_durations.attr,
>         &dev_attr_timeouts.attr,
> +       &dev_attr_version_major.attr,
>         NULL,
>  };
>  

The TPM version seems to be included in "dev_attr_caps.attr".

> -static const struct attribute_group tpm_dev_group = {
> -       .attrs = tpm_dev_attrs,
> +static struct attribute *tpm20_dev_attrs[] = {
> +       &dev_attr_version_major.attr,
> +       NULL
> +};

This should work, but wouldn't exporting this information under
security/tpmX, like the binary_bios_measurements, be a lot easier to
find and use?

Mimi

> +
> +static const struct attribute_group tpm12_dev_group = {
> +       .attrs = tpm12_dev_attrs,
> +};
> +
> +static const struct attribute_group tpm20_dev_group = {
> +       .attrs = tpm20_dev_attrs,
>  };
>  
>  void tpm_sysfs_add_device(struct tpm_chip *chip)
>  {
> -       if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -               return;
> -
>         WARN_ON(chip->groups_cnt != 0);
> -       chip->groups[chip->groups_cnt++] = &tpm_dev_group;
> +       if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +               chip->groups[chip->groups_cnt++] = &tpm20_dev_group;
> +       else
> +               chip->groups[chip->groups_cnt++] = &tpm12_dev_group;
>  }
> 
> 
> Did a quick test on 2 systems here.

