Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307212E27C6
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Dec 2020 15:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgLXOmm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Dec 2020 09:42:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbgLXOmm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Dec 2020 09:42:42 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BOEWhWO064381;
        Thu, 24 Dec 2020 09:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7UGMiFVFxi00pwrQ6v3x2kjQ3RPwifgbIv6xsQ2BjTM=;
 b=HLU6xS+nCiXeqoVvfinujFBsxdeTOaNc9BocICxWN25+xkv1+0V+N+s4DmQ86ov+iKob
 GNjsJnFwOq/lfaEbUbx9PvoLows+Zr0GSDrv4dPQVrZ6G7U9GwwEUnsu9x1GWS9GOZ0e
 Xv5npalkmh8iE/GXO/slsMg4vmtts5I6pA9Rg5aqC9nTNWVCXQsQXNS8eX2YSGh6MXLx
 Ieb+eFCFa4zETIroDto6UfZr/JZ/RSdg+ef1lAHJofVkkk5++LtJOC0ZbbwHwnJo9feQ
 lSFneDG+oF+/+mtdppvM28ilQXIEaDq9ye69gcIHdROO0qifEACU29ioDVzK/NA9laUe /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35mtka31tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 09:41:57 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BOEfvbx097495;
        Thu, 24 Dec 2020 09:41:57 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35mtka31ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 09:41:56 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BOEWkOn007779;
        Thu, 24 Dec 2020 14:41:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 35ja5rsxmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 14:41:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BOEfqJc34800044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Dec 2020 14:41:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50BF542047;
        Thu, 24 Dec 2020 14:41:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23FF342045;
        Thu, 24 Dec 2020 14:41:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.1.132])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Dec 2020 14:41:48 +0000 (GMT)
Message-ID: <93dc6912192df78026f8f98c8f6ab67608c188f0.camel@linux.ibm.com>
Subject: Re: [PATCH v9 7/8] IMA: define a builtin critical data measurement
 policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 24 Dec 2020 09:41:48 -0500
In-Reply-To: <20201212180251.9943-8-tusharsu@linux.microsoft.com>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
         <20201212180251.9943-8-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-24_08:2020-12-24,2020-12-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012240088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> Define a new critical data builtin policy to allow measuring
> early kernel integrity critical data before a custom IMA policy
> is loaded.
> 
> Add critical data to built-in IMA rules if the kernel command line
> contains "ima_policy=critical_data".

This sentence isn't really necessary.

> 
> Update the documentation on kernel parameters to document
> the new critical data builtin policy.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Otherwise,
Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

thanks,

Mimi

