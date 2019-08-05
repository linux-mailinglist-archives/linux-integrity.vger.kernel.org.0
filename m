Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17B81F13
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 16:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfHEO2Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 10:28:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729163AbfHEO2Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 10:28:24 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75ELr1m085821
        for <linux-integrity@vger.kernel.org>; Mon, 5 Aug 2019 10:28:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u6n024g2f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Aug 2019 10:28:23 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 5 Aug 2019 15:28:21 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Aug 2019 15:28:18 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x75ES0Du31129946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Aug 2019 14:28:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 835F611C058;
        Mon,  5 Aug 2019 14:28:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2096911C04C;
        Mon,  5 Aug 2019 14:28:16 +0000 (GMT)
Received: from dhcp-9-31-103-47.watson.ibm.com (unknown [9.31.103.47])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Aug 2019 14:28:15 +0000 (GMT)
Subject: Re: [PATCH] ima: Allow to import the blacklisted cert signed by
 secondary CA cert
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, dhowells@redhat.com,
        dmitry.kasatkin@gmail.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Mark D. Baushke" <mdb@juniper.net>,
        Petko Manolov <petkan@mip-labs.com>
Date:   Mon, 05 Aug 2019 10:28:15 -0400
In-Reply-To: <d6a27436-3822-3dda-a3be-4e2dfbe04390@linux.alibaba.com>
References: <1564622625-112173-1-git-send-email-zhang.jia@linux.alibaba.com>
         <1564700229.11223.9.camel@linux.ibm.com>
         <d6a27436-3822-3dda-a3be-4e2dfbe04390@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080514-0008-0000-0000-000003056D1C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080514-0009-0000-0000-0000A17F72E7
Message-Id: <1565015295.11223.147.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050159
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-08-02 at 09:42 +0800, Jia Zhang wrote:
> 
> On 2019/8/2 上午6:57, Mimi Zohar wrote:
> > Hi Jia,
> > 
> > On Thu, 2019-08-01 at 09:23 +0800, Jia Zhang wrote:
> >> Similar to .ima, the cert imported to .ima_blacklist is able to be
> >> authenticated by a secondary CA cert.
> >>
> >> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> > 
> > The IMA blacklist, which is defined as experimental for a reason, was
> > upstreamed prior to the system blacklist.  Any reason you're not using
> > the system blacklist?  Before making this sort of change, I'd like
> > some input from others.
> 
> In our trusted cloud service, the IMA private key is controlled by
> tenant for some reason. Some unprofessional operations made by tenant
> may lead to the leakage of IMA private key. So the need for importing
> the blacklisted is necessary，without system/kexec reboot, on the
> contrary, the system blacklist needs a kernel rebuild and system/kexec
> reboot, without runtime and fine-grained control.
> 
> The secondary CA cert has a similar story, but it is not controlled by
> tenant. It is always imported during system/kexec boot to serve
> importing IMA trusted cert and IMA blacklisted cert.

Before expanding the set of keys permitted to blacklist a key on the
IMA keyring, there needs to be a way of differentiating how keys may
be used.  The same certificate should not be allowed to be loaded onto
both the IMA and the IMA blacklist keyrings for obvious reasons.

The normal way of blacklisting a key is by using CRLs.  I'm not
recommending adding full CRL support in the kernel, but using the key
usage extension to differentiate who may sign a certificate being
black listed.  Please refer to section "4.2.1.3.  Key Usage", in
particular the cRLSign bit.

thanks,

Mimi

