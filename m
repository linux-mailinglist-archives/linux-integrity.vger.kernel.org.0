Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFF6367137
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 19:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbhDURWI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 13:22:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244628AbhDURWH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 13:22:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LH2g7M113466;
        Wed, 21 Apr 2021 13:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=lstJpaHwPFkUUecS6me/y6hgIuRLr1B2Zik2vEOtV1I=;
 b=d46kAqLLCLEbrPtCRsPmtm1U89QGxXVQSHqXIITTdg2OtAMICXksXzAHLA8llP/qoC60
 6/p0cc4NGLDpXpuBCdhhwGLdCp2fltGN5vmMYysSIBT4t7H28rDXiUkbAchScDz8PbeC
 QIURB8kH0vGCzlQJNG9hjhMthuf+bpndktdEwfk9tdi1hY7327kwc+PBFB0YwD5tQq3P
 Y4tAWMFmxWuQUIUP826vmWocwRXGBipqyTwmVRwhwqHrkejDzqtFxqmW0l7Ii02kxh9e
 prYQeaNVgOWRWr3MO0YT4/NvQQeohRxxy/4FLDmE6opejJz4v/grRlJKEF9h16Z3edCN og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382pqjm504-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 13:21:08 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13LH374m114846;
        Wed, 21 Apr 2021 13:21:08 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382pqjm4xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 13:21:08 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LHCZEJ012292;
        Wed, 21 Apr 2021 17:21:06 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3813tav4qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 17:21:06 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LHL56629098260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 17:21:05 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CD3D7805F;
        Wed, 21 Apr 2021 17:21:04 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DD4A78060;
        Wed, 21 Apr 2021 17:21:00 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.203.222])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 17:21:00 +0000 (GMT)
Message-ID: <e7a91c8c09722afe1fb1ec3aa7b6544e713183af.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/4] KEYS: trusted: Add generic trusted keys framework
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Date:   Wed, 21 Apr 2021 10:20:59 -0700
In-Reply-To: <CAFA6WYOzD-qhHrcnzvd9P7iFvEqWwf0NCKXrgrEgvnB5i_-SxQ@mail.gmail.com>
References: <20210301131127.793707-1-sumit.garg@linaro.org>
         <20210301131127.793707-2-sumit.garg@linaro.org>
         <65dcc9fa28833e6beb1eadf98b0ed3402404d693.camel@linux.ibm.com>
         <CAFA6WYOzD-qhHrcnzvd9P7iFvEqWwf0NCKXrgrEgvnB5i_-SxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mF_mQJ94uIxxjn9pVwPv8BfLpLfMiGuW
X-Proofpoint-GUID: 6unQ4mr8lhL0JY8r4cz4nOfNC94-vrI6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-04-21 at 16:38 +0530, Sumit Garg wrote:
> Hi James,
> 
> On Wed, 21 Apr 2021 at 04:47, James Bottomley <jejb@linux.ibm.com>
> wrote:
> > On Mon, 2021-03-01 at 18:41 +0530, Sumit Garg wrote:
> > > Current trusted keys framework is tightly coupled to use TPM
> > > device as an underlying implementation which makes it difficult
> > > for implementations like Trusted Execution Environment (TEE) etc.
> > > to provide trusted keys support in case platform doesn't posses a
> > > TPM device.
> > > 
> > > Add a generic trusted keys framework where underlying
> > > implementations can be easily plugged in. Create struct
> > > trusted_key_ops to achieve this, which contains necessary
> > > functions of a backend.
> > > 
> > > Also, define a module parameter in order to select a particular
> > > trust source in case a platform support multiple trust sources.
> > > In case its not specified then implementation itetrates through
> > > trust sources list starting with TPM and assign the first trust
> > > source as a backend which has initiazed successfully during
> > > iteration.
> > > 
> > > Note that current implementation only supports a single trust
> > > source at runtime which is either selectable at compile time or
> > > during boot via aforementioned module parameter.
> > 
> > You never actually tested this, did you?  I'm now getting EINVAL
> > from all the trusted TPM key operations because of this patch.
> > 
> 
> Unfortunately, I don't possess a development machine with a TPM
> device. So mine testing was entirely based on TEE as a backend which
> doesn't support any optional parameters. And that being the reason I
> didn't catch this issue at first instance.
> 
> Is there any TPM emulation environment available that I can use for
> testing?

Well use the same as we all use: A software TPM running in the host
coupled with a virtual machine guest for the kernel:

https://en.opensuse.org/Software_TPM_Emulator_For_QEMU

It doesn't catch interface issues (like TIS timeouts) but it does catch
TPM operations problems like this patch had.

James


