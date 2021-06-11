Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C163A393C
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Jun 2021 03:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhFKB0Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 21:26:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25198 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230169AbhFKB0Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 21:26:16 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15B137WB122516;
        Thu, 10 Jun 2021 21:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3UZaid9LaN7IOF3CYC1eCX4lLUxOwA2hKs9yAiR/CrQ=;
 b=p7XYyhONqsq/1w8WZCP5k6euYoyG036jAr/OTAHbEIUQLAex2y+jYNRf/0suYjsT+F4M
 iYejGfSPkqzpIkIm1ZHDis2t8Ctj83ZOauFBl/h5GL9oilx8Enz24mBfpe4PDQ//tsOC
 t9+t0++Icd+CQ81TjUU1TTaPjpfcNo/X4LPYIPajcqWQf3IJUtDYXE9RCvQAVA+iCPpg
 ZwEkLYHGeGtZZnTaRfr7GRLC+1gpRTrN+3NvLBHV82KnJ0M/ErUs28fBa/WMkAY0iDz0
 TrQBoKNHiTDn+T8HVLyKyTZDdOKmkc7wQ6SHsA34ilkXWRHguivJi9pkx8lkEXPMdKsK jw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393wq2gjms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 21:24:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15B1CK1m010743;
        Fri, 11 Jun 2021 01:24:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3900w8b4t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 01:24:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15B1OARc11469252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 01:24:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6260952054;
        Fri, 11 Jun 2021 01:24:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.28.13])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7DDC65204E;
        Fri, 11 Jun 2021 01:24:08 +0000 (GMT)
Message-ID: <f6251386feb733d4278e97c3501c09f8dc1a4105.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima: Fix warning: no previous prototype for
 function 'ima_post_key_create_or_update'
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        robh@kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tusharsu@linux.microsoft.com
Date:   Thu, 10 Jun 2021 21:24:07 -0400
In-Reply-To: <20210610171553.3806-2-nramas@linux.microsoft.com>
References: <20210610171553.3806-1-nramas@linux.microsoft.com>
         <20210610171553.3806-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yea9vnz1XdiVSQ4XiFFNhIcN1tMKdy32
X-Proofpoint-GUID: yea9vnz1XdiVSQ4XiFFNhIcN1tMKdy32
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_13:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxlogscore=889 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110005
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Thu, 2021-06-10 at 10:15 -0700, Lakshmi Ramasubramanian wrote:
> The function prototype for ima_post_key_create_or_update() is present
> in 'linux/ima.h'.  But this header file is not included in
> ima_asymmetric_keys.c where the function is implemented.  This results
> in the following compiler warning when "-Wmissing-prototypes" flag
> is turned on:
> 
>   security/integrity/ima/ima_asymmetric_keys.c:29:6: warning: no previous
>   prototype for 'ima_post_key_create_or_update' [-Wmissing-prototypes]
> 
> Include the header file 'linux/ima.h' in ima_asymmetric_keys.c to
> fix the compiler warning.
> 
> Fixes: 88e70da170e8 (IMA: Define an IMA hook to measure keys)
> Cc: stable@vger.kernel.org
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Roberto posted an equivalent patch "[PATCH 4/5] ima: Include header
defining ima_post_key_create_or_update()" earlier this week.

Compiler warnings don't meet the requirements for stable -
Documentation/process/stable-kernel-rules.rst.

thanks,

Mimi

