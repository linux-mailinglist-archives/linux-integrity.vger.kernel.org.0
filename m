Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF4B49BF74
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 00:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiAYXQO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 18:16:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230111AbiAYXQO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 18:16:14 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMh9iD012492;
        Tue, 25 Jan 2022 23:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yiyWToWFqnlyskNfoTnW0lrVrnPqVY5shMwyPUWLsQY=;
 b=PRxt7xQPBTXRYN2BVHR2enKRBjRxgnlzVVx7CMy97bu5x51NI5pZE14YRynlWvm3ROco
 pihFoNdTKywQjtdZzbIdqRa9dThcyG4e3ywAvKkxe4hhQ+ilwRtXDeNv3ZM9FFvFz7Va
 d69EgQF5sHA7TkusFJs2VaZwY+WVP5ivY93VAVtqDwKwdVcr6/N5CWZ0Re0CgK/8Mk80
 4L3o80WiNkUiqnXt0zw4NEiq0JCMPEVbM7iMvDBPtB7XaE2/V1Mq4ZQsVdY+qm3jrbvC
 3uG37mk5mxcFb7hsbXE7AlV39gnFy1xILK7CYCQ5eM5ohBqbuHrsyVVqvfCwfpVKnYY2 wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtt83ghjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 23:16:11 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMiJsP015033;
        Tue, 25 Jan 2022 23:16:10 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtt83ghj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 23:16:10 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PNDwJF029300;
        Tue, 25 Jan 2022 23:16:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3dr9j9a2xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 23:16:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PNG63Q46465328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 23:16:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F3D8A405F;
        Tue, 25 Jan 2022 23:16:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0223A405B;
        Tue, 25 Jan 2022 23:16:05 +0000 (GMT)
Received: from sig-9-65-78-94.ibm.com (unknown [9.65.78.94])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 23:16:05 +0000 (GMT)
Message-ID: <6de3a9e2d9b4d068d8b5914473574c7d17030429.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ci/travis: Replace groovy -> impish
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
Date:   Tue, 25 Jan 2022 18:16:05 -0500
In-Reply-To: <bcb59cb4d8af33fe666acc8648ded424dbbc7370.camel@linux.ibm.com>
References: <20220121164748.6536-1-pvorel@suse.cz>
         <bcb59cb4d8af33fe666acc8648ded424dbbc7370.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xF8ptfoBYTHzDFbQOSJwN98mgr1YVywk
X-Proofpoint-GUID: 7cClxPGnLgFVDnQaEoVwwXpVmi38B2P9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=768 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250139
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-01-25 at 18:07 -0500, Mimi Zohar wrote:
> Hi Petr,
> 
> On Fri, 2022-01-21 at 17:47 +0100, Petr Vorel wrote:
> > From: Petr Vorel <petr.vorel@gmail.com>
> > 
> > follow previous commit also for Travis.
> > 
> > Fixes: 024c02d ("ci: Replace groovy -> impish")
> > 
> > Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> > ---
> > Update only for Travis, as previous patch has been merged.
> 
> I had picked up your v2 1/1 version, which updated both.

Oh, looks like only my local and the internal repo have the v2 version.
The external github repo still has the original v1 version, that was
used for testing.  Sorry for the confusion.

Mimi

