Return-Path: <linux-integrity+bounces-735-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B903B82B426
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 18:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15DB1C24146
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61FD53E35;
	Thu, 11 Jan 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tOLYBvFY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24653E37
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jan 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BFvZ0n009743;
	Thu, 11 Jan 2024 17:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qWdfCt8z/P2xCnocYypnu8bW8jwmBddLfgsWWT9ZquQ=;
 b=tOLYBvFYWJd2ZQJQJW5yqslUztSt3lJzM5zbwTr2s+UOaMe6Rb3UtgQnnrUWuwPQb9Du
 188Y1dmS6cRWGkWfSJlXM9CNcpyEVSbooXSUSA2VFSB4hxJlzZCNoFT0l57pvhwsLXco
 MGiTFIvzlcZLhdvgAs5aM/NdrvXfPgQQpro6YklnvOfw4zFtkZLPmrziJjWsmLLNPpaR
 xodwh1B+I3Ob42D7dUTJKo92KYyCEP0m8rSxua9aHVywZCRnXKqCqZU/SUeiiZP667aE
 2m8gtmcztQba50nXWjvEFWFWhC67d0aIlNDwKLVqkLlqCs4nB6xdRMBUaYq6fEz5IAYF /A== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjke2ahqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 17:30:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGR9dn027026;
	Thu, 11 Jan 2024 17:30:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw2cex5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 17:30:10 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40BHU9ml12452546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 17:30:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55EC658056;
	Thu, 11 Jan 2024 17:30:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 900D058061;
	Thu, 11 Jan 2024 17:30:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jan 2024 17:30:08 +0000 (GMT)
Message-ID: <10d5bc81db27c21613dacace9bedad345705dcea.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/7] ima: suspend measurements during buffer copy at
 kexec execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Thu, 11 Jan 2024 12:30:07 -0500
In-Reply-To: <7ed7dccf-8482-4285-b21e-d518cb20d9e9@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-6-tusharsu@linux.microsoft.com>
	 <c174d4d7d3ab646f0e0ebf5aa1dd6894f22dbc02.camel@linux.ibm.com>
	 <7ed7dccf-8482-4285-b21e-d518cb20d9e9@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wvqONkTzh_ZUAihedAj9J5XazHsvxL9g
X-Proofpoint-GUID: wvqONkTzh_ZUAihedAj9J5XazHsvxL9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110137

On Fri, 2024-01-05 at 11:50 -0800, Tushar Sugandhi wrote:
> 
> On 12/20/23 12:44, Mimi Zohar wrote:
> > On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
> >> If the new measurements are added to the IMA log while it is being
> >> being copied to the kexec buffer during kexec 'execute', it can miss
> >> copying those new measurements to the kexec buffer, and the buffer can go
> >> out of sync with TPM PCRs.  This could result in breaking the integrity
> >> of the measurements after the kexec soft reboot to the new Kernel.
> >>
> >> Add a check in the ima_add_template_entry() function not to measure
> >> events and return from the function early when 'suspend_ima_measurements'
> >> flag is set.
> >>
> >> This ensures the consistency of the IMA measurement list while copying
> >> them to the kexec buffer.  When the 'suspend_ima_measurements' flag is
> >> set, any new measurements will be ignored until the flag is unset.  This
> >> allows the buffer to be safely copied without worrying about concurrent
> >> modifications to the measurement list.  This is crucial for maintaining
> >> the integrity of the measurements during a kexec soft reboot.
> >>
> >> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> >> ---
> >>   security/integrity/ima/ima_queue.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> >> index cb9abc02a304..5946a26a2849 100644
> >> --- a/security/integrity/ima/ima_queue.c
> >> +++ b/security/integrity/ima/ima_queue.c
> >> @@ -195,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
> >>   		}
> >>   	}
> >>   
> >> +	/*
> >> +	 * suspend_ima_measurements will be set if the system is
> >> +	 * undergoing kexec soft boot to a new kernel.
> >> +	 * suspending measurements in this short window ensures the
> >> +	 * consistency of the IMA measurement list during copying
> >> +	 * of the kexec buffer.
> >> +	 */
> >> +	if (atomic_read(&suspend_ima_measurements)) {
> >> +		audit_cause = "measurements_suspended";
> >> +		audit_info = 0;
> >> +		goto out;
> >> +	}
> >> +
> >>   	result = ima_add_digest_entry(entry,
> >>   				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
> >>   	if (result < 0) {
> > 
> > I assume you meant to include the suspend/resume code in "ima: kexec:
> > move ima log copy from kexec load to execute"  in this patch.
> > 
> 
> Sure, I can move the suspend/resume code from Patch 2/7 of this series
> to this patch (5/7).
> 
> Earlier I introduced the suspend/resume functionality in patch 2 because
> it was used in the functions in that patch.
> 
> But shifting it hear will make the patches cleaner.

Just a reminder this isn't the only issued mentioned in 2/7.  Please refer to it
for the other comments (e.g. make not including/verifying the IMA segment hash a
separate patch).

Before reposting, please remember to test after applying each patch in the patch
set to ensure that the measurement list is properly carried across kexec.
-- 
thanks,

Mimi


