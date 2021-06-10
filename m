Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBEB3A34D9
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 22:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFJUd0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 16:33:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230083AbhFJUdZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 16:33:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15AKGgFG047083;
        Thu, 10 Jun 2021 16:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vzfKBBzMbwYTjZSiCQMZXB90Pu2FGbi+HCrs1yLDtLc=;
 b=iwsXdRGSoTfv9MhaAOHlObaNxXhFh7VyKJAqLqhHYNZHP2uHecl0635DkQoWjb9ygs0U
 TQ8sqwEsflQB8zGVSf9u3cPtwENScHbx/WFvjGyBsRbzHwSTaFuCGeAt7ZYC0SswvVdG
 Cd7wFDV5YpwaM3ni187M3Ji0tx1ASzwEBVBjApjbTVAXEoB6PZB3xROBQrWWUyt8lgrm
 wz4kIdFgVadVeAW4xKkaJjwzMnM3DBYFqm/9TEUI0NONsXRvGHvRZp3OicO5ACNOedNn
 /8cKSbAc/pI0r6xrQK1PFziA5utDM6DzUmAyqDfDmXsSvLXc2GE+b6wYUjCmmaB73GhG 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 393smt88wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 16:31:21 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15AKVKoH105046;
        Thu, 10 Jun 2021 16:31:20 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 393smt88w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 16:31:20 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15AKE8jh014264;
        Thu, 10 Jun 2021 20:31:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3900hhu27v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 20:31:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15AKVGU517236458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 20:31:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41CD8A4057;
        Thu, 10 Jun 2021 20:31:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4895BA404D;
        Thu, 10 Jun 2021 20:31:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.32.85])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jun 2021 20:31:14 +0000 (GMT)
Message-ID: <f0c6ab70093eb9e360232482ce415e9863a8699c.camel@linux.ibm.com>
Subject: Re: ima - wait for tpm load
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Date:   Thu, 10 Jun 2021 16:31:13 -0400
In-Reply-To: <20210610151801.GA19687@trex>
References: <20210610071633.GA30216@trex>
         <b3c1f5a0a37419fac51d570cd1c8e521f59cee14.camel@linux.ibm.com>
         <20210610151801.GA19687@trex>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N61KujLEAWV_vdE1Nhe93iRmmvAX39cf
X-Proofpoint-GUID: 31eahvPyzSqlKXUd3aY2EWBCUbQG8TUl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_13:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100129
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-06-10 at 17:18 +0200, Jorge Ramirez-Ortiz, Foundries
wrote:
> On 10/06/21, Mimi Zohar wrote:
> > [Cc'ing Jarkko]
> > 
> > On Thu, 2021-06-10 at 09:16 +0200, Jorge Ramirez-Ortiz, Foundries
> > wrote:
> > > I am enabling IMA on a ZynqMP based platform using an SPI based TPM
> > > from Infineon.
> > > 
> > > The SPI TPM driver is built-in but since the IMA is initalized from a
> > > late_initcall, IMA never finds the TPM.
> > > 
> > > Is there a recomended way to work around this issue?
> > > 
> > > fio@uz3cg-dwg:~$ dmesg | grep tpm
> > > [    3.381181] tpm_tis_spi spi1.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> > > [    3.423608] tpm tpm0: A TPM error (256) occurred attempting the self test
> > > [    3.430406] tpm tpm0: starting up the TPM manually
> > > 
> > > fio@uz3cg-dwg:~$ dmesg | grep ima
> > > [    3.525741] ima: No TPM chip found, activating TPM-bypass!
> > > [    3.531233] ima: Allocated hash algorithm: sha1
> > 
> > Lengthening the TPM timeout, executing the TPM self test have been past
> > reasons for the TPM not to initialize prior to IMA.
> 
> right, I can understand this.
> 
> The problem in this case is that tpm_chip_register() is taking too
> long so by the time it executes tpm_add_char_device(chip) is called,
> ima has already given up.
> 
> The way I am working around this is just by adding a new flag and
> providing the chip in idr_alloc (so ima can find it).
> 
> Then add an 'enable' flag to the chip structure that ima can use to
> wait on.
> 
> @@ -333,8 +345,13 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
> 
>         chip->ops = ops;
> 
> + if (ops->flags & TPM_OPS_SLOW_STARTUP)
> +         chip->flags |= TPM_CHIP_FLAG_SLOW_STARTUP;
> +
>         mutex_lock(&idr_lock);
> -   rc = idr_alloc(&dev_nums_idr, NULL, 0, TPM_NUM_DEVICES, GFP_KERNEL);
> + rc = idr_alloc(&dev_nums_idr,
> +                chip->flags & TPM_CHIP_FLAG_SLOW_STARTUP ? chip : NULL,
> +                0, TPM_NUM_DEVICES, GFP_KERNEL);
>         mutex_unlock(&idr_lock);
>         if (rc < 0) {
>                 dev_err(pdev, "No available tpm device numbers\n");

As I recall "extend" works pretty much from the beginning.  There's no
need to wait for the self test to complete.   Registering the TPM early
might be enough without having to wait.  Or maybe check the selftest
result.

Thank you for looking into resolving this problem!

Mimi

> 
> 
> > 
> > (Missing from this bug report is the kernel version.)
> 
> um, didnt think of it as a bug report - the feature is clearly not
> synchronized so there can be no guarantees about available TPMs being
> used. 
> 
> but yes, this is happening on 5.10.42 using tpm_tis_spi to connect to
> infineon SLM9670


