Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD331386EA
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jan 2020 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbgALPhV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Jan 2020 10:37:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733063AbgALPhV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Jan 2020 10:37:21 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00CFb6MG100681
        for <linux-integrity@vger.kernel.org>; Sun, 12 Jan 2020 10:37:20 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvv9takx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 12 Jan 2020 10:37:19 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 12 Jan 2020 15:37:18 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 12 Jan 2020 15:37:13 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00CFbCcO11862282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jan 2020 15:37:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D9F4AE045;
        Sun, 12 Jan 2020 15:37:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E23E4AE051;
        Sun, 12 Jan 2020 15:37:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.200.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 12 Jan 2020 15:37:10 +0000 (GMT)
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
Date:   Sun, 12 Jan 2020 10:37:10 -0500
In-Reply-To: <e6945c33-a540-9d0a-ba71-3602b8e38154@schaufler-ca.com>
References: <20191224235939.7483-1-casey.ref@schaufler-ca.com>
         <20191224235939.7483-1-casey@schaufler-ca.com>
         <ee5e4cea-b6c1-fa12-30de-8fc9007d69e9@schaufler-ca.com>
         <1578587607.5147.63.camel@linux.ibm.com>
         <e6945c33-a540-9d0a-ba71-3602b8e38154@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011215-0008-0000-0000-00000348B768
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011215-0009-0000-0000-00004A690461
Message-Id: <1578843430.4546.45.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-12_05:2020-01-10,2020-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001120148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-10 at 11:40 -0800, Casey Schaufler wrote:
> On 1/9/2020 8:33 AM, Mimi Zohar wrote:
> > Hi Casey,
> >
> > On Fri, 2020-01-03 at 10:53 -0800, Casey Schaufler wrote:
> >> With multiple possible security modules supporting audit rule
> >> it is necessary to keep separate data for each module in the
> >> audit rules. This affects IMA as well, as it re-uses the audit
> >> rule list mechanisms.
> > While reviewing this patch, I realized there was a bug in the base IMA
> > code.  With Janne's bug fix, that he just posted, I think this patch
> > can now be simplified.
> 
> How and when do you plan to get Janne's fix in? It's looking like
> stacking won't be in for 5.6.

The patch is now in the next-integrity-testing branch.  We'll see how
it goes.

> 
> > My main concern is the number of warning messages that will be
> > generated.  Any time a new LSM policy is loaded, the labels will be
> > re-evaulated whether or not they are applicable to the particular LSM,
> > causing unnecessary warnings.
> 
> Uhg.

