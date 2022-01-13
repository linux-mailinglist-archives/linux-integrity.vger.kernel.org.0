Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124D648DEE6
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jan 2022 21:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiAMU21 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 15:28:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232027AbiAMU20 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 15:28:26 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DJVdYJ013568;
        Thu, 13 Jan 2022 20:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1EYX4u0Pawe8bbo+K7brjm0j63gZV/se8XDuYrSDzOA=;
 b=jQ5BupOvdUQcCS6wfZ0vYINUqy+znyFh6/CAdjLcy8kztCagdFETpyUc0e/pybjKfMgs
 NKhj53ysSiSHXJ+KXKOCaO4UpQCQXzHfMsLDkITa7bZ76jCJkIjJZKf5x2TLAv/Jedkw
 VbPRCqtCyk/dRwj20X8x3tqc1qGcGDSe7HVqzqCwf0JdFVUSYPvaUCmIolA8VOiJ7e0o
 8NIwPrSqYm9i0Qs6vfviYKzaLshQW26cFqbV+wAyNJ5B5uQfGlTHGqoNMYVaoaInwimE
 bjW1v74NyY8Xkf83opY5z8SBAboIfD1n/8vfcnE68J/dwoDAktIld3ZxHebO+HWTopYr Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djt98h80s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:28:13 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DKSDIn005532;
        Thu, 13 Jan 2022 20:28:13 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djt98h7yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:28:13 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DK8OdF012477;
        Thu, 13 Jan 2022 20:28:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3df28a86q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:28:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DKS7Kd38601060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 20:28:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DA9AA4079;
        Thu, 13 Jan 2022 20:28:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4916EA4062;
        Thu, 13 Jan 2022 20:28:04 +0000 (GMT)
Received: from sig-9-65-68-109.ibm.com (unknown [9.65.68.109])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 20:28:04 +0000 (GMT)
Message-ID: <a7c5ac94b4c4d87b407353f74ff87bc0b13542a4.camel@linux.ibm.com>
Subject: Re: [PATCH v8 07/19] ima: Move dentry into ima_namespace and others
 onto stack
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 13 Jan 2022 15:28:03 -0500
In-Reply-To: <20220104170416.1923685-8-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
         <20220104170416.1923685-8-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YumDPKOO21BoPCfufXCqPs8kiuh27GFL
X-Proofpoint-ORIG-GUID: ZmKgdwQgFA7TBjpkJe9vI-bfey1KQ_Kv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_09,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201130126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Nobody refers to the IMA securityfs files as dentries.  The Subject
line is suppose to provide a hint about the patch.  How about changing
the "Subject" line to "ima: Move IMA securityfs files into
ima_namespaces or onto stack".

On Tue, 2022-01-04 at 12:04 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Move the policy file dentry into the ima_namespace for reuse by
> virtualized SecurityFS and for being able to remove it from
> the filesystem. Move the other dentries onto the stack.

Missing is an explanation why the other IMA securityfs files can be on
the stack.  Maybe start out by saying that the ns_ima_init securityfs
files are never deleted.  Then transition into the IMA namespaced
securityfs files and how they will be deleted.

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/ima/ima.h    |  2 ++
>  security/integrity/ima/ima_fs.c | 32 ++++++++++++++++++--------------
>  2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 82b3f6a98320..224b09617c52 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -140,6 +140,8 @@ struct ima_namespace {
>  	struct mutex ima_write_mutex;
>  	unsigned long ima_fs_flags;
>  	int valid_policy;
> +
> +	struct dentry *policy_dentry;

None of the other securityfs files are renamed.  Why is "ima_policy" 
being renamed to "policy_dentry"?  If there is a need, it should be
documented in the patch description.

thanks,

Mimi

>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;
> 

