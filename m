Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81DD3E4BE8
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 20:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhHISNB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 14:13:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51024 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231357AbhHISNB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 14:13:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179I6OrB156955;
        Mon, 9 Aug 2021 14:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=drIZvBVPpu/VxN56GHjmzGfNxrClThzQ6ON2BzaQzc8=;
 b=UkqZctICwcrGua3ew9cdsPMh+ZxPT3Xmt3tLLRHRopNvOwDhtfoNas9RhAfndl0DcZQm
 O8qB83pHWlZSO28BJvX4/NjeW8vJDTr0qiVNsBxMNSEUhuDRSzhAu2b1HCCK95eIwrqn
 Dt6HCnxAOP7nZqTyAxAozqKzhsCjmGs3rtrR1EB+i6tPL4gtopEKkAveADI7Xs5Bxz0S
 Q+2VbIU/g5L5WWhi2y7yWqCxdsVJiwE+wtOwoAvDHG4R4z7fDlsGjTX16gvw+lf+SlaH
 XlmR8Kx7xfyJUP6/ZZwO+K1uM8i+zbVvFfy2DaBxJgCXsEu3j6igDfpuHh6Xjz/JGQXJ oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab5k3qgbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 14:12:38 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 179IAWtw177799;
        Mon, 9 Aug 2021 14:12:38 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab5k3qgb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 14:12:38 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179I87i3026172;
        Mon, 9 Aug 2021 18:12:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3a9ht8m14n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 18:12:36 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179ICXM241287968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 18:12:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76993A409F;
        Mon,  9 Aug 2021 18:12:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2548FA408B;
        Mon,  9 Aug 2021 18:12:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.79.43])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 18:12:31 +0000 (GMT)
Message-ID: <d5c10e30a5424bb1498e2f827c1b2fdb19937723.camel@linux.ibm.com>
Subject: Re: [PATCH v6 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Mon, 09 Aug 2021 14:12:31 -0400
In-Reply-To: <2b1f1c32-b4c8-154f-e733-b2738c35d6fe@linux.microsoft.com>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
         <20210804092010.350372-6-simon.thoby@viveris.fr>
         <2b1f1c32-b4c8-154f-e733-b2738c35d6fe@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: naPuZ7eZ-WL_PqlUiRj7mKShUHFO7gae
X-Proofpoint-GUID: 73vBGM_TUhX5FPvTjgl-3KL6vZ4lf4bD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_06:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Wed, 2021-08-04 at 11:49 -0700, Lakshmi Ramasubramanian wrote:
> On 8/4/2021 2:20 AM, THOBY Simon wrote:

> > > > diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> > index aeb622698047..537be0e1720e 100644
> > --- a/Documentation/ABI/testing/ima_policy
> > +++ b/Documentation/ABI/testing/ima_policy
> > @@ -30,9 +30,10 @@ Description:
> >   				[appraise_flag=] [appraise_hash=] [keyrings=]
> >   		  base:
> >   			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
> > -			        [FIRMWARE_CHECK]
> > +				[FIRMWARE_CHECK]
> Is there a white space in the above line that is showing up as a change 
> in this patch?

Blanks are being replaced with a tab.

Mimi

