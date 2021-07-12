Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B823C5C3B
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhGLMiJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 08:38:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24750 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230361AbhGLMiI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 08:38:08 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CCY0wu069149;
        Mon, 12 Jul 2021 08:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=Zb9upJBc+YFn/3mIkuA4OTV9VZo9rl9+mOoR1WP0ZkA=;
 b=rIm/5LRqZYnHG0ihSRgBakRlmAeKv22MQAG8H4oLLE6Pgujp9FLutRTaagbdncbXcxsE
 Unkzv19HsM2FdqJYT5VTSsEqddSoTNRqfC8Ff3XhhPAkBVWH3FvhMZMzeND7s1cWeCHI
 yhOfKFDHrhrCBxfdEFcI6TKbxTqTM4zDP9pYJrmjQIaNeTAnZ70Etaa+c19IVrHWvMzh
 WSim2vaRTfZloPWvEBBPoPsBrQiiu576a6xSg6oQq2m3XGQRSnXkMmwhMhBTTdkqZ8oz
 vLlBf5nrOunYncP3iLoW48MOtO1BTywVOJ+uSygF6B9scvZD6fSqM7v7AUo7KJYIIV4R qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrsxrhg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 08:35:18 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16CCY2U9070075;
        Mon, 12 Jul 2021 08:35:17 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrsxrhfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 08:35:17 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16CCTUH9026547;
        Mon, 12 Jul 2021 12:35:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 39q3688s11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 12:35:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16CCZDjA23396774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:35:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AF7E42041;
        Mon, 12 Jul 2021 12:35:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 814FC42045;
        Mon, 12 Jul 2021 12:35:12 +0000 (GMT)
Received: from sig-9-65-203-86.ibm.com (unknown [9.65.203.86])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jul 2021 12:35:12 +0000 (GMT)
Message-ID: <d1b072c36b4d3770d6b7385836fbed2ec23be349.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3] ima-evm-utils: Support SM2 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Date:   Mon, 12 Jul 2021 08:35:11 -0400
In-Reply-To: <4f4a220d-23c5-dbf4-ac57-0ce16ecff2a7@linux.alibaba.com>
References: <20210526084455.56705-1-tianjia.zhang@linux.alibaba.com>
         <d7526f84-f7c9-cbc6-c4a5-3e8b8d78fb60@linux.alibaba.com>
         <10f55257f543cc1d63e7a8ae36cbf2433a01c30b.camel@linux.ibm.com>
         <bb6afba7-255f-5254-5ac7-e793c24d56d3@linux.alibaba.com>
         <5f61f4b0f305a26df0346524e4999c5bbb66571f.camel@linux.ibm.com>
         <4f4a220d-23c5-dbf4-ac57-0ce16ecff2a7@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5xSmMW_9Pzo11x5-FWLFFppRE628xTxn
X-Proofpoint-GUID: R3CYUZ0KPAMi4j9ZAsUEbzBxQVXdY5X8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_07:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107120099
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-07-12 at 20:12 +0800, Tianjia Zhang wrote:
> 
> On 7/9/21 8:05 PM, Mimi Zohar wrote:
> > On Fri, 2021-07-09 at 17:06 +0800, Tianjia Zhang wrote:
> >> On 7/7/21 10:28 AM, Mimi Zohar wrote:
> > 
> > 
> >>> I'm also seeing:
> >>> - openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 -sm3
> >>> -sigopt distid:1234567812345678 -config test-ca.conf -copy_extensions
> >>> copyall -newkey sm2 -out test-sm2.cer -outform DER -keyout test-sm2.key
> >>> req: Unrecognized flag copy_extensions
> >>>
> >>
> >> This command is for openssl 3.0, and '-copy_extensions copyall' is also
> >> a parameter supported on 3.0. At present, the mainstream version of
> >> openssl 1.1.1 only partially supports SM2 signatures. For example, the
> >> USERID in the SM2 specification cannot be used, and the certificate
> >> cannot be operated in the command using the SM2/3 algorithm combination,
> >> just like the modification of libimaevm.c in this patch, this cannot be
> >> done directly through the openssl command, even if the '-copy_extensions
> >> copyall' parameter is deleted, this command will be failed on openssl
> >> 1.1.1. The final solution may be openssl 3.0.
> >>
> >> On openssl 1.1.1, there is no problem to operate the signature of the
> >> SM2/3 algorithm combination through the API. If it is possible, the
> >> sign_verify test of sm2/3 is not required. What is your opinion?
> > 
> > Instead of dropping the test altogether, add an openssl version
> > dependency.
> 
> Great. will do in next version patch.

Please consider adding a new CI distro matrix rule that includes the
needed openssl version.  Another option would be to define a new script
in the tests directory to install openssl from the git repo.  Please
limit using that script to a single distro matrix rule.

thanks,

Mimi

