Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA82E27B4
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Dec 2020 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgLXOaq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Dec 2020 09:30:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgLXOap (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Dec 2020 09:30:45 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BOEQU9j109809;
        Thu, 24 Dec 2020 09:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=57l2+4mboaPLXXgwyXBHOgNva8RJC7Xd2zbbKlZ+6PY=;
 b=WIa/ZGnXyvWyVOZY+zP2Uvyer/S4Q9dTV3vFwlI2Tfc0YMXUG8Y+mYdOFvD5fwCOobNQ
 IrG/imv5rmha/zYUI2qIdhqDQUFh4RhIzE1a1+rk/94Ck7DRyepqdbez+MDrz6KevlgW
 bPLGBZfZdU+kPag0G3nFoTAw1/2t6yKuxLP9AmBXj8qWNPmi+aIGoeVdtH2EUuCkMq1i
 4qo+1N9NM7o6DuQLg8C+KKwhU/kwHsdfw4fjNVJizcLpcMXF203jw9CtV0ESrJUmz7I3
 Ss7AF0tMZOme2xtDTYfDh8PgTHaKawzolEM6TDzqdH37ZF4hpvEF/lhRI8hmTg1OGDMA Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35mvqy82d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 09:29:59 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BOEQVL1109853;
        Thu, 24 Dec 2020 09:29:59 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35mvqy82cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 09:29:58 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BOERHuf019926;
        Thu, 24 Dec 2020 14:29:57 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 35kefjh33d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 14:29:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BOETrVo25756090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Dec 2020 14:29:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EBA3A4040;
        Thu, 24 Dec 2020 14:29:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E241A4059;
        Thu, 24 Dec 2020 14:29:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.1.132])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Dec 2020 14:29:50 +0000 (GMT)
Message-ID: <56db41c08d625b8143454a2e0aaaef3ea2927442.camel@linux.ibm.com>
Subject: Re: [PATCH v9 5/8] IMA: limit critical data measurement based on a
 label
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 24 Dec 2020 09:29:50 -0500
In-Reply-To: <20201212180251.9943-6-tusharsu@linux.microsoft.com>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
         <20201212180251.9943-6-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-24_08:2020-12-24,2020-12-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012240085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
> System administrators should be able to limit which kernel subsystems
> they want to measure the critical data for. To enable that, an IMA policy
> condition to choose specific kernel subsystems is needed. This policy
> condition would constrain the measurement of the critical data based on
> a label for the given subsystems.

Restricting which kernel integrity critical data is measured is not
only of interest to system administrators.   Why single them out?

Limiting which critical data is measured is based on a label, making it
flexible.  In your use case scenario, you're grouping the label based
on kernel subsystem, but is that really necessary?  In the broader
picture, there could be cross subsystem critical data being measured
based on a single label.

Please think about the broader picture and re-write the patch
descirption more generically.

> 
> Add a new IMA policy condition - "data_source:=" to the IMA func

What is with "add"?  You're "adding support for" or "defining" a new
policy condition.  Remove the single hyphen, as explained in 3/8.

Please replace "data_source" with something more generic (e.g. label).

thanks,

Mimi

> CRITICAL_DATA to allow measurement of various kernel subsystems. This
> policy condition would enable the system administrators to restrict the
> measurement to the labels listed in "data_source:=".
> 
> Limit the measurement to the labels that are specified in the IMA
> policy - CRITICAL_DATA+"data_source:=". If "data_sources:=" is not
> provided with the func CRITICAL_DATA, the data from all the
> supported kernel subsystems is measured.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

