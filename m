Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B934258540
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0PIw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 11:08:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbfF0PIv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 11:08:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RF5Zxb040882
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 11:08:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tcx4xqjne-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 11:08:49 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 27 Jun 2019 16:08:46 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 16:08:43 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RF8X5p33947926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 15:08:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E07D7A4051;
        Thu, 27 Jun 2019 15:08:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8011A4040;
        Thu, 27 Jun 2019 15:08:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.20])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 15:08:41 +0000 (GMT)
Subject: Re: [PATCH V10 2/3] IMA: Define a new template field buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        vgoyal@redhat.com
Date:   Thu, 27 Jun 2019 11:08:31 -0400
In-Reply-To: <87ftnyk5e0.fsf@morokweng.localdomain>
References: <20190624062331.388-1-prsriva02@gmail.com>
         <20190624062331.388-3-prsriva02@gmail.com>
         <87ftnyk5e0.fsf@morokweng.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062715-0028-0000-0000-0000037E4223
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062715-0029-0000-0000-0000243E6CD9
Message-Id: <1561648111.4101.135.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270176
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-24 at 19:03 -0300, Thiago Jung Bauermann wrote:
> Hello Prakhar,
> 
> Prakhar Srivastava <prsriva02@gmail.com> writes:
> 
> > diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> > index 00dd5a434689..a01a17e5c581 100644
> > --- a/security/integrity/ima/ima_template.c
> > +++ b/security/integrity/ima/ima_template.c
> > @@ -26,6 +26,7 @@ static struct ima_template_desc builtin_templates[] = {
> >  	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
> >  	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
> >  	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
> > +	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
> >  	{.name = "", .fmt = ""},	/* placeholder for a custom format */
> >  };
> >
> > @@ -43,6 +44,8 @@ static const struct ima_template_field supported_fields[] = {
> >  	 .field_show = ima_show_template_string},
> >  	{.field_id = "sig", .field_init = ima_eventsig_init,
> >  	 .field_show = ima_show_template_sig},
> > +	{.field_id = "buf", .field_init = ima_eventbuf_init,
> > +	 .field_show = ima_show_template_buf},
> >  };
> >  #define MAX_TEMPLATE_NAME_LEN 15
> 
> Currently, MAX_TEMPLATE_NAME_LEN is the length of a template that
> contains all valid fields. It may make sense to increase it since
> there's a new field being added.
> 
> I suggest using a sizeof() to show where the number comes from (and
> which can be visually shown to be correct):
> 
> #define MAX_TEMPLATE_NAME_LEN sizeof("d|n|d-ng|n-ng|sig|buf")
> 
> The sizeof() is calculated at compile time.

MAX_TEMPLATE_NAME_LEN is used when restoring measurements carried over
from a kexec.  'd' and 'd-ng' should not both be defined in the
template description, nor should 'n' and 'n-ng'.  Even without the
duplication, the MAX_TEPLATE_NAME_LEN is greater than the current 15.

Thiago, could you address this as a separate patch?

thanks!

Mimi



