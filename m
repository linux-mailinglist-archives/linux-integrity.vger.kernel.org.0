Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267B446052
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 16:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfFNOOf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 10:14:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728239AbfFNOOb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 10:14:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EE7ewI093370
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jun 2019 10:14:30 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t4bv548mc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jun 2019 10:14:30 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 14 Jun 2019 15:14:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 15:14:24 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EEEN2H20840506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 14:14:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DC59AE053;
        Fri, 14 Jun 2019 14:14:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5240AE051;
        Fri, 14 Jun 2019 14:14:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.199])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 14:14:22 +0000 (GMT)
Subject: Re: [PATCH V8 2/3] Define a new ima template field buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roberto.sassu@huawei.com,
        thiago Jung Bauermann <bauerman@linux.ibm.com>
Date:   Fri, 14 Jun 2019 10:14:11 -0400
In-Reply-To: <1560509860.4171.13.camel@linux.ibm.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
         <20190612221549.28399-3-prsriva02@gmail.com>
         <1560455980.4805.57.camel@linux.ibm.com>
         <1560509860.4171.13.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061414-0008-0000-0000-000002F3C76B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061414-0009-0000-0000-00002260D213
Message-Id: <1560521651.4072.7.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140121
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> > > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> > > index 993d0f1915ff..c8591406c0e2 100644
> > > --- a/security/integrity/ima/ima_init.c
> > > +++ b/security/integrity/ima/ima_init.c
> > > @@ -50,7 +50,7 @@ static int __init ima_add_boot_aggregate(void)
> > >  	struct ima_template_entry *entry;
> > >  	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> > >  	struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
> > > -					    NULL, 0, NULL};
> > > +					    NULL, 0, NULL, NULL, 0};
> > 
> > here, don't belong in this patch.  It belongs in "IMA: support for per
> > policy rule template formats", in case it should ever be backported.
> >  Please post this as a separate patch, that will be squashed with
> > "IMA: support for per policy rule template formats".
> 
> My mistake.  I should have picked up Thaigo's "ima: Use designated
> initializers for struct ima_event_data".  Please drop these changes
> instead.

Sorry for the confusion.  I just pushed out Thiago's patch.

thanks,

Mimi

