Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527AD3C2343
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhGIMId (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jul 2021 08:08:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56482 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230404AbhGIMId (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jul 2021 08:08:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169C38p7029635;
        Fri, 9 Jul 2021 08:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=NT43wmVfjmDEHmkGySUfnI1q3H+4FGBjK7r1lHv/m8w=;
 b=df9ZCGaZwX1kpHSzqglSjiqaRs3hpttsi74Idk0mx5CUj1jre9ZW+LqWzKsA9SPVJ78r
 GD+iUF/BS80CW4SDykKkWT4mf+FB/QL3jsDrnH+JxNtoLs60BagUcuH3y8Bh/hDopZ+o
 fylUcSW8VP7urSmqQu9zxnbhj/Puo24jv+FPADkNjIZGWKwRGa4NwlLUAkXKRSRYFLb9
 8++/zdpTXlPBoHJEKuiJBK54Khq382DW8QNUkAdgoaznL0102UpmEB5VahTHQuY/rKtZ
 gq+/69/XRnNEKUpAjmaR1eN/vSmW6NvSr7Vf8OYKychsN6DE9kBThXW/Nj5m4a477sbU GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39p0hrde8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 08:05:47 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 169C3Txw030935;
        Fri, 9 Jul 2021 08:05:47 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39p0hrde83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 08:05:47 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 169C20tg029512;
        Fri, 9 Jul 2021 12:05:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 39jf5hanmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 12:05:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 169C5hLb33816916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jul 2021 12:05:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DDD111C054;
        Fri,  9 Jul 2021 12:05:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED5D511C05B;
        Fri,  9 Jul 2021 12:05:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.81.156])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Jul 2021 12:05:41 +0000 (GMT)
Message-ID: <5f61f4b0f305a26df0346524e4999c5bbb66571f.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3] ima-evm-utils: Support SM2 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Date:   Fri, 09 Jul 2021 08:05:41 -0400
In-Reply-To: <bb6afba7-255f-5254-5ac7-e793c24d56d3@linux.alibaba.com>
References: <20210526084455.56705-1-tianjia.zhang@linux.alibaba.com>
         <d7526f84-f7c9-cbc6-c4a5-3e8b8d78fb60@linux.alibaba.com>
         <10f55257f543cc1d63e7a8ae36cbf2433a01c30b.camel@linux.ibm.com>
         <bb6afba7-255f-5254-5ac7-e793c24d56d3@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ng6SsYBIDmHOStuigIQ6_Ny8Mx0tmIQw
X-Proofpoint-ORIG-GUID: esV8JD2qOtFpfppYv14VlOQDBFhE8gTT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_05:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090061
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-07-09 at 17:06 +0800, Tianjia Zhang wrote:
> On 7/7/21 10:28 AM, Mimi Zohar wrote:


> > I'm also seeing:
> > - openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 -sm3
> > -sigopt distid:1234567812345678 -config test-ca.conf -copy_extensions
> > copyall -newkey sm2 -out test-sm2.cer -outform DER -keyout test-sm2.key
> > req: Unrecognized flag copy_extensions
> > 
> 
> This command is for openssl 3.0, and '-copy_extensions copyall' is also 
> a parameter supported on 3.0. At present, the mainstream version of 
> openssl 1.1.1 only partially supports SM2 signatures. For example, the 
> USERID in the SM2 specification cannot be used, and the certificate 
> cannot be operated in the command using the SM2/3 algorithm combination, 
> just like the modification of libimaevm.c in this patch, this cannot be 
> done directly through the openssl command, even if the '-copy_extensions 
> copyall' parameter is deleted, this command will be failed on openssl 
> 1.1.1. The final solution may be openssl 3.0.
> 
> On openssl 1.1.1, there is no problem to operate the signature of the 
> SM2/3 algorithm combination through the API. If it is possible, the 
> sign_verify test of sm2/3 is not required. What is your opinion?

Instead of dropping the test altogether, add an openssl version
dependency.

thanks,

Mimi

