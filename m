Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE93F1AE0
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhHSNsO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 09:48:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239919AbhHSNsN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 09:48:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JDXUDP042517;
        Thu, 19 Aug 2021 09:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=lmCX3xirj2yr3m9fviadcL2ht297AW8kVkM8618LgoY=;
 b=foL6RCePU3jhLEEeUlnoz/gYRbzxBBhPU4JsTteF6+r9jbKxddxEap7z5McXLOmOzH1S
 BNXQqaN7Ra9tU7gEB3BV3syl/FPH7lLlcV9fJyd+DBYfJ3lql1UsAdY3YtrvFZLAZqxu
 flyzuDbqDXYOKXWhewWzpk+YamWL4oANfK9GCna0X6Tt3rqxf+xWO+3J93y2HwcAT7vU
 2xSAxTQut4T7asV5en2ZYoHsNJagVlVQEQNvjzzOV+KFF5YOsLZ4TPHk7uFNIAdTHRPA
 F90/Z367Cx47vBmQlB4tT7uelL5yaoqUmhi1tAkm1hkJyusYyu5QS27PVsZm47kfd1uj zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahk0y9qha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:47:29 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JDXZPH043046;
        Thu, 19 Aug 2021 09:47:28 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahk0y9qf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:47:28 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JDgXhG022640;
        Thu, 19 Aug 2021 13:47:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ae5f8gbk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 13:47:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JDlNxt48693692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 13:47:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E82652076;
        Thu, 19 Aug 2021 13:47:23 +0000 (GMT)
Received: from sig-9-65-206-165.ibm.com (unknown [9.65.206.165])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B48E25205F;
        Thu, 19 Aug 2021 13:47:21 +0000 (GMT)
Message-ID: <ed27351e0574f58ee59a3024554b8b0c7293515f.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        liqiong <liqiong@nfschina.com>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 19 Aug 2021 09:47:20 -0400
In-Reply-To: <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
         <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n_CbaYba6B_QNcPfZJvWKqYBN2RbNEY8
X-Proofpoint-ORIG-GUID: 4XccRGiFYSlgmYn4mt-9HQQtbsMYKhK-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_04:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190079
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-19 at 12:58 +0000, THOBY Simon wrote:
> Hi Liqiong,
> 
> On 8/19/21 12:15 PM, liqiong wrote:
> > When "ima_match_policy" is looping while "ima_update_policy" changs
> > the variable "ima_rules", then "ima_match_policy" may can't exit loop,
> > and kernel keeps printf "rcu_sched detected stall on CPU ...".
> > 
> > It occurs at boot phase, systemd-services are being checked within
> > "ima_match_policy,at the same time, the variable "ima_rules"
> > is changed by a service.
> 
> First off, thanks for finding and identifying this nasty bug.

Once the initial builtin policy rules have been replaced by a custom
policy, rules may only be appended by splicing the new rules with the
existing rules.  There should never be a problem reading the rules at
that point.   Does this problem occur before the builtin policy rules
have been replaced with a custom policy?

Mimi

