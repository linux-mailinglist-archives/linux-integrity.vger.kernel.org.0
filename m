Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530F2296665
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Oct 2020 23:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372208AbgJVVP6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Oct 2020 17:15:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21302 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S372206AbgJVVP5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Oct 2020 17:15:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09ML23pa103440;
        Thu, 22 Oct 2020 17:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xtaHrcJEIXJvJm8YVTTt46wQwrlM3pZFE5RPQ95qv+c=;
 b=HY6m9Y1aq0Az7+R59tDshjeSqD0fjMGQ2DRaCv/Du7wnaq1/kNtZq6vOqXvaHj88j5Un
 +d++E2Gbaom3p75nFCbCT+Fe/oCkjulZoEEcME78eefs5LesG7batW2lXUgHKkK1o0RP
 5wM6t7O7pedfjwkwwvMlGgpu2PB+vZQQifbYxcJR+5JRiYSchlB+i2iagOxScnYtpDtC
 cBGKhdNKVMBc79R4SbJ0k7z2RWoCtht9lSAnjtHj9iVtn8/85X4PmDRVz91DAxzhkb8y
 N6RILwHUCEzXWf1PknWV+p+aVcBeHSsM7cq1dziGD3/0aH28BI3upz2fe+402HPEbmco eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34b0nag2gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 17:15:51 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09ML22E5103346;
        Thu, 22 Oct 2020 17:15:51 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34b0nag2fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 17:15:50 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09MLDL8e032562;
        Thu, 22 Oct 2020 21:15:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 348d5qw29a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 21:15:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09MLFkXZ31654314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 21:15:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 976F311C04C;
        Thu, 22 Oct 2020 21:15:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 537DF11C050;
        Thu, 22 Oct 2020 21:15:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.44])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Oct 2020 21:15:43 +0000 (GMT)
Message-ID: <37aa4e6f5db6c53f4021f829ec09388d55d28208.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/6] IMA: add policy to measure critical data from
 kernel components
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 22 Oct 2020 17:15:42 -0400
In-Reply-To: <20200923192011.5293-5-tusharsu@linux.microsoft.com>
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
         <20200923192011.5293-5-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_15:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220131
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

The above Subject line should be truncated to "IMA: add policy to
measure critical data".    

On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:
> There would be several candidate kernel components suitable for IMA
> measurement. Not all of them would have support for IMA measurement.

This intro is besides the point.  The patch description should describe
what is meant by "critical data".

> Also, system administrators may not want to measure data for all of
> them, even when they support IMA measurement.
> An IMA policy option 
> specific to various kernel components is needed to measure their
> respective critical data.
> 
> This policy option needs to be constrained to measure data for
> specific kernel components that are specified as input values to the
> policy option.
> 
> Add a new IMA policy option - "data_sources:=" to allow measuring
> various critical kernel components. This policy option would enable the
> system administrators to limit the measurement to the components
> listed in "data_sources:=", if the components support IMA measurement.
> 
> The new policy option "data_sources:=" is different from the existing
> policy option "keyrings:=". 
> 
> In case of "keyrings:=", a policy may measure all keyrings (when
> "keyrings:=" option is not provided for func KEY_CHECK), or may
> constrain which keyrings need to be measured (when "keyrings:=" option
> is provided for func KEY_CHECK).
> 
> But unlike "keyrings:=", the entries in "data_sources:=" would have
> different data format. Further, the components listed in
> "data_sources:=" need to be modified to call IMA to measure their
> data. Therefore, unlike "keyrings:=", IMA shouldn't measure all of the
> components by default, when "data_sources:=" is not specified. Because
> measuring non-vetted components just by specifying them as a policy
> option value may impact the overall reliability of the system.
> 
> To address this, "data_sources:=" should be a mandatory policy option
> for func=CRITICAL_DATA. This func is introduced in the 5th patch in this
> series). And the compile-time vetting functionality described above is
> introduced in the 6th patch in this series.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

I don't understand what you mean by "non-vetted" components, nor how
measuring critical data may impact the overall reliability of the
system.

The system owner or adminstrator defines what they want to measure,
including "critical data", based on the policy rules.  They might
decide that they want to constrain which "critical data" is measured by
specifying "data_sources:=", but that decision is their perogative.  
The default should allow measuring all critical data.

 A simple example of "critical data" could be some in memory structure,
along the lines of __ro_after_init, or hash of the memory structure. 
Once the data structure is initialized, the "critical data" measurement
shouldn't change.    From the attestation server perspective, the IMA
measurement list would contain a single record unless the critical data
changes.  The attestation server doesn't need to know anything about
the initial value, just that it has changed in order to trigger some
sort alert.

thanks,

Mimi

