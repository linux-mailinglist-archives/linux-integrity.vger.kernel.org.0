Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD2112EA93
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jan 2020 20:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgABTpM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 14:45:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727951AbgABTpM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 14:45:12 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002JcEvp079762
        for <linux-integrity@vger.kernel.org>; Thu, 2 Jan 2020 14:45:10 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x869ssh2r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jan 2020 14:45:10 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 Jan 2020 19:45:09 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Jan 2020 19:45:07 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 002Jj6RB26214670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jan 2020 19:45:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6EF311CD04;
        Thu,  2 Jan 2020 19:18:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34F9811CB29;
        Thu,  2 Jan 2020 19:18:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.148.97])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jan 2020 19:18:28 +0000 (GMT)
Subject: Re: IMA's use of the audit rule code
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 02 Jan 2020 14:18:27 -0500
In-Reply-To: <a6c15a35-a8cb-7589-7960-a19e788b6c45@schaufler-ca.com>
References: <a6c15a35-a8cb-7589-7960-a19e788b6c45.ref@schaufler-ca.com>
         <a6c15a35-a8cb-7589-7960-a19e788b6c45@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010219-0008-0000-0000-000003460143
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010219-0009-0000-0000-00004A6638A4
Message-Id: <1577992707.5874.110.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_06:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001020157
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-02 at 09:06 -0800, Casey Schaufler wrote:
> IMA refines security_audit_rule_init to security_filter_rule_init.
> I need to understand what, if any, relationship there is between
> IMA's use of the audit rule mechanisms and the audit system's use.
> Is this simple code reuse, or is there some interaction between IMA
> and audit?
> 
> I'm trying to sort out the problem of audit rules when
> there are multiple security modules. It looks as if there is also a
> problem for integrity rules, but it looks different. The "easy"
> change for audit doesn't fit with what's in IMA. If there's no
> interaction between the IMA and audit use of the rule infrastructure
> it's reasonable to fix them separately. If there is interaction
> things get messy.

They're both comparing rules with LSM labels.  In IMA's case, the LSM
labels are used to identify which files are in/out of the IMA policy -
"measurement", "appraisal", and "audit".  I'm not sure how different
this is than the audit subsystem.

Mimi 

