Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED534467EB
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Nov 2021 18:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhKERbw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Nov 2021 13:31:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234280AbhKERbw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Nov 2021 13:31:52 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5HBmVU017120;
        Fri, 5 Nov 2021 17:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KIBOQwiMkltIEZd0nLJ+XGokU70edvB4BdVLlUrPiWI=;
 b=oWmhTHUMNOMIFupYJeGBMj24j5/LBbBGdcx++tSNQd5WRtNe4yzAksWKyTQnjI7dusY1
 ydF/yU3avCRfXU00I08eLUZCDMS5x/6hWRBiwu+Y0OZBueEgxmElWuN9KfjZ1wbnv5nt
 R9Q33e2IUmVVspZLujImeJc33X5E2N21zzVweEthUOub5IsB+4f399idQ5HUEfho1BTt
 oXEnVycnVIJjGn2+ECxDht5F/tLWYsm8mVqx2AUqbkyR/vqzRFc5TSfHe61oFIIuaQpU
 3HhXMATHArDL5nQhbHthAOH4fAHM5KZ0daAhLBQLdxySq1DUz2mIQ/LQ+uT1n4vzQpE+ jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c56aubxxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 17:29:06 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A5HLK1n026591;
        Fri, 5 Nov 2021 17:29:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c56aubxwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 17:29:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A5HRG4T017754;
        Fri, 5 Nov 2021 17:29:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3c4t4cpxk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 17:29:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A5HT1BH55837000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Nov 2021 17:29:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1626BA405B;
        Fri,  5 Nov 2021 17:29:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60C6DA4060;
        Fri,  5 Nov 2021 17:29:00 +0000 (GMT)
Received: from sig-9-77-136-168.ibm.com (unknown [9.77.136.168])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Nov 2021 17:29:00 +0000 (GMT)
Message-ID: <9475f96833540e0601b23b40cbc1dcbc30903ec6.camel@linux.ibm.com>
Subject: Re: ima-evm-utils: version 1.4 released
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Fri, 05 Nov 2021 13:28:59 -0400
In-Reply-To: <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
         <YYToG+8u/edIcc3u@pevik>
         <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k5Pz04of-f2yQTdHy6sbPCJ7MhX7dOiz
X-Proofpoint-ORIG-GUID: x1PkviYE51m0ng9b2e1-izibCSOSx9Bs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_02,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-11-05 at 09:21 -0700, Lakshmi Ramasubramanian wrote:
> On 11/5/2021 1:15 AM, Petr Vorel wrote:
> > Hi Mimi,
> > 
> >> Please refer to the NEWS file for the short summary and the git history
> >> for details of the ima-evm-utils v1.4 release.
> 
> Thanks for the info Mimi.
> 
> I checked both "master" and "next-testing" branches in the following, 
> and I still see 1.3.2 version only.
> 
> 	https://github.com/pevik/ima-evm-utils
> 
> Is there a different github url for the latest ima-evm-utils source?

The original sf git repo https://sourceforge.net/projects/linux-ima/
and the new github https://github.com/mimizohar/ima-evm-utils.

Mimi

