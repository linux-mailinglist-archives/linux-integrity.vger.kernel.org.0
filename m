Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96E1102D4
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 17:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLCQrw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Dec 2019 11:47:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726466AbfLCQrv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Dec 2019 11:47:51 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3GhsDk147049
        for <linux-integrity@vger.kernel.org>; Tue, 3 Dec 2019 11:47:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wntcsb9yj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Dec 2019 11:47:50 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 3 Dec 2019 16:47:48 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 16:47:45 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3GlihS29098084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 16:47:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0FE7A4054;
        Tue,  3 Dec 2019 16:47:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79031A4060;
        Tue,  3 Dec 2019 16:47:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.191.79])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 16:47:42 +0000 (GMT)
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Tue, 03 Dec 2019 11:47:41 -0500
In-Reply-To: <e2faf0d0-fee1-96fe-1120-c003761aa517@linux.microsoft.com>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
         <20191127015654.3744-6-nramas@linux.microsoft.com>
         <1575375945.5241.16.camel@linux.ibm.com>
         <e2faf0d0-fee1-96fe-1120-c003761aa517@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120316-4275-0000-0000-0000038A9660
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120316-4276-0000-0000-0000389E356B
Message-Id: <1575391661.5241.47.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_05:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxlogscore=930 clxscore=1015 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912030125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-03 at 08:13 -0800, Lakshmi Ramasubramanian wrote:
> On 12/3/2019 4:25 AM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> > Hi Lakshmi,
> > 
> > A keyring can be created by any user with any keyring name, other than
> >   ones dot prefixed, which are limited to the trusted builtin keyrings.
> >   With a policy of "func=KEY_CHECK template=ima-buf keyrings=foo", for
> > example, keys loaded onto any keyring named "foo" will be measured.
> >   For files, the IMA policy may be constrained to a particular uid/gid.
> >   An additional method of identifying or constraining keyring names
> > needs to be defined.
> > 
> 
> I agree - this is a good idea.
> 
> Do you think this can be added as a separate patch set - enhancement to 
> the current one, or should this be addressed in the current set?
> 
> I was just about to send an update today that addresses your latest 
> comments. Will hold it if you think the above change should be included 
> now. Please let me know.

I'm hoping that it won't be all that difficult to implement and could
be included in this patch set as an additional patch.

Mimi

