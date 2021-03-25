Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A487A3494FE
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Mar 2021 16:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhCYPKa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Mar 2021 11:10:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230512AbhCYPKJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Mar 2021 11:10:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12PF5NOS076836;
        Thu, 25 Mar 2021 11:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rravADpvfL0QIpujNbNT4TsZjUwxpTDGUfrXBRxDamg=;
 b=CqxNirFAAmoKb+ExR3AYjFmjJ1aO9lcbYCUlvTdRD/5Ba2upzBGtIAAFrwvWN7mB9/lh
 1yKnhebjCl78NkELKLmRqp8p6xssl3K85c/W/ZevnxtdZ0pmdDhI77bqe0w2LkksnhkZ
 Ky4TP9on1jSrJECfQpXN14BZR+WlcMOrRiHh1Wvw+hojC65HqDf6sFH858BSdkANaCCi
 2YtQBH0umOzTlBeOGfD2onttusZ040LMUuZnNawhEgMpZIvlMK8WUsUezuH6sQ8hF6+7
 QVCGRH8nDlz5Ks1mtE6AURhWFe8HHznidnU7/DrJki5aGRaa/V/eQeId9zXpkKdjS20o AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37gvavhb3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 11:09:41 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12PF5YeG077253;
        Thu, 25 Mar 2021 11:09:40 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37gvavhb0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 11:09:39 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12PEvhBg027442;
        Thu, 25 Mar 2021 15:09:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 37d9bptvqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 15:09:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12PF9V3N38142278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 15:09:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBA6C52050;
        Thu, 25 Mar 2021 15:09:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.11.141])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 44CBD5204F;
        Thu, 25 Mar 2021 15:09:29 +0000 (GMT)
Message-ID: <39af167527d6478f86431c2ce29f68177700e82d.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix the error code for restoring the PCR value
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        lihuafei <lihuafei1@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        yangjihong <yangjihong1@huawei.com>,
        Zhangjinhao <zhangjinhao2@huawei.com>
Date:   Thu, 25 Mar 2021 11:09:27 -0400
In-Reply-To: <0764ed04a7e84546a8b31fc13b264c47@huawei.com>
References: <20210303032824.124112-1-lihuafei1@huawei.com>
         <9df8d712-0e58-f95d-8f95-5feae2150b42@huawei.com>
         <0764ed04a7e84546a8b31fc13b264c47@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_04:2021-03-24,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-03-24 at 09:00 +0000, Roberto Sassu wrote:
> > From: lihuafei
> > Sent: Tuesday, March 23, 2021 2:41 PM
> > ping. :-)
> > 
> > On 2021/3/3 11:28, Li Huafei wrote:
> > > In ima_restore_measurement_list(), hdr[HDR_PCR].data is pointing to a
> > > buffer of type u8, which contains the dumped 32-bit pcr value.
> > > Currently, only the least significant byte is used to restore the pcr
> > > value. We should convert hdr[HDR_PCR].data to a pointer of type u32
> > > before fetching the value to restore the correct pcr value.
> > >
> > > Fixes: 47fdee60b47f ("ima: use ima_parse_buf() to parse measurements
> > headers")
> > > Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> 
> Hi Li Huafei
> 
> yes, correct. Thanks for the patch.
> 
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

The patch set is now queued in next-integrity-testing.

thanks,

Mimi

