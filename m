Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA6BA1007
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 05:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfH2DqF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 23:46:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbfH2DqF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 23:46:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7T3h0U3127937
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 23:46:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up31jdv5w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 23:46:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 29 Aug 2019 04:46:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Aug 2019 04:45:57 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7T3juQf51839122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 03:45:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BED444204C;
        Thu, 29 Aug 2019 03:45:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0A8342041;
        Thu, 29 Aug 2019 03:45:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.163.216])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 03:45:55 +0000 (GMT)
Subject: Re: [PATCH] ima: use struct_size() in kzalloc()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 23:45:55 -0400
In-Reply-To: <671185b9-5c91-5235-b5ea-96d3449bf716@embeddedor.com>
References: <20190529165343.GA2584@embeddedor>
         <671185b9-5c91-5235-b5ea-96d3449bf716@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082903-4275-0000-0000-0000035E859E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082903-4276-0000-0000-00003870BB55
Message-Id: <1567050355.11493.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=989 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290038
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Gustavo,

On Wed, 2019-08-28 at 13:29 -0500, Gustavo A. R. Silva wrote:
> On 5/29/19 11:53 AM, Gustavo A. R. Silva wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> > 
> > struct foo {
> >    int stuff;
> >    struct boo entry[];
> > };
> > 
> > instance = kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
> > 
> > Instead of leaving these open-coded and prone to type mistakes, we can
> > now use the new struct_size() helper:
> > 
> > instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> > 
> > This code was detected with the help of Coccinelle.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  security/integrity/ima/ima_template.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> > index b631b8bc7624..b945dff2ed14 100644
> > --- a/security/integrity/ima/ima_template.c
> > +++ b/security/integrity/ima/ima_template.c
> > @@ -281,9 +281,8 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
> >  	int ret = 0;
> >  	int i;
> >  
> > -	*entry = kzalloc(sizeof(**entry) +
> > -		    template_desc->num_fields * sizeof(struct ima_field_data),
> > -		    GFP_NOFS);
> > +	*entry = kzalloc(struct_size(*entry, template_data,
> > +				     template_desc->num_fields), GFP_NOFS);
> >  	if (!*entry)
> >  		return -ENOMEM;
> >  
> > 

The same usage exists in ima_api.c: ima_alloc_init_template().  Did
you want to make the change there as well?

thanks,

Mimi

