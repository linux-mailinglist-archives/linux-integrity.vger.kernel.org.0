Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F293C6680
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 00:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhGLWsA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 18:48:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229931AbhGLWsA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 18:48:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CMXma5002998;
        Mon, 12 Jul 2021 18:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NGlTYBJGMqCyEAmKkiQZNloDrvxCE6TSdJnmqBOO8vM=;
 b=iPJ90cG/o0cAcZRGHbm4nSFWqC/zfBnwAckZ5j/neFbgsv531CgT9Lhl/KVIrHo60lYg
 MuqJSMeM7Lwq1iC6u8PQ+9XAuTD3BafjzvGjWNfgzB6ki0JbSkNCrolDiWgN4dWWm88Y
 9S/BfS7wYFim3fmf5snTCD55kEDOsNWbeuZpWDmf6pQI6aP5kqgbzVTQIlboAyaIjkQR
 TpSUFAQIs5PC0EJsMwmhxHB3M0mQdnSJyMEzjBIrfeKSZ3d1sopefGSHRQg9mQxb2ZWD
 xReSLb3EbwatWA9WEpfn59/3yySuP58HHwx0sHErgTWAdcx5iJa+7cs58iOmokHCeTlP zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrkw7wuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 18:45:07 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16CMiFTg033533;
        Mon, 12 Jul 2021 18:45:06 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrkw7wtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 18:45:06 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16CMdfaD005015;
        Mon, 12 Jul 2021 22:45:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 39q368ggwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 22:45:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16CMj1QS23068964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 22:45:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBDA711C0B5;
        Mon, 12 Jul 2021 22:45:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83E3911C0BA;
        Mon, 12 Jul 2021 22:45:00 +0000 (GMT)
Received: from sig-9-65-203-86.ibm.com (unknown [9.65.203.86])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jul 2021 22:45:00 +0000 (GMT)
Message-ID: <611f4c83d27d4c7360e3d9041fdce859577cc7cc.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3] ima-evm-utils: Support SM2 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Date:   Mon, 12 Jul 2021 18:44:59 -0400
In-Reply-To: <YOylqbuLL4gj0yTF@pevik>
References: <20210526084455.56705-1-tianjia.zhang@linux.alibaba.com>
         <d7526f84-f7c9-cbc6-c4a5-3e8b8d78fb60@linux.alibaba.com>
         <10f55257f543cc1d63e7a8ae36cbf2433a01c30b.camel@linux.ibm.com>
         <bb6afba7-255f-5254-5ac7-e793c24d56d3@linux.alibaba.com>
         <5f61f4b0f305a26df0346524e4999c5bbb66571f.camel@linux.ibm.com>
         <4f4a220d-23c5-dbf4-ac57-0ce16ecff2a7@linux.alibaba.com>
         <d1b072c36b4d3770d6b7385836fbed2ec23be349.camel@linux.ibm.com>
         <3b5aea51-c82c-70f3-d41e-d615bc14823a@linux.alibaba.com>
         <YOylqbuLL4gj0yTF@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y_1Kys0g0zA6DXNCoTCJeoMsmTBsbxHn
X-Proofpoint-ORIG-GUID: rc7w5T7xkd8hzhKGIY9jb828LEn_kHsc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_14:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107120154
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-07-12 at 22:27 +0200, Petr Vorel wrote:
> Hi Tianjia, Mimi,
> 
> > On 7/12/21 8:35 PM, Mimi Zohar wrote:
> > > On Mon, 2021-07-12 at 20:12 +0800, Tianjia Zhang wrote:
> 
> > > > On 7/9/21 8:05 PM, Mimi Zohar wrote:
> > > > > On Fri, 2021-07-09 at 17:06 +0800, Tianjia Zhang wrote:
> > > > > > On 7/7/21 10:28 AM, Mimi Zohar wrote:
> 
> 
> > > > > > > I'm also seeing:
> > > > > > > - openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 -sm3
> > > > > > > -sigopt distid:1234567812345678 -config test-ca.conf -copy_extensions
> > > > > > > copyall -newkey sm2 -out test-sm2.cer -outform DER -keyout test-sm2.key
> > > > > > > req: Unrecognized flag copy_extensions
> 
> 
> > > > > > This command is for openssl 3.0, and '-copy_extensions copyall' is also
> > > > > > a parameter supported on 3.0. At present, the mainstream version of
> > > > > > openssl 1.1.1 only partially supports SM2 signatures. For example, the
> > > > > > USERID in the SM2 specification cannot be used, and the certificate
> > > > > > cannot be operated in the command using the SM2/3 algorithm combination,
> > > > > > just like the modification of libimaevm.c in this patch, this cannot be
> > > > > > done directly through the openssl command, even if the '-copy_extensions
> > > > > > copyall' parameter is deleted, this command will be failed on openssl
> > > > > > 1.1.1. The final solution may be openssl 3.0.
> 
> > > > > > On openssl 1.1.1, there is no problem to operate the signature of the
> > > > > > SM2/3 algorithm combination through the API. If it is possible, the
> > > > > > sign_verify test of sm2/3 is not required. What is your opinion?
> 
> > > > > Instead of dropping the test altogether, add an openssl version
> > > > > dependency.
> 
> > > > Great. will do in next version patch.
> 
> > > Please consider adding a new CI distro matrix rule that includes the
> > > needed openssl version.  Another option would be to define a new script
> > > in the tests directory to install openssl from the git repo.  Please
> > > limit using that script to a single distro matrix rule.
> 
> 
> > Got it, thanks for your suggestion. It seems that the second method is more
> > suitable.
> Although it appears there is no distro which would have openssl 3.0 [1],
> Debian actually have 3.0.0~~beta1-1 in experimental [2]. openSUSE has slightly
> older version openssl-3.0.0-alpha16 [3]. I suppose we update soon to beta1 as
> well.
> 
> Using distro packages would be probably faster to run in CI than install from git.

Definitely!

thanks,

Mimi


