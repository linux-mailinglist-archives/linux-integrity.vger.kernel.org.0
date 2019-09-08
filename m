Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A04AD132
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 01:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfIHXb0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Sep 2019 19:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731296AbfIHXb0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Sep 2019 19:31:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x88NRKAM104026
        for <linux-integrity@vger.kernel.org>; Sun, 8 Sep 2019 19:31:25 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uw83u4cqx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 08 Sep 2019 19:31:24 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 9 Sep 2019 00:31:22 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 00:31:19 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x88NVIGt45547968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Sep 2019 23:31:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58576AE04D;
        Sun,  8 Sep 2019 23:31:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78A1CAE053;
        Sun,  8 Sep 2019 23:31:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.159.93])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  8 Sep 2019 23:31:17 +0000 (GMT)
Subject: Re: [RFC][PATCH 1/1] Carry ima measurement log for arm64 via
 kexec_file_load
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     prsriva <prsriva@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
Date:   Sun, 08 Sep 2019 19:31:16 -0400
In-Reply-To: <0c7453d4-620d-2d98-3fda-f902b18da535@linux.microsoft.com>
References: <20190829200532.13545-1-prsriva@linux.microsoft.com>
         <20190829200532.13545-2-prsriva@linux.microsoft.com>
         <87r252kxc8.fsf@morokweng.localdomain>
         <0c7453d4-620d-2d98-3fda-f902b18da535@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090823-4275-0000-0000-00000362F7CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090823-4276-0000-0000-000038754646
Message-Id: <1567985476.4614.224.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-08_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909080260
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Prakhar,

On Fri, 2019-09-06 at 16:56 -0700, prsriva wrote:
> On 8/30/19 5:11 PM, Thiago Jung Bauermann wrote:
> > Hello Prakhar,
> >
> > Answering this part from the cover letter:
> >
> >> The code is in most part same as powerpc, i want to get feedback as to
> >> how/correct way to refactor the code so that cross architecture
> >> partial helpers can be put in a common place.
> 
> I started refactoring code to bring helpers under drivers/of, but
> 
> i soon reliazed the current implementation can be changed a bit
> 
> so that some of the additional functions can be sourced from
> 
> existing fdt_*/of_* functions since the fdt_ima was seeming to be
> 
> an overkill. I have done so in the V1 patch and also addressed
> 
> comments you have.
> 
> Hopefully its(v1) is a cleaner approach.
> 
> - Thanks for the review, and guidance.

"Carrying over the ima log during kexec_file_load" was originally
posted on 5/10 and 5/31 without a cover letter. On 8/29 it was
reposted as an RFC with a cover letter.  The cover letter was v1, but
the patch itself was not.  In the future, please use the "git format-
patch "-subject-prefix" option to add the version number to both the
cover letter and the patches.

The comments you received were based on the 8/29 version.  I haven't
seen anything after that. 

Mimi


> > That's a great idea. If it could go to drivers/of/ as Stephen Boyd
> > mentioned in the other email that would be great.
> >
> > More comments below.
> > -Addressed those in the v1 patch
> > Prakhar Srivastava <prsriva@linux.microsoft.com> writes:
> >

