Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92034AE3
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2019 16:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfFDOsI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jun 2019 10:48:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727948AbfFDOsI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jun 2019 10:48:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54Ebudc048856
        for <linux-integrity@vger.kernel.org>; Tue, 4 Jun 2019 10:48:07 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2swr8hyg0r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 04 Jun 2019 10:48:06 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 4 Jun 2019 15:48:04 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 15:48:00 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x54ElxjU23920802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 14:47:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9077FAE058;
        Tue,  4 Jun 2019 14:47:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0218AE055;
        Tue,  4 Jun 2019 14:47:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 14:47:58 +0000 (GMT)
Subject: Re: [PATCH V3] IMA: Allow profiles to define the desired IMA
 template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, prsriva02@gmail.com,
        bauerman@linux.ibm.com, Matthew Garrett <mjg59@google.com>
Date:   Tue, 04 Jun 2019 10:47:48 -0400
In-Reply-To: <3b452fea-f8e6-ebd3-824d-f7b8c5ceae58@huawei.com>
References: <20190603201322.7443-1-matthewgarrett@google.com>
         <1559613113.3956.9.camel@linux.ibm.com>
         <18481910-ea3b-3ca7-ded2-46b094bbe959@huawei.com>
         <1559658772.4076.3.camel@linux.ibm.com>
         <3b452fea-f8e6-ebd3-824d-f7b8c5ceae58@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060414-4275-0000-0000-0000033C9F81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060414-4276-0000-0000-0000384CAEFC
Message-Id: <1559659668.4076.10.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040097
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-06-04 at 16:40 +0200, Roberto Sassu wrote:
> On 6/4/2019 4:32 PM, Mimi Zohar wrote:
> > On Tue, 2019-06-04 at 16:03 +0200, Roberto Sassu wrote:
> >> On 6/4/2019 3:51 AM, Mimi Zohar wrote:
> >>> On Mon, 2019-06-03 at 13:13 -0700, Matthew Garrett wrote:
> >>>> Admins may wish to log different measurements using different IMA
> >>>> templates. Add support for overriding the default template on a per-rule
> >>>> basis.
> >>>>
> >>>> Signed-off-by: Matthew Garrett <mjg59@google.com>
> >>>> ---
> >>>>
> >>>> Updated based on review feedback, verified that I can generate an event
> >>>> log that contains multiple different templates.
> >>>>
> >>>>    Documentation/ABI/testing/ima_policy  |  6 ++++--
> >>>>    security/integrity/ima/ima.h          | 13 +++++++++----
> >>>>    security/integrity/ima/ima_api.c      | 24 ++++++++++++++++-------
> >>>>    security/integrity/ima/ima_appraise.c |  2 +-
> >>>>    security/integrity/ima/ima_init.c     |  2 +-
> >>>>    security/integrity/ima/ima_main.c     |  9 +++++----
> >>>>    security/integrity/ima/ima_policy.c   | 28 +++++++++++++++++++++++++--
> >>>>    security/integrity/ima/ima_template.c | 10 ++++++++--
> >>>>    8 files changed, 71 insertions(+), 23 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> >>>> index 74c6702de74e..4ded0668a22d 100644
> >>>> --- a/Documentation/ABI/testing/ima_policy
> >>>> +++ b/Documentation/ABI/testing/ima_policy
> >>>> @@ -24,8 +24,7 @@ Description:
> >>>>    				[euid=] [fowner=] [fsname=]]
> >>>>    			lsm:	[[subj_user=] [subj_role=] [subj_type=]
> >>>>    				 [obj_user=] [obj_role=] [obj_type=]]
> >>>> -			option:	[[appraise_type=]] [permit_directio]
> >>>> -
> >>>> +			option:	[[appraise_type=]] [template=] [permit_directio]
> >>>>    		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
> >>>>    				[FIRMWARE_CHECK]
> >>>>    				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> >>>> @@ -38,6 +37,9 @@ Description:
> >>>>    			fowner:= decimal value
> >>>>    		lsm:  	are LSM specific
> >>>>    		option:	appraise_type:= [imasig]
> >>>> +			template:= name or format of a defined IMA template
> >>>> +			type (eg,ima-ng or d-ng|n-ng). Only valid when action
> >>>> +			is "measure".
> >>>
> >>> This patch only supports specifying the template name, not the
> >>> template format description.  Please remove "d-ng|n-ng".
> >>
> >> The patch is correct. lookup_template_desc() also considers the format.
> > 
> > Specifying the template format works if it is defined in
> > builtin_templates[], but seems to fail if it isn't.
> 
> Yes, the original patch set supports the definition of new templates.
> That part is not included in this patch.

There are three patch sets waiting for this new feature.  For now,
let's remove the reference to the template definition in this patch.
 The missing support could be added as a separate patch.

Roberto, are you ok with that?

Mimi

