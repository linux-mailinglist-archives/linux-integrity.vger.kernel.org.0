Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C37B158538
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 22:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJVq2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 16:46:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45700 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727385AbgBJVq1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 16:46:27 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ALRPhR042569
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2020 16:46:26 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucjk3y1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2020 16:46:26 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 10 Feb 2020 21:46:24 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Feb 2020 21:46:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01ALkKb463569932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 21:46:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02791A4051;
        Mon, 10 Feb 2020 21:46:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20BF1A4040;
        Mon, 10 Feb 2020 21:46:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.79])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Feb 2020 21:46:19 +0000 (GMT)
Subject: Re: [PATCH] IMA: Add log statements for failure conditions.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Joe Perches <joe@perches.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, khan@linuxfoundation.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Feb 2020 16:46:18 -0500
In-Reply-To: <0c9099b5-da29-3e71-0933-123dfe08442c@linux.microsoft.com>
References: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
         <20200207195346.4017-2-tusharsu@linux.microsoft.com>
         <1581253027.5585.671.camel@linux.ibm.com>
         <da7bd0441ef3044cb40d705b8bb176bfdf391557.camel@perches.com>
         <41d61aa5-db98-6291-d91f-104f029c897f@linux.microsoft.com>
         <13eb9760ba13cee2f25c74c665198faac6a5a2f3.camel@perches.com>
         <0c9099b5-da29-3e71-0933-123dfe08442c@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021021-4275-0000-0000-0000039FDEB2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021021-4276-0000-0000-000038B4148A
Message-Id: <1581371178.5585.913.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_07:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Mon, 2020-02-10 at 13:33 -0800, Tushar Sugandhi wrote:
> On 2020-02-10 8:50 a.m., Joe Perches wrote:
> > On Mon, 2020-02-10 at 08:40 -0800, Lakshmi Ramasubramanian wrote:
> >> On 2/9/20 6:46 PM, Joe Perches wrote:
> >>
> >>>> In addition, as Shuah Khan suggested for the security/integrity/
> >>>> directory, "there is an opportunity here to add #define pr_fmt(fmt)
> >>>> KBUILD_MODNAME ": " fmt to integrity.h and get rid of duplicate
> >>>> defines."
> >> Good point - we'll make that change.
> >>
> >> With Joe Perches patch (waiting for it to be re-posted),
> >>>> are all the pr_fmt definitions needed in each file in the
> >>>> integrity/ima directory?
> >>> btw Tushar and Lakshmi:
> >>>
> >>> I am not formally submitting a patch here.
> >>>
> >>> I was just making suggestions and please do
> >>> with it as you think appropriate.
> >> Joe - it's not clear to me what you are suggesting.
> >> We'll move the #define for pr_fmt to integrity.h.
> >>
> >> What's other changes are you proposing?
> > https://lore.kernel.org/lkml/4b4ee302f2f97e3907ab03e55a92ccd46b6cf171.camel@perches.com/
> >
> Thanks Joe.
> 
> Joe, Shuah:
> 
> Could one of you please clarify if the changes proposed in the above URL 
> will be part of Shuah's future patchset?
> 
> Or should I include those in my patchset? I am referring to the 
> following snippet in security/integrity/integrity.h.

Joe is saying that he made some suggestions, which Shuah commented on,
but has no intention of posting a formal patch.  The end result of
that discussion is to define pr_fmt once in integrity/integrity.h and
remove any duplication in the integrity/ files.

I'd appreciate your including that change in this patch set, and if
needed a similar one in ima/ima.h.

thanks,

Mimi

