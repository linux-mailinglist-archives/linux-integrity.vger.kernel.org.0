Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382194768DD
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 04:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhLPDzG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 22:55:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230521AbhLPDzF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 22:55:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFNvM0A006100;
        Thu, 16 Dec 2021 03:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=I1BNzcIRmoN7aOl9tlwlBjfyA/GXktpCkdPglc/VMRU=;
 b=hEfKO2nfD92SlAKSq7RfYeCTlN/AjAabztgBGe/C3uQl0nIRS3/1Qwb1UC/5glXXtlvj
 sznPxmTOHWyBhngs3miaO0ackLPIVXXgdkVNl8qQ/3yTqsw8nHcAnRJ8GeqEtKxn/qZ0
 YUddKJRmcU8z1setCQfH29l346YhBHIeSk08LFimxx8ZqZF/DNjQ9fWCVm33dR67cIS3
 c7OufhgI+H8SHbZmid36DmOmGWtPQI4Y93+sg0OWFDGOa7vpWiVRTEqKL3nkPDk7+ivF
 w3G31yIUdy1WwSBWBNamj+INIp4DvPaPQseh6IlX5BYgAF769Gc3RSXwZReDkPpij45l uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyhykf95t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 03:54:51 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG3sXe5019741;
        Thu, 16 Dec 2021 03:54:50 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyhykf958-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 03:54:50 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG3mJSm010811;
        Thu, 16 Dec 2021 03:54:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3cy78ha80r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 03:54:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG3sjDx39584146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 03:54:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B23D11C04A;
        Thu, 16 Dec 2021 03:54:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA5F711C054;
        Thu, 16 Dec 2021 03:54:42 +0000 (GMT)
Received: from sig-9-65-74-182.ibm.com (unknown [9.65.74.182])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 03:54:42 +0000 (GMT)
Message-ID: <6c88c5bb9523674be2ecfc49d093b16a42220a53.camel@linux.ibm.com>
Subject: Re: [PATCH v6 03/17] ima: Namespace audit status flags
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Date:   Wed, 15 Dec 2021 22:54:42 -0500
In-Reply-To: <ffd4b877-389b-63b5-576d-f3ce66849ebf@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
         <20211210194736.1538863-4-stefanb@linux.ibm.com>
         <925ed27a6375dffcb92e9812e36b1c461ae63aa2.camel@linux.ibm.com>
         <ffd4b877-389b-63b5-576d-f3ce66849ebf@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S0YR8R3iPsV2knUOYUC-YCxmmGCpTIjM
X-Proofpoint-ORIG-GUID: ZVz7F78D81Tr3Yiycu3A8ErLAlkzu0ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160018
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-12-15 at 21:38 -0500, Stefan Berger wrote:
> On 12/15/21 16:15, Mimi Zohar wrote:
> > On Fri, 2021-12-10 at 14:47 -0500, Stefan Berger wrote:
> >> From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
> >>
> >> The iint cache stores whether the file is measured, appraised, audited
> >> etc. This patch moves the IMA_AUDITED flag into the per-namespace
> >> ns_status, enabling IMA audit mechanism to audit the same file each time
> >> it is accessed in a new namespace.
> >>
> >> The ns_status is not looked up if the CONFIG_IMA_NS is disabled or if
> >> any of the IMA_NS_STATUS_ACTIONS (currently only IMA_AUDIT) is not
> >> enabled.
> > ^none of the ... are enabled.
> 
> You want me to rephrase it?

Yes, please.

thanks,

Mimi

