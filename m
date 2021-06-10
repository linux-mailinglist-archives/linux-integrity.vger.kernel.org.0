Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE153A2DF9
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 16:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhFJOWP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 10:22:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45268 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhFJOWN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 10:22:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15AEENVB055864;
        Thu, 10 Jun 2021 10:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=f+GezljSdiJkbrktAHsZueMoVCCsL7CmeGI26dX+WHM=;
 b=dDXd2IQPWrl0IYR+bMqeHQOz2uCKga9izEsuCWjDu81+gjvVRPAGk0Ft/fpT1rKtXuh1
 thpcpJBgg/2HgHqzTPQ4pOnaoxAMwOpy229ksySXnu/DzjYVQKpMeO3Rpa6UA96AU/nU
 rpjkXVEmrIYJrITYRQ+9e6X8NAYJopIkyaSXt7My+CssWWO2B3zeljbW+sNU4K94kHda
 cICxFaayG8prY23cHSaJxh92HXDOvucV5C68Q03YhA3iabdUyMlirhhsPevFJiculFNY
 FKWVusxiaO3jqE01HtfUZqpQbULiJr3DXyoyyQh8TgqYxpFei/XT1rEt8BIpSNBJL5Hv CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393man86yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 10:20:07 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15AEFNvM062503;
        Thu, 10 Jun 2021 10:20:06 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393man86xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 10:20:06 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15AEG7Ds013524;
        Thu, 10 Jun 2021 14:20:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3900w8avdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 14:20:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15AEJBRe26739060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 14:19:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BA6D4C05A;
        Thu, 10 Jun 2021 14:20:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 410024C058;
        Thu, 10 Jun 2021 14:19:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.91.59])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jun 2021 14:19:59 +0000 (GMT)
Message-ID: <b3c1f5a0a37419fac51d570cd1c8e521f59cee14.camel@linux.ibm.com>
Subject: Re: ima - wait for tpm load
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Date:   Thu, 10 Jun 2021 10:19:58 -0400
In-Reply-To: <20210610071633.GA30216@trex>
References: <20210610071633.GA30216@trex>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0U3gc6pr1KzWqWTNLPRcz7M3gCbXPNHb
X-Proofpoint-GUID: rlXwXebxr61XdBXnHvUQfvIM0CGIRX5e
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_07:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1011 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100091
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Jarkko]

On Thu, 2021-06-10 at 09:16 +0200, Jorge Ramirez-Ortiz, Foundries
wrote:
> I am enabling IMA on a ZynqMP based platform using an SPI based TPM
> from Infineon.
> 
> The SPI TPM driver is built-in but since the IMA is initalized from a
> late_initcall, IMA never finds the TPM.
> 
> Is there a recomended way to work around this issue?
> 
> fio@uz3cg-dwg:~$ dmesg | grep tpm
> [    3.381181] tpm_tis_spi spi1.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> [    3.423608] tpm tpm0: A TPM error (256) occurred attempting the self test
> [    3.430406] tpm tpm0: starting up the TPM manually
> 
> fio@uz3cg-dwg:~$ dmesg | grep ima
> [    3.525741] ima: No TPM chip found, activating TPM-bypass!
> [    3.531233] ima: Allocated hash algorithm: sha1

Lengthening the TPM timeout, executing the TPM self test have been past
reasons for the TPM not to initialize prior to IMA.

(Missing from this bug report is the kernel version.)

thanks,

Mimi

