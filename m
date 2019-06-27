Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 656E658E8B
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2019 01:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfF0X2B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 19:28:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726679AbfF0X2B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 19:28:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RNQbtF084788
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 19:28:00 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td5qwbr28-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 19:28:00 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 28 Jun 2019 00:27:59 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 00:27:56 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RNRtVU57475570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 23:27:55 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63B0FBE056;
        Thu, 27 Jun 2019 23:27:55 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C498BE051;
        Thu, 27 Jun 2019 23:27:53 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.218.134])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Jun 2019 23:27:53 +0000 (GMT)
References: <20190624062331.388-1-prsriva02@gmail.com> <20190624062331.388-3-prsriva02@gmail.com> <87ftnyk5e0.fsf@morokweng.localdomain> <1561648111.4101.135.camel@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        vgoyal@redhat.com
Subject: Re: [PATCH V10 2/3] IMA: Define a new template field buf
In-reply-to: <1561648111.4101.135.camel@linux.ibm.com>
Date:   Thu, 27 Jun 2019 20:27:47 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19062723-8235-0000-0000-00000EB00450
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011343; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224213; UDB=6.00644313; IPR=6.01005402;
 MB=3.00027497; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 23:27:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062723-8236-0000-0000-0000463029CB
Message-Id: <878stmr4lo.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270272
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Mimi Zohar <zohar@linux.ibm.com> writes:

> On Mon, 2019-06-24 at 19:03 -0300, Thiago Jung Bauermann wrote:
>> Hello Prakhar,
>> 
>> Prakhar Srivastava <prsriva02@gmail.com> writes:
>> 
>> > diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
>> > index 00dd5a434689..a01a17e5c581 100644
>> > --- a/security/integrity/ima/ima_template.c
>> > +++ b/security/integrity/ima/ima_template.c
>> > @@ -26,6 +26,7 @@ static struct ima_template_desc builtin_templates[] = {
>> >  	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
>> >  	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
>> >  	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
>> > +	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
>> >  	{.name = "", .fmt = ""},	/* placeholder for a custom format */
>> >  };
>> >
>> > @@ -43,6 +44,8 @@ static const struct ima_template_field supported_fields[] = {
>> >  	 .field_show = ima_show_template_string},
>> >  	{.field_id = "sig", .field_init = ima_eventsig_init,
>> >  	 .field_show = ima_show_template_sig},
>> > +	{.field_id = "buf", .field_init = ima_eventbuf_init,
>> > +	 .field_show = ima_show_template_buf},
>> >  };
>> >  #define MAX_TEMPLATE_NAME_LEN 15
>> 
>> Currently, MAX_TEMPLATE_NAME_LEN is the length of a template that
>> contains all valid fields. It may make sense to increase it since
>> there's a new field being added.
>> 
>> I suggest using a sizeof() to show where the number comes from (and
>> which can be visually shown to be correct):
>> 
>> #define MAX_TEMPLATE_NAME_LEN sizeof("d|n|d-ng|n-ng|sig|buf")
>> 
>> The sizeof() is calculated at compile time.
>
> MAX_TEMPLATE_NAME_LEN is used when restoring measurements carried over
> from a kexec.  'd' and 'd-ng' should not both be defined in the
> template description, nor should 'n' and 'n-ng'.

Ah, makes sense. Thanks for that information. 

> Even without the
> duplication, the MAX_TEPLATE_NAME_LEN is greater than the current 15.
>
> Thiago, could you address this as a separate patch?

Yes, I just sent a patch.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

