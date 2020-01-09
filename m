Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF65135E5A
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jan 2020 17:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgAIQdl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jan 2020 11:33:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729700AbgAIQdl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jan 2020 11:33:41 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009GPRq4061616
        for <linux-integrity@vger.kernel.org>; Thu, 9 Jan 2020 11:33:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe7dv0y10-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 09 Jan 2020 11:33:39 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 9 Jan 2020 16:33:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Jan 2020 16:33:30 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009GXT0b40698010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 16:33:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A49CBA4055;
        Thu,  9 Jan 2020 16:33:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52DFFA404D;
        Thu,  9 Jan 2020 16:33:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.153.42])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jan 2020 16:33:28 +0000 (GMT)
Subject: Re: [PATCH v13 26/25] Audit: Multiple LSM support in audit rules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 09 Jan 2020 11:33:27 -0500
In-Reply-To: <ee5e4cea-b6c1-fa12-30de-8fc9007d69e9@schaufler-ca.com>
References: <20191224235939.7483-1-casey.ref@schaufler-ca.com>
         <20191224235939.7483-1-casey@schaufler-ca.com>
         <ee5e4cea-b6c1-fa12-30de-8fc9007d69e9@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010916-0012-0000-0000-0000037BF9E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010916-0013-0000-0000-000021B81BDA
Message-Id: <1578587607.5147.63.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090140
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Casey,

On Fri, 2020-01-03 at 10:53 -0800, Casey Schaufler wrote:
> With multiple possible security modules supporting audit rule
> it is necessary to keep separate data for each module in the
> audit rules. This affects IMA as well, as it re-uses the audit
> rule list mechanisms.

While reviewing this patch, I realized there was a bug in the base IMA
code.  With Janne's bug fix, that he just posted, I think this patch
can now be simplified.

My main concern is the number of warning messages that will be
generated.  Any time a new LSM policy is loaded, the labels will be
re-evaulated whether or not they are applicable to the particular LSM,
causing unnecessary warnings.

Mimi

