Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79DC45B05
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfFNK6A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 06:58:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727284AbfFNK6A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 06:58:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EAvGa7142954
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jun 2019 06:57:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t4775fdss-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jun 2019 06:57:58 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 14 Jun 2019 11:57:56 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 11:57:53 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EAvq1P34210172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 10:57:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7753A4C04A;
        Fri, 14 Jun 2019 10:57:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8073A4C040;
        Fri, 14 Jun 2019 10:57:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.115])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 10:57:51 +0000 (GMT)
Subject: Re: [PATCH V8 2/3] Define a new ima template field buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roberto.sassu@huawei.com, vgoyal@redhat.com
Date:   Fri, 14 Jun 2019 06:57:40 -0400
In-Reply-To: <1560455980.4805.57.camel@linux.ibm.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
         <20190612221549.28399-3-prsriva02@gmail.com>
         <1560455980.4805.57.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061410-0008-0000-0000-000002F3B999
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061410-0009-0000-0000-00002260C358
Message-Id: <1560509860.4171.13.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140091
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Prakhar,

> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index ea7d8cbf712f..83ca99d65e4b 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -140,7 +140,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
> >  	struct ima_template_entry *entry;
> >  	struct inode *inode = file_inode(file);
> >  	struct ima_event_data event_data = {iint, file, filename, NULL, 0,
> > -					    cause};
> > +					    cause, NULL, 0};
> 
> This change here and
> 
> >  	int violation = 1;
> >  	int result;
> >  
> > @@ -296,7 +296,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
> >  	struct inode *inode = file_inode(file);
> >  	struct ima_template_entry *entry;
> >  	struct ima_event_data event_data = {iint, file, filename, xattr_value,
> > -					    xattr_len, NULL};
> > +					    xattr_len, NULL, NULL, 0};
> 
> here and 
> 
> >  	int violation = 0;
> >  
> >  	if (iint->measured_pcrs & (0x1 << pcr))
> > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> > index 993d0f1915ff..c8591406c0e2 100644
> > --- a/security/integrity/ima/ima_init.c
> > +++ b/security/integrity/ima/ima_init.c
> > @@ -50,7 +50,7 @@ static int __init ima_add_boot_aggregate(void)
> >  	struct ima_template_entry *entry;
> >  	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> >  	struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
> > -					    NULL, 0, NULL};
> > +					    NULL, 0, NULL, NULL, 0};
> 
> here, don't belong in this patch.  It belongs in "IMA: support for per
> policy rule template formats", in case it should ever be backported.
>  Please post this as a separate patch, that will be squashed with
> "IMA: support for per policy rule template formats".

Might mistake.  I should have picked up Thaigo's "ima: Use designated
initializers for struct ima_event_data".  Please drop these changes
instead.

thanks,

Mimi

> 
> >  	int result = -ENOMEM;
> >  	int violation = 0;
> >  	struct {
> 

