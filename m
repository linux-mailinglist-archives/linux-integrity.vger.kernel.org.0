Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F068A109384
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2019 19:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfKYSaZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Nov 2019 13:30:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727893AbfKYSaZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Nov 2019 13:30:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAPIS4YR114836
        for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2019 13:30:24 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wfju96byr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2019 13:30:23 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 25 Nov 2019 18:30:22 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Nov 2019 18:30:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAPIUJGM23724206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 18:30:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0E30A4059;
        Mon, 25 Nov 2019 18:30:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23F17A405D;
        Mon, 25 Nov 2019 18:30:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.107])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Nov 2019 18:30:19 +0000 (GMT)
Subject: Re: [PATCH v0] IMA: Check IMA policy flag
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        eric.snowberg@oracle.com, linux-integrity@vger.kernel.org
Date:   Mon, 25 Nov 2019 13:30:18 -0500
In-Reply-To: <5a43ec9d-af82-9a31-3546-76e8328ff213@linux.microsoft.com>
References: <20191121171444.2797-1-nramas@linux.microsoft.com>
         <5a43ec9d-af82-9a31-3546-76e8328ff213@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112518-0008-0000-0000-000003381EE5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112518-0009-0000-0000-00004A571FE0
Message-Id: <1574706618.4793.218.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_04:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911250150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-11-25 at 10:23 -0800, Lakshmi Ramasubramanian wrote:
> On 11/21/19 9:14 AM, Lakshmi Ramasubramanian wrote:
> 
> Hi Mimi,
> 
> > process_buffer_measurement() needs to check if ima_policy_flag
> > is set to measure and\or appraise. Not doing this check can
> > result in kernel panic (such as when process_buffer_measurement()
> > is called before IMA is initialized).
> >  
> > This change adds the check in process_buffer_measurement()
> > to return immediately if ima_policy_flag is set to 0.
> > 
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > ---
> >   security/integrity/ima/ima_main.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 60027c643ecd..c9374430bb72 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -651,6 +651,9 @@ static void process_buffer_measurement(const void *buf, int size,
> >   	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> >   	int action = 0;
> >   
> > +	if (!ima_policy_flag)
> > +		return;
> > +
> 
> Please let me know if the above change would be accepted as a standalone 
> patch (like the one in this patch),
> or, I should include this change as one of the patches in the "Key 
> Measurement" patch set?

As I'm not planning on sending a pull request this open window, so
that it doesn't get lost/forgotten, please include it as the first
patch in this patch set.

Mimi

